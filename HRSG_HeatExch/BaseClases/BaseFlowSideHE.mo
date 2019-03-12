within TPPSim.HRSG_HeatExch.BaseClases;
partial model BaseFlowSideHE
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconFlowSideHE;
  import Modelica.Fluid.Types;
  replaceable package Medium = Modelica.Media.Water.StandardWater;
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
  parameter Integer[2] section "Координаты участка";
  parameter Modelica.SIunits.Length deltaHpipe = 0 "Разность высот на участке ряда труб";
  //Параметры уравнений динамики
  outer parameter Types.Dynamics flowEnergyDynamics "Параметры уравнения сохранения энергии вода/пар" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  outer parameter Types.Dynamics flowMassDynamics "Параметры уравнения сохранения массы вода/пар" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  outer parameter Modelica.Fluid.Types.Dynamics flowMomentumDynamics "Параметры уравнения сохранения момента вода/пар" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  outer parameter Types.Dynamics metalDynamics "Параметры уравнения динамики прогрева металла" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  //Начальные значения
  outer parameter Modelica.SIunits.SpecificEnthalpy h_flow_start "Начальная энтальпия вода/пар" annotation(Dialog(tab = "Initialization"));    
  outer parameter Modelica.SIunits.AbsolutePressure p_flow_start "Начальное давление вода/пар" annotation(Dialog(tab = "Initialization"));
  outer parameter Modelica.SIunits.MassFlowRate m_flow_start "Начальный массовый расход вода/пар" annotation(Dialog(tab = "Initialization"));
  outer parameter Modelica.SIunits.Temperature T_m_start = system.T_start "Начальная температура металла вода/пар" annotation(Dialog(tab = "Initialization"));   
  //Переменные
  outer Medium.SpecificEnthalpy h_gl "Энтальпия (глобальная переменная)";
  outer Medium.MassFlowRate D_gl "Массовый расход (глобальная переменная)";
  outer Medium.AbsolutePressure p_gl "Давление (глобальная переменная)";
  inner Medium.ThermodynamicState stateFlow(p(start = system.p_start)) "Термодинамическое состояние потока вода/пар на участках трубопровода";
  inner Medium.MassFlowRate D_flow_v(start = 0) "Массовый расход потока вода/пар по участкам ряда труб";
  inner Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
  Modelica.SIunits.HeatFlowRate Q_flow "тепло переданное стенке трубы";
  Modelica.SIunits.Temperature t_m "Температура металла на участках трубопровода";
  Modelica.SIunits.Velocity w_flow_v "Скорость потока вода/пар в конечных объемах";
  Real dp_fric "Потеря давления из-за сил трения";
  Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
  Real lambda_tr "Коэффициент трения";
  //Интерфейс
  outer Modelica.Fluid.System system;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  replaceable TPPSim.thermal.alfaForEVO alpha;
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end BaseFlowSideHE;
