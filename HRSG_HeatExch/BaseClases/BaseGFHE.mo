within TPPSim.HRSG_HeatExch.BaseClases;
partial model BaseGFHE
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconHE;
  import Modelica.Fluid.Types;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  //Геометрия пучка
  parameter TPPSim.Choices.HRSG_type HRSG_type_set = Choices.HRSG_type.horizontalBottom "Геометрия пучка (горизонтальный/вертикальный)" annotation(
    Dialog(group = "Геометрия пучка"));
  parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг" annotation(
    Dialog(group = "Геометрия пучка"));
  parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг" annotation(
    Dialog(group = "Геометрия пучка"));
  parameter Integer zahod = 1 "Заходность труб теплообменника" annotation(
    Dialog(group = "Геометрия пучка"));
  parameter Integer z1 = 126 "Число труб по ширине газохода" annotation(
    Dialog(group = "Геометрия пучка"));
  parameter Integer z2 = 4 "Число труб по ходу газов в теплообменнике" annotation(
    Dialog(group = "Геометрия пучка"));
  parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки" annotation(
    Dialog(group = "Геометрия пучка"));
  //Конструктивные характеристики труб
  inner parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(
    Dialog(group = "Конструктивные характеристики труб"));
  inner parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(
    Dialog(group = "Конструктивные характеристики труб"));
  inner parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость" annotation(
    Dialog(group = "Конструктивные характеристики труб"));
  //Характеристики оребрения
  parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м" annotation(
    Dialog(group = "Характеристики оребрения"));
  parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м" annotation(
    Dialog(group = "Характеристики оребрения"));
  parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м" annotation(
    Dialog(group = "Характеристики оребрения"));
  //Характеристики металла
  inner parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
    Dialog(group = "Характеристики металла"));
  inner parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(
    Dialog(group = "Характеристики металла"));  
  parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
    Dialog(group = "Характеристики металла"));
  //Поправки
  inner parameter Real k_gamma_gas = 1 "Поправка к коэффициенту теплоотдачи со стороны газов" annotation(
    Dialog(group = "Поправки"));
  //Параметры уравнений динамики
  inner parameter Types.Dynamics flowEnergyDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения энергии вода/пар" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  inner parameter Types.Dynamics flowMassDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения массы вода/пар" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  inner parameter Modelica.Fluid.Types.Dynamics flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState "Параметры уравнения сохранения момента вода/пар" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  inner parameter Types.Dynamics metalDynamics = Types.Dynamics.FixedInitial "Параметры уравнения динамики прогрева металла" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics")); 
  inner parameter Types.Dynamics gasEnergyDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения энергии газов" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  inner parameter Types.Dynamics gasMassDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения массы газов" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));  
  //Расчетные конструктивные параметры
  final parameter Modelica.SIunits.Length omega = Modelica.Constants.pi * (Din + 2 * delta) "Наружный периметр трубы";
  final parameter Modelica.SIunits.Length Dfin = Din + 2 * delta + 2 * hfin "Диаметр ребер, м";
  final parameter Real psi_fin = 1 / (2 * (Din + 2 * delta) * sfin) * (Dfin ^ 2 - (Din + 2 * delta) ^ 2 + 2 * Dfin * delta_fin) + 1 - delta_fin / sfin "Коэффициент оребрения, равный отношению полной поверхности пучка к поверхности несущих труб на оребренном участке";
  //формула 7.22а нормативного метода
  final parameter Real sigma1 = s1 / (Din + 2 * delta) "Относительный поперечный шаг";
  final parameter Real sigma2 = s2 / (Din + 2 * delta) "Относительный продольный шаг";
  final parameter Real sigma3 = sqrt(0.25 * sigma1 ^ 2 + sigma2) "Средний относительный диагональный шаг труб";
  final parameter Real xfin = sigma1 / sigma2 - 1.26 / psi_fin - 2 "Параметр 'x' для шахматного пучка";
  final parameter Real phi_fin = Modelica.Math.tanh(xfin) "Некий параметр 'фи'";
  final inner parameter Real n_fin = 0.7 + 0.08 * phi_fin + 0.005 * psi_fin "Показатель степени 'n' в формуле коэффициента теплоотдачи";
  final inner parameter Real Cs = (1.36 - phi_fin) * (11 / (psi_fin + 8) - 0.14) "Коэффициент, определяемый в зависимости от от относительного поперечного и продольного шага труб в пучке, типа пучка и коэффициента оребрения";
  final inner parameter Real Cz = if z2 < 8 and sigma1 / sigma2 < 2 then 3.15 * z2 ^ 0.05 - 2.5 elseif z2 < 8 and sigma1 / sigma2 >= 2 then 3.5 * z2 ^ 0.03 - 2.72 else 1 "Поправка на число рядов труб по ходу газов";
  final inner parameter Real Kaer = (Din + 2 * delta) ^ 0.611 * z2 / s1 ^ 0.412 / s2 ^ 0.515 "Коэффициент для расчета аэродинамического сопротивления";
  //Начальные значения
  inner parameter Modelica.SIunits.SpecificEnthalpy h_flow_start = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(system.p_start) "Начальная энтальпия вода/пар" annotation(Dialog(tab = "Initialization"));    
  inner parameter Modelica.SIunits.AbsolutePressure p_flow_start = system.p_start "Начальное давление вода/пар" annotation(Dialog(tab = "Initialization"));
  inner parameter Modelica.SIunits.MassFlowRate m_flow_start = system.m_flow_start "Начальный массовый расход вода/пар" annotation(Dialog(tab = "Initialization"));
  inner parameter Modelica.SIunits.Temperature T_m_start = system.T_start "Начальная температура металла вода/пар" annotation(Dialog(tab = "Initialization"));
  inner parameter Modelica.SIunits.Temperature T_gas_start = system.T_start "Начальная температура газов" annotation(Dialog(tab = "Initialization"));  
  inner parameter Modelica.SIunits.AbsolutePressure p_gas_start = system.p_start "Начальное давление газов" annotation(Dialog(tab = "Initialization"));    
  //Интерфейс
  outer Modelica.Fluid.System system;  
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    version = "",
    uses,
    Icon(coordinateSystem(extent = {{-50, -100}, {50, 100}})),
    Diagram(coordinateSystem(extent = {{-50, -100}, {50, 100}})),
    __OpenModelica_commandLineOptions = "");
end BaseGFHE;
