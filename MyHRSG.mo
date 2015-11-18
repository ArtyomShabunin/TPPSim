package MyHRSG
  model onlyFlowHE100501 "Модель нагреваемой части поверхности нагрева КУ совместно с металом"
    function positiveMax
      extends Modelica.Icons.Function;
      input Real x;
      output Real y;
    algorithm
      y := max(x, 1e-10);
    end positiveMax;

    //**
    //***Исходные данные для газовой стороны
    //**
    parameter Modelica.SIunits.Power setQ_gas = 100 "тепловой поток со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
    //**
    //***Исходные данные по стороне вода/пар
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow = 10e5 "Начальное давление потока вода/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
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
    parameter Integer numberOfTubeSections = 10 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfFlueSections = 2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Real zahod = numberOfFlueSections "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Hpipe = Lpipe "Разность высотных отметов выхода и входа теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Real Xi_flow = 0.3 "Коэффициент гидравлического сопротивления участка трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    //Константы
    //Поток вода/пар
    parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 / numberOfTubeSections "Внутренняя площадь одного участка ряда труб";
    parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 / 4 / numberOfTubeSections "Внутренний объем одного участка ряда труб";
    parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 / numberOfTubeSections "Масса металла участка ряда труб";
    parameter Modelica.SIunits.Length deltaHpipe = Hpipe / numberOfTubeSections "Разность высот на участке ряда труб";
    parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
    //**
    //Начальные значения
    //**
    //Поток вода/пар
    parameter Medium_F.SpecificEnthalpy h_startTubeFlow[numberOfTubeSections + 1] = linspace(Medium_F.specificEnthalpy_pT(setp_flow, setT_inFlow), Medium_F.specificEnthalpy_pT(setp_flow, setT_outFlow), numberOfTubeSections + 1) "Начальный вектор энальпии потока вода/пар вдоль трубы" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow[numberOfFlueSections, numberOfTubeSections + 1] = array(array(h_startTubeFlow[j] for j in 1:numberOfTubeSections + 1) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow[numberOfFlueSections, numberOfTubeSections + 1] = fill(setp_flow, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow[numberOfFlueSections, numberOfTubeSections + 1] = fill(setD_flow / numberOfFlueSections, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор массового расхода потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startTubeM[numberOfTubeSections] = if numberOfTubeSections == 1 then {(setT_inFlow + setT_outFlow) / 2} else linspace(setT_inFlow, setT_outFlow, numberOfTubeSections) "Начальный вектор температур металла" annotation(Dialog(tab = "Инициализация"));
    parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = array(array(t_startTubeM[j] for j in 1:numberOfTubeSections) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    //Поток вода/пар
    Medium_F.ThermodynamicState stateFlow[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    Medium_F.AbsolutePressure p_flow[numberOfFlueSections, numberOfTubeSections + 1](start = p_startFlow) "Давление потока вода/пар по участкам трубы";
    Medium_F.SpecificEnthalpy h_flow[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow) "Энтальпия потока вода/пар по участкам трубы";
    Medium_F.Density rho_flow[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы";
    Modelica.SIunits.DerDensityByEnthalpy drdh_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow[numberOfFlueSections, numberOfTubeSections + 1](start = D_startFlow) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
    //Металл
    Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    Real C1[numberOfFlueSections, numberOfTubeSections] "Показатель в числителе уравнения сплошности";
    Real C2[numberOfFlueSections, numberOfTubeSections] "Показатель в знаменателе уравнения сплошности";
    //**
    //Интерфейс
    //**
    Modelica.Fluid.Interfaces.FluidPort_a waterIn annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = true, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    //*****Уравнения для потока вода/пар и металла
    for i in 1:numberOfFlueSections loop
      for j in 1:numberOfTubeSections loop
        deltaVFlow * rho_flow[i, j] * der(h_flow[i, j + 1]) = alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - D_flow[i, j + 1] * (h_flow[i, j + 1] - h_flow[i, j]) "Уравнение баланса тепла теплоносителя (формула 3-1d диссертации Рубашкина)";
        //der(p_flow[i, j]) * deltaVFlow * drdp_flow[i, j] = D_flow[i, j] - D_flow[i, j + 1] - deltaVFlow * drdh_flow[i, j] * der(h_flow[i, j + 1]) "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
        C1[i, j] = deltaVFlow * drdh_flow[i, j] * der(h_flow[i, j + 1]);
        C2[i, j] = deltaVFlow * drdp_flow[i, j];
        //abs(p_flow[i, j] - p_flow[i, j + 1]) = D_flow[i, j + 1] ^ 2 / rho_flow[i, j] / Cd_flow[i, j];
        p_flow[i, j + 1] = p_flow[i, j];
        D_flow[i, j + 1] = D_flow[i, j];
        deltaMMetal * C_m * der(t_m[i, j]) = heat[i, j].Q_flow - alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
        heat[i, j].T = t_m[i, j];
        //Уравнения состояния
        stateFlow[i, j] = Medium_F.setState_ph(p_flow[i, j + 1], h_flow[i, j + 1]);
        t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
        rho_flow[i, j] = Medium_F.density(stateFlow[i, j]);
        drdp_flow[i, j] = if Medium_F.singleState then 0 else Medium_F.density_derp_h(stateFlow[i, j]);
        drdh_flow[i, j] = Medium_F.density_derh_p(stateFlow[i, j]);
        //Коэффициент теплоотдачи
        k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
        Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
        mu_flow[i, j] = Medium_F.dynamicViscosity(stateFlow[i, j]);
        Re_flow[i, j] = abs(D_flow[i, j + 1] * Din / (f_flow * mu_flow[i, j]));
        //не верная формула
        alfa_flow[i, j] = 0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4;
      end for;
    end for;
    //Граничные условия
    for i in 2:numberOfFlueSections loop
      D_flow[i - 1, 1] = D_flow[i, 1];
    end for;
    waterIn.m_flow = sum(D_flow[i, 1] for i in 1:numberOfFlueSections);
    0 = waterOut.m_flow + sum(D_flow[i, numberOfTubeSections + 1] for i in 1:numberOfFlueSections);
    if waterIn.m_flow > 0 then
      for i in 1:numberOfFlueSections loop
        waterOut.p = p_flow[i, numberOfTubeSections + 1];
      end for;
      waterIn.p = sum(p_flow[i, 1] for i in 1:numberOfFlueSections) / numberOfFlueSections;
    else
      for i in 1:numberOfFlueSections loop
        waterIn.p = p_flow[i, 1];
      end for;
      waterOut.p = sum(p_flow[i, numberOfTubeSections + 1] for i in 1:numberOfFlueSections) / numberOfFlueSections;
    end if;
    if waterIn.m_flow > 0 then
      for i in 1:numberOfFlueSections loop
        h_flow[i, 1] = inStream(waterIn.h_outflow);
      end for;
    else
      for i in 1:numberOfFlueSections loop
        h_flow[i, numberOfTubeSections + 1] = inStream(waterOut.h_outflow);
      end for;
    end if;
    waterOut.h_outflow = sum(array(positiveMax(D_flow[i, numberOfTubeSections + 1]) * h_flow[i, numberOfTubeSections + 1] for i in 1:numberOfFlueSections)) / sum(array(positiveMax(D_flow[i, numberOfTubeSections + 1]) for i in 1:numberOfFlueSections));
    waterIn.h_outflow = sum(array(positiveMax(D_flow[i, 1]) * h_flow[i, 1] for i in 1:numberOfFlueSections)) / sum(array(positiveMax(D_flow[i, 1]) for i in 1:numberOfFlueSections));
    annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Но не используются гибы, т.е. возможет только прямой участок труб между коллекторами, можно сказать, что моделируется только один ход теплообменника</html>"), Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-100, -115}, {100, -145}}, lineColor = {85, 170, 255}, textString = "%name")}), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
  end onlyFlowHE100501;

  model TestOnlyFlowHE
    import ThermoPower.*;
    //**
    //***Исходные данные для водяной стороны
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Modelica.SIunits.MassFlowRate wflow = 78 "Номинальный массовый расход воды/пар";
    parameter Modelica.SIunits.Pressure pflow = 10e5 "Начальное давление потока вода/пар";
    parameter SI.Temperature Tinflow = 60 + 273.15 "Начальная входная температура потока воды/пар";
    parameter SI.Temperature Toutflow = 80 + 273.15 "Начальная выходная температура потока воды/пар";
    parameter SI.Temperature T2flow = (Tinflow + Toutflow) / 2 "Начальная промежуточная температура потока воды/пар";
    parameter Modelica.SIunits.SpecificEnthalpy hinflow = Medium_F.specificEnthalpy_pT(pflow, Tinflow) "Начальная энтальпия входного потока вода/пар";
    parameter Modelica.SIunits.SpecificEnthalpy houtflow = Medium_F.specificEnthalpy_pT(pflow, Toutflow) "Начальная энтальпия выходного потока вода/пар";
    parameter Modelica.SIunits.SpecificEnthalpy h2flow = Medium_F.specificEnthalpy_pT(pflow, T2flow) "Начальная промежуточная энтальпия потока вода/пар";
    //**
    //***Исходные данные по разбиению
    //**
    parameter Integer numberOfTubeSections = 10 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfFlueSections = 2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    /*//**
                                                                                                                                                                                                                                                                                                                                                                                      //***конструктивные характеристики
                                                                                                                                                                                                                                                                                                                                                                                      //**
                                                                                                                                                                                                                                                                                                                                                                                      parameter SI.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
                                                                                                                                                                                                                                                                                                                                                                                      parameter SI.Length delta = 0.003 "Толщина стенки трубки теплообменника";
                                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг";
                                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг";
                                                                                                                                                                                                                                                                                                                                                                                      parameter Real zahod = 1 "заходность труб теплообменника";
                                                                                                                                                                                                                                                                                                                                                                                      parameter Integer z1 = 126 "Число труб по ширине газохода";
                                                                                                                                                                                                                                                                                                                                                                                      parameter Integer z2_total = 18 "Общее число труб по ходу газов в теплообменнике";
                                                                                                                                                                                                                                                                                                                                                                                      parameter Integer z2 = 1 "Число труб по ходу газов в данной поверхности нагрева";
                                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки";
                                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length Hpipe = Lpipe "Разность высотных отметов выхода и входа теплообменной трубки";
                                                                                                                                                                                                                                                                                                                                                                                      ///Оребрение
                                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
                                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м";
                                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м";
                                                                                                                                                                                                                                                                                                                                                                                      //**/
    //***
    //**
    ThermoPower.Water.SourceMassFlow flowsource(p0 = pflow, h = hinflow, w0 = wflow, use_in_w0 = false, use_in_h = true, redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-88, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.SensT sensflow1(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-46, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step flowenthalpstep(height = 0, offset = hinflow, startTime = 80) annotation(Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    inner ThermoPower.System system annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.SinkPressure sinkflow(p0 = pflow / 2, redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.SensT sensflow2(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {60, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.ValveLin flowvalve(redeclare package Medium = Medium_F, Kv = wflow / pflow) annotation(Placement(visible = true, transformation(origin = {34, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    //Modelica.Blocks.Sources.IntegerTable flowvalvestep(table = [0, 1; 50000, 0.7; 70000, 0.4; 100000, 1]) annotation(Placement(visible = true, transformation(origin = {10, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step flowvalvestep(height = -0.3, offset = 1, startTime = 10000) annotation(Placement(visible = true, transformation(origin = {4, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    MyHRSG.onlyFlowHE100502 onlyFlowHE1(redeclare package Medium_F = Medium_F, setD_flow = wflow, setp_flow = pflow, setT_inFlow = Tinflow, setT_outFlow = Toutflow, numberOfTubeSections = numberOfTubeSections, numberOfFlueSections = numberOfFlueSections) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow heatSource[numberOfFlueSections, numberOfTubeSections](Q_flow = 5.1e6 / numberOfTubeSections / numberOfFlueSections) annotation(Placement(visible = true, transformation(origin = {48, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  equation
    for j in 1:numberOfTubeSections loop
      for i in 1:numberOfFlueSections loop
        connect(heatSource[i, j].port, onlyFlowHE1.heat[i, j]);
      end for;
    end for;
    connect(sensflow1.outlet, onlyFlowHE1.waterIn) annotation(Line(points = {{-40, 60}, {0, 60}, {0, 10}, {0, 10}}, color = {0, 0, 255}));
    connect(onlyFlowHE1.waterOut, flowvalve.inlet) annotation(Line(points = {{0, -10}, {0, -10}, {0, -30}, {-30, -30}, {-30, -90}, {24, -90}, {24, -90}}, color = {0, 0, 255}));
    connect(flowvalvestep.y, flowvalve.cmd) annotation(Line(points = {{15, -54}, {34, -54}, {34, -82}}, color = {0, 0, 127}));
    connect(flowvalve.outlet, sensflow2.inlet) annotation(Line(points = {{44, -90}, {54, -90}}, color = {0, 0, 255}));
    connect(sensflow2.outlet, sinkflow.flange) annotation(Line(points = {{66, -90}, {80, -90}, {80, -92}, {80, -92}, {80, -92}, {80, -92}}, color = {0, 0, 255}));
    connect(flowsource.flange, sensflow1.inlet) annotation(Line(points = {{-78, 60}, {-52, 60}, {-52, 60}, {-52, 60}}, color = {0, 0, 255}));
    connect(flowenthalpstep.y, flowsource.in_h) annotation(Line(points = {{-79, 90}, {-74, 90}, {-74, 72}, {-84, 72}, {-84, 68}, {-84, 68}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 200000, Tolerance = 1e-06, Interval = 400));
  end TestOnlyFlowHE;

  model onlyGasHE100501 "Используется аналогия с SiemensPower.Components.Junctions.SplitterMixer"
    function positiveMax
      extends Modelica.Icons.Function;
      input Real x;
      output Real y;
    algorithm
      y := max(x, 1e-10);
    end positiveMax;

    //**
    //***Исходные данные для газовой стороны
    //**
    replaceable package Medium_G = MyHRSG.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
    //parameter Modelica.SIunits.Power setQ_gas = 100000 "тепловой поток со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
    parameter Modelica.SIunits.MassFlowRate setD_gas = 509 "Номинальный (и начальный) массовый расход газов" annotation(Dialog(group = "Параметры стороны газов"));
    parameter Modelica.SIunits.Pressure setp_gas = 3e3 "Начальное давление газов" annotation(Dialog(group = "Параметры стороны газов"));
    parameter Modelica.SIunits.Temperature setT_inGas = 184 + 273.15 "Начальная входная температура газов" annotation(Dialog(group = "Параметры стороны газов"));
    parameter Modelica.SIunits.Temperature setT_outGas = 170 + 273.15 "Начальная выходная температура газов" annotation(Dialog(group = "Параметры стороны газов"));
    parameter Medium_G.MassFraction setX_gas[Medium_G.nXi] = Medium_G.reference_X;
    parameter Real k_alfaGas = 1 "Поправка к коэффициенту теплоотдачи со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
    //**
    //Конструктивные характеристики
    //**
    //Параметры
    parameter Integer numberOfTubeSections = 10 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfFlueSections = 2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Dout = Din + 2 * delta "Наружный диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Real zahod = numberOfFlueSections "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z1 = 79 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Hpipe = Lpipe "Разность высотных отметов выхода и входа теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Real Xi_flow = 0.3 "Коэффициент гидравлического сопротивления участка трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length omega = Modelica.Constants.pi * Dout "Наружный периметр трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    //Поток газов
    parameter Modelica.SIunits.Volume deltaVGas = Lpipe * (s1 * s2 * z1 - Modelica.Constants.pi * Dout ^ 2 / 4) / numberOfTubeSections "Объем одного участка газового тракта";
    parameter Modelica.SIunits.Area deltaSGas = Lpipe * Modelica.Constants.pi * Dout * z1 / numberOfTubeSections "Наружная площадь одного участка ряда труб";
    parameter Modelica.SIunits.Area f_gas = (1 - Dout / s1 * (1 + 2 * hfin * delta_fin / sfin / Dout)) * Lpipe * s2 * z1 / numberOfTubeSections "Площадь для прохода газов на одном участке разбиения";
    //**
    //Характеристики оребрения
    //
    parameter Modelica.SIunits.Length delta_fin = 0.0009 "Средняя толщина ребра, м" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Modelica.SIunits.Length hfin = 0.014 "Высота ребра, м" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Modelica.SIunits.Length sfin = 0.004 "Шаг ребер, м" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Modelica.SIunits.Length Dfin = Dout + 2 * hfin "Диаметр ребер, м" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real psi_fin = 1 / (2 * Dout * sfin) * (Dfin ^ 2 - Dout ^ 2 + 2 * Dfin * delta_fin) + 1 - delta_fin / sfin "Коэффициент оребрения, равный отношению полной поверхности пучка к поверхности несущих труб на оребренном участке" annotation(Dialog(group = "Характеристики оребрения"));
    //формула 7.22а нормативного метода
    parameter Real sigma1 = s1 / Dout "Относительный поперечный шаг" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real sigma2 = s2 / Dout "Относительный продольный шаг" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real sigma3 = sqrt(0.25 * sigma1 ^ 2 + sigma2) "Средний относительный диагональный шаг труб" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real xfin = sigma1 / sigma2 - 1.26 / psi_fin - 2 "Параметр 'x' для шахматного пучка" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real phi_fin = Modelica.Math.tanh(xfin) "Некий параметр 'фи'" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real n_fin = 0.7 + 0.08 * phi_fin + 0.005 * psi_fin "Показатель степени 'n' в формуле коэффициента теплоотдачи" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real Cs = (1.36 - phi_fin) * (11 / (psi_fin + 8) - 0.14) "Коэффициент, определяемый в зависимости от от относительного поперечного и продольного шага труб в пучке, типа пучка и коэффициента оребрения";
    parameter Real Cz = if z2 < 8 and sigma1 / sigma2 < 2 then 3.15 * z2 ^ 0.05 - 2.5 elseif z2 < 8 and sigma1 / sigma2 >= 2 then 3.5 * z2 ^ 0.03 - 2.72 else 1 "Поправка на число рядов труб по ходу газов";
    parameter Real H_fin = (omega * Lpipe * (1 - delta_fin / sfin) + 2 * Modelica.Constants.pi * (Dfin ^ 2 - Dout ^ 2) / 4 + Modelica.Constants.pi * Dfin * delta_fin * (Lpipe / sfin)) * z1 "Площадь оребренной поверхности";
    //**
    //Начальные значения
    //**
    //Поток газов
    parameter Medium_G.MassFlowRate deltaDGasStart = setD_gas / numberOfTubeSections "Расход газов через один участок разбиения";
    parameter Medium_G.SpecificEnthalpy h_startTubeGas[numberOfFlueSections + 1] = linspace(Medium_G.specificEnthalpy_pTX(setp_gas, setT_inGas, setX_gas), Medium_G.specificEnthalpy_pTX(setp_gas, setT_outGas, setX_gas), numberOfFlueSections + 1) "Начальный вектор энальпии потока газов вдоль газохода" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_G.SpecificEnthalpy h_startGas[numberOfFlueSections + 1, numberOfTubeSections] = array(array(h_startTubeGas[i] for j in 1:numberOfTubeSections) for i in 1:numberOfFlueSections + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_G.AbsolutePressure p_startGas[numberOfFlueSections + 1, numberOfTubeSections] = fill(setp_gas, numberOfFlueSections + 1, numberOfTubeSections) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    //Поток газов
    Medium_G.BaseProperties gas[numberOfFlueSections, numberOfTubeSections];
    Medium_G.SpecificEnthalpy h_gas[numberOfFlueSections + 1, numberOfTubeSections](start = h_startGas) "Энтальпия потока вода/пар по участкам трубы";
    Medium_G.Temperature t_gas[numberOfFlueSections, numberOfTubeSections] "Температура потока газов по участкам трубы";
    Medium_G.MassFlowRate deltaDGas[numberOfFlueSections + 1, numberOfTubeSections](start = fill(deltaDGasStart, numberOfFlueSections + 1, numberOfTubeSections)) "Расход газов через участок газохода";
    Medium_G.DynamicViscosity mu[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость газов";
    Medium_G.ThermalConductivity k[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности газов";
    Medium_G.SpecificHeatCapacity cp[numberOfFlueSections, numberOfTubeSections] "Изобарная теплоемкость газов";
    Modelica.SIunits.PerUnit Re[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Medium_G.PrandtlNumber Pr[numberOfFlueSections, numberOfTubeSections] "Число Прандтля";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_gas[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока газов";
    Modelica.SIunits.HeatFlowRate Q_gas[numberOfFlueSections, numberOfTubeSections] "Тепловой поток со стороны газов";
    //**
    //Интерфейс
    //**
    Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(Placement(transformation(extent = {{80, -20}, {120, 20}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = true, transformation(origin = {0, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    //*****Уравнения для потока газов и металла
    for j in 1:numberOfTubeSections loop
      for i in 1:numberOfFlueSections loop
        deltaVGas * gas[i, j].d * der(h_gas[i + 1, j]) = deltaDGas[i, j] * (h_gas[i, j] - h_gas[i + 1, j]) - heat[i, j].Q_flow "Уавнение теплового баланса газов (формула 3-15 диссертации Рубашкина)";
        Q_gas[i, j] = alfa_gas[i, j] * H_fin * (t_gas[i, j] - heat[i, j].T);
        heat[i, j].Q_flow = Q_gas[i, j];
        //Уравнения состояния
        gas[i, j].h = h_gas[i + 1, j];
        gas[i, j].p = gasIn.p "Уравнение для давления";
        gas[i, j].X = setX_gas;
        gas[i, j].T = t_gas[i, j];
        //gasState[i, j] = gas[i, j].state;
        deltaDGas[i, j] = deltaDGas[i + 1, j];
        //Коэффициент теплоотдачи
        mu[i, j] = Medium_G.dynamicViscosity(gas[i, j].state);
        k[i, j] = Medium_G.thermalConductivity(gas[i, j].state);
        cp[i, j] = Medium_G.heatCapacity_cp(gas[i, j].state);
        Re[i, j] = abs(deltaDGas[i, j] * Dout / (f_gas * mu[i, j]));
        Pr[i, j] = Medium_G.prandtlNumber(gas[i, j].state);
        alfa_gas[i, j] = k_alfaGas * 0.113 * Cs * Cz * k[i, j] / Dout * Re[i, j] ^ n_fin * Pr[i, j] ^ 0.33;
      end for;
      //Граничные условия
      h_gas[1, j] = inStream(gasIn.h_outflow);
    end for;
    //Граничные условия
    for j in 1:numberOfTubeSections - 1 loop
      deltaDGas[1, j] = deltaDGas[1, j + 1];
    end for;
    gasIn.h_outflow = sum(array(positiveMax(deltaDGas[1, j]) * h_gas[1, j] for j in 1:numberOfTubeSections)) / sum(array(positiveMax(deltaDGas[1, j]) for j in 1:numberOfTubeSections));
    gasOut.h_outflow = sum(array(positiveMax(deltaDGas[i, j]) * h_gas[i, j] for i in numberOfFlueSections + 1:numberOfFlueSections + 1, j in 1:numberOfTubeSections)) / sum(array(positiveMax(deltaDGas[i, j]) for i in numberOfFlueSections + 1:numberOfFlueSections + 1, j in 1:numberOfTubeSections));
    gasIn.Xi_outflow = inStream(gasOut.Xi_outflow);
    inStream(gasIn.Xi_outflow) = gasOut.Xi_outflow;
    gasIn.m_flow - sum(deltaDGas[1, j] for j in 1:numberOfTubeSections) = 0;
    gasOut.m_flow + sum(deltaDGas[numberOfFlueSections + 1, j] for j in 1:numberOfTubeSections) = 0;
    gasOut.p = gasIn.p;
    annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-100, -115}, {100, -145}}, lineColor = {85, 170, 255}, textString = "%name")}));
  end onlyGasHE100501;

  model ExhaustGas
    import Modelica.Media.IdealGases.Common;
    extends Common.MixtureGasNasa(mediumName = "ExhaustGas", data = {Common.SingleGasesData.O2, Common.SingleGasesData.CO2, Common.SingleGasesData.H2O, Common.SingleGasesData.N2, Common.SingleGasesData.Ar, Common.SingleGasesData.SO2}, fluidConstants = {Common.FluidData.O2, Common.FluidData.CO2, Common.FluidData.H2O, Common.FluidData.N2, Common.FluidData.Ar, Common.FluidData.SO2}, substanceNames = {"Oxygen", "Carbondioxide", "Water", "Nitrogen", "Argon", "Sulfurdioxide"}, reference_X = {0.1383, 0.032, 0.0688, 1 - 0.1383 - 0.032 - 0.0688 - 0.0000000001 - 0.0000000001, 0.0000000001, 0.0000000001});
    annotation(Documentation(info = "<html>
</html>"));
  end ExhaustGas;

  model testOnlyGasHE
    import ThermoPower.*;
    //**
    //***Исходные данные для газовой стороны
    //**
    replaceable package Medium_G = MyHRSG.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter SI.MassFlowRate wgas = 509 "Номинальный (и начальный) массовый расход газов";
    parameter SI.Pressure pgas = 3e3 "Начальное давление газов";
    parameter SI.Temperature Tingas = 184 + 273.15 "Начальная входная температура газов";
    parameter SI.Temperature Toutgas = 170 + 273.15 "Начальная выходная температура газов";
    parameter SI.Temperature T2gas = (Tingas + Toutgas) / 2 "Промежуточная температура газов";
    parameter Real k_gamma_gas = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
    parameter Real Set_X[6] = Medium_G.reference_X "Состав дымовых газов";
    //**
    //***Исходные данные по разбиению
    //**
    parameter Integer numberOfTubeSections = 10 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfFlueSections = 2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    //**
    //***конструктивные характеристики
    //**
    /*parameter SI.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
                                                                                                                                                                                                                                                                                                                                                                      parameter SI.Length delta = 0.003 "Толщина стенки трубки теплообменника";
                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг";
                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг";
                                                                                                                                                                                                                                                                                                                                                                      parameter Real zahod = 1 "заходность труб теплообменника";
                                                                                                                                                                                                                                                                                                                                                                      parameter Integer z1 = 126 "Число труб по ширине газохода";
                                                                                                                                                                                                                                                                                                                                                                      parameter Integer z2_total = 18 "Общее число труб по ходу газов в теплообменнике";
                                                                                                                                                                                                                                                                                                                                                                      parameter Integer z2 = 1 "Число труб по ходу газов в данной поверхности нагрева";
                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки";
                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length Hpipe = Lpipe "Разность высотных отметов выхода и входа теплообменной трубки";
                                                                                                                                                                                                                                                                                                                                                                      ///Оребрение
                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м";
                                                                                                                                                                                                                                                                                                                                                                      parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м";
                                                                                                                                                                                                                                                                                                                                                                      //**/
    //***
    //**
    ThermoPower.Gas.SourceMassFlow gassource(redeclare package Medium = Medium_G, p0 = pgas, T = Tingas, w0 = wgas, use_in_T = true, use_in_X = true) annotation(Placement(visible = true, transformation(origin = {-88, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step gastempstep(height = 0, offset = Tingas, startTime = 20000) annotation(Placement(visible = true, transformation(origin = {-88, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    inner ThermoPower.System system annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Gas.SensT sensgas1(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {-56, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant[6] setX(k = Set_X) annotation(Placement(visible = true, transformation(origin = {-88, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step gasvalvestep(height = 0, offset = 1, startTime = 50000) annotation(Placement(visible = true, transformation(origin = {18, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    MyHRSG.onlyGasHE100501 onlygashe1(redeclare package Medium_G = Medium_G, numberOfTubeSections = numberOfTubeSections, numberOfFlueSections = numberOfFlueSections) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Gas.SinkPressure sinkgas(redeclare package Medium = Medium_G, p0 = pgas, T = 300) annotation(Placement(visible = true, transformation(origin = {90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Gas.ValveLin gasvalve(redeclare package Medium = Medium_G, Kv = wgas / pgas) annotation(Placement(visible = true, transformation(origin = {38, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Gas.SensT sensgas2(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {66, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature tempSource[numberOfFlueSections, numberOfTubeSections](T = 65 + 372.15) annotation(Placement(visible = true, transformation(origin = {8, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  equation
    connect(gasvalve.outlet, sensgas2.inlet) annotation(Line(points = {{48, 60}, {60, 60}}, color = {159, 159, 223}));
    connect(sensgas2.outlet, sinkgas.flange) annotation(Line(points = {{72, 60}, {80, 60}}, color = {159, 159, 223}));
    connect(gasvalvestep.y, gasvalve.cmd) annotation(Line(points = {{29, 88}, {33.5, 88}, {33.5, 90}, {38, 90}, {38, 67}}, color = {0, 0, 127}));
    connect(onlygashe1.gasOut, gasvalve.inlet) annotation(Line(points = {{10, 0}, {28, 0}, {28, 60}}, color = {159, 159, 223}));
    for j in 1:numberOfTubeSections loop
      for i in 1:numberOfFlueSections loop
        connect(tempSource[i, j].port, onlygashe1.heat[i, j]);
      end for;
    end for;
    connect(sensgas1.outlet, onlygashe1.gasIn) annotation(Line(points = {{-50, 0}, {-10, 0}}, color = {159, 159, 223}));
    connect(setX.y, gassource.in_X) annotation(Line(points = {{-77, -28}, {-70, -28}, {-70, 10}, {-82, 10}, {-82, 6}, {-82, 6}}, color = {0, 0, 127}));
    connect(gassource.flange, sensgas1.inlet) annotation(Line(points = {{-78, 0}, {-62, 0}}, color = {159, 159, 223}));
    connect(gastempstep.y, gassource.in_T) annotation(Line(points = {{-77, 32}, {-68, 32}, {-68, 12}, {-88, 12}, {-88, 6}, {-88, 6}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 100000, Tolerance = 1e-06, Interval = 200));
  end testOnlyGasHE;

  model testHE
    import ThermoPower.*;
    //**
    //***Исходные данные для газовой стороны
    //**
    replaceable package Medium_G = MyHRSG.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter SI.MassFlowRate wgas = 509 "Номинальный (и начальный) массовый расход газов";
    parameter SI.Pressure pgas = 3e3 "Начальное давление газов";
    parameter SI.Temperature Tingas = 184 + 273.15 "Начальная входная температура газов";
    parameter SI.Temperature Toutgas = 170 + 273.15 "Начальная выходная температура газов";
    parameter SI.Temperature T2gas = (Tingas + Toutgas) / 2 "Промежуточная температура газов";
    parameter Real k_gamma_gas = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
    parameter Real Set_X[6] = Medium_G.reference_X "Состав дымовых газов";
    //**
    //***Исходные данные для водяной стороны
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Modelica.SIunits.MassFlowRate wflow = 78 "Номинальный массовый расход воды/пар";
    parameter Modelica.SIunits.Pressure pflow = 10e5 "Начальное давление потока вода/пар";
    parameter SI.Temperature Tinflow = 60 + 273.15 "Начальная входная температура потока воды/пар";
    parameter SI.Temperature Toutflow = 75 + 273.15 "Начальная выходная температура потока воды/пар";
    parameter SI.Temperature T2flow = (Tinflow + Toutflow) / 2 "Начальная промежуточная температура потока воды/пар";
    parameter Modelica.SIunits.SpecificEnthalpy hinflow = Medium_F.specificEnthalpy_pT(pflow, Tinflow) "Начальная энтальпия входного потока вода/пар";
    parameter Modelica.SIunits.SpecificEnthalpy houtflow = Medium_F.specificEnthalpy_pT(pflow, Toutflow) "Начальная энтальпия выходного потока вода/пар";
    parameter Modelica.SIunits.SpecificEnthalpy h2flow = Medium_F.specificEnthalpy_pT(pflow, T2flow) "Начальная промежуточная энтальпия потока вода/пар";
    //**
    //***Исходные данные по разбиению
    //**
    parameter Integer numberOfTubeSections = 10 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfFlueSections = 2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    //**
    //***конструктивные характеристики
    //**
    parameter SI.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
    parameter SI.Length delta = 0.003 "Толщина стенки трубки теплообменника";
    parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг";
    parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг";
    parameter Real zahod = 1 "заходность труб теплообменника";
    parameter Integer z1 = 126 "Число труб по ширине газохода";
    parameter Integer z2_total = 18 "Общее число труб по ходу газов в теплообменнике";
    parameter Integer z2 = 1 "Число труб по ходу газов в данной поверхности нагрева";
    parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки";
    parameter Modelica.SIunits.Length Hpipe = Lpipe "Разность высотных отметов выхода и входа теплообменной трубки";
    ///Оребрение
    parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
    parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м";
    parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м";
    //**
    //***
    //**
    inner ThermoPower.System system annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Gas.SinkPressure sinkgas(redeclare package Medium = Medium_G, p0 = pgas, T = 300) annotation(Placement(visible = true, transformation(origin = {90, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Gas.ValveLin gasvalve(redeclare package Medium = Medium_G, Kv = wgas / pgas) annotation(Placement(visible = true, transformation(origin = {38, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Gas.SensT sensgas2(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {66, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Gas.SourceMassFlow gassource(redeclare package Medium = Medium_G, p0 = pgas, T = Tingas, w0 = wgas, use_in_T = true, use_in_X = true) annotation(Placement(visible = true, transformation(origin = {-90, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step gastempstep(height = 0, offset = Tingas, startTime = 100) annotation(Placement(visible = true, transformation(origin = {-90, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Gas.SensT sensgas1(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {-58, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant[6] setX(k = Set_X) annotation(Placement(visible = true, transformation(origin = {-90, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    MyHRSG.onlyGasHE100501 onlygashe1(redeclare package Medium_G = Medium_G, numberOfTubeSections = numberOfTubeSections, numberOfFlueSections = numberOfFlueSections) annotation(Placement(visible = true, transformation(origin = {0, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    MyHRSG.onlyFlowHE100501 onlyFlowHE1005011(redeclare package Medium_F = Medium_F, setD_flow = wflow, setp_flow = pflow, setT_inFlow = Tinflow, setT_outFlow = Toutflow, numberOfTubeSections = numberOfTubeSections, numberOfFlueSections = numberOfFlueSections) annotation(Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    ThermoPower.Water.SourceMassFlow flowsource(p0 = pflow, h = hinflow, w0 = wflow, use_in_w0 = false, use_in_h = true, redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-88, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.SensT sensflow1(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-46, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step flowenthalpstep(height = 0, offset = hinflow, startTime = 80) annotation(Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.SinkPressure sinkflow(p0 = pflow / 2, redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.SensT sensflow2(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {60, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.ValveLin flowvalve(redeclare package Medium = Medium_F, Kv = wflow / pflow) annotation(Placement(visible = true, transformation(origin = {34, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step flowvalvestep(height = 0, offset = 1, startTime = 150000) annotation(Placement(visible = true, transformation(origin = {4, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step gasvalvestep(height = 0, offset = 1, startTime = 40) annotation(Placement(visible = true, transformation(origin = {18, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(gasvalvestep.y, gasvalve.cmd) annotation(Line(points = {{29, 90}, {38, 90}, {38, 65}}, color = {0, 0, 127}));
    connect(sensflow2.outlet, sinkflow.flange) annotation(Line(points = {{66, -90}, {80, -90}, {80, -92}, {80, -92}}, color = {0, 0, 255}));
    connect(flowvalve.outlet, sensflow2.inlet) annotation(Line(points = {{44, -90}, {54, -90}, {54, -90}, {54, -90}}, color = {0, 0, 255}));
    connect(flowvalvestep.y, flowvalve.cmd) annotation(Line(points = {{15, -54}, {34, -54}, {34, -80}, {34, -80}}, color = {0, 0, 127}));
    connect(onlyFlowHE1005011.waterOut, flowvalve.inlet) annotation(Line(points = {{10, -10}, {28, -10}, {28, -34}, {-12, -34}, {-12, -90}, {24, -90}, {24, -90}}, color = {0, 127, 255}));
    connect(sensflow1.outlet, onlyFlowHE1005011.waterIn) annotation(Line(points = {{-40, 60}, {-34, 60}, {-34, -10}, {-10, -10}, {-10, -10}}, color = {0, 0, 255}));
    connect(sensflow1.inlet, flowsource.flange) annotation(Line(points = {{-52, 60}, {-78, 60}, {-78, 60}, {-78, 60}}, color = {0, 0, 255}));
    connect(flowenthalpstep.y, flowsource.in_h) annotation(Line(points = {{-79, 90}, {-72, 90}, {-72, 74}, {-84, 74}, {-84, 66}, {-84, 66}}, color = {0, 0, 127}));
    connect(onlygashe1.heat[numberOfFlueSections, numberOfTubeSections], onlyFlowHE1005011.heat[numberOfFlueSections, numberOfTubeSections]) annotation(Line(points = {{9, 19}, {10, 19}, {10, -2}, {10, -2}}, color = {191, 0, 0}));
    connect(sensgas1.outlet, onlygashe1.gasIn) annotation(Line(points = {{-52, -60}, {-29, -60}, {-29, 28}, {-10, 28}}, color = {159, 159, 223}));
    connect(onlygashe1.gasOut, gasvalve.inlet) annotation(Line(points = {{10, 28}, {28, 28}, {28, 60}}, color = {159, 159, 223}));
    connect(setX.y, gassource.in_X) annotation(Line(points = {{-79, -88}, {-75.5, -88}, {-75.5, -88}, {-72, -88}, {-72, -50}, {-84, -50}, {-84, -54}, {-84, -54}}, color = {0, 0, 127}));
    connect(gassource.flange, sensgas1.inlet) annotation(Line(points = {{-80, -60}, {-64, -60}}, color = {159, 159, 223}));
    connect(gastempstep.y, gassource.in_T) annotation(Line(points = {{-79, -28}, {-76.75, -28}, {-76.75, -28}, {-74.5, -28}, {-74.5, -28}, {-72, -28}, {-72, -48}, {-92, -48}, {-92, -54}, {-90, -54}, {-90, -54}, {-90, -54}, {-90, -54}, {-90, -54}}, color = {0, 0, 127}));
    connect(sensgas2.outlet, sinkgas.flange) annotation(Line(points = {{72, 58}, {80, 58}}, color = {159, 159, 223}));
    connect(gasvalve.outlet, sensgas2.inlet) annotation(Line(points = {{48, 58}, {60, 58}}, color = {159, 159, 223}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 2));
  end testHE;

  model onlyFlowHE
    function positiveMax
      extends Modelica.Icons.Function;
      input Real x;
      output Real y;
    algorithm
      y := max(x, 1e-10);
    end positiveMax;

    //**
    //***Исходные данные для газовой стороны
    //**
    parameter Modelica.SIunits.Power setQ_gas = 100 "тепловой поток со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
    //**
    //***Исходные данные по стороне вода/пар
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow = 10e5 "Начальное давление потока вода/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
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
    parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer zahod = 2 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Hpipe = Lpipe "Разность высотных отметов выхода и входа теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Real Xi_flow = 0.3 "Коэффициент гидравлического сопротивления участка трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    //Константы
    //Поток вода/пар
    parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 / numberOfTubeSections "Внутренняя площадь одного участка ряда труб";
    parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 / 4 / numberOfTubeSections "Внутренний объем одного участка ряда труб";
    parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 / numberOfTubeSections "Масса металла участка ряда труб";
    parameter Modelica.SIunits.Length deltaHpipe = Hpipe / numberOfTubeSections "Разность высот на участке ряда труб";
    parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
    //**
    //Начальные значения
    //**
    //Поток вода/пар
    parameter Medium_F.SpecificEnthalpy h_startTubeFlow[numberOfTubeSections + 1] = linspace(Medium_F.specificEnthalpy_pT(setp_flow, setT_inFlow), Medium_F.specificEnthalpy_pT(setp_flow, setT_outFlow), numberOfTubeSections + 1) "Начальный вектор энальпии потока вода/пар вдоль трубы" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow[numberOfFlueSections, numberOfTubeSections + 1] = array(array(h_startTubeFlow[j] for j in 1:numberOfTubeSections + 1) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow[numberOfFlueSections, numberOfTubeSections + 1] = fill(setp_flow, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow[numberOfFlueSections, numberOfTubeSections + 1] = fill(setD_flow / numberOfFlueSections, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор массового расхода потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startTubeM[numberOfTubeSections] = if numberOfTubeSections == 1 then {(setT_inFlow + setT_outFlow) / 2} else linspace(setT_inFlow, setT_outFlow, numberOfTubeSections) "Начальный вектор температур металла" annotation(Dialog(tab = "Инициализация"));
    parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = array(array(t_startTubeM[j] for j in 1:numberOfTubeSections) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    //Поток вода/пар
    Medium_F.ThermodynamicState stateFlow[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    Medium_F.AbsolutePressure p_flow[numberOfFlueSections, numberOfTubeSections + 1](start = p_startFlow) "Давление потока вода/пар по участкам трубы";
    Medium_F.SpecificEnthalpy h_flow[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow) "Энтальпия потока вода/пар по участкам трубы";
    Medium_F.Density rho_flow[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы";
    Modelica.SIunits.DerDensityByEnthalpy drdh_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow[numberOfFlueSections, numberOfTubeSections + 1](start = D_startFlow) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
    //Металл
    Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    //Real C1[numberOfFlueSections, numberOfTubeSections] "Показатель в числителе уравнения сплошности";
    //Real C2[numberOfFlueSections, numberOfTubeSections] "Показатель в знаменателе уравнения сплошности";
    //Boolean hod_flow[numberOfFlueSections] "Текущий ход потока вода/пар (true - нечетный ход, false - четный)";
    //Integer numberHod_flow[numberOfFlueSections] "Текущий номер потока воды/пар";
    //**
    //Интерфейс
    //**
    Modelica.Fluid.Interfaces.FluidPort_a waterIn annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = true, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    //*****Уравнения для потока вода/пар и металла
    for i in 1:numberOfFlueSections loop
      //numberHod_flow[i] = i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod);
      //hod_flow[i] = if (-1) ^ numberHod_flow[i] < 0 then true else false;
      for j in 1:numberOfTubeSections loop
        if (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) < 0 then
          //выбор уравнения в зависимости от четного или нечетного хода потока вода/пар
          deltaVFlow * rho_flow[i, j] * der(h_flow[i, j + 1]) = alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - D_flow[i, j + 1] * (h_flow[i, j + 1] - h_flow[i, j]);
        else
          deltaVFlow * rho_flow[i, j] * der(h_flow[i, j]) = alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) + D_flow[i, j] * (h_flow[i, j + 1] - h_flow[i, j]);
        end if;
        //der(p_flow[i, j]) * deltaVFlow * drdp_flow[i, j] = D_flow[i, j] - D_flow[i, j + 1] - deltaVFlow * drdh_flow[i, j] * der(h_flow[i, j + 1]) "Уравнение сплошности (формула 3-6 диссертации Рубашкина) drdp_flow[i, j] - абсолютный ноль, смотри уравнения состояния";
        //C1[i, j] = deltaVFlow * drdh_flow[i, j] * (if hod_flow[i] then der(h_flow[i, j + 1]) else der(h_flow[i, j]));
        //C2[i, j] = deltaVFlow * drdp_flow[i, j];
        //abs(p_flow[i, j] - p_flow[i, j + 1]) = D_flow[i, j + 1] ^ 2 / rho_flow[i, j] / Cd_flow[i, j];
        p_flow[i, j + 1] = p_flow[i, j];
        D_flow[i, j + 1] = D_flow[i, j];
        deltaMMetal * C_m * der(t_m[i, j]) = heat[i, j].Q_flow - alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
        heat[i, j].T = t_m[i, j];
        //Уравнения состояния
        if (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) < 0 then
          stateFlow[i, j] = Medium_F.setState_ph(p_flow[i, j + 1], h_flow[i, j + 1]);
        else
          stateFlow[i, j] = Medium_F.setState_ph(p_flow[i, j], h_flow[i, j]);
        end if;
        t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
        rho_flow[i, j] = Medium_F.density(stateFlow[i, j]);
        drdp_flow[i, j] = if Medium_F.singleState then 0 else Medium_F.density_derp_h(stateFlow[i, j]);
        drdh_flow[i, j] = Medium_F.density_derh_p(stateFlow[i, j]);
        //Коэффициент теплоотдачи
        k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
        Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
        mu_flow[i, j] = Medium_F.dynamicViscosity(stateFlow[i, j]);
        if (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) < 0 then
          Re_flow[i, j] = abs(D_flow[i, j + 1] * Din / (f_flow * mu_flow[i, j]));
        else
          Re_flow[i, j] = abs(D_flow[i, j] * Din / (f_flow * mu_flow[i, j]));
        end if;
        alfa_flow[i, j] = 0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4;
      end for;
    end for;
    for i in 1:numberOfFlueSections - zahod loop
      //Описание гибов
      if (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) < 0 then
        D_flow[i, numberOfTubeSections + 1] = D_flow[i + zahod, numberOfTubeSections + 1];
        p_flow[i, numberOfTubeSections + 1] = p_flow[i + zahod, numberOfTubeSections + 1];
        h_flow[i, numberOfTubeSections + 1] = h_flow[i + zahod, numberOfTubeSections + 1];
      else
        D_flow[i, 1] = D_flow[i + zahod, 1];
        p_flow[i, 1] = p_flow[i + zahod, 1];
        h_flow[i, 1] = h_flow[i + zahod, 1];
      end if;
    end for;
    //Граничные условия
    for i in 2:zahod loop
      D_flow[i - 1, 1] = D_flow[i, 1];
    end for;
    waterIn.m_flow = sum(D_flow[i, 1] for i in 1:zahod);
    0 = waterOut.m_flow + sum(D_flow[i, numberOfTubeSections + 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections);
    if waterIn.m_flow > 0 then
      for i in numberOfFlueSections - zahod + 1:numberOfFlueSections loop
        if (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) < 0 then
          waterOut.p = p_flow[i, numberOfTubeSections + 1];
        else
          waterOut.p = p_flow[i, 1];
        end if;
      end for;
      waterIn.p = sum(p_flow[i, 1] for i in 1:zahod) / zahod;
    else
      for i in 1:zahod loop
        waterIn.p = p_flow[i, 1];
      end for;
      if (-1) ^ (numberOfFlueSections / zahod + (if mod(numberOfFlueSections, zahod) == 0 then 0 else 1 - mod(numberOfFlueSections, zahod) / zahod)) < 0 then
        waterOut.p = sum(p_flow[i, numberOfTubeSections + 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections) / zahod;
      else
        waterOut.p = sum(p_flow[i, 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections) / zahod;
      end if;
    end if;
    if waterIn.m_flow > 0 then
      for i in 1:zahod loop
        h_flow[i, 1] = inStream(waterIn.h_outflow);
      end for;
    else
      for i in numberOfFlueSections - zahod + 1:numberOfFlueSections loop
        if (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) < 0 then
          h_flow[i, numberOfTubeSections + 1] = inStream(waterOut.h_outflow);
        else
          h_flow[i, 1] = inStream(waterOut.h_outflow);
        end if;
      end for;
    end if;
    if (-1) ^ (numberOfFlueSections / zahod + (if mod(numberOfFlueSections, zahod) == 0 then 0 else 1 - mod(numberOfFlueSections, zahod) / zahod)) < 0 then
      waterOut.h_outflow = sum(array(positiveMax(D_flow[i, numberOfTubeSections + 1]) * h_flow[i, numberOfTubeSections + 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections)) / sum(array(positiveMax(D_flow[i, numberOfTubeSections + 1]) for i in numberOfFlueSections - zahod + 1:numberOfFlueSections));
    else
      waterOut.h_outflow = sum(array(positiveMax(D_flow[i, 1]) * h_flow[i, 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections)) / sum(array(positiveMax(D_flow[i, 1]) for i in numberOfFlueSections - zahod + 1:numberOfFlueSections));
    end if;
    waterIn.h_outflow = sum(array(positiveMax(D_flow[i, 1]) * h_flow[i, 1] for i in 1:zahod)) / sum(array(positiveMax(D_flow[i, 1]) for i in 1:zahod));
    annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется неског=лько ходов</html>"), Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-100, -115}, {100, -145}}, lineColor = {85, 170, 255}, textString = "%name")}), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
  end onlyFlowHE;

  model TestOnlyFlowHE2
    import ThermoPower.*;
    //**
    //***Исходные данные для водяной стороны
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Modelica.SIunits.MassFlowRate wflow = 78 "Номинальный массовый расход воды/пар";
    parameter Modelica.SIunits.Pressure pflow = 10e5 "Начальное давление потока вода/пар";
    parameter SI.Temperature Tinflow = 60 + 273.15 "Начальная входная температура потока воды/пар";
    parameter SI.Temperature Toutflow = 80 + 273.15 "Начальная выходная температура потока воды/пар";
    parameter SI.Temperature T2flow = (Tinflow + Toutflow) / 2 "Начальная промежуточная температура потока воды/пар";
    parameter Modelica.SIunits.SpecificEnthalpy hinflow = Medium_F.specificEnthalpy_pT(pflow, Tinflow) "Начальная энтальпия входного потока вода/пар";
    parameter Modelica.SIunits.SpecificEnthalpy houtflow = Medium_F.specificEnthalpy_pT(pflow, Toutflow) "Начальная энтальпия выходного потока вода/пар";
    parameter Modelica.SIunits.SpecificEnthalpy h2flow = Medium_F.specificEnthalpy_pT(pflow, T2flow) "Начальная промежуточная энтальпия потока вода/пар";
    //**
    //***Исходные данные по разбиению
    //**
    parameter Integer numberOfTubeSections = 5 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева";
    parameter Integer zahod = 2 "заходность труб теплообменника";
    /*//**
                                                                                                                                                                                                                      //***конструктивные характеристики
                                                                                                                                                                                                                      //**
                                                                                                                                                                                                                      parameter SI.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
                                                                                                                                                                                                                      parameter SI.Length delta = 0.003 "Толщина стенки трубки теплообменника";
                                                                                                                                                                                                                      parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг";
                                                                                                                                                                                                                      parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг";
                                                                                                                                                                                                                      parameter Real zahod = 1 "заходность труб теплообменника";
                                                                                                                                                                                                                      parameter Integer z1 = 126 "Число труб по ширине газохода";
                                                                                                                                                                                                                      parameter Integer z2_total = 18 "Общее число труб по ходу газов в теплообменнике";
                                                                                                                                                                                                                      parameter Integer z2 = 1 "Число труб по ходу газов в данной поверхности нагрева";
                                                                                                                                                                                                                      parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки";
                                                                                                                                                                                                                      parameter Modelica.SIunits.Length Hpipe = Lpipe "Разность высотных отметов выхода и входа теплообменной трубки";
                                                                                                                                                                                                                      ///Оребрение
                                                                                                                                                                                                                      parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
                                                                                                                                                                                                                      parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м";
                                                                                                                                                                                                                      parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м";
                                                                                                                                                                                                                      //**/
    //***
    //**
    ThermoPower.Water.SourceMassFlow flowsource(p0 = pflow, h = hinflow, w0 = wflow, use_in_w0 = false, use_in_h = true, redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-88, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.SensT sensflow1(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-46, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step flowenthalpstep(height = 0, offset = hinflow, startTime = 80) annotation(Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    inner ThermoPower.System system annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.SinkPressure sinkflow(p0 = pflow / 2, redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.SensT sensflow2(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {60, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.ValveLin flowvalve(redeclare package Medium = Medium_F, Kv = wflow / pflow) annotation(Placement(visible = true, transformation(origin = {34, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    //Modelica.Blocks.Sources.IntegerTable flowvalvestep(table = [0, 1; 50000, 0.7; 70000, 0.4; 100000, 1]) annotation(Placement(visible = true, transformation(origin = {10, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step flowvalvestep(height = -0.3, offset = 1, startTime = 10000) annotation(Placement(visible = true, transformation(origin = {4, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    MyHRSG.onlyFlowHE onlyFlowHE1(redeclare package Medium_F = Medium_F, setD_flow = wflow, setp_flow = pflow, setT_inFlow = Tinflow, setT_outFlow = Toutflow, numberOfTubeSections = numberOfTubeSections, z2 = z2, zahod = zahod) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow heatSource[numberOfFlueSections, numberOfTubeSections](Q_flow = 5.1e6 / numberOfTubeSections / numberOfFlueSections) annotation(Placement(visible = true, transformation(origin = {48, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  equation
    for j in 1:numberOfTubeSections loop
      for i in 1:numberOfFlueSections loop
        connect(heatSource[i, j].port, onlyFlowHE1.heat[i, j]);
      end for;
    end for;
    connect(sensflow1.outlet, onlyFlowHE1.waterIn) annotation(Line(points = {{-40, 60}, {0, 60}, {0, 10}, {0, 10}}, color = {0, 0, 255}));
    connect(onlyFlowHE1.waterOut, flowvalve.inlet) annotation(Line(points = {{0, -10}, {0, -10}, {0, -30}, {-30, -30}, {-30, -90}, {24, -90}, {24, -90}}, color = {0, 0, 255}));
    connect(flowvalvestep.y, flowvalve.cmd) annotation(Line(points = {{15, -54}, {34, -54}, {34, -82}}, color = {0, 0, 127}));
    connect(flowvalve.outlet, sensflow2.inlet) annotation(Line(points = {{44, -90}, {54, -90}}, color = {0, 0, 255}));
    connect(sensflow2.outlet, sinkflow.flange) annotation(Line(points = {{66, -90}, {80, -90}, {80, -92}, {80, -92}, {80, -92}, {80, -92}}, color = {0, 0, 255}));
    connect(flowsource.flange, sensflow1.inlet) annotation(Line(points = {{-78, 60}, {-52, 60}, {-52, 60}, {-52, 60}}, color = {0, 0, 255}));
    connect(flowenthalpstep.y, flowsource.in_h) annotation(Line(points = {{-79, 90}, {-74, 90}, {-74, 72}, {-84, 72}, {-84, 68}, {-84, 68}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 200000, Tolerance = 1e-06, Interval = 400));
  end TestOnlyFlowHE2;

  model onlyFlowHE100502
    function positiveMax
      extends Modelica.Icons.Function;
      input Real x;
      output Real y;
    algorithm
      y := max(x, 1e-10);
    end positiveMax;

    //**
    //***Исходные данные для газовой стороны
    //**
    parameter Modelica.SIunits.Power setQ_gas = 100 "тепловой поток со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
    //**
    //***Исходные данные по стороне вода/пар
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow = 10e5 "Начальное давление потока вода/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
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
    parameter Integer numberOfTubeSections = 10 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfFlueSections = 2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Real zahod = numberOfFlueSections "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Hpipe = Lpipe "Разность высотных отметов выхода и входа теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Real Xi_flow = 0.3 "Коэффициент гидравлического сопротивления участка трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Real Cd_flow = 1 / sqrt(Xi_flow / 2 / Modelica.Constants.g_n / f_flow ^ 2) "Константа характеризующая конструкцию тракта";
    //Константы
    //Поток вода/пар
    parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 / numberOfTubeSections "Внутренняя площадь одного участка ряда труб";
    parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 / 4 / numberOfTubeSections "Внутренний объем одного участка ряда труб";
    parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 / numberOfTubeSections "Масса металла участка ряда труб";
    parameter Modelica.SIunits.Length deltaHpipe = Hpipe / numberOfTubeSections "Разность высот на участке ряда труб";
    parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
    //**
    //Начальные значения
    //**
    //Поток вода/пар
    parameter Medium_F.SpecificEnthalpy h_startTubeFlow[numberOfTubeSections + 1] = linspace(Medium_F.specificEnthalpy_pT(setp_flow, setT_inFlow), Medium_F.specificEnthalpy_pT(setp_flow, setT_outFlow), numberOfTubeSections + 1) "Начальный вектор энальпии потока вода/пар вдоль трубы" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow[numberOfFlueSections, numberOfTubeSections + 1] = array(array(h_startTubeFlow[j] for j in 1:numberOfTubeSections + 1) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow[numberOfFlueSections, numberOfTubeSections + 1] = fill(setp_flow, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow[numberOfFlueSections, numberOfTubeSections + 1] = fill(setD_flow / numberOfFlueSections, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор массового расхода потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startTubeM[numberOfTubeSections] = if numberOfTubeSections == 1 then {(setT_inFlow + setT_outFlow) / 2} else linspace(setT_inFlow, setT_outFlow, numberOfTubeSections) "Начальный вектор температур металла" annotation(Dialog(tab = "Инициализация"));
    parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = array(array(t_startTubeM[j] for j in 1:numberOfTubeSections) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    //Поток вода/пар
    Medium_F.ThermodynamicState stateFlow[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    Medium_F.AbsolutePressure p_flow[numberOfFlueSections, numberOfTubeSections + 1](start = p_startFlow) "Давление потока вода/пар по участкам трубы";
    Medium_F.SpecificEnthalpy h_flow[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow) "Энтальпия потока вода/пар по участкам трубы";
    Medium_F.Density rho_flow[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы";
    Modelica.SIunits.DerDensityByEnthalpy drdh_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow[numberOfFlueSections, numberOfTubeSections + 1](start = D_startFlow) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
    //Металл
    Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    Real C1[numberOfFlueSections, numberOfTubeSections] "Показатель в числителе уравнения сплошности";
    Real C2[numberOfFlueSections, numberOfTubeSections] "Показатель в знаменателе уравнения сплошности";
    Modelica.SIunits.MassFlowRate dD[numberOfFlueSections, numberOfTubeSections] "Разность расходов на входе и выходе участка потока вода/пар";
    Modelica.SIunits.Pressure Dpfric[numberOfFlueSections, numberOfTubeSections] "Гидавлическое сопротивление участка потока вода/пар";
    //**
    //Интерфейс
    //**
    Modelica.Fluid.Interfaces.FluidPort_a waterIn annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = true, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    //*****Уравнения для потока вода/пар и металла
    for i in 1:numberOfFlueSections loop
      for j in 1:numberOfTubeSections loop
        deltaVFlow * rho_flow[i, j] * der(h_flow[i, j + 1]) = alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - D_flow[i, j + 1] * (h_flow[i, j + 1] - h_flow[i, j]) "Уравнение баланса тепла теплоносителя (формула 3-1d диссертации Рубашкина)";
        C1[i, j] = deltaVFlow * drdh_flow[i, j] * der(h_flow[i, j + 1]);
        C2[i, j] = deltaVFlow * drdp_flow[i, j];
        //* der(p_flow[i, j + 1]) добавление в уравнение С2 производной по давлению вызывает ошибку компиляции
        dD[i, j] = C1[i, j] "Уравнение сплошности (формула 3-6 диссертации Рубашкина) пренебрегаем слогамым C2[i, j] * der(p_flow[i, j + 1])";
        Dpfric[i, j] = D_flow[i, j + 1] ^ 2 / rho_flow[i, j] / Cd_flow;
        p_flow[i, j + 1] = p_flow[i, j] - Dpfric[i, j];
        D_flow[i, j + 1] = D_flow[i, j];
        deltaMMetal * C_m * der(t_m[i, j]) = heat[i, j].Q_flow - alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
        heat[i, j].T = t_m[i, j];
        //Уравнения состояния
        stateFlow[i, j] = Medium_F.setState_ph(p_flow[i, j + 1], h_flow[i, j + 1]);
        t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
        rho_flow[i, j] = Medium_F.density(stateFlow[i, j]);
        drdp_flow[i, j] = if Medium_F.singleState then 0 else Medium_F.density_derp_h(stateFlow[i, j]);
        drdh_flow[i, j] = Medium_F.density_derh_p(stateFlow[i, j]);
        //Коэффициент теплоотдачи
        k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
        Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
        mu_flow[i, j] = Medium_F.dynamicViscosity(stateFlow[i, j]);
        Re_flow[i, j] = abs(D_flow[i, j + 1] * Din / (f_flow * mu_flow[i, j]));
        //не верная формула
        alfa_flow[i, j] = 0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4;
      end for;
    end for;
    //Граничные условия
    for i in 2:numberOfFlueSections loop
      D_flow[i - 1, 1] = D_flow[i, 1];
    end for;
    waterIn.m_flow = sum(D_flow[i, 1] for i in 1:numberOfFlueSections);
    0 = waterOut.m_flow + sum(D_flow[i, numberOfTubeSections + 1] for i in 1:numberOfFlueSections);
    if waterIn.m_flow > 0 then
      for i in 1:numberOfFlueSections loop
        waterOut.p = p_flow[i, numberOfTubeSections + 1];
      end for;
      waterIn.p = sum(p_flow[i, 1] for i in 1:numberOfFlueSections) / numberOfFlueSections;
    else
      for i in 1:numberOfFlueSections loop
        waterIn.p = p_flow[i, 1];
      end for;
      waterOut.p = sum(p_flow[i, numberOfTubeSections + 1] for i in 1:numberOfFlueSections) / numberOfFlueSections;
    end if;
    if waterIn.m_flow > 0 then
      for i in 1:numberOfFlueSections loop
        h_flow[i, 1] = inStream(waterIn.h_outflow);
      end for;
    else
      for i in 1:numberOfFlueSections loop
        h_flow[i, numberOfTubeSections + 1] = inStream(waterOut.h_outflow);
      end for;
    end if;
    waterOut.h_outflow = sum(array(positiveMax(D_flow[i, numberOfTubeSections + 1]) * h_flow[i, numberOfTubeSections + 1] for i in 1:numberOfFlueSections)) / sum(array(positiveMax(D_flow[i, numberOfTubeSections + 1]) for i in 1:numberOfFlueSections));
    waterIn.h_outflow = sum(array(positiveMax(D_flow[i, 1]) * h_flow[i, 1] for i in 1:numberOfFlueSections)) / sum(array(positiveMax(D_flow[i, 1]) for i in 1:numberOfFlueSections));
    annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Но не используются гибы, т.е. возможет только прямой участок труб между коллекторами, можно сказать, что моделируется только один ход теплообменника</html>"), Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-100, -115}, {100, -145}}, lineColor = {85, 170, 255}, textString = "%name")}), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
  end onlyFlowHE100502;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end MyHRSG;