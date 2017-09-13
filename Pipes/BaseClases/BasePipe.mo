within TPPSim.Pipes.BaseClases;
partial model BasePipe
  extends TPPSim.Pipes.BaseClases.Icons.IconPipe;
  //parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
  replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  //parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(
    //Dialog(group = "Параметры стороны вода/пар"));
  //parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(
    //Dialog(group = "Параметры стороны вода/пар"));
  //parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(
    //Dialog(group = "Параметры стороны вода/пар"));
  //parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(
    //Dialog(group = "Параметры стороны вода/пар"));
  //parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(
    //Dialog(group = "Параметры стороны вода/пар"));
  //parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
  //parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
  //parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
  //Характеристики металла
  parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
    Dialog(group = "Металл"));
  parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
    Dialog(group = "Металл"));
  //parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
  //Конструктивные характеристики
  parameter Modelica.SIunits.Diameter Din = 0.3 "Внутренний диаметр трубопровода" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Length delta = 0.01 "Толщина стенки трубопровода" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Length Lpipe = 25 "Длина теплообменной трубки" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
  //Поток вода/пар
  final parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din "Внутренняя площадь одного участка ряда труб";
  final parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 / 4 "Внутренний объем одного участка ряда труб";
  final parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) / 4 "Масса металла участка ряда труб";
  final parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 / 4 "Площадь для прохода теплоносителя";
  //Начальные значения
  //parameter Medium_F.SpecificEnthalpy h_startFlow_n[2] = fill(seth_in, 2) "Начальный вектор энальпии потока газов" annotation(
    //Dialog(tab = "Инициализация"));
  //parameter Medium_F.SpecificEnthalpy h_startFlow_v = seth_in "Начальный вектор энальпии потока газов" annotation(
    //Dialog(tab = "Инициализация"));
  //parameter Medium_F.AbsolutePressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(
    //Dialog(tab = "Инициализация"));
  //parameter Medium_F.AbsolutePressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(
    //Dialog(tab = "Инициализация"));
  //parameter Medium_F.MassFlowRate D_startFlow_v = setD_flow "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(
    //Dialog(tab = "Инициализация"));
  //parameter Medium_F.MassFlowRate D_startFlow_n[2] = fill(setD_flow, 2) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(
    //Dialog(tab = "Инициализация"));
  //Металл
  //parameter Modelica.SIunits.Temperature t_startM = setTm "Начальный вектор энальпии потока газов" annotation(
    //Dialog(tab = "Инициализация"));
  parameter Boolean DynamicMomentum = false "Использовать или нет уравнение сохранения момента";
  //Переменные
  Medium_F.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
  Medium_F.Temperature t_flow "Температура потока вода/пар по участкам трубы";
  Medium_F.AbsolutePressure p_v(start = system.p_start) "Давление потока вода/пар по участкам трубы в конечных объемах";
  Medium_F.AbsolutePressure p_n[2] "Давление потока вода/пар по участкам трубы в узловых точках";
  Medium_F.SpecificEnthalpy h_v "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
  Medium_F.SpecificEnthalpy h_n[2] "Энтальпия потока вода/пар по участкам трубы в узловых точках";
  Medium_F.Density rho_v "Плотность потока по участкам трубы в конечных объемах";
  Medium_F.MassFlowRate D_flow_v(start = 0) "Массовый расход потока вода/пар по участкам ряда труб";
  Medium_F.MassFlowRate D_flow_n[2] "Массовый расход потока вода/пар по участкам ряда труб";
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
  Modelica.SIunits.Temperature t_m "Температура металла на участках трубопровода";
  Modelica.SIunits.Velocity w_flow_v "Скорость потока вода/пар в конечных объемах";
  Real dp_fric "Потеря давления из-за сил трения";
  Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
  Real lambda_tr "Коэффициент трения";
  //Интерфейс
  outer Modelica.Fluid.System system;
  Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {121, 0}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
//Граничные условия
  //D_flow_n[1] = max(waterIn.m_flow, system.m_flow_small);
  D_flow_n[1] = waterIn.m_flow;  
  waterOut.m_flow = -D_flow_n[2];
  waterOut.p = p_n[2];
  waterIn.p = p_n[1];
  h_n[1] = inStream(waterIn.h_outflow);
  waterOut.h_outflow = h_n[2];
  waterIn.h_outflow = h_n[1];
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end BasePipe;
