package MyHRSG
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
    parameter Modelica.SIunits.Length ke = 0.0014 "Абсолютная эквивалентная шероховатость";
    parameter Real lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2 "Коэффициент трения при движении среды по трубам";
    parameter Real Xi_flow = lambda_tr * Lpipe / Din / numberOfTubeSections "Коэффициент гидравлического сопротивления участка трубы" annotation(Dialog(group = "Конструктивные характеристики"));
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
    parameter Medium_F.SpecificEnthalpy h_startFlow_v[numberOfFlueSections, numberOfTubeSections] = array(array(h_startTubeFlow[j] for j in 1:numberOfTubeSections) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = array(array(h_startTubeFlow[j] for j in 1:numberOfTubeSections + 1) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(setp_flow, numberOfFlueSections, numberOfTubeSections) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(setp_flow, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(setD_flow / numberOfFlueSections, numberOfFlueSections, numberOfTubeSections) "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(setD_flow / numberOfFlueSections, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startTubeM[numberOfTubeSections] = if numberOfTubeSections == 1 then {(setT_inFlow + setT_outFlow) / 2} else linspace(setT_inFlow, setT_outFlow, numberOfTubeSections) "Начальный вектор температур металла" annotation(Dialog(tab = "Инициализация"));
    parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = array(array(t_startTubeM[j] for j in 1:numberOfTubeSections) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    //Поток вода/пар
    Medium_F.ThermodynamicState stateFlow[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    Medium_F.AbsolutePressure p_flow_v[numberOfFlueSections, numberOfTubeSections](start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.AbsolutePressure p_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
    Medium_F.SpecificEnthalpy h_flow_v[numberOfFlueSections, numberOfTubeSections](start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.SpecificEnthalpy h_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
    Medium_F.Density rho_flow_v[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы в конечных объемах";
    Medium_F.Density rho_flow_n[numberOfFlueSections, numberOfTubeSections + 1] "Плотность потока по участкам трубы в узловых точках";
    Modelica.SIunits.DerDensityByEnthalpy drdh_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow_v[numberOfFlueSections, numberOfTubeSections](start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
    Medium_F.MassFlowRate D_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
    //Металл
    Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    Real C1[numberOfFlueSections, numberOfTubeSections] "Показатель в числителе уравнения сплошности";
    Real C2[numberOfFlueSections, numberOfTubeSections] "Показатель в знаменателе уравнения сплошности";
    Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
    Modelica.SIunits.Length H_flow[numberOfFlueSections, numberOfTubeSections + 1] "Высотная отметка каждого узла";
    Modelica.SIunits.Velocity w_flow_v[numberOfFlueSections, numberOfTubeSections] "Скорость потока вода/пар в конечных объемах";
    Modelica.SIunits.Velocity w_flow_n[numberOfFlueSections, numberOfTubeSections + 1] "Скорость потока вода/пар в узловых точках";
    Real dp_fric[numberOfFlueSections, numberOfTubeSections] "Потеря давления из-за сил трения";
    Real dp_kin[numberOfFlueSections, numberOfTubeSections] "Потеря давления из-за приращения кинетической энергии";
    Real dp_piez[numberOfFlueSections, numberOfTubeSections] "Перепад давления из-за изменения пьезометрической высоты";
    //**
    //Интерфейс
    //**
    Modelica.Fluid.Interfaces.FluidPort_a waterIn annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = true, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    //*****Уравнения для потока вода/пар и металла
    for i in 1:numberOfFlueSections loop
      hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева";
      //Рачет скорости потока в узловых точках
      for j in 1:numberOfTubeSections + 1 loop
        rho_flow_n[i, j] = Medium_F.density_ph(p_flow_n[i, j], h_flow_n[i, j]) "Расчет плотности вода/пар в узловых точках";
        w_flow_n[i, j] = D_flow_n[i, j] / rho_flow_n[i, j] / f_flow "Расчет скорости потока вода/пар в узловых точках";
      end for;
      for j in 1:numberOfTubeSections loop
        //Осреднение по конечному объему
        p_flow_v[i, j] = (p_flow_n[i, j + 1] + p_flow_n[i, j]) / 2;
        h_flow_v[i, j] = (h_flow_n[i, j + 1] + h_flow_n[i, j]) / 2;
        D_flow_v[i, j] = (D_flow_n[i, j + 1] + D_flow_n[i, j]) / 2;
        //Уравнение баланса тепла теплоносителя (формула 3-1d диссертации Рубашкина)
        deltaVFlow * rho_flow_v[i, j] * der(h_flow_v[i, j]) = alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) + hod[i] * D_flow_v[i, j] * (h_flow_n[i, j + 1] - h_flow_n[i, j]) "Уравнение баланса тепла теплоносителя для нечетных ходов";
        //Основное уравнение гидравлики
        w_flow_v[i, j] = D_flow_v[i, j] / rho_flow_v[i, j] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        dp_fric[i, j] = -1 * hod[i] * w_flow_v[i, j] ^ 2 * Xi_flow * rho_flow_v[i, j] / 2 / Modelica.Constants.g_n "Потеря давления от трения";
        dp_kin[i, j] = -1 * hod[i] * w_flow_v[i, j] * (w_flow_n[i, j + 1] - w_flow_n[i, j]) * rho_flow_v[i, j] / Modelica.Constants.g_n "Потеря давления из-за приращения кинетической энергии";
        H_flow[i, j + 1] = H_flow[i, j] + deltaHpipe;
        dp_piez[i, j] = -1 * hod[i] * rho_flow_v[i, j] * (H_flow[i, j + 1] - H_flow[i, j]) "Расчет перепада давления из-за изменения пьезометрической высоты";
        p_flow_n[i, j + 1] - p_flow_n[i, j] = dp_fric[i, j] + dp_kin[i, j] + dp_piez[i, j] "Формула 2-1 из книги Рудомино, Ремжин";
        D_flow_n[i, j] - D_flow_n[i, j + 1] = C1[i, j] + C1[i, j] "Уравнение сплошности (формула 3-6 диссертации Рубашкина) drdp_flow[i, j] - абсолютный ноль, смотри уравнения состояния";
        C1[i, j] = deltaVFlow * drdh_flow[i, j] * der(h_flow_v[i, j]);
        C2[i, j] = deltaVFlow * drdp_flow[i, j] * (p_flow_v[i, j] - delay(p_flow_v[i, j], 0.2)) / 0.2;
        deltaMMetal * C_m * der(t_m[i, j]) = heat[i, j].Q_flow - alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
        heat[i, j].T = t_m[i, j];
        //Уравнения состояния
        stateFlow[i, j] = Medium_F.setState_ph(p_flow_v[i, j], h_flow_v[i, j]);
        t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
        rho_flow_v[i, j] = Medium_F.density(stateFlow[i, j]);
        drdp_flow[i, j] = if Medium_F.singleState then 0 else Medium_F.density_derp_h(stateFlow[i, j]);
        drdh_flow[i, j] = Medium_F.density_derh_p(stateFlow[i, j]);
        //Коэффициент теплоотдачи
        k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
        Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
        mu_flow[i, j] = Medium_F.dynamicViscosity(stateFlow[i, j]);
        Re_flow[i, j] = abs(D_flow_v[i, j] * Din / (f_flow * mu_flow[i, j]));
        alfa_flow[i, j] = 0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4;
      end for;
    end for;
    for i in 1:numberOfFlueSections - zahod loop
      //Описание гибов
      if (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) < 0 then
        D_flow_n[i, numberOfTubeSections + 1] = D_flow_n[i + zahod, numberOfTubeSections + 1];
        p_flow_n[i, numberOfTubeSections + 1] = p_flow_n[i + zahod, numberOfTubeSections + 1];
        h_flow_n[i, numberOfTubeSections + 1] = h_flow_n[i + zahod, numberOfTubeSections + 1];
        H_flow[i, numberOfTubeSections + 1] = H_flow[i + zahod, numberOfTubeSections + 1];
        //Для горизонтальных КУ
      else
        D_flow_n[i, 1] = D_flow_n[i + zahod, 1];
        p_flow_n[i, 1] = p_flow_n[i + zahod, 1];
        h_flow_n[i, 1] = h_flow_n[i + zahod, 1];
        H_flow[i, 1] = H_flow[i + zahod, 1];
        //Для горизонтальных КУ
      end if;
    end for;
    //Граничные условия
    //Граничные условия для высотной отметки входного коллектора
    for i in 1:zahod loop
      H_flow[i, 1] = 0 "Задание высотной отметки входного коллектора";
    end for;
    for i in 2:zahod loop
      D_flow_n[i - 1, 1] = D_flow_n[i, 1];
    end for;
    waterIn.m_flow = sum(D_flow_n[i, 1] for i in 1:zahod);
    0 = waterOut.m_flow + sum(D_flow_n[i, numberOfTubeSections + 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections);
    if waterIn.m_flow > 0 then
      for i in numberOfFlueSections - zahod + 1:numberOfFlueSections loop
        if (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) < 0 then
          waterOut.p = p_flow_n[i, numberOfTubeSections + 1];
        else
          waterOut.p = p_flow_n[i, 1];
        end if;
      end for;
      waterIn.p = sum(p_flow_n[i, 1] for i in 1:zahod) / zahod;
    else
      for i in 1:zahod loop
        waterIn.p = p_flow_n[i, 1];
      end for;
      if (-1) ^ (numberOfFlueSections / zahod + (if mod(numberOfFlueSections, zahod) == 0 then 0 else 1 - mod(numberOfFlueSections, zahod) / zahod)) < 0 then
        waterOut.p = sum(p_flow_n[i, numberOfTubeSections + 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections) / zahod;
      else
        waterOut.p = sum(p_flow_n[i, 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections) / zahod;
      end if;
    end if;
    if waterIn.m_flow > 0 then
      for i in 1:zahod loop
        h_flow_n[i, 1] = inStream(waterIn.h_outflow);
      end for;
    else
      for i in numberOfFlueSections - zahod + 1:numberOfFlueSections loop
        if (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) < 0 then
          h_flow_n[i, numberOfTubeSections + 1] = inStream(waterOut.h_outflow);
        else
          h_flow_n[i, 1] = inStream(waterOut.h_outflow);
        end if;
      end for;
    end if;
    if (-1) ^ (numberOfFlueSections / zahod + (if mod(numberOfFlueSections, zahod) == 0 then 0 else 1 - mod(numberOfFlueSections, zahod) / zahod)) < 0 then
      waterOut.h_outflow = sum(array(positiveMax(D_flow_n[i, numberOfTubeSections + 1]) * h_flow_n[i, numberOfTubeSections + 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections)) / sum(array(positiveMax(D_flow_n[i, numberOfTubeSections + 1]) for i in numberOfFlueSections - zahod + 1:numberOfFlueSections));
    else
      waterOut.h_outflow = sum(array(positiveMax(D_flow_n[i, 1]) * h_flow_n[i, 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections)) / sum(array(positiveMax(D_flow_n[i, 1]) for i in numberOfFlueSections - zahod + 1:numberOfFlueSections));
    end if;
    waterIn.h_outflow = sum(array(positiveMax(D_flow_n[i, 1]) * h_flow_n[i, 1] for i in 1:zahod)) / sum(array(positiveMax(D_flow_n[i, 1]) for i in 1:zahod));
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
    parameter Integer numberOfTubeSections = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 2 "Число труб по ходу газов в данной поверхности нагрева";
    parameter Integer zahod = 1 "заходность труб теплообменника";
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

  model onlyFlowHEBoil
    function positiveMax
      extends Modelica.Icons.Function;
      input Real x;
      output Real y;
    algorithm
      y := max(x, 1e-10);
    end positiveMax;

    import MyHRSG.phi_heatedPipe;
    import MyHRSG.lambda_tr;
    //**
    //***Исходные данные для газовой стороны
    //**
    parameter Modelica.SIunits.Power setQ_gas = 100 "тепловой поток со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
    //**
    //***Исходные данные по стороне вода/пар
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    replaceable package Medium_F2 = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
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
    parameter Modelica.SIunits.Length ke = 0.0014 "Абсолютная эквивалентная шероховатость";
    //parameter Real lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2 "Коэффициент трения при движении среды по трубам";
    //parameter Real Xi_flow = lambda_tr * Lpipe / Din / numberOfTubeSections "Коэффициент гидравлического сопротивления участка трубы" annotation(Dialog(group = "Конструктивные характеристики"));
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
    parameter Medium_F.SpecificEnthalpy h_startFlow_v[numberOfFlueSections, numberOfTubeSections] = array(array(h_startTubeFlow[j] for j in 1:numberOfTubeSections) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = array(array(h_startTubeFlow[j] for j in 1:numberOfTubeSections + 1) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(setp_flow, numberOfFlueSections, numberOfTubeSections) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(setp_flow, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(setD_flow / numberOfFlueSections, numberOfFlueSections, numberOfTubeSections) "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(setD_flow / numberOfFlueSections, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startTubeM[numberOfTubeSections] = if numberOfTubeSections == 1 then {(setT_inFlow + setT_outFlow) / 2} else linspace(setT_inFlow, setT_outFlow, numberOfTubeSections) "Начальный вектор температур металла" annotation(Dialog(tab = "Инициализация"));
    parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = array(array(t_startTubeM[j] for j in 1:numberOfTubeSections) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    //Поток вода/пар
    Medium_F.ThermodynamicState stateFlow[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F2.ThermodynamicState stateFlowTwoPhase[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    Medium_F.AbsolutePressure p_flow_v[numberOfFlueSections, numberOfTubeSections](start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.AbsolutePressure p_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
    Medium_F.SpecificEnthalpy h_flow_v[numberOfFlueSections, numberOfTubeSections](start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.SpecificEnthalpy h_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
    Medium_F.Density rho_flow_v[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы в конечных объемах";
    Medium_F.Density rho_flow_n[numberOfFlueSections, numberOfTubeSections + 1] "Плотность потока по участкам трубы в узловых точках";
    Modelica.SIunits.DerDensityByEnthalpy drdh_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow_v[numberOfFlueSections, numberOfTubeSections](start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
    Medium_F.MassFlowRate D_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
    Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    Real C1[numberOfFlueSections, numberOfTubeSections] "Показатель в числителе уравнения сплошности";
    Real C2[numberOfFlueSections, numberOfTubeSections] "Показатель в знаменателе уравнения сплошности";
    Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
    Modelica.SIunits.Length H_flow[numberOfFlueSections, numberOfTubeSections + 1] "Высотная отметка каждого узла";
    Modelica.SIunits.Velocity w_flow_v[numberOfFlueSections, numberOfTubeSections] "Скорость потока вода/пар в конечных объемах";
    Modelica.SIunits.Velocity w_flow_n[numberOfFlueSections, numberOfTubeSections + 1] "Скорость потока вода/пар в узловых точках";
    Real dp_fric[numberOfFlueSections, numberOfTubeSections] "Потеря давления из-за сил трения";
    Real dp_kin[numberOfFlueSections, numberOfTubeSections] "Потеря давления из-за приращения кинетической энергии";
    Real dp_piez[numberOfFlueSections, numberOfTubeSections] "Перепад давления из-за изменения пьезометрической высоты";
    Medium_F2.SaturationProperties sat_v[numberOfFlueSections, numberOfTubeSections] "State vector to compute saturation properties внутри конечного объема";
    Real wrhop[numberOfFlueSections, numberOfTubeSections] "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
    Real phi[numberOfFlueSections, numberOfTubeSections] "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
    Real Xi_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент гидравлического сопротивления участка трубы";
    Real x_v[numberOfFlueSections, numberOfTubeSections] "Степень сухости";
    Medium_F.Density dew_rho_flow_v[numberOfFlueSections, numberOfTubeSections] "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
    Medium_F.Density bubble_rho_flow_v[numberOfFlueSections, numberOfTubeSections] "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
    //**
    //Интерфейс
    //**
    Modelica.Fluid.Interfaces.FluidPort_a waterIn annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = true, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    //*****Уравнения для потока вода/пар и металла
    for i in 1:numberOfFlueSections loop
      hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева";
      //Рачет скорости потока в узловых точках
      for j in 1:numberOfTubeSections + 1 loop
        rho_flow_n[i, j] = Medium_F.density_ph(p_flow_n[i, j], h_flow_n[i, j]) "Расчет плотности вода/пар в узловых точках";
        w_flow_n[i, j] = D_flow_n[i, j] / rho_flow_n[i, j] / f_flow "Расчет скорости потока вода/пар в узловых точках";
      end for;
      for j in 1:numberOfTubeSections loop
        //Осреднение по конечному объему
        p_flow_v[i, j] = (p_flow_n[i, j + 1] + p_flow_n[i, j]) / 2;
        h_flow_v[i, j] = (h_flow_n[i, j + 1] + h_flow_n[i, j]) / 2;
        D_flow_v[i, j] = (D_flow_n[i, j + 1] + D_flow_n[i, j]) / 2;
        //Уравнение баланса тепла теплоносителя (формула 3-1d диссертации Рубашкина)
        deltaVFlow * rho_flow_v[i, j] * der(h_flow_v[i, j]) = alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) + hod[i] * D_flow_v[i, j] * (h_flow_n[i, j + 1] - h_flow_n[i, j]) "Уравнение баланса тепла теплоносителя для нечетных ходов";
        //Основное уравнение гидравлики
        w_flow_v[i, j] = D_flow_v[i, j] / rho_flow_v[i, j] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        wrhop[i, j] = w_flow_v[i, j] * rho_flow_v[i, j] * p_flow_v[i, j] * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
        Xi_flow[i, j] = lambda_tr(Din, ke, Re_flow[i, j]) * Lpipe / Din / numberOfTubeSections;
        phi[i, j] = phi_heatedPipe(wrhop[i, j], p_flow_v[i, j] / 100000, x_v[i, j]) "Расчет коэффициента phi";
        if x_v[i, j] < 1 and x_v[i, j] > 0 then
          dp_fric[i, j] = -1 * hod[i] * w_flow_v[i, j] ^ 2 * Xi_flow[i, j] * rho_flow_v[i, j] / 2 / Modelica.Constants.g_n * (1 + x_v[i, j] * phi[i, j] * (bubble_rho_flow_v[i, j] / dew_rho_flow_v[i, j] - 1)) "Потеря давления от трения";
        else
          dp_fric[i, j] = -1 * hod[i] * w_flow_v[i, j] ^ 2 * Xi_flow[i, j] * rho_flow_v[i, j] / 2 / Modelica.Constants.g_n "Потеря давления от трения";
        end if;
        dp_kin[i, j] = -1 * hod[i] * w_flow_v[i, j] * (w_flow_n[i, j + 1] - w_flow_n[i, j]) * rho_flow_v[i, j] / Modelica.Constants.g_n "Потеря давления из-за приращения кинетической энергии";
        H_flow[i, j + 1] = H_flow[i, j] + deltaHpipe;
        dp_piez[i, j] = -1 * hod[i] * rho_flow_v[i, j] * (H_flow[i, j + 1] - H_flow[i, j]) "Расчет перепада давления из-за изменения пьезометрической высоты";
        //p_flow_n[i, j + 1] - p_flow_n[i, j] = dp_fric[i, j] + dp_kin[i, j] + dp_piez[i, j] "Формула 2-1 из книги Рудомино, Ремжин";
        p_flow_n[i, j + 1] - p_flow_n[i, j] = 0 "Упрощение при расчете давления";
        //D_flow_n[i, j] - D_flow_n[i, j + 1] = C1[i, j] + C1[i, j] "Уравнение сплошности (формула 3-6 диссертации Рубашкина) drdp_flow[i, j] - абсолютный ноль, смотри уравнения состояния";
        D_flow_n[i, j] - D_flow_n[i, j + 1] = 0 "Упрощение при расчете расходов";
        C1[i, j] = deltaVFlow * drdh_flow[i, j] * der(h_flow_v[i, j]);
        C2[i, j] = deltaVFlow * drdp_flow[i, j] * (p_flow_v[i, j] - delay(p_flow_v[i, j], 0.2)) / 0.2;
        deltaMMetal * C_m * der(t_m[i, j]) = heat[i, j].Q_flow - alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
        heat[i, j].T = t_m[i, j];
        //Уравнения состояния
        stateFlow[i, j] = Medium_F.setState_ph(p_flow_v[i, j], h_flow_v[i, j]);
        t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
        rho_flow_v[i, j] = Medium_F.density(stateFlow[i, j]);
        drdp_flow[i, j] = if Medium_F.singleState then 0 else Medium_F.density_derp_h(stateFlow[i, j]);
        drdh_flow[i, j] = Medium_F.density_derh_p(stateFlow[i, j]);
        //Коэффициент теплоотдачи
        k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
        Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
        mu_flow[i, j] = Medium_F.dynamicViscosity(stateFlow[i, j]);
        Re_flow[i, j] = abs(D_flow_v[i, j] * Din / (f_flow * mu_flow[i, j]));
        alfa_flow[i, j] = 0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4;
        //Про две фазы
        stateFlowTwoPhase[i, j] = Medium_F2.setState_ph(p_flow_v[i, j], h_flow_v[i, j]);
        sat_v[i, j] = Medium_F2.setSat_T(t_flow[i, j]);
        x_v[i, j] = Medium_F2.vapourQuality(stateFlowTwoPhase[i, j]);
        dew_rho_flow_v[i, j] = Medium_F2.dewDensity(sat_v[i, j]);
        bubble_rho_flow_v[i, j] = Medium_F2.bubbleDensity(sat_v[i, j]);
      end for;
    end for;
    for i in 1:numberOfFlueSections - zahod loop
      //Описание гибов
      if (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) < 0 then
        D_flow_n[i, numberOfTubeSections + 1] = D_flow_n[i + zahod, numberOfTubeSections + 1];
        p_flow_n[i, numberOfTubeSections + 1] = p_flow_n[i + zahod, numberOfTubeSections + 1];
        h_flow_n[i, numberOfTubeSections + 1] = h_flow_n[i + zahod, numberOfTubeSections + 1];
        H_flow[i, numberOfTubeSections + 1] = H_flow[i + zahod, numberOfTubeSections + 1];
        //Для горизонтальных КУ
      else
        D_flow_n[i, 1] = D_flow_n[i + zahod, 1];
        p_flow_n[i, 1] = p_flow_n[i + zahod, 1];
        h_flow_n[i, 1] = h_flow_n[i + zahod, 1];
        H_flow[i, 1] = H_flow[i + zahod, 1];
        //Для горизонтальных КУ
      end if;
    end for;
    //Граничные условия
    //Граничные условия для высотной отметки входного коллектора
    for i in 1:zahod loop
      H_flow[i, 1] = 0 "Задание высотной отметки входного коллектора";
    end for;
    for i in 2:zahod loop
      D_flow_n[i - 1, 1] = D_flow_n[i, 1];
    end for;
    waterIn.m_flow = sum(D_flow_n[i, 1] for i in 1:zahod);
    0 = waterOut.m_flow + sum(D_flow_n[i, numberOfTubeSections + 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections);
    if waterIn.m_flow > 0 then
      for i in numberOfFlueSections - zahod + 1:numberOfFlueSections loop
        if (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) < 0 then
          waterOut.p = p_flow_n[i, numberOfTubeSections + 1];
        else
          waterOut.p = p_flow_n[i, 1];
        end if;
      end for;
      waterIn.p = sum(p_flow_n[i, 1] for i in 1:zahod) / zahod;
    else
      for i in 1:zahod loop
        waterIn.p = p_flow_n[i, 1];
      end for;
      if (-1) ^ (numberOfFlueSections / zahod + (if mod(numberOfFlueSections, zahod) == 0 then 0 else 1 - mod(numberOfFlueSections, zahod) / zahod)) < 0 then
        waterOut.p = sum(p_flow_n[i, numberOfTubeSections + 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections) / zahod;
      else
        waterOut.p = sum(p_flow_n[i, 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections) / zahod;
      end if;
    end if;
    if waterIn.m_flow > 0 then
      for i in 1:zahod loop
        h_flow_n[i, 1] = inStream(waterIn.h_outflow);
      end for;
    else
      for i in numberOfFlueSections - zahod + 1:numberOfFlueSections loop
        if (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) < 0 then
          h_flow_n[i, numberOfTubeSections + 1] = inStream(waterOut.h_outflow);
        else
          h_flow_n[i, 1] = inStream(waterOut.h_outflow);
        end if;
      end for;
    end if;
    if (-1) ^ (numberOfFlueSections / zahod + (if mod(numberOfFlueSections, zahod) == 0 then 0 else 1 - mod(numberOfFlueSections, zahod) / zahod)) < 0 then
      waterOut.h_outflow = sum(array(positiveMax(D_flow_n[i, numberOfTubeSections + 1]) * h_flow_n[i, numberOfTubeSections + 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections)) / sum(array(positiveMax(D_flow_n[i, numberOfTubeSections + 1]) for i in numberOfFlueSections - zahod + 1:numberOfFlueSections));
    else
      waterOut.h_outflow = sum(array(positiveMax(D_flow_n[i, 1]) * h_flow_n[i, 1] for i in numberOfFlueSections - zahod + 1:numberOfFlueSections)) / sum(array(positiveMax(D_flow_n[i, 1]) for i in numberOfFlueSections - zahod + 1:numberOfFlueSections));
    end if;
    waterIn.h_outflow = sum(array(positiveMax(D_flow_n[i, 1]) * h_flow_n[i, 1] for i in 1:zahod)) / sum(array(positiveMax(D_flow_n[i, 1]) for i in 1:zahod));
    annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph</html>"), Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-100, -115}, {100, -145}}, lineColor = {85, 170, 255}, textString = "%name")}), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
  end onlyFlowHEBoil;

  model TestOnlyHEBoil
    import ThermoPower.*;
    //**
    //***Исходные данные для водяной стороны
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Modelica.SIunits.MassFlowRate wflow = 78 "Номинальный массовый расход воды/пар";
    parameter Modelica.SIunits.Pressure pflow = 13e6 "Начальное давление потока вода/пар";
    parameter SI.Temperature Tinflow = 60 + 273.15 "Начальная входная температура потока воды/пар";
    parameter SI.Temperature Toutflow = 290 + 273.15 "Начальная выходная температура потока воды/пар";
    parameter SI.Temperature T2flow = (Tinflow + Toutflow) / 2 "Начальная промежуточная температура потока воды/пар";
    parameter Modelica.SIunits.SpecificEnthalpy hinflow = Medium_F.specificEnthalpy_pT(pflow, Tinflow) "Начальная энтальпия входного потока вода/пар";
    parameter Modelica.SIunits.SpecificEnthalpy houtflow = Medium_F.specificEnthalpy_pT(pflow, Toutflow) "Начальная энтальпия выходного потока вода/пар";
    parameter Modelica.SIunits.SpecificEnthalpy h2flow = Medium_F.specificEnthalpy_pT(pflow, T2flow) "Начальная промежуточная энтальпия потока вода/пар";
    //**
    //***Исходные данные по разбиению
    //**
    parameter Integer numberOfTubeSections = 10 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 10 "Число труб по ходу газов в данной поверхности нагрева";
    parameter Integer zahod = 1 "заходность труб теплообменника";
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
    Modelica.Blocks.Sources.Step flowvalvestep(height = 0, offset = 1, startTime = 10000) annotation(Placement(visible = true, transformation(origin = {4, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    MyHRSG.onlyFlowHEBoil onlyFlowHE1(redeclare package Medium_F = Medium_F, setD_flow = wflow, setp_flow = pflow, setT_inFlow = Tinflow, setT_outFlow = Toutflow, numberOfTubeSections = numberOfTubeSections, z2 = z2, zahod = zahod) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow heatSource[numberOfFlueSections, numberOfTubeSections](Q_flow = 2e8 / numberOfTubeSections / numberOfFlueSections) annotation(Placement(visible = true, transformation(origin = {48, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
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
    annotation(Documentation(info = "<HTML>Испытывается модель испарителя</html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 200000, Tolerance = 1e-06, Interval = 400));
  end TestOnlyHEBoil;

  function phi_heatedPipe "Функция для расчета коэффициента phi к формуле расчета потерь трения при течении двухфазного потока в обогреваемой трубе (оцифровка номограммы 5а из гидравлического расчета котельных агрегатов)"
    extends Modelica.Icons.Function;
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

  function phi_notHeatedPipe "Функция для расчета коэффициента phi к формуле расчета потерь трения при течении двухфазного потока в необогреваемой трубе (оцифровка номограммы 5б из гидравлического расчета котельных агрегатов)"
    extends Modelica.Icons.Function;
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
      phi_less180_up := if x >= 0.929 then (1.1160112 + 2.7703818 * x ^ 2 - 3.7359854 * x ^ 4) / (1 + 16.431491 * x ^ 2 - 27.563562 * x ^ 4 + 10.289915 * x ^ 6) else 1;
      wrhop_down := 300;
      phi_less180_down := if x >= 0.929 then (1.1160112 + 2.7703818 * x ^ 2 - 3.7359854 * x ^ 4) / (1 + 16.431491 * x ^ 2 - 27.563562 * x ^ 4 + 10.289915 * x ^ 6) else 1;
    elseif wrhop < 300 and wrhop >= 260 then
      wrhop_up := 300;
      phi_less180_up := if x >= 0.929 then (1.1160112 + 2.7703818 * x ^ 2 - 3.7359854 * x ^ 4) / (1 + 16.431491 * x ^ 2 - 27.563562 * x ^ 4 + 10.289915 * x ^ 6) else 1;
      wrhop_down := 260;
      phi_less180_down := if x >= 0.108 then (0.89708298 + 4.7982936 * x - 5.5133864 * x ^ 2 - 0.1447869 * x ^ 3) / (1 - 0.34467125 * x + 41.209031 * x ^ 2 - 75.500433 * x ^ 3 + 33.673279 * x ^ 4) else 1;
    elseif wrhop < 260 and wrhop >= 240 then
      wrhop_up := 260;
      phi_less180_up := if x >= 0.108 then (0.89708298 + 4.7982936 * x - 5.5133864 * x ^ 2 - 0.1447869 * x ^ 3) / (1 - 0.34467125 * x + 41.209031 * x ^ 2 - 75.500433 * x ^ 3 + 33.673279 * x ^ 4) else 1;
      wrhop_down := 240;
      phi_less180_down := if x >= 0.115 then (0.97663388 - 9.9736014 * x + 59.557372 * x ^ 2 - 125.45315 * x ^ 3 + 131.23507 * x ^ 4 - 55.657059 * x ^ 5) / (1 - 10.258929 * x + 55.422401 * x ^ 2 - 75.587534 * x ^ 3 + 61.763853 * x ^ 4 - 31.654485 * x ^ 5) else 1;
    elseif wrhop < 240 and wrhop >= 220 then
      wrhop_up := 240;
      phi_less180_up := if x >= 0.115 then (0.97663388 - 9.9736014 * x + 59.557372 * x ^ 2 - 125.45315 * x ^ 3 + 131.23507 * x ^ 4 - 55.657059 * x ^ 5) / (1 - 10.258929 * x + 55.422401 * x ^ 2 - 75.587534 * x ^ 3 + 61.763853 * x ^ 4 - 31.654485 * x ^ 5) else 1;
      wrhop_down := 220;
      phi_less180_down := if x >= 0.132 then ((-10.228577) + 4319.6549 * x ^ 2 + 24312.406 * x ^ 4 + 8579.2181 * x ^ 6 - 28234.741 * x ^ 8) / (1 + 2900.7944 * x ^ 2 + 69269.534 * x ^ 4 - 18788.349 * x ^ 6 - 44408.746 * x ^ 8) else 1;
    elseif wrhop < 220 and wrhop >= 200 then
      wrhop_up := 220;
      phi_less180_up := if x >= 0.132 then ((-10.228577) + 4319.6549 * x ^ 2 + 24312.406 * x ^ 4 + 8579.2181 * x ^ 6 - 28234.741 * x ^ 8) / (1 + 2900.7944 * x ^ 2 + 69269.534 * x ^ 4 - 18788.349 * x ^ 6 - 44408.746 * x ^ 8) else 1;
      wrhop_down := 200;
      phi_less180_down := if x >= 0.156 then (0.66843259 - 2.7713756 * x ^ 0.5 + 4.4386535 * x - 2.2781927 * x ^ 1.5) / (1 - 4.9010314 * x ^ 0.5 + 8.6644624 * x - 4.7063616 * x ^ 1.5) else 1;
    elseif wrhop < 200 and wrhop >= 180 then
      wrhop_up := 200;
      phi_less180_up := if x >= 0.156 then (0.66843259 - 2.7713756 * x ^ 0.5 + 4.4386535 * x - 2.2781927 * x ^ 1.5) / (1 - 4.9010314 * x ^ 0.5 + 8.6644624 * x - 4.7063616 * x ^ 1.5) else 1;
      wrhop_down := 180;
      phi_less180_down := if x >= 0.171 then ((-105.09791) + 1693.3173 * x - 4686.1774 * x ^ 2 + 5625.4262 * x ^ 3 - 2917.844 * x ^ 4 + 528.13081 * x ^ 5) / (1 + 4.3959294 * x + 4334.0874 * x ^ 2 - 13495.12 * x ^ 3 + 15239.466 * x ^ 4 - 5946.089 * x ^ 5) else 1;
    elseif wrhop < 180 and wrhop >= 160 then
      wrhop_up := 180;
      phi_less180_up := if x >= 0.171 then ((-105.09791) + 1693.3173 * x - 4686.1774 * x ^ 2 + 5625.4262 * x ^ 3 - 2917.844 * x ^ 4 + 528.13081 * x ^ 5) / (1 + 4.3959294 * x + 4334.0874 * x ^ 2 - 13495.12 * x ^ 3 + 15239.466 * x ^ 4 - 5946.089 * x ^ 5) else 1;
      wrhop_down := 160;
      phi_less180_down := if x >= 0.191 then (1.3019518 - 5.8689682 * x + 11.073734 * x ^ 2 - 9.6200996 * x ^ 3 + 3.1209569 * x ^ 4) / (1 - 3.1240685 * x + 3.1773507 * x ^ 2 + 1.2499544 * x ^ 3 - 4.3773472 * x ^ 4 + 2.0816853 * x ^ 5) else 1;
    elseif wrhop < 160 and wrhop >= 150 then
      wrhop_up := 160;
      phi_less180_up := if x >= 0.191 then (1.3019518 - 5.8689682 * x + 11.073734 * x ^ 2 - 9.6200996 * x ^ 3 + 3.1209569 * x ^ 4) / (1 - 3.1240685 * x + 3.1773507 * x ^ 2 + 1.2499544 * x ^ 3 - 4.3773472 * x ^ 4 + 2.0816853 * x ^ 5) else 1;
      wrhop_down := 150;
      phi_less180_down := if x >= 0.214 then 1.1679896 - 4.6977502 * x ^ 2 + 26.60315 * x ^ 4 - 112.12267 * x ^ 6 + 371.00488 * x ^ 8 - 891.73597 * x ^ 10 + 1472.4046 * x ^ 12 - 1608.2865 * x ^ 14 + 1103.7726 * x ^ 16 - 428.09003 * x ^ 18 + 70.97972 * x ^ 20 else 1;
    elseif wrhop < 150 and wrhop >= 140 then
      wrhop_up := 150;
      phi_less180_up := if x >= 0.214 then 1.1679896 - 4.6977502 * x ^ 2 + 26.60315 * x ^ 4 - 112.12267 * x ^ 6 + 371.00488 * x ^ 8 - 891.73597 * x ^ 10 + 1472.4046 * x ^ 12 - 1608.2865 * x ^ 14 + 1103.7726 * x ^ 16 - 428.09003 * x ^ 18 + 70.97972 * x ^ 20 else 1;
      wrhop_down := 140;
      phi_less180_down := if x >= 0.237 then 1.1802356 - 4.2276943 * x ^ 2 + 20.300278 * x ^ 4 - 45.089744 * x ^ 6 + 17.620965 * x ^ 8 + 137.10003 * x ^ 10 - 324.4792 * x ^ 12 + 329.13172 * x ^ 14 - 161.31303 * x ^ 16 + 30.776496 * x ^ 18 else 1;
    elseif wrhop < 140 and wrhop >= 130 then
      wrhop_up := 140;
      phi_less180_up := if x >= 0.237 then 1.1802356 - 4.2276943 * x ^ 2 + 20.300278 * x ^ 4 - 45.089744 * x ^ 6 + 17.620965 * x ^ 8 + 137.10003 * x ^ 10 - 324.4792 * x ^ 12 + 329.13172 * x ^ 14 - 161.31303 * x ^ 16 + 30.776496 * x ^ 18 else 1;
      wrhop_down := 130;
      phi_less180_down := if x >= 0.263 then 1.2828416 - 7.046377 * x ^ 2 + 58.757998 * x ^ 4 - 284.95031 * x ^ 6 + 857.02366 * x ^ 8 - 1635.9503 * x ^ 10 + 1978.2262 * x ^ 12 - 1464.9664 * x ^ 14 + 605.8126 * x ^ 16 - 107.18998 * x ^ 18 else 1;
    elseif wrhop < 130 and wrhop >= 125 then
      wrhop_up := 130;
      phi_less180_up := if x >= 0.263 then 1.2828416 - 7.046377 * x ^ 2 + 58.757998 * x ^ 4 - 284.95031 * x ^ 6 + 857.02366 * x ^ 8 - 1635.9503 * x ^ 10 + 1978.2262 * x ^ 12 - 1464.9664 * x ^ 14 + 605.8126 * x ^ 16 - 107.18998 * x ^ 18 else 1;
      wrhop_down := 125;
      phi_less180_down := if x >= 0.282 then 14.944683 - 239.05789 * x + 1811.9863 * x ^ 2 - 7974.3565 * x ^ 3 + 22512.542 * x ^ 4 - 42560.432 * x ^ 5 + 54537.298 * x ^ 6 - 46751.885 * x ^ 7 + 25647.917 * x ^ 8 - 8126.1591 * x ^ 9 + 1128.202 * x ^ 10 else 1;
    elseif wrhop < 125 and wrhop >= 120 then
      wrhop_up := 125;
      phi_less180_up := if x >= 0.282 then 14.944683 - 239.05789 * x + 1811.9863 * x ^ 2 - 7974.3565 * x ^ 3 + 22512.542 * x ^ 4 - 42560.432 * x ^ 5 + 54537.298 * x ^ 6 - 46751.885 * x ^ 7 + 25647.917 * x ^ 8 - 8126.1591 * x ^ 9 + 1128.202 * x ^ 10 else 1;
      wrhop_down := 120;
      phi_less180_down := 1;
    elseif wrhop < 120 and wrhop >= 110 then
      wrhop_up := 120;
      phi_less180_up := 1;
      wrhop_down := 110;
      phi_less180_down := 1.1000165 + 0.00035623019 * x ^ 2 - 0.068572729 * x ^ 4 + 0.92075497 * x ^ 6 - 3.9692 * x ^ 8 + 6.6865532 * x ^ 10 - 5.1926831 * x ^ 12 + 1.5227299 * x ^ 14;
    elseif wrhop < 110 and wrhop >= 100 then
      wrhop_up := 110;
      phi_less180_up := 1.1000165 + 0.00035623019 * x ^ 2 - 0.068572729 * x ^ 4 + 0.92075497 * x ^ 6 - 3.9692 * x ^ 8 + 6.6865532 * x ^ 10 - 5.1926831 * x ^ 12 + 1.5227299 * x ^ 14;
      wrhop_down := 100;
      phi_less180_down := (1.176932 - 7.7893552 * x ^ 2 + 21.118695 * x ^ 4 - 21.656887 * x ^ 6 + 7.5845347 * x ^ 8) / (1 - 6.6156743 * x ^ 2 + 17.919908 * x ^ 4 - 18.359876 * x ^ 6 + 6.4895739 * x ^ 8);
    elseif wrhop < 100 and wrhop >= 90 then
      wrhop_up := 100;
      phi_less180_up := (1.176932 - 7.7893552 * x ^ 2 + 21.118695 * x ^ 4 - 21.656887 * x ^ 6 + 7.5845347 * x ^ 8) / (1 - 6.6156743 * x ^ 2 + 17.919908 * x ^ 4 - 18.359876 * x ^ 6 + 6.4895739 * x ^ 8);
      wrhop_down := 90;
      phi_less180_down := (1.2311741 - 9.5633564 * x ^ 2 + 28.305015 * x ^ 4 - 39.306465 * x ^ 6 + 25.987068 * x ^ 8 - 6.6531902 * x ^ 10) / (1 - 7.7715677 * x ^ 2 + 23.02875 * x ^ 4 - 32.064249 * x ^ 6 + 21.319708 * x ^ 8 - 5.5123967 * x ^ 10);
    elseif wrhop < 90 and wrhop >= 80 then
      wrhop_up := 90;
      phi_less180_up := (1.2311741 - 9.5633564 * x ^ 2 + 28.305015 * x ^ 4 - 39.306465 * x ^ 6 + 25.987068 * x ^ 8 - 6.6531902 * x ^ 10) / (1 - 7.7715677 * x ^ 2 + 23.02875 * x ^ 4 - 32.064249 * x ^ 6 + 21.319708 * x ^ 8 - 5.5123967 * x ^ 10);
      wrhop_down := 80;
      phi_less180_down := (1.300727618 - 7.19037357 * x ^ 0.5 + 15.88632448 * x - 17.5216916 * x ^ 1.5 + 9.64255146 * x ^ 2 - 2.1175309 * x ^ 2.5) / (1 - 5.52752683 * x ^ 0.5 + 12.21139391 * x - 13.4672713 * x ^ 1.5 + 7.410713972 * x ^ 2 - 1.6273023 * x ^ 2.5);
    elseif wrhop < 80 and wrhop >= 70 then
      wrhop_up := 80;
      phi_less180_up := (1.300727618 - 7.19037357 * x ^ 0.5 + 15.88632448 * x - 17.5216916 * x ^ 1.5 + 9.64255146 * x ^ 2 - 2.1175309 * x ^ 2.5) / (1 - 5.52752683 * x ^ 0.5 + 12.21139391 * x - 13.4672713 * x ^ 1.5 + 7.410713972 * x ^ 2 - 1.6273023 * x ^ 2.5);
      wrhop_down := 70;
      phi_less180_down := (1.3511004 + 1.709817 * x - 6.8822576 * x ^ 2 + 3.8771043 * x ^ 3) / (1 + 1.2702537 * x - 5.1206003 * x ^ 2 + 2.9061398 * x ^ 3);
    elseif wrhop < 70 and wrhop >= 60 then
      wrhop_up := 70;
      phi_less180_up := (1.3511004 + 1.709817 * x - 6.8822576 * x ^ 2 + 3.8771043 * x ^ 3) / (1 + 1.2702537 * x - 5.1206003 * x ^ 2 + 2.9061398 * x ^ 3);
      wrhop_down := 60;
      phi_less180_down := 1.3991448 + 0.02911584 * x ^ 2 - 1.181137 * x ^ 4 + 17.50421 * x ^ 6 - 126.72684 * x ^ 8 + 513.32985 * x ^ 10 - 1242.665 * x ^ 12 + 1825.7391 * x ^ 14 - 1590.4492 * x ^ 16 + 752.87429 * x ^ 18 - 148.85355 * x ^ 20;
    elseif wrhop < 60 and wrhop >= 50 then
      wrhop_up := 60;
      phi_less180_up := 1.3991448 + 0.02911584 * x ^ 2 - 1.181137 * x ^ 4 + 17.50421 * x ^ 6 - 126.72684 * x ^ 8 + 513.32985 * x ^ 10 - 1242.665 * x ^ 12 + 1825.7391 * x ^ 14 - 1590.4492 * x ^ 16 + 752.87429 * x ^ 18 - 148.85355 * x ^ 20;
      wrhop_down := 50;
      phi_less180_down := (1.441734 - 6.4053556 * x + 10.566088 * x ^ 2 - 7.6647504 * x ^ 3 + 2.0641227 * x ^ 4) / (1 - 4.4371009 * x + 7.2911442 * x ^ 2 - 5.2248014 * x ^ 3 + 1.3339947 * x ^ 4 + 0.038603441 * x ^ 5);
    elseif wrhop < 50 and wrhop >= 40 then
      wrhop_up := 50;
      phi_less180_up := (1.441734 - 6.4053556 * x + 10.566088 * x ^ 2 - 7.6647504 * x ^ 3 + 2.0641227 * x ^ 4) / (1 - 4.4371009 * x + 7.2911442 * x ^ 2 - 5.2248014 * x ^ 3 + 1.3339947 * x ^ 4 + 0.038603441 * x ^ 5);
      wrhop_down := 40;
      phi_less180_down := (1.4795265 - 7.1692594 * x ^ 2 + 12.697645 * x ^ 4 - 9.6627311 * x ^ 6 + 2.6719018 * x ^ 8) / (1 - 4.8441344 * x ^ 2 + 8.5640741 * x ^ 4 - 6.4576876 * x ^ 6 + 1.6869312 * x ^ 8 + 0.067906062 * x ^ 10);
    elseif wrhop < 40 and wrhop >= 30 then
      wrhop_up := 40;
      phi_less180_up := (1.4795265 - 7.1692594 * x ^ 2 + 12.697645 * x ^ 4 - 9.6627311 * x ^ 6 + 2.6719018 * x ^ 8) / (1 - 4.8441344 * x ^ 2 + 8.5640741 * x ^ 4 - 6.4576876 * x ^ 6 + 1.6869312 * x ^ 8 + 0.067906062 * x ^ 10);
      wrhop_down := 30;
      phi_less180_down := (1.5002909 - 8.7863495 * x ^ 2 + 20.649298 * x ^ 4 - 24.343014 * x ^ 6 + 14.39313 * x ^ 8 - 3.4128172 * x ^ 10) / (1 - 5.853886 * x ^ 2 + 13.74732 * x ^ 4 - 16.187379 * x ^ 6 + 9.5541865 * x ^ 8 - 2.2597026 * x ^ 10);
    elseif wrhop < 30 then
      wrhop_up := 30;
      phi_less180_up := (1.5002909 - 8.7863495 * x ^ 2 + 20.649298 * x ^ 4 - 24.343014 * x ^ 6 + 14.39313 * x ^ 8 - 3.4128172 * x ^ 10) / (1 - 5.853886 * x ^ 2 + 13.74732 * x ^ 4 - 16.187379 * x ^ 6 + 9.5541865 * x ^ 8 - 2.2597026 * x ^ 10);
      wrhop_down := 20;
      phi_less180_down := (1.5002909 - 8.7863495 * x ^ 2 + 20.649298 * x ^ 4 - 24.343014 * x ^ 6 + 14.39313 * x ^ 8 - 3.4128172 * x ^ 10) / (1 - 5.853886 * x ^ 2 + 13.74732 * x ^ 4 - 16.187379 * x ^ 6 + 9.5541865 * x ^ 8 - 2.2597026 * x ^ 10);
    end if;
    phi_less180 := phi_less180_down + (wrhop - wrhop_down) * (phi_less180_up - phi_less180_down) / (wrhop_up - wrhop_down) "Расчет phi для давления меньше 180 кгс/см2";
    //Оцифровка правой части (Р > 180) диаграммы 5б (Нормативный метод гидравлического расчета котельных агрегатов (1978))
    if p < 180 then
      p_up := 180;
      phi_up := phi_less180;
      p_down := 170;
      phi_down := phi_less180;
    elseif p >= 180 and p < 190 then
      p_up := 190;
      phi_up := ((-0.38727116) + 3.7172002 * phi_less180 ^ 2 - 5.7810724 * phi_less180 ^ 4 + 2.6277926 * phi_less180 ^ 6 - 0.0074910401 * phi_less180 ^ 8) / (1 + 0.35659014 * phi_less180 ^ 2 - 3.7227101 * phi_less180 ^ 4 + 3.2206161 * phi_less180 ^ 6 - 0.77120666 * phi_less180 ^ 8 + 0.085440751 * phi_less180 ^ 10);
      p_down := 180;
      phi_down := 1.6683 * phi_less180 - 0.6669;
    elseif p >= 190 and p < 200 then
      p_up := 200;
      phi_up := ((-0.56499308) + 3.8637496 * phi_less180 - 9.170028 * phi_less180 ^ 2 + 10.20122 * phi_less180 ^ 3 - 5.4998541 * phi_less180 ^ 4 + 1.1716854 * phi_less180 ^ 5) / (1 - 3.237545 * phi_less180 + 3.8132513 * phi_less180 ^ 2 - 1.771051 * phi_less180 ^ 3 + 0.076441418 * phi_less180 ^ 4 + 0.12067979 * phi_less180 ^ 5);
      p_down := 190;
      phi_down := ((-0.38727116) + 3.7172002 * phi_less180 ^ 2 - 5.7810724 * phi_less180 ^ 4 + 2.6277926 * phi_less180 ^ 6 - 0.0074910401 * phi_less180 ^ 8) / (1 + 0.35659014 * phi_less180 ^ 2 - 3.7227101 * phi_less180 ^ 4 + 3.2206161 * phi_less180 ^ 6 - 0.77120666 * phi_less180 ^ 8 + 0.085440751 * phi_less180 ^ 10);
    elseif p >= 200 and p < 210 then
      p_up := 210;
      phi_up := ((-0.23022792) + 1.8670365 * phi_less180 - 2.7284609 * phi_less180 ^ 2 + 1.1370724 * phi_less180 ^ 3 + 0.030002178 * phi_less180 ^ 4) / (1 - 2.3906129 * phi_less180 + 3.3062657 * phi_less180 ^ 2 - 3.4844912 * phi_less180 ^ 3 + 2.0905602 * phi_less180 ^ 4 - 0.44638264 * phi_less180 ^ 5);
      p_down := 200;
      phi_down := ((-0.56499308) + 3.8637496 * phi_less180 - 9.170028 * phi_less180 ^ 2 + 10.20122 * phi_less180 ^ 3 - 5.4998541 * phi_less180 ^ 4 + 1.1716854 * phi_less180 ^ 5) / (1 - 3.237545 * phi_less180 + 3.8132513 * phi_less180 ^ 2 - 1.771051 * phi_less180 ^ 3 + 0.076441418 * phi_less180 ^ 4 + 0.12067979 * phi_less180 ^ 5);
    elseif p >= 210 and p < 220 then
      p_up := 220;
      phi_up := 268.19561 - 2496.4334 * phi_less180 ^ 0.5 + 9729.2434 * phi_less180 - 19838.828 * phi_less180 ^ 1.5 + 19977.25 * phi_less180 ^ 2 - 977.21967 * phi_less180 ^ 2.5 - 23104.339 * phi_less180 ^ 3 + 29777.716 * phi_less180 ^ 3.5 - 18552.804 * phi_less180 ^ 4 + 6045.8435 * phi_less180 ^ 4.5 - 827.62478 * phi_less180 ^ 5;
      p_down := 210;
      phi_down := ((-0.23022792) + 1.8670365 * phi_less180 - 2.7284609 * phi_less180 ^ 2 + 1.1370724 * phi_less180 ^ 3 + 0.030002178 * phi_less180 ^ 4) / (1 - 2.3906129 * phi_less180 + 3.3062657 * phi_less180 ^ 2 - 3.4844912 * phi_less180 ^ 3 + 2.0905602 * phi_less180 ^ 4 - 0.44638264 * phi_less180 ^ 5);
    elseif p >= 220 and p < 225 then
      p_up := 225;
      phi_up := 1;
      p_down := 220;
      phi_down := 268.19561 - 2496.4334 * phi_less180 ^ 0.5 + 9729.2434 * phi_less180 - 19838.828 * phi_less180 ^ 1.5 + 19977.25 * phi_less180 ^ 2 - 977.21967 * phi_less180 ^ 2.5 - 23104.339 * phi_less180 ^ 3 + 29777.716 * phi_less180 ^ 3.5 - 18552.804 * phi_less180 ^ 4 + 6045.8435 * phi_less180 ^ 4.5 - 827.62478 * phi_less180 ^ 5;
    elseif p >= 225 then
      p_up := 230;
      phi_up := 1;
      p_down := 225;
      phi_down := 1;
    end if;
    phi := phi_down + (wrhop - wrhop_down) * (phi_up - phi_down) / (wrhop_up - wrhop_down) "Расчет phi для давления больше 180 кгс/см2 (итоговое phi)";
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end phi_notHeatedPipe;

  function lambda_tr "Функция для расчета коэффициента трения (лямбда)"
    extends Modelica.Icons.Function;

    function lambda_tr_per "Функция для расчета коэффициента трения (лямбда) в переходной зоне"
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
      Re_II := (120 * dn / ke) ^ 1.125;
      lambda_tr_I := lambda_tr_lessReI(Re_I);
      lambda_tr_II := lambda_tr_moreReII(dn, ke);
      lambda_tr := lambda_tr_I + (Re - Re_I) * (lambda_tr_II - lambda_tr_I) / (Re_II - Re_I);
    end lambda_tr_per;

    function lambda_tr_lessReI "Функция для расчета коэффициента трения при Re меньше Re_I"
      input Real Re "Число Рейнольдса";
      output Real lambda_tr;
    algorithm
      lambda_tr := 64 / Re;
    end lambda_tr_lessReI;

    function lambda_tr_moreReII "Функция для расчета коэффициента трения при Re больше Re_II"
      input Modelica.SIunits.Length dn "расчетный внутренний диаметр трубы";
      input Modelica.SIunits.Length ke "абсолютная эквивалентная шероховатость";
      output Real lambda_tr;
    algorithm
      lambda_tr := 1 / (1.14 + 2 * log10(dn / ke)) ^ 2;
    end lambda_tr_moreReII;

    input Modelica.SIunits.Length dn "расчетный внутренний диаметр трубы";
    input Modelica.SIunits.Length ke "абсолютная эквивалентная шероховатость";
    input Real Re "Число Рейнольдса";
    output Real lambda_tr;
  protected
    Real Re_I "Нижняя граница переходной области (по числу Рейнольдса)";
    Real Re_II "Верхняя граница переходной области (по числу Рейнольдса)";
  algorithm
    Re_I := 2300;
    Re_II := (120 * dn / ke) ^ 1.125;
    if Re < Re_I then
      lambda_tr := lambda_tr_lessReI(Re);
    elseif Re > Re_II then
      lambda_tr := lambda_tr_moreReII(dn, ke);
    else
      lambda_tr := lambda_tr_per(dn, ke, Re);
    end if;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end lambda_tr;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end MyHRSG;