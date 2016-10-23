package MyHRSGj
  package Water_poly "Package for water properties as Taylor expansion from phase boundary"
    package Data
      constant Real[6] T_sat_coeff = {1519.09706124263150000000, -461.32756663686405000000, 66.16968587624899100000, -4.48545167189394880000, 0.14630748316842188000, -0.00163813549750234330};
      constant Real[6] h_dew_coeff = {2125.89140222407830000000, -793.10873588777815000000, 119.63022502080931000000, -9.01505298786940120000, 0.33973091878137379000, -0.00512408378131911330};
      constant Real[6] d_dew_coeff = {0.12479600471241821000, 0.51158711356012465000, -0.00140313600803631030, 0.00003740499928538711, -0.00000029649121394411, 0.00000000104553780187};
      constant Real[8] T_vap_coeff = {4675.53968960622480000000, -1740.77058702298860000000, 264.30791901149030000000, -20.16507005131880700000, 0.77208035101345585000, -0.01188914514796556400, -5.72036907896985180000, 0.43411249107620631000};
      constant Real[6] v_vap_coeff = {163.14715271319142000000, -53.71759381691334300000, 7.10365042050133240000, -0.47125509914238284000, 0.01567341302320128500, -0.00020895912149403655};
      constant Real[6] d_bub_coeff = {15847.85419342394900000000, -6648.54207344666970000000, 1162.54127243965290000000, -99.81061648767723700000, 4.22607733695329200000, -0.07105883564590123600};
      constant Real[3] p_bub_coeff = {2.64717571396794370000, 1.09775136607384010000, -0.01703458750187615600};
      constant Real[6] T_liq_coeff = {-5.26034200514096820000, 4.52082815175959230000, -1.65456692396229330000, 0.26650594498774288000, -0.01945160462687971600, 0.00053908477161699394};
      constant Real[6] d_liq_coeff = {4.96216278877657760000, 8.18886803491067820000, -5.93233608044620380000, 1.36013616868327870000, -0.12755610320614794000, 0.00424463360178258410};
      constant Real[6] cv_bub_coeff = {4203.18992049, 21.217943061, -0.38527812972, 0.00568582708629, -3.73784359529e-05, 9.62362607675e-08};
      constant Real[6] cv_dew_coeff = {571243.605774, -125640.14858, 15876.794162, -1213.64888666, 48.2210009623, -0.757675724622};
    end Data;

    package Functions
      function cubicStep "Cubic step function"
        input Real tau;
        output Real y;
      algorithm
        y := noEvent(if tau < 0 then 0 else if tau > 1 then 1 else (3 - 2 * tau) * tau ^ 2);
      end cubicStep;

      function cv2p_ph "isochoric heat capacity as a function of pressure and spec. enthalpy in the two phase region"
        input Units.Pressure p;
        input Units.SpecificEnthalpy h;
        output Modelica.SIunits.SpecificHeatCapacity cv;
      protected
        Real x "vapor fraction";
        constant Integer n = size(Data.cv_bub_coeff, 1);
        Real[n] cvbc = Data.cv_bub_coeff;
        Real[n] cvdc = Data.cv_dew_coeff;
        Modelica.SIunits.SpecificHeatCapacity cv_dew "limiting isochoric heat capacity at dew boiling point";
        Modelica.SIunits.SpecificHeatCapacity cv_bub "limiting isochoric heat capacity at dew boiling point";
      algorithm
        x := Water_poly.Functions.x_ph(p, h);
        cv_dew := sum({cvdc[i] * Modelica.Math.log(p) ^ (i - 1) for i in 1:n});
        cv_bub := sum({cvbc[i] * (p * 1.0e-5) ^ (i - 1) for i in 1:n});
        cv := x * cv_dew + (1 - x) * cv_bub;
      end cv2p_ph;

      function dbub_p "Bubble density as a function of pressure"
        input Units.Pressure p;
        output Modelica.SIunits.Density ddew;
        output Real dd_dp;
      protected
        constant Integer n = size(Data.d_bub_coeff, 1);
        Real[n] coeff = Data.d_bub_coeff;
      algorithm
        ddew := sum({coeff[i] * Modelica.Math.log(p) ^ (i - 1) for i in 1:n});
        dd_dp := sum({(i - 1) * coeff[i] * Modelica.Math.log(p) ^ (i - 2) for i in 1:n}) / p;
//dd_dp := 1/p*(coeff[2] + 2*coeff[3]*Modelica.Math.log(p) + 3*coeff[4]*Modelica.Math.log(p)^2 + 4*coeff[5]*Modelica.Math.log(p)^3 + 5*coeff[6]*Modelica.Math.log(p)^4);
      end dbub_p;

      function ddew_p "Dew density as a function of pressure"
        input Units.Pressure p;
        output Modelica.SIunits.Density ddew;
        output Real dd_dp;
      protected
        constant Integer n = size(Data.d_dew_coeff, 1);
        Real[n] coeff = Data.d_dew_coeff;
      algorithm
        ddew := sum({coeff[i] * (p * 1e-5) ^ (i - 1) for i in 1:n});
        dd_dp := sum({1e-5 * (i - 1) * coeff[i] * (p * 1e-5) ^ (i - 2) for i in 1:n});
      end ddew_p;

      function ddhp2p_ph "derivative of density w.r.t. spec. enthalpy at constant pressure in two-phase region"
        input Units.Pressure p;
        input Units.SpecificEnthalpy h;
        output Real ddhp;
      protected
        Real dTdp(unit = "K/Pa");
        Modelica.SIunits.Temperature T;
        Modelica.SIunits.Density d;
      algorithm
        (T, dTdp) := Water_poly.Functions.Tsat_p(p);
        d := Water_poly.Functions.density_ph(p, h);
        ddhp := -d * d / T * dTdp;
      end ddhp2p_ph;

      function ddhp_ph "Water density derivative w.r.t h at constant p"
        input Units.Pressure p;
        input Units.SpecificEnthalpy h;
        //output Modelica.SIunits.Density ddhp;
        output Real ddhp;
      protected
        constant Real deltah = 1.0e1;
        Real ddew = Water_poly.Functions.ddew_p(p);
        Real dbub = Water_poly.Functions.dbub_p(p);
        Real x = Water_poly.Functions.x_ph(p, h);
        Real hbub = Water_poly.Functions.hbub_p(p);
        Real hdew = Water_poly.Functions.hdew_p(p);
        Real d_tmp;
        Real ddph_tmp;
        Real ddhp_2p;
        Real ddhp_tmp;
        Real v_tmp;
        Real dvph_tmp;
        Real dvhp_tmp;
      algorithm
        (d_tmp, ddph_tmp, ddhp_tmp) := Water_poly.Functions.dliq_ph(p, h);
        (v_tmp, dvph_tmp, dvhp_tmp) := Water_poly.Functions.vvap_ph(p, h);
        ddhp_2p := Water_poly.Functions.ddhp2p_ph(p, h);
//ddhp := noEvent(if h < hbub then ddhp_tmp else if h > hdew then -dvhp_tmp/(v_tmp*v_tmp) else ddph_2p);
        ddhp := (1 - cubicStep((h - hbub) / deltah)) * ddhp_tmp - cubicStep((h - hdew) / deltah) * dvhp_tmp / (v_tmp * v_tmp) + cubicStep((h - hbub) / deltah) * (1 - cubicStep((h - hdew) / deltah)) * ddhp_2p;
      end ddhp_ph;

      function ddph2p_ph "derivative of density w.r.t. pressure at constant spec. enthalpy in two-phase region"
        input Units.Pressure p;
        input Units.SpecificEnthalpy h;
        output Real ddph;
      protected
        Real dTdp(unit = "K/Pa");
        Modelica.SIunits.Temperature T;
        Modelica.SIunits.Density d;
        Modelica.SIunits.SpecificHeatCapacity cv;
      algorithm
        (T, dTdp) := Water_poly.Functions.Tsat_p(p);
        cv := Water_poly.Functions.cv2p_ph(p, h);
        d := Water_poly.Functions.density_ph(p, h);
        ddph := d * d * cv / T * dTdp * dTdp + d / T * dTdp;
      end ddph2p_ph;

      function ddph_ph "Water density derivative w.r.t p at constant h"
        input Units.Pressure p;
        input Units.SpecificEnthalpy h;
        //output Modelica.SIunits.Density ddph;
        output Real ddph;
      protected
        constant Real deltah = 1.0e1;
        Real ddew = Water_poly.Functions.ddew_p(p);
        Real dbub = Water_poly.Functions.dbub_p(p);
        Real x = Water_poly.Functions.x_ph(p, h);
        Real hbub = Water_poly.Functions.hbub_p(p);
        Real hdew = Water_poly.Functions.hdew_p(p);
        Real d_tmp;
        Real ddph_tmp;
        Real ddph_2p;
        Real ddhp_tmp;
        Real v_tmp;
        Real dvph_tmp;
        Real dvhp_tmp;
      algorithm
        (d_tmp, ddph_tmp, ddhp_tmp) := Water_poly.Functions.dliq_ph(p, h);
        (v_tmp, dvph_tmp, dvhp_tmp) := Water_poly.Functions.vvap_ph(p, h);
        ddph_2p := Water_poly.Functions.ddph2p_ph(p, h);
//ddph := noEvent(if h < hbub then ddph_tmp else if h > hdew then -dvph_tmp/(v_tmp*v_tmp) else ddph_2p);
        ddph := (1 - cubicStep((h - hbub) / deltah)) * ddph_tmp - cubicStep((h - hdew) / deltah) * dvph_tmp / (v_tmp * v_tmp) + cubicStep((h - hbub) / deltah) * (1 - cubicStep((h - hdew) / deltah)) * ddph_2p;
      end ddph_ph;

      function density_ph "Water density"
        input Units.Pressure p;
        input Units.SpecificEnthalpy h;
        output Modelica.SIunits.Density d;
      protected
        constant Real deltah = 1.0e1;
        Real ddew = Water_poly.Functions.ddew_p(p);
        Real dbub = Water_poly.Functions.dbub_p(p);
        Real x = Water_poly.Functions.x_ph(p, h);
        Real hbub = Water_poly.Functions.hbub_p(p);
        Real hdew = Water_poly.Functions.hdew_p(p);
        Real dl;
        Real dv;
        Real d2p;
      algorithm
        dl := Water_poly.Functions.dliq_ph(p, h);
        dv := 1 / Water_poly.Functions.vvap_ph(p, h);
        d2p := 1 / (x / ddew + (1 - x) / dbub);
        d := (1 - cubicStep((h - hbub) / deltah)) * dl + cubicStep((h - hdew) / deltah) * dv + cubicStep((h - hbub) / deltah) * (1 - cubicStep((h - hdew) / deltah)) * d2p;
//d := noEvent(if h < hbub then dl else if h > hdew then dv else d2p);
      end density_ph;

      function dliq_ph "Liquid density as a function of pressure and enthalpy"
        input Units.Pressure p;
        input Units.SpecificEnthalpy h;
        output Modelica.SIunits.Density d;
        output Real dd_dp;
        output Real dd_dh;
      protected
        Modelica.SIunits.Density dbub;
        Modelica.SIunits.Density dd1;
        Modelica.SIunits.Pressure pbub;
        Real dd_bub_dp;
        Real dpbub_dh;
        constant Integer n = size(Data.d_liq_coeff, 1);
        Real[n] coeff = Data.d_liq_coeff;
      algorithm
        (pbub, dpbub_dh) := Water_poly.Functions.pbub_h(h);
        (dbub, dd_bub_dp) := Water_poly.Functions.dbub_p(pbub);
        dd1 := (Modelica.Math.log(p) - Modelica.Math.log(pbub)) * sum({coeff[i] * (h * 1e-5) ^ (i - 1) for i in 1:n});
        d := dbub + dd1;
        dd_dp := 1 / p * sum({coeff[i] * (h * 1e-5) ^ (i - 1) for i in 1:n});
        dd_dh := dd_bub_dp * dpbub_dh + (Modelica.Math.log(p) - Modelica.Math.log(pbub)) * sum({1e-5 * (i - 1) * coeff[i] * (h * 1e-5) ^ (i - 2) for i in 1:n}) - 1 / pbub * dpbub_dh * sum({coeff[i] * (h * 1e-5) ^ (i - 1) for i in 1:n});
      end dliq_ph;

      function hbub_p "Bubble enthalpy as a function of pressure"
        input Units.Pressure p;
        output Units.SpecificEnthalpy h;
      protected
        Real b[3] = Data.p_bub_coeff;
      algorithm
        h := ((-b[2] / b[3] / 2) - sqrt((b[2] / 2 / b[3]) ^ 2 + (p ^ (1 / 6) - b[1]) / b[3])) * 1e5;
      end hbub_p;

      function hdew_p "Dew enthalpy as a function of pressure"
        input Units.Pressure p;
        output Units.SpecificEnthalpy hdew;
        output Modelica.SIunits.DerEnthalpyByPressure dhdew_dp;
      protected
        constant Integer n = size(Data.h_dew_coeff, 1);
        Real[n] coeff = Data.h_dew_coeff;
      algorithm
        hdew := sum({coeff[i] * Modelica.Math.log(p) ^ (i - 1) for i in 1:n}) * 1e5;
        dhdew_dp := sum({(i - 1) * coeff[i] * Modelica.Math.log(p) ^ (i - 2) / p for i in 1:n}) * 1e5;
      end hdew_p;

      function pbub_h "Bubble pressure as a function of enthalpy"
        input Units.SpecificEnthalpy h;
        output Units.Pressure p;
        output Real dp_dh;
      protected
        constant Integer n = size(Data.p_bub_coeff, 1);
        Real[n] coeff = Data.p_bub_coeff;
      algorithm
        p := sum({coeff[i] * (h * 1e-5) ^ (i - 1) for i in 1:n}) ^ 6;
        dp_dh := 6 * sum({1e-5 * (i - 1) * coeff[i] * (h * 1e-5) ^ (i - 2) for i in 1:n}) * sum({coeff[i] * (h * 1e-5) ^ (i - 1) for i in 1:n}) ^ 5;
      end pbub_h;

      function temperature_ph "Water temperature"
        input Units.Pressure p;
        input Units.SpecificEnthalpy h;
        output Modelica.SIunits.Temperature T;
      protected
        constant Real deltah = 1.0e1;
        Real x = Water_poly.Functions.x_ph(p, h);
        Real hbub = Water_poly.Functions.hbub_p(p);
        Real hdew = Water_poly.Functions.hdew_p(p);
        Real Tl;
        Real Tv;
        Real T2p;
      algorithm
        assert(h > 1e5, "Too low entahlpy");
        Tl := Water_poly.Functions.Tliq_ph(p, h);
        Tv := Water_poly.Functions.Tvap_ph(p, h);
        T2p := Water_poly.Functions.Tsat_p(p);
        T := (1 - cubicStep((h - hbub) / deltah)) * Tl + cubicStep((h - hdew) / deltah) * Tv + cubicStep((h - hbub) / deltah) * (1 - cubicStep((h - hdew) / deltah)) * T2p;
//T := noEvent(if h < hbub then Tl else if h > hdew then Tv else T2p);
      end temperature_ph;

      function Tliq_ph "Liquid temperature as a function of enthalpy and pressure"
        input Units.Pressure p;
        input Units.SpecificEnthalpy h;
        output Modelica.SIunits.Temperature T;
      protected
        Modelica.SIunits.Pressure pbub = Water_poly.Functions.pbub_h(h);
        Modelica.SIunits.Temperature Tsat = Water_poly.Functions.Tsat_p(pbub);
        Modelica.SIunits.Temperature dT1;
        constant Integer n = size(Data.T_liq_coeff, 1);
        Real[n] coeff = Data.T_liq_coeff;
      algorithm
        dT1 := (Modelica.Math.log(p) - Modelica.Math.log(pbub)) * sum({coeff[i] * (h * 1e-5) ^ (i - 1) for i in 1:n});
        T := Tsat + dT1;
      end Tliq_ph;

      function Tsat_p "Saturation temperature as a functio nof pressure"
        input Units.Pressure p;
        output Modelica.SIunits.Temperature T_sat;
        output Real dTdp(unit = "K/Pa");
      protected
        constant Integer n = size(Data.T_sat_coeff, 1);
        Real[n] coeff = Data.T_sat_coeff;
      algorithm
//T_sat :=sum({coeff[i]*Modelica.Math.log(p)^(i-1) for i in 1:n});
        T_sat := sum({coeff[i] * Modelica.Math.log(p + 0.0001) ^ (i - 1) for i in 1:n});
        dTdp := sum({(i - 1) * coeff[i] * Modelica.Math.log(p) ^ (i - 2) / p for i in 1:n});
//
//dTdp :=sum({(i-1)*coeff[i]*Modelica.Math.log(p)^(i-2)/p for i in 1:n});//
      end Tsat_p;

      function Tvap_ph "Vapor temperature as a function of enthalpy and pressure"
        input Units.Pressure p;
        input Units.SpecificEnthalpy h;
        output Modelica.SIunits.Temperature T;
      protected
        Modelica.SIunits.Temperature Tsat = Water_poly.Functions.Tsat_p(p);
        Modelica.SIunits.Temperature dT1;
        Modelica.SIunits.Temperature dT2;
        Units.SpecificEnthalpy hdew = Water_poly.Functions.hdew_p(p);
        constant Integer n = size(Data.T_vap_coeff, 1);
        Real[n] coeff = Data.T_vap_coeff;
      algorithm
        dT1 := (h - hdew) * 1e-5 * sum({coeff[i] * Modelica.Math.log(p) ^ (i - 1) for i in 1:n - 2});
        dT2 := ((h - hdew) * 1e-5) ^ 2 * sum({coeff[size(coeff, 1) - 2 + i] * Modelica.Math.log(p) ^ (i - 1) for i in 1:2});
        T := Tsat + dT1 + dT2;
      end Tvap_ph;

      function vvap_ph "Vapor specific volume as a function of pressure and enthalpy"
        input Units.Pressure p;
        input Units.SpecificEnthalpy h;
        output Modelica.SIunits.SpecificVolume v;
        output Real dv_dp;
        output Real dv_dh;
      protected
        Modelica.SIunits.SpecificVolume vdew = 1 / Water_poly.Functions.ddew_p(p);
        Modelica.SIunits.SpecificVolume dv1;
        Units.SpecificEnthalpy hdew = Water_poly.Functions.hdew_p(p);
        Real ddew;
        Real dd_dew_dp;
        constant Integer n = size(Data.v_vap_coeff, 1);
        Real[n] coeff = Data.v_vap_coeff;
      algorithm
        (ddew, dd_dew_dp) := Water_poly.Functions.ddew_p(p);
        dv1 := (h - hdew) * 1e-5 * sum({coeff[i] * Modelica.Math.log(p) ^ (i - 1) for i in 1:n});
        v := vdew + dv1;
        dv_dp := (-vdew ^ 2 * dd_dew_dp) - (h - hdew) * 1e-5 * sum({(i - 1) * coeff[i] * Modelica.Math.log(p) ^ (i - 2) / p for i in 1:n}) * vdew ^ 2;
        dv_dh := 1e-5 * sum({coeff[i] * Modelica.Math.log(p) ^ (i - 1) for i in 1:n});
      end vvap_ph;

      function x_ph "vapor quality"
        input Units.Pressure p;
        input Units.SpecificEnthalpy h;
        output Real x;
      protected
        Modelica.SIunits.SpecificEnthalpy hbub = Water_poly.Functions.hbub_p(p);
        Modelica.SIunits.SpecificEnthalpy hdew = Water_poly.Functions.hdew_p(p);
      algorithm
        x := noEvent(if (h - hbub) / (hdew - hbub) > 1 then 1 else if (h - hbub) / (hdew - hbub) < 0 then 0 else (h - hbub) / (hdew - hbub));
      end x_ph;
    end Functions;

    package Units
      type Area = Modelica.SIunits.Area(start = 1, min = 0, max = 1000000, nominal = 1);
      type CoefficientOfHeatTransfer = Modelica.SIunits.CoefficientOfHeatTransfer(start = 100, min = 1, max = 100000, nominal = 100);
      type Density = Modelica.SIunits.Density(start = 100, min = 0, max = 4000, nominal = 100);
      type HeatFlowRate = Modelica.SIunits.HeatFlowRate(start = 1.0e8, min = -1.0e11, max = 1.0e11, nominal = 1.0e8);
      type Length = Modelica.SIunits.Length(start = 1, min = 0, max = 1000000, nominal = 1);
      type Mass = Modelica.SIunits.Mass(start = 100, min = 0, max = 1000, nominal = 100);
      type MassFlowRate = Modelica.SIunits.MassFlowRate(min = -1000, max = 1000, nominal = 100);
      type Pressure = Modelica.SIunits.Pressure(start = 5.0e5, min = 0.1e5, max = 20.0e6, nominal = 5.0e5);
      type SpecificEnthalpy = Modelica.SIunits.SpecificEnthalpy(start = 0.8e6, min = 1e5, max = 3.6e6, nominal = 1.0e6);
      type SpecificHeatCapacity = Modelica.SIunits.SpecificHeatCapacity(start = 1, min = 0, max = 10000, nominal = 1);
      type Temperature = Modelica.SIunits.Temperature(start = 400, min = 273, max = 1500, nominal = 400);
      type Volume = Modelica.SIunits.Volume(start = 1, min = 0, max = 10000, nominal = 1);
    end Units;
    annotation(uses(Modelica(version = "3.2")));
  end Water_poly;

  package Components
    package Water
    package Models  
      model FlowHE_Evap
        import MyHRSGj.Components.Water.Functions.phi_heatedPipe;
        import MyHRSGj.Components.Water.Functions.lambda_tr;
        //**
        //***Исходные данные
        //**
        parameter Modelica.SIunits.MassFlowRate m_flow_small = 0.01 "Минимальный расход";  
        constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
        constant Modelica.SIunits.Pressure pc = 22064000.0;
        constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
        parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.Enthalpy seth_in "Начальная входная энтальпия";
        parameter Modelica.SIunits.Enthalpy seth_out "Начальная выходная энтальпия";
        //**
        //***Характеристики металла
        parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
        parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
        parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
        //**
        //**
        //Конструктивные характеристики
        //**
        //Параметры
        parameter MyHRSGj.Components.Choices.HRSG_type HRSG_type = MyHRSG.Choices.HRSG_type.horizontalBottom "Тип КУ";
        parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberFirstTubeInLastZahod = integer(numberOfFlueSections - zahod + 1) "Номер первой трубы в последнем заходе";
        parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer zahod = 1 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer z2 = 2 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
        //Поток вода/пар
        parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 / numberOfTubeSections "Внутренняя площадь одного участка ряда труб";
        parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 / 4 / numberOfTubeSections "Внутренний объем одного участка ряда труб";
        parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 / numberOfTubeSections "Масса металла участка ряда труб";
        parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
        parameter Boolean avoidInletEnthalpyDerivative = true "Avoid inlet enthalpy derivative";
        //**
        //Начальные значения
        //**
        //Поток вода/пар
        parameter Modelica.SIunits.Enthalpy h_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(seth_in, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
        parameter Modelica.SIunits.Enthalpy h_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(seth_in, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
        parameter Modelica.SIunits.Pressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
        parameter Modelica.SIunits.Pressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
        parameter Modelica.SIunits.MassFlowRate D_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(setD_flow / zahod, numberOfFlueSections, numberOfTubeSections) "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
        parameter Modelica.SIunits.MassFlowRate D_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(setD_flow / zahod, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
        //Металл
        parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = fill(setTm, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
        //**
        //Переменные
        //**
        Modelica.SIunits.Length deltaHpipe "Разность высот на участке ряда труб";
        //Поток вода/пар
        Modelica.SIunits.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
        Modelica.SIunits.Pressure p_v(start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
        Modelica.SIunits.Pressure p_n[2](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
        Modelica.SIunits.Enthalpy h_v[numberOfFlueSections, numberOfTubeSections](start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
        Modelica.SIunits.Enthalpy h_n[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
        Real der_h_n[numberOfFlueSections, numberOfTubeSections + 1] "Производняа энтальпии потока вода/пар";
        Modelica.SIunits.Density rho_v[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы в конечных объемах";
        Modelica.SIunits.Density rho_n[numberOfFlueSections, numberOfTubeSections + 1] "Плотность потока по участкам трубы в конечных объемах";
        Modelica.SIunits.Density rho_v_av "Осредненная по заходу плотность потока по участкам трубы в конечных объемах";
        Modelica.SIunits.DerDensityByEnthalpy drdh_v1[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
        Modelica.SIunits.DerDensityByEnthalpy drdh_v2[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
        Modelica.SIunits.DerDensityByEnthalpy drdh_n[numberOfFlueSections, numberOfTubeSections + 1] "Производная плотности потока по энтальпии на участках ряда труб";
        Modelica.SIunits.DerDensityByPressure drdp_v[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
        Modelica.SIunits.DerDensityByPressure drdp_n[numberOfFlueSections, numberOfTubeSections + 1] "Производная плотности потока по давлению на участках ряда труб";
        Modelica.SIunits.MassFlowRate D_flow_v[numberOfFlueSections, numberOfTubeSections](start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
        Modelica.SIunits.MassFlowRate D_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
        Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
        Modelica.SIunits.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
        Modelica.SIunits.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
        Modelica.SIunits.HeatFlowRate Q_flow[numberOfFlueSections, numberOfTubeSections] "тепло переданное стенке трубы";
        Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
        Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
        Real Re_flow_av "Число Рейнольдса осредненное по заходу";
        Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
        Real C1[numberOfFlueSections, numberOfTubeSections] "Показатель в числителе уравнения сплошности";
        Real C2[numberOfFlueSections, numberOfTubeSections] "Показатель в знаменателе уравнения сплошности";
        Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
        Modelica.SIunits.Length H_flow[2] "Высотная отметка каждого узла";
        Modelica.SIunits.Velocity w_flow_v[numberOfFlueSections, numberOfTubeSections] "Скорость потока вода/пар в конечных объемах";
        Modelica.SIunits.Velocity w_flow_v_av "Средняя по заходу скорость потока вода/пар в конечных объемах";
        Real dp_fric "Потеря давления из-за сил трения";
        Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
        Real wrhop "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
        Real phi "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
        Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
        Real x_v[numberOfFlueSections, numberOfTubeSections] "Степень сухости";
        Real x_v_av "Степень сухости осредненная по заходу";
        Modelica.SIunits.Density rhov "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
        Modelica.SIunits.Density rhol "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
        //Medium_F.Temperature Ts "Температура на линии насыщения";
        Modelica.SIunits.Enthalpy hl "Энтальпия воды на линии насыщения";
        Modelica.SIunits.Enthalpy hv "Энтальпия пара на линии насыщения";
        Modelica.SIunits.DerDensityByPressure drldp;
        Modelica.SIunits.DerDensityByPressure drvdp;
        Modelica.SIunits.DerDensityByEnthalpy dhldp;
        Modelica.SIunits.DerDensityByEnthalpy dhvdp;
        Real AA;
        Real AA1;
        //**
        //Интерфейс
        //**
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        MyHRSGj.Components.Water.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
        MyHRSGj.Components.Water.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
        if HRSG_type == MyHRSG.Choices.HRSG_type.horizontalBottom then
          deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
        elseif HRSG_type == MyHRSG.Choices.HRSG_type.horizontalTop then
          deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
        elseif HRSG_type == MyHRSG.Choices.HRSG_type.verticalBottom then
          deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
        else
          deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
        end if;
//*****Уравнения для потока вода/пар и металла
        for i in 1:numberOfFlueSections loop
          hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева";
//Уравнения для расчета процессов теплообмена
          for j in 1:numberOfTubeSections loop
//Осреднение по конечному объему
            deltaVFlow * rho_v[i, j] * der(h_v[i, j]) = 0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - D_flow_v[i, j] * (h_v[i, j] - h_n[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
            deltaVFlow * rho_v[i, j] * der_h_n[i, j + 1] = 0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - D_flow_v[i, j] * (h_n[i, j + 1] - h_v[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
            deltaMMetal * C_m * der(t_m[i, j]) = Q_flow[i, j] - alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
            if hod[i] < 0 then
              heat[i, j].Q_flow = Q_flow[i, j];
              heat[i, j].T = t_m[i, j];
            else
              heat[i, j].Q_flow = Q_flow[i, numberOfTubeSections - j + 1];
              heat[i, j].T = t_m[i, numberOfTubeSections - j + 1];
            end if;
//Уравнения состояния
            stateFlow[i, j] = Medium_F.setState_ph(p_v, h_v[i, j]);
            t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
            k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
            Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
            mu_flow[i, j] = if Medium_F.dynamicViscosity(stateFlow[i, j]) < 1.503e-004 then 1.503e-004 else Medium_F.dynamicViscosity(stateFlow[i, j]);
            w_flow_v[i, j] = D_flow_v[i, j] / rho_v[i, j] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
            Re_flow[i, j] = abs(w_flow_v[i, j] * Din * rho_v[i, j] / mu_flow[i, j]);
            alfa_flow[i, j] = if D_flow_v[i, j] > 0.001 then 0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4 else 0;
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium_F2.setState_ph(p_v, h_v[i, j]);
            x_v[i, j] = if h_v[i, j] < hl then 0 elseif h_v[i, j] > hv then 1 else (h_v[i, j] - hl) / (hv - hl);
            D_flow_v[i, j] = (D_flow_n[i, j + 1] + D_flow_n[i, j]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
            D_flow_n[i, j + 1] = D_flow_n[i, j] - C1[i, j] - C2[i, j] "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
            C1[i, j] = deltaVFlow * (drdh_v1[i, j] * der_h_n[i, j] + drdh_v2[i, j] * der_h_n[i, j + 1]);
            C2[i, j] = deltaVFlow * drdp_v[i, j] * der(p_v);
            if avoidInletEnthalpyDerivative and i == 1 and j == zahod then
// first volume properties computed by the outlet properties
              rho_v[i, j] = rho_n[i, j + 1];
              drdp_v[i, j] = drdp_n[i, j + 1];
              drdh_v1[i, j] = 0;
              drdh_v2[i, j] = drdh_n[i, j + 1];
            elseif noEvent(h_n[i, j] < hl and h_n[i, j + 1] < hl or h_n[i, j] > hv and h_n[i, j + 1] > hv or p_v >= pc - pzero or abs(h_n[i, j + 1] - h_n[i, j]) < hzero) then
// 1-phase or almost uniform properties
              rho_v[i, j] = (rho_n[i, j] + rho_n[i, j + 1]) / 2;
              drdp_v[i, j] = (drdp_n[i, j] + drdp_n[i, j + 1]) / 2;
              drdh_v1[i, j] = drdh_n[i, j] / 2;
              drdh_v2[i, j] = drdh_n[i, j + 1] / 2;
            elseif noEvent(h_n[i, j] >= hl and h_n[i, j] <= hv and h_n[i, j + 1] >= hl and h_n[i, j + 1] <= hv) then
// 2-phase
              rho_v[i, j] = AA * log(rho_n[i, j] / rho_n[i, j + 1]) / (h_n[i, j + 1] - h_n[i, j]);
              drdp_v[i, j] = (AA1 * log(rho_n[i, j] / rho_n[i, j + 1]) + AA * (1 / rho_n[i, j] * drdp_n[i, j] - 1 / rho_n[i, j + 1] * drdp_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v1[i, j] = (rho_v[i, j] - rho_n[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v2[i, j] = (rho_n[i, j + 1] - rho_v[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
            elseif noEvent(h_n[i, j] < hl and h_n[i, j + 1] >= hl and h_n[i, j + 1] <= hv) then
// liquid/2-phase
              rho_v[i, j] = ((rho_n[i, j] + rhol) * (hl - h_n[i, j]) / 2 + AA * log(rhol / rho_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
              drdp_v[i, j] = ((drdp_n[i, j] + drldp) * (hl - h_n[i, j]) / 2 + (rho_n[i, j] + rhol) / 2 * dhldp + AA1 * log(rhol / rho_n[i, j + 1]) + AA * (1 / rhol * drldp - 1 / rho_n[i, j + 1] * drdp_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v1[i, j] = (rho_v[i, j] - (rho_n[i, j] + rhol) / 2 + drdh_n[i, j] * (hl - h_n[i, j]) / 2) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v2[i, j] = (rho_n[i, j + 1] - rho_v[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
            elseif noEvent(h_n[i, j] >= hl and h_n[i, j] <= hv and h_n[i, j + 1] > hv) then
// 2-phase/vapour
              rho_v[i, j] = (AA * log(rho_n[i, j] / rhov) + (rhov + rho_n[i, j + 1]) * (h_n[i, j + 1] - hv) / 2) / (h_n[i, j + 1] - h_n[i, j]);
              drdp_v[i, j] = (AA1 * log(rho_n[i, j] / rhov) + AA * (1 / rho_n[i, j] * drdp_n[i, j] - 1 / rhov * drvdp) + (drvdp + drdp_n[i, j + 1]) * (h_n[i, j + 1] - hv) / 2 - (rhov + rho_n[i, j + 1]) / 2 * dhvdp) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v1[i, j] = (rho_v[i, j] - rho_n[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v2[i, j] = ((rhov + rho_n[i, j + 1]) / 2 - rho_v[i, j] + drdh_n[i, j + 1] * (h_n[i, j + 1] - hv) / 2) / (h_n[i, j + 1] - h_n[i, j]);
            elseif noEvent(h_n[i, j] < hl and h_n[i, j + 1] > hv) then
// liquid/2-phase/vapour
              rho_v[i, j] = ((rho_n[i, j] + rhol) * (hl - h_n[i, j]) / 2 + AA * log(rhol / rhov) + (rhov + rho_n[i, j + 1]) * (h_n[i, j + 1] - hv) / 2) / (h_n[i, j + 1] - h_n[i, j]);
              drdp_v[i, j] = ((drdp_n[i, j] + drldp) * (hl - h_n[i, j]) / 2 + (rho_n[i, j] + rhol) / 2 * dhldp + AA1 * log(rhol / rhov) + AA * (1 / rhol * drldp - 1 / rhov * drvdp) + (drvdp + drdp_n[i, j + 1]) * (h_n[i, j + 1] - hv) / 2 - (rhov + rho_n[i, j + 1]) / 2 * dhvdp) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v1[i, j] = (rho_v[i, j] - (rho_n[i, j] + rhol) / 2 + drdh_n[i, j] * (hl - h_n[i, j]) / 2) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v2[i, j] = ((rhov + rho_n[i, j + 1]) / 2 - rho_v[i, j] + drdh_n[i, j + 1] * (h_n[i, j + 1] - hv) / 2) / (h_n[i, j + 1] - h_n[i, j]);
            elseif noEvent(h_n[i, j] >= hl and h_n[i, j] <= hv and h_n[i, j + 1] < hl) then
// 2-phase/liquid
              rho_v[i, j] = (AA * log(rho_n[i, j] / rhol) + (rhol + rho_n[i, j + 1]) * (h_n[i, j + 1] - hl) / 2) / (h_n[i, j + 1] - h_n[i, j]);
              drdp_v[i, j] = (AA1 * log(rho_n[i, j] / rhol) + AA * (1 / rho_n[i, j] * drdp_n[i, j] - 1 / rhol * drldp) + (drldp + drdp_n[i, j + 1]) * (h_n[i, j + 1] - hl) / 2 - (rhol + rho_n[i, j + 1]) / 2 * dhldp) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v1[i, j] = (rho_v[i, j] - rho_n[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v2[i, j] = ((rhol + rho_n[i, j + 1]) / 2 - rho_v[i, j] + drdh_n[i, j + 1] * (h_n[i, j + 1] - hl) / 2) / (h_n[i, j + 1] - h_n[i, j]);
            elseif noEvent(h_n[i, j] > hv and h_n[i, j + 1] < hl) then
// vapour/2-phase/liquid
              rho_v[i, j] = ((rho_n[i, j] + rhov) * (hv - h_n[i, j]) / 2 + AA * log(rhov / rhol) + (rhol + rho_n[i, j + 1]) * (h_n[i, j + 1] - hl) / 2) / (h_n[i, j + 1] - h_n[i, j]);
              drdp_v[i, j] = ((drdp_n[i, j] + drvdp) * (hv - h_n[i, j]) / 2 + (rho_n[i, j] + rhov) / 2 * dhvdp + AA1 * log(rhov / rhol) + AA * (1 / rhov * drvdp - 1 / rhol * drldp) + (drldp + drdp_n[i, j + 1]) * (h_n[i, j + 1] - hl) / 2 - (rhol + rho_n[i, j + 1]) / 2 * dhldp) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v1[i, j] = (rho_v[i, j] - (rho_n[i, j] + rhov) / 2 + drdh_n[i, j] * (hv - h_n[i, j]) / 2) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v2[i, j] = ((rhol + rho_n[i, j + 1]) / 2 - rho_v[i, j] + drdh_n[i, j + 1] * (h_n[i, j + 1] - hl) / 2) / (h_n[i, j + 1] - h_n[i, j]);
            else
// vapour/2-phase
              rho_v[i, j] = ((rho_n[i, j] + rhov) * (hv - h_n[i, j]) / 2 + AA * log(rhov / rho_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
              drdp_v[i, j] = ((drdp_n[i, j] + drvdp) * (hv - h_n[i, j]) / 2 + (rho_n[i, j] + rhov) / 2 * dhvdp + AA1 * log(rhov / rho_n[i, j + 1]) + AA * (1 / rhov * drvdp - 1 / rho_n[i, j + 1] * drdp_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
              drdh_v1[i, j] = (rho_v[i, j] - (rho_n[i, j] + rhov) / 2 + drdh_n[i, j] * (hv - h_n[i, j]) / 2) / (drdp_n[i, j] - h_n[i, j]);
              drdh_v2[i, j] = (rho_n[i, j + 1] - rho_v[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
            end if;
          end for;
          for j in 1:numberOfTubeSections + 1 loop
            stateFlow_n[i, j] = Medium_F.setState_ph(p_v, h_n[i, j]);
            drdp_n[i, j] = Medium_F.density_derp_h(stateFlow_n[i, j]);
            drdh_n[i, j] = Medium_F.density_derh_p(stateFlow_n[i, j]);
            rho_n[i, j] = Medium_F.density(stateFlow_n[i, j]);
            der_h_n[i, j] = der(h_n[i, j]);
          end for;
        end for;
        sat_v = Medium_F2.setSat_p(p_v);
//Ts = sat_v.Tsat;
        rhol = Medium_F2.bubbleDensity(sat_v);
        rhov = Medium_F2.dewDensity(sat_v);
        hl = Medium_F2.bubbleEnthalpy(sat_v);
        hv = Medium_F2.dewEnthalpy(sat_v);
        drldp = Medium_F2.dBubbleDensity_dPressure(sat_v);
        drvdp = Medium_F2.dDewDensity_dPressure(sat_v);
        dhldp = Medium_F2.dBubbleEnthalpy_dPressure(sat_v);
        dhvdp = Medium_F2.dDewEnthalpy_dPressure(sat_v);
        AA = (hv - hl) / (1 / rhov - 1 / rhol);
        AA1 = ((dhvdp - dhldp) * (rhol - rhov) * rhol * rhov - (hv - hl) * (rhov ^ 2 * drldp - rhol ^ 2 * drvdp)) / (rhol - rhov) ^ 2;
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
        p_v = (p_n[1] + p_n[2]) / 2;
//Основное уравнение гидравлики
        w_flow_v_av = sum(w_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
        rho_v_av = sum(rho_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
        Re_flow_av = sum(Re_flow[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
        x_v_av = sum(x_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
        wrhop = w_flow_v_av * rho_v_av * p_v * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
        Xi_flow = lambda_tr(Din, ke, Re_flow_av) * Lpipe * numberOfFlueSections / zahod / Din;
        phi = phi_heatedPipe(wrhop, p_v / 100000, x_v_av) "Расчет коэффициента phi";
        dp_fric = homotopy(if x_v_av < 1 then w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * phi * (rhol / rhov - 1)) else w_flow_v_av ^ 2 * Xi_flow * rho_v_av / 2 / Modelica.Constants.g_n, 100000 * waterIn.m_flow / setD_flow) "Потеря давления от трения";
        p_n[1] - p_n[2] = dp_fric + dp_piez "Формула 2-1 из книги Рудомино, Ремжин";
        if HRSG_type == MyHRSG.Choices.HRSG_type.horizontalBottom then
          H_flow[2] = H_flow[1] - sum(hod[i] * deltaHpipe for i in 1:numberOfFlueSections / zahod) "Расчет высотных отметок для горизонтального КУ";
        elseif HRSG_type == MyHRSG.Choices.HRSG_type.horizontalTop then
          H_flow[2] = H_flow[1] + sum(hod[i] * deltaHpipe for i in 1:numberOfFlueSections / zahod) "Расчет высотных отметок для горизонтального КУ";
        elseif HRSG_type == MyHRSG.Choices.HRSG_type.verticalBottom then
          H_flow[2] = H_flow[1] + deltaHpipe * (numberOfFlueSections - 1) "Расчет высотных отметок для вертикального КУ";
        else
          H_flow[2] = H_flow[1] - deltaHpipe * (numberOfFlueSections - 1) "Расчет высотных отметок для вертикального КУ";
        end if;
        dp_piez = (rho_n[numberOfFlueSections, numberOfTubeSections + 1] * H_flow[2] - rho_n[1, 1] * H_flow[1]) * Modelica.Constants.g_n "Расчет перепада давления из-за изменения пьезометрической высоты";
        for i in 1:numberOfFlueSections - zahod loop
//Описание гибов
          D_flow_n[i, numberOfTubeSections + 1] = D_flow_n[i + zahod, 1];
          h_n[i, numberOfTubeSections + 1] = h_n[i + zahod, 1];
//Для горизонтальных КУ
        end for;
//Граничные условия
//Граничные условия для высотной отметки входного коллектора
        if HRSG_type == MyHRSG.Choices.HRSG_type.verticalBottom then
          H_flow[1] = 0 "Задание высотной отметки входного коллектора";
        elseif HRSG_type == Choices.HRSG_type.horizontalBottom then
          H_flow[1] = 0 "Задание высотной отметки входного коллектора";
        elseif HRSG_type == MyHRSG.Choices.HRSG_type.horizontalTop then
          H_flow[1] = Lpipe "Задание высотной отметки входного коллектора";
        else
          H_flow[1] = deltaHpipe * (numberOfFlueSections - 1) "Задание высотной отметки входного коллектора";
        end if;
        for i in 1:zahod loop
          max(waterIn.m_flow, m_flow_small) / zahod = D_flow_n[i, 1];
        end for;
        waterOut.m_flow = -sum(D_flow_n[i, numberOfTubeSections + 1] for i in numberFirstTubeInLastZahod:numberOfFlueSections);
        waterOut.p = p_n[2];
        waterIn.p = p_n[1];
        for i in 1:zahod loop
          h_n[i, 1] = inStream(waterIn.h_outflow);
        end for;
        waterOut.h_outflow = sum(array(max(D_flow_n[i, numberOfTubeSections + 1], m_flow_small) * h_n[i, numberOfTubeSections + 1] for i in numberFirstTubeInLastZahod:numberOfFlueSections)) / sum(array(max(D_flow_n[i, numberOfTubeSections + 1], m_flow_small) for i in numberFirstTubeInLastZahod:numberOfFlueSections));
        waterIn.h_outflow = sum(array(max(D_flow_n[i, 1], m_flow_small) * h_n[i, 1] for i in 1:zahod)) / sum(array(max(D_flow_n[i, 1], m_flow_small) for i in 1:zahod));
      initial equation
        for i in 1:numberOfFlueSections loop
          for j in 1:numberOfTubeSections loop
            der(h_v[i, j]) = 0;
            der(t_m[i, j]) = 0;
            der(h_n[i, j + 1]) = 0;
          end for;
          for j in 1:numberOfTubeSections + 1 loop
          end for;
        end for;
        der(p_v) = 0;
        annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
      end FlowHE_Evap;
end Models;
    package Functions
      function phi_heatedPipe "Функция для расчета коэффициента phi к формуле расчета потерь трения при течении двухфазного потока в обогреваемой трубе (оцифровка номограммы 5а из гидравлического расчета котельных агрегатов)"
        input Real wrhop;
        input Real p "Давление в кгс/см2";
        input Real x;
        output Real phi;
      protected
        Real p_up;
        Real p_down;
        Real phi_up "phi расчитанное по ф-ле для wrhop_up для интерполяции";
        Real phi_down "phi расчитанное по ф-ле для wrop_down для интерполяции";
        Real wrhop_up "wrhop большее чем заданное, из номограммы 5";
        Real wrhop_down "wrhop меньшее чем заданное, из номограммы 5";
        Real phi_less180_up;
        Real phi_less180_down;
        Real phi_less180 "phi для давления меньше 180 кгс/см2";
      algorithm
      //Оцифровка левой части (Р < 180) диаграммы 5а (Нормативный метод гидравлического расчета котельных агрегатов (1978))
        if wrhop >= 300 then
          wrhop_up := 400;
          phi_less180_up := if x >= 0.077 then 1.7326735348 * x ^ 4 - 4.2892926077 * x ^ 3 + 4.5140570635 * x ^ 2 - 2.6239534310 * x + 1.1783239733 else 1;
          wrhop_down := 300;
          phi_less180_down := if x >= 0.077 then 1.7326735348 * x ^ 4 - 4.2892926077 * x ^ 3 + 4.5140570635 * x ^ 2 - 2.6239534310 * x + 1.1783239733 else 1;
        elseif wrhop < 300 and wrhop >= 260 then
          wrhop_up := 300;
          phi_less180_up := if x >= 0.077 then 1.7326735348 * x ^ 4 - 4.2892926077 * x ^ 3 + 4.5140570635 * x ^ 2 - 2.6239534310 * x + 1.1783239733 else 1;
          wrhop_down := 260;
          phi_less180_down := if x >= 0.102 then 1.4513971826 * x ^ 4 - 3.5387206445 * x ^ 3 + 3.8180468410 * x ^ 2 - 2.3764538834 * x + 1.2059010954 else 1;
        elseif wrhop < 260 and wrhop >= 240 then
          wrhop_up := 260;
          phi_less180_up := if x >= 0.102 then 1.4513971826 * x ^ 4 - 3.5387206445 * x ^ 3 + 3.8180468410 * x ^ 2 - 2.3764538834 * x + 1.2059010954 else 1;
          wrhop_down := 240;
          phi_less180_down := if x >= 0.118 then 1.7337140333 * x ^ 4 - 4.1183545121 * x ^ 3 + 4.2222156937 * x ^ 2 - 2.4782615093 * x + 1.2384507739 else 1;
        elseif wrhop < 240 and wrhop >= 220 then
          wrhop_up := 240;
          phi_less180_up := if x >= 0.118 then 1.7337140333 * x ^ 4 - 4.1183545121 * x ^ 3 + 4.2222156937 * x ^ 2 - 2.4782615093 * x + 1.2384507739 else 1;
          wrhop_down := 220;
          phi_less180_down := if x >= 0.134 then 1.8386110496 * x ^ 4 - 4.3424422808 * x ^ 3 + 4.3999276658 * x ^ 2 - 2.5337516786 * x + 1.2690488813 else 1;
        elseif wrhop < 220 and wrhop >= 200 then
          wrhop_up := 220;
          phi_less180_up := if x >= 0.134 then 1.8386110496 * x ^ 4 - 4.3424422808 * x ^ 3 + 4.3999276658 * x ^ 2 - 2.5337516786 * x + 1.2690488813 else 1;
          wrhop_down := 200;
          phi_less180_down := if x >= 0.147 then 1.4219712545 * x ^ 4 - 3.3261748246 * x ^ 3 + 3.5532256217 * x ^ 2 - 2.2303203025 * x + 1.2605298510 else 1;
        elseif wrhop < 200 and wrhop >= 180 then
          wrhop_up := 200;
          phi_less180_up := if x >= 0.147 then 1.4219712545 * x ^ 4 - 3.3261748246 * x ^ 3 + 3.5532256217 * x ^ 2 - 2.2303203025 * x + 1.2605298510 else 1;
          wrhop_down := 180;
          phi_less180_down := if x >= 0.168 then 1.4930025266 * x ^ 4 - 3.6239432394 * x ^ 3 + 3.8621639609 * x ^ 2 - 2.2996291408 * x + 1.2931208181 else 1;
        elseif wrhop < 180 and wrhop >= 160 then
          wrhop_up := 180;
          phi_less180_up := if x >= 0.168 then 1.4930025266 * x ^ 4 - 3.6239432394 * x ^ 3 + 3.8621639609 * x ^ 2 - 2.2996291408 * x + 1.2931208181 else 1;
          wrhop_down := 160;
          phi_less180_down := if x >= 0.19 then 1.4298209842 * x ^ 4 - 3.4050752571 * x ^ 3 + 3.5399754890 * x ^ 2 - 2.0595533382 * x + 1.2840925182 else 1;
        elseif wrhop < 160 and wrhop >= 150 then
          wrhop_up := 160;
          phi_less180_up := if x >= 0.19 then 1.4298209842 * x ^ 4 - 3.4050752571 * x ^ 3 + 3.5399754890 * x ^ 2 - 2.0595533382 * x + 1.2840925182 else 1;
          wrhop_down := 150;
          phi_less180_down := if x >= 0.214 then 2.3694725716 * x ^ 4 - 5.3818366810 * x ^ 3 + 4.8445067447 * x ^ 2 - 2.3192050299 * x + 1.3216168513 else 1;
        elseif wrhop < 150 and wrhop >= 140 then
          wrhop_up := 150;
          phi_less180_up := if x >= 0.214 then 2.3694725716 * x ^ 4 - 5.3818366810 * x ^ 3 + 4.8445067447 * x ^ 2 - 2.3192050299 * x + 1.3216168513 else 1;
          wrhop_down := 140;
          phi_less180_down := if x >= 0.244 then 0.0853282028 * x ^ 4 + 0.07409610708 * x ^ 3 + 0.1991497509 * x ^ 2 - 0.6125891375 * x + 1.1361515441 else 1;
        elseif wrhop < 140 and wrhop >= 130 then
          wrhop_up := 140;
          phi_less180_up := if x >= 0.244 then 0.0853282028 * x ^ 4 + 0.07409610708 * x ^ 3 + 0.1991497509 * x ^ 2 - 0.6125891375 * x + 1.1361515441 else 1;
          wrhop_down := 130;
          phi_less180_down := if x >= 0.304 then 0.6797707858 * x ^ 4 - 1.7043172696 * x ^ 3 + 1.9464370756 * x ^ 2 - 1.2184246841 * x + 1.2322690806 else 1;
        elseif wrhop < 130 and wrhop >= 125 then
          wrhop_up := 130;
          phi_less180_up := if x >= 0.304 then 0.6797707858 * x ^ 4 - 1.7043172696 * x ^ 3 + 1.9464370756 * x ^ 2 - 1.2184246841 * x + 1.2322690806 else 1;
          wrhop_down := 125;
          phi_less180_down := if x >= 0.356 then 0.6148375351 * x ^ 4 - 1.5791519021 * x ^ 3 + 1.8400903024 * x ^ 2 - 1.1333788283 * x + 1.2316231629 else 1;
        elseif wrhop < 125 and wrhop >= 120 then
          wrhop_up := 125;
          phi_less180_up := if x >= 0.356 then 0.6148375351 * x ^ 4 - 1.5791519021 * x ^ 3 + 1.8400903024 * x ^ 2 - 1.1333788283 * x + 1.2316231629 else 1;
          wrhop_down := 120;
          phi_less180_down := 1;
        elseif wrhop < 120 and wrhop >= 110 then
          wrhop_up := 120;
          phi_less180_up := 1;
          wrhop_down := 110;
          phi_less180_down := (-0.0620371743 * x ^ 4) + 0.0143877246 * x ^ 3 + 0.0045396916 * x ^ 2 - 0.0041319291 * x + 1.1023521492;
        elseif wrhop < 110 and wrhop >= 100 then
          wrhop_up := 110;
          phi_less180_up := (-0.0620371743 * x ^ 4) + 0.0143877246 * x ^ 3 + 0.0045396916 * x ^ 2 - 0.0041319291 * x + 1.1023521492;
          wrhop_down := 100;
          phi_less180_down := (-0.2125876214 * x ^ 4) + 0.2310174677 * x ^ 3 - 0.0938761376 * x ^ 2 + 0.0171025286 * x + 1.1789805166;
        elseif wrhop < 100 and wrhop >= 90 then
          wrhop_up := 100;
          phi_less180_up := (-0.2125876214 * x ^ 4) + 0.2310174677 * x ^ 3 - 0.0938761376 * x ^ 2 + 0.0171025286 * x + 1.1789805166;
          wrhop_down := 90;
          phi_less180_down := (-0.3803668297 * x ^ 4) + 0.5649203234 * x ^ 3 - 0.2855069360 * x ^ 2 + 0.0465697023 * x + 1.2283165978;
        elseif wrhop < 90 and wrhop >= 80 then
          wrhop_up := 90;
          phi_less180_up := (-0.3803668297 * x ^ 4) + 0.5649203234 * x ^ 3 - 0.2855069360 * x ^ 2 + 0.0465697023 * x + 1.2283165978;
          wrhop_down := 80;
          phi_less180_down := (-0.4103774225 * x ^ 4) + 0.5791958019 * x ^ 3 - 0.2749076196 * x ^ 2 + 0.0390357265 * x + 1.30025436128;
        elseif wrhop < 80 and wrhop >= 70 then
          wrhop_up := 80;
          phi_less180_up := (-0.4103774225 * x ^ 4) + 0.5791958019 * x ^ 3 - 0.2749076196 * x ^ 2 + 0.0390357265 * x + 1.30025436128;
          wrhop_down := 70;
          phi_less180_down := (-0.4876399173 * x ^ 4) + 0.7254330563 * x ^ 3 - 0.3482365887 * x ^ 2 + 0.0491618028 * x + 1.3496682544;
        elseif wrhop < 70 and wrhop >= 60 then
          wrhop_up := 70;
          phi_less180_up := (-0.4876399173 * x ^ 4) + 0.7254330563 * x ^ 3 - 0.3482365887 * x ^ 2 + 0.0491618028 * x + 1.3496682544;
          wrhop_down := 60;
          phi_less180_down := (-0.4555512967 * x ^ 4) + 0.6412893137 * x ^ 3 - 0.2929308789 * x ^ 2 + 0.0392568200 * x + 1.3993462281;
        elseif wrhop < 60 and wrhop >= 50 then
          wrhop_up := 60;
          phi_less180_up := (-0.4555512967 * x ^ 4) + 0.6412893137 * x ^ 3 - 0.2929308789 * x ^ 2 + 0.0392568200 * x + 1.3993462281;
          wrhop_down := 50;
          phi_less180_down := (-0.6321126834 * x ^ 4) + 0.9668229999 * x ^ 3 - 0.4655184559 * x ^ 2 + 0.0654015637 * x + 1.4396176158;
        elseif wrhop < 50 and wrhop >= 40 then
          wrhop_up := 50;
          phi_less180_up := (-0.6321126834 * x ^ 4) + 0.9668229999 * x ^ 3 - 0.4655184559 * x ^ 2 + 0.0654015637 * x + 1.4396176158;
          wrhop_down := 40;
          phi_less180_down := (-0.4670410259 * x ^ 4) + 0.6443808260 * x ^ 3 - 0.2803329356 * x ^ 2 + 0.0367508367 * x + 1.4804057664;
        elseif wrhop < 40 and wrhop >= 30 then
          wrhop_up := 40;
          phi_less180_up := (-0.4670410259 * x ^ 4) + 0.6443808260 * x ^ 3 - 0.2803329356 * x ^ 2 + 0.0367508367 * x + 1.4804057664;
          wrhop_down := 30;
          phi_less180_down := (-0.4770593418 * x ^ 4) + 0.6707145924 * x ^ 3 - 0.2782995210 * x ^ 2 + 0.0343904964 * x + 1.4984705199;
        elseif wrhop < 30 then
          wrhop_up := 30;
          phi_less180_up := (-0.4770593418 * x ^ 4) + 0.6707145924 * x ^ 3 - 0.2782995210 * x ^ 2 + 0.0343904964 * x + 1.4984705199;
          wrhop_down := 20;
          phi_less180_down := (-0.4770593418 * x ^ 4) + 0.6707145924 * x ^ 3 - 0.2782995210 * x ^ 2 + 0.0343904964 * x + 1.4984705199;
        end if;
        phi_less180 := phi_less180_down + (wrhop - wrhop_down) * (phi_less180_up - phi_less180_down) / (wrhop_up - wrhop_down) "Расчет phi для давления меньше 180 кгс/см2";
      //Оцифровка правой части (Р > 180) диаграммы 5а (Нормативный метод гидравлического расчета котельных агрегатов (1978))
        if p < 180 then
          p_up := 180;
          phi_up := phi_less180;
          p_down := 170;
          phi_down := phi_less180;
        elseif p >= 180 and p < 190 then
          p_up := 190;
          phi_up := 0.5519859872 * phi_less180 ^ 3 - 1.6482979996 * phi_less180 ^ 2 + 2.4385239509 * phi_less180 - 0.3418330801;
          p_down := 180;
          phi_down := 0.9971503617 * phi_less180 + 0.0042472870;
        elseif p >= 190 and p < 200 then
          p_up := 200;
          phi_up := 0.7054219388 * phi_less180 ^ 3 - 2.1155986359 * phi_less180 ^ 2 + 2.7218648407 * phi_less180 - 0.3075156641;
          p_down := 190;
          phi_down := 0.5519859872 * phi_less180 ^ 3 - 1.6482979996 * phi_less180 ^ 2 + 2.4385239509 * phi_less180 - 0.3418330801;
        elseif p >= 200 and p < 210 then
          p_up := 210;
          phi_up := 0.7525810088 * phi_less180 ^ 3 - 2.2381909015 * phi_less180 ^ 2 + 2.5724339224 * phi_less180 - 0.0848064371;
          p_down := 200;
          phi_down := 0.7054219388 * phi_less180 ^ 3 - 2.1155986359 * phi_less180 ^ 2 + 2.7218648407 * phi_less180 - 0.3075156641;
        elseif p >= 210 and p < 220 then
          p_up := 220;
          phi_up := 0.4488108026 * phi_less180 ^ 3 - 1.3484765978 * phi_less180 ^ 2 + 1.4418111541 * phi_less180 + 0.4601807173;
          p_down := 210;
          phi_down := 0.7525810088 * phi_less180 ^ 3 - 2.2381909015 * phi_less180 ^ 2 + 2.5724339224 * phi_less180 - 0.0848064371;
        elseif p >= 220 and p < 225 then
          p_up := 225;
          phi_up := 1;
          p_down := 220;
          phi_down := 0.4488108026 * phi_less180 ^ 3 - 1.3484765978 * phi_less180 ^ 2 + 1.4418111541 * phi_less180 + 0.4601807173;
        elseif p >= 225 then
          p_up := 230;
          phi_up := 1;
          p_down := 225;
          phi_down := 1;
        end if;
        phi := phi_down + (wrhop - wrhop_down) * (phi_up - phi_down) / (wrhop_up - wrhop_down) "Расчет phi для давления больше 180 кгс/см2 (итоговое phi)";
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end phi_heatedPipe;

      function lambda_tr "Функция для расчета коэффициента трения (лямбда)"
      
        function lambda_tr_lessReI "Функция для расчета коэффициента трения при Re меньше Re_I"
          input Real Re "Число Рейнольдса";
          output Real lambda_tr;
        algorithm
          if Re > 1 then
            lambda_tr := 64 / Re;
          else
            lambda_tr := 64;
          end if;
        end lambda_tr_lessReI;
      
        function lambda_tr_moreReII "Функция для расчета коэффициента трения при Re больше Re_II"
          input Modelica.SIunits.Length dn "расчетный внутренний диаметр трубы";
          input Modelica.SIunits.Length ke "абсолютная эквивалентная шероховатость";
          output Real lambda_tr;
        algorithm
          lambda_tr := 1 / (1.14 + 2 * log10(dn / ke)) ^ 2;
        end lambda_tr_moreReII;
      
        function lambda_polinom "Функция для расчеталямбда между Re = 4000 и ReII (оцифровка номограммы 11 Локшин В.А. (ред)-Гидравлический расчет котельных агрегатов (1978))"
          input Modelica.SIunits.Length dn "расчетный внутренний диаметр трубы";
          input Modelica.SIunits.Length ke "абсолютная эквивалентная шероховатость";
          input Real Re "Число Рейнольдса";
          output Real lambda;
        protected
          Real c[10] = {0.2587364420580208, -0.03516379584534394, -0.01845051721724587, 0.003140978795613697, 0.003982247918962438, -0.002620692312095342, -8.042305352946224E-05, -0.0001725422555343841, 5.317219412247827E-05, 5.169795621325457E-05};
        algorithm
          lambda := c[1] + c[2] * log(Re) + c[3] * log(dn / ke) + c[4] * log(Re) ^ 2 + c[5] * log(dn / ke) ^ 2 + c[6] * log(Re) * log(dn / ke) + c[7] * log(Re) ^ 3 + c[8] * log(dn / ke) ^ 3 + c[9] * log(Re) * log(dn / ke) ^ 2 + c[10] * log(Re) ^ 2 * log(dn / ke);
        end lambda_polinom;
      
        function lambda_tr_per "Функция для расчета коэффициента трения в зоне между ReI и Re = 4000"
          input Modelica.SIunits.Length dn "расчетный внутренний диаметр трубы";
          input Modelica.SIunits.Length ke "абсолютная эквивалентная шероховатость";
          input Real Re "Число Рейнольдса";
          output Real lambda_tr;
        protected
          Real Re_I "Нижняя граница переходной области (по числу Рейнольдса)";
          Real Re_II "Верхняя граница переходной области (по числу Рейнольдса)";
          Real lambda_tr_I "Нижняя граница переходной области (по коэффициенту трения)";
          Real lambda_tr_II "Верхняя граница переходной области (по коэффициенту трения)";
        algorithm
          Re_I := 2300;
          Re_II := 4000;
          lambda_tr_I := lambda_tr_lessReI(Re_I);
          lambda_tr_II := lambda_polinom(dn, ke, Re);
          lambda_tr := lambda_tr_I + (Re - Re_I) * (lambda_tr_II - lambda_tr_I) / (Re_II - Re_I);
        end lambda_tr_per;
      
        input Modelica.SIunits.Length dn "расчетный внутренний диаметр трубы";
        input Modelica.SIunits.Length ke "абсолютная эквивалентная шероховатость";
        input Real Re "Число Рейнольдса";
        output Real lambda_tr;
      protected
        Real Re_I "Нижняя граница переходной области (по числу Рейнольдса)";
        Real Re_II "Верхняя граница переходной области (по числу Рейнольдса)";
        Real Re4000 "Нижняя граница номограммы 11 Локшин В.А. (ред)-Гидравлический расчет котельных агрегатов (1978)";
      algorithm
        Re_I := 2300;
        Re_II := (120 * dn / ke) ^ 1.125;
        Re4000 := 4000;
        if Re < Re_I then
          lambda_tr := lambda_tr_lessReI(Re);
        elseif Re > Re_II then
          lambda_tr := lambda_tr_moreReII(dn, ke);
        elseif Re > Re_I and Re < Re4000 then
          lambda_tr := lambda_tr_per(dn, ke, Re);
        else
          lambda_tr := lambda_polinom(dn, ke, Re);
        end if;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end lambda_tr;
    end Functions;

      package Interfaces
        connector FluidPort
          flow Modelica.SIunits.MassFlowRate m_flow "Mass flow rate from the connection point into the component";
          Modelica.SIunits.Pressure p "Thermodynamic pressure in the connection point";
          stream Modelica.SIunits.Enthalpy h_outflow "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
        end FluidPort;

        connector FluidPort_a "Generic fluid connector at design inlet"
          extends FluidPort;
          annotation (defaultComponentName="port_a",
                      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Ellipse(
                  extent={{-40,40},{40,-40}},
                  lineColor={0,0,0},
                  fillColor={0,127,255},
                  fillPattern=FillPattern.Solid), Text(extent={{-150,110},{150,50}},
                    textString="%name")}),
               Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                    100,100}}), graphics={Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,127,255},
                  fillColor={0,127,255},
                  fillPattern=FillPattern.Solid), Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  fillColor={0,127,255},
                  fillPattern=FillPattern.Solid)}));
        end FluidPort_a;

        connector FluidPort_b "Generic fluid connector at design outlet"
          extends FluidPort;
          annotation (defaultComponentName="port_b",
                      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={
                Ellipse(
                  extent={{-40,40},{40,-40}},
                  lineColor={0,0,0},
                  fillColor={0,127,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-30,30},{30,-30}},
                  lineColor={0,127,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(extent={{-150,110},{150,50}}, textString="%name")}),
               Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                    100,100}}), graphics={
                Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,127,255},
                  fillColor={0,127,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  fillColor={0,127,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-80,80},{80,-80}},
                  lineColor={0,127,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}));
        end FluidPort_b;
      end Interfaces;
    end Water;

    package Gas
    end Gas;

    package Choices
      type HRSG_type = enumeration(verticalBottom "Вертикальный КУ входной коллектор внизу", verticalTop "Вертикальный КУ входной коллектор наверху", horizontalBottom "Гоизонтальный КУ входной коллектор внизу", horizontalTop "Гоизонтальный КУ входной коллектор наверху") "Тип котла-утилизатора (вертикальный/горизонтальный)";
    end Choices;
  end Components;
end MyHRSGj;
