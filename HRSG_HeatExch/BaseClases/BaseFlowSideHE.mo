within TPPSim.HRSG_HeatExch.BaseClases;
partial model BaseFlowSideHE
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconFlowSideHE;
  final outer parameter Medium.MassFlowRate m_flow_small "Минимальный расход";
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
  constant Medium.AbsolutePressure pc = Medium.fluidConstants[1].criticalPressure;
  constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
  //Характеристики металла
  final outer parameter Modelica.SIunits.SpecificHeatCapacity C_m "Удельная теплоемкость металла";
  final outer parameter Modelica.SIunits.ThermalConductivity lambda_m "Теплопроводность метала";
  //Конструктивные характеристики
  final outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр трубок теплообменника";
  final outer parameter Modelica.SIunits.Length deltaLpipe "Длина теплообменной трубки";
  final outer parameter Modelica.SIunits.Length ke "Абсолютная эквивалентная шероховатость";
  //Поток вода/пар
  final outer parameter Modelica.SIunits.Area deltaSFlow "Внутренняя площадь одного участка ряда труб";
  final outer parameter Modelica.SIunits.Volume deltaVFlow "Внутренний объем одного участка ряда труб";
  final outer parameter Modelica.SIunits.Mass deltaMMetal "Масса металла участка ряда труб";
  final outer parameter Modelica.SIunits.Area f_flow "Площадь для прохода теплоносителя";
  parameter Boolean DynamicMomentum "Использовать или нет уравнение сохранения момента";
  parameter Boolean DynamicMassBalance "Использовать или нет уравнение сохранение массы с производными";
  parameter Boolean DynamicEnergyBalance "Использовать или нет уравнение сохранения энергии с производными";
  parameter Boolean DynamicTm "Использовать или нет производную по температуре металла";
  //Переменные
  Medium.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
  //Medium.Temperature t_flow "Температура потока вода/пар по участкам трубы";
  Medium.AbsolutePressure p_v "Давление потока вода/пар по участкам трубы в конечных объемах";
  //Medium.AbsolutePressure p_n[2] "Давление потока вода/пар по участкам трубы в узловых точках";
  Medium.SpecificEnthalpy h_v "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
  Medium.SpecificEnthalpy h_n[2] "Энтальпия потока вода/пар по участкам трубы в узловых точках";
  //Medium.Density rho_v "Плотность потока по участкам трубы в конечных объемах";
  Medium.MassFlowRate D_flow_v "Массовый расход потока вода/пар по участкам ряда труб";
  Medium.MassFlowRate D_flow_in "Массовый расход потока вода/пар по участкам ряда труб";
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
  Modelica.SIunits.HeatFlowRate Q_flow "тепло переданное стенке трубы";
  Modelica.SIunits.Temperature t_m "Температура металла на участках трубопровода";
  Modelica.SIunits.Velocity w_flow_v "Скорость потока вода/пар в конечных объемах";
  Real dp_fric "Потеря давления из-за сил трения";
  Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
  Real lambda_tr "Коэффициент трения";
  //Интерфейс
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {99, 60}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
//Граничные условия
  D_flow_in = max(waterIn.m_flow, m_flow_small);
//waterOut.m_flow = -D_flow_n[2];
//waterOut.p = p_n[2];
//waterIn.p = p_n[1];
  h_n[1] = inStream(waterIn.h_outflow);
  waterOut.h_outflow = h_n[2];
  waterIn.h_outflow = inStream(waterOut.h_outflow);
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end BaseFlowSideHE;
