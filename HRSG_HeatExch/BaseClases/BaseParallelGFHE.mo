within TPPSim.HRSG_HeatExch.BaseClases;
partial model BaseParallelGFHE
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconParallelHE;
  import Modelica.Fluid.Types;
  //Настройки первого теплообменника
  //Геометрия пучка
  parameter TPPSim.Choices.HRSG_type HRSG_type_set_1 = Choices.HRSG_type.horizontalBottom "Геометрия пучка (горизонтальный/вертикальный)" annotation(
    Dialog(tab = "1-st HE", group = "Геометрия пучка"));
  parameter Modelica.SIunits.Length s1_1 = 82e-3 "Поперечный шаг" annotation(
    Dialog(tab = "1-st HE", group = "Геометрия пучка"));
  parameter Modelica.SIunits.Length s2_1 = 110e-3 "Продольный шаг" annotation(
    Dialog(tab = "1-st HE", group = "Геометрия пучка"));
  parameter Integer zahod_1 = 1 "Заходность труб теплообменника" annotation(
    Dialog(tab = "1-st HE", group = "Геометрия пучка"));
  parameter Integer z1_1 = 126 "Число труб по ширине газохода" annotation(
    Dialog(tab = "1-st HE", group = "Геометрия пучка"));
  parameter Integer z2_1 = 4 "Число труб по ходу газов в теплообменнике" annotation(
    Dialog(tab = "1-st HE", group = "Геометрия пучка"));
  parameter Modelica.SIunits.Length Lpipe_1 = 20.85 "Длина теплообменной трубки" annotation(
    Dialog(tab = "1-st HE", group = "Геометрия пучка"));
  //Конструктивные характеристики труб
  parameter Modelica.SIunits.Diameter Din_1 = 0.038 "Внутренний диаметр трубок теплообменника" annotation(
    Dialog(tab = "1-st HE", group = "Конструктивные характеристики труб"));
  parameter Modelica.SIunits.Length delta_1 = 0.003 "Толщина стенки трубки теплообменника" annotation(
    Dialog(tab = "1-st HE", group = "Конструктивные характеристики труб"));
  parameter Modelica.SIunits.Length ke_1 = 0.00014 "Абсолютная эквивалентная шероховатость" annotation(
    Dialog(tab = "1-st HE", group = "Конструктивные характеристики труб"));
  //Характеристики оребрения
  parameter Modelica.SIunits.Length delta_fin_1 = 0.0008 "Средняя толщина ребра, м" annotation(
    Dialog(tab = "1-st HE", group = "Характеристики оребрения"));
  parameter Modelica.SIunits.Length hfin_1 = 0.017 "Высота ребра, м" annotation(
    Dialog(tab = "1-st HE", group = "Характеристики оребрения"));
  parameter Modelica.SIunits.Length sfin_1 = 0.00404 "Шаг ребер, м" annotation(
    Dialog(tab = "1-st HE", group = "Характеристики оребрения"));
  //Характеристики металла
  parameter Modelica.SIunits.SpecificHeatCapacity C_m_1 = 578.05 "Удельная теплоемкость металла" annotation(
    Dialog(tab = "1-st HE", group = "Характеристики металла"));
  parameter Modelica.SIunits.ThermalConductivity lambda_m_1 = 20 "Теплопроводность метала" annotation(
    Dialog(tab = "1-st HE", group = "Характеристики металла"));  
  parameter Modelica.SIunits.Density rho_m_1 = 7800 "Плотность металла" annotation(
    Dialog(tab = "1-st HE", group = "Характеристики металла"));
  //Поправки
  parameter Real k_gamma_gas_1 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов" annotation(
    Dialog(tab = "1-st HE", group = "Поправки"));
  parameter Real k_weight_metal_1 = 1 "Поправка к массе металла поверхности нагрева"  annotation(
    Dialog(tab = "1-st HE", group = "Поправки"));
  parameter Real k_volume_1 = 1 "Поправка к внутреннему объему трубок поверхности нагрева"  annotation(
    Dialog(tab = "1-st HE", group = "Поправки"));
  parameter Real k_volume_gas_1 = 1 "Поправка к объему газов поверхности нагрева"  annotation(
    Dialog(tab = "1-st HE", group = "Поправки"));  
  //Параметры уравнений динамики
  parameter Types.Dynamics flowEnergyDynamics_1 = Types.Dynamics.FixedInitial "Параметры уравнения сохранения энергии вода/пар" annotation(
  Evaluate=true, Dialog(tab = "Assumptions 1-st HE", group="Dynamics"));
  parameter Types.Dynamics flowMassDynamics_1 = Types.Dynamics.FixedInitial "Параметры уравнения сохранения массы вода/пар" annotation(
  Evaluate=true, Dialog(tab = "Assumptions 1-st HE", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics flowMomentumDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyState "Параметры уравнения сохранения момента вода/пар" annotation(
  Evaluate=true, Dialog(tab = "Assumptions 1-st HE", group="Dynamics"));
  parameter Types.Dynamics metalDynamics_1 = Types.Dynamics.FixedInitial "Параметры уравнения динамики прогрева металла" annotation(
  Evaluate=true, Dialog(tab = "Assumptions 1-st HE", group="Dynamics")); 
  parameter Types.Dynamics gasEnergyDynamics_1 = Types.Dynamics.FixedInitial "Параметры уравнения сохранения энергии газов" annotation(
  Evaluate=true, Dialog(tab = "Assumptions 1-st HE", group="Dynamics"));
  parameter Types.Dynamics gasMassDynamics_1 = Types.Dynamics.FixedInitial "Параметры уравнения сохранения массы газов" annotation(
  Evaluate=true, Dialog(tab = "Assumptions 1-st HE", group="Dynamics"));  
  //Расчетные конструктивные параметры
  final parameter Modelica.SIunits.Length omega_1 = Modelica.Constants.pi * (Din_1 + 2 * delta_1) "Наружный периметр трубы";
  final parameter Modelica.SIunits.Length Dfin_1 = Din_1 + 2 * delta_1 + 2 * hfin_1 "Диаметр ребер, м";
  final parameter Real psi_fin_1 = 1 / (2 * (Din_1 + 2 * delta_1) * sfin_1) * (Dfin_1 ^ 2 - (Din_1 + 2 * delta_1) ^ 2 + 2 * Dfin_1 * delta_fin_1) + 1 - delta_fin_1 / sfin_1 "Коэффициент оребрения, равный отношению полной поверхности пучка к поверхности несущих труб на оребренном участке";
  //формула 7.22а нормативного метода
  final parameter Real sigma1_1 = s1_1 / (Din_1 + 2 * delta_1) "Относительный поперечный шаг";
  final parameter Real sigma2_1 = s2_1 / (Din_1 + 2 * delta_1) "Относительный продольный шаг";
  final parameter Real sigma3_1 = sqrt(0.25 * sigma1_1 ^ 2 + sigma2_1) "Средний относительный диагональный шаг труб";
  final parameter Real xfin_1 = sigma1_1 / sigma2_1 - 1.26 / psi_fin_1 - 2 "Параметр 'x' для шахматного пучка";
  final parameter Real phi_fin_1 = Modelica.Math.tanh(xfin_1) "Некий параметр 'фи'";
  final parameter Real n_fin_1 = 0.7 + 0.08 * phi_fin_1 + 0.005 * psi_fin_1 "Показатель степени 'n' в формуле коэффициента теплоотдачи";
  final parameter Real Cs_1 = (1.36 - phi_fin_1) * (11 / (psi_fin_1 + 8) - 0.14) "Коэффициент, определяемый в зависимости от от относительного поперечного и продольного шага труб в пучке, типа пучка и коэффициента оребрения";
  final parameter Real Cz_1 = if z2_1 < 8 and sigma1_1 / sigma2_1 < 2 then 3.15 * z2_1 ^ 0.05 - 2.5 elseif z2_1 < 8 and sigma1_1 / sigma2_1 >= 2 then 3.5 * z2_1 ^ 0.03 - 2.72 else 1 "Поправка на число рядов труб по ходу газов";
  final parameter Real Kaer_1 = (Din_1 + 2 * delta_1) ^ 0.611 * z2_1 / s1_1 ^ 0.412 / s2_1 ^ 0.515 "Коэффициент для расчета аэродинамического сопротивления";
  //Начальные значения
  parameter Modelica.SIunits.SpecificEnthalpy h_flow_start_1 = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(system.p_start) "Начальная энтальпия вода/пар" annotation(
  Dialog(tab = "Initialization 1-st HE"));    
  parameter Modelica.SIunits.AbsolutePressure p_flow_start_1 = system.p_start "Начальное давление вода/пар" annotation(
  Dialog(tab = "Initialization 1-st HE"));
  parameter Modelica.SIunits.MassFlowRate m_flow_start_1 = system.m_flow_start "Начальный массовый расход вода/пар" annotation(
  Dialog(tab = "Initialization 1-st HE"));
  parameter Modelica.SIunits.Temperature T_m_start_1 = system.T_start "Начальная температура металла вода/пар" annotation(
  Dialog(tab = "Initialization 1-st HE"));
  parameter Modelica.SIunits.Temperature T_gas_start_1 = system.T_start "Начальная температура газов" annotation(
  Dialog(tab = "Initialization 1-st HE"));  
  parameter Modelica.SIunits.AbsolutePressure p_gas_start_1 = system.p_start "Начальное давление газов 1-st HE" annotation(
  Dialog(tab = "Initialization 1-st HE"));    
  //Настройки второго теплообменника
  //Геометрия пучка
  parameter TPPSim.Choices.HRSG_type HRSG_type_set_2 = Choices.HRSG_type.horizontalBottom "Геометрия пучка (горизонтальный/вертикальный)" annotation(
    Dialog(tab = "2-nd HE", group = "Геометрия пучка"));
  parameter Modelica.SIunits.Length s1_2 = 82e-3 "Поперечный шаг" annotation(
    Dialog(tab = "2-nd HE", group = "Геометрия пучка"));
  parameter Modelica.SIunits.Length s2_2 = 110e-3 "Продольный шаг" annotation(
    Dialog(tab = "2-nd HE", group = "Геометрия пучка"));
  parameter Integer zahod_2 = 1 "Заходность труб теплообменника" annotation(
    Dialog(tab = "2-nd HE", group = "Геометрия пучка"));
  parameter Integer z1_2 = 126 "Число труб по ширине газохода" annotation(
    Dialog(tab = "2-nd HE", group = "Геометрия пучка"));
  parameter Integer z2_2 = 4 "Число труб по ходу газов в теплообменнике" annotation(
    Dialog(tab = "2-nd HE", group = "Геометрия пучка"));
  parameter Modelica.SIunits.Length Lpipe_2 = 20.85 "Длина теплообменной трубки" annotation(
    Dialog(tab = "2-nd HE", group = "Геометрия пучка"));
  //Конструктивные характеристики труб
  parameter Modelica.SIunits.Diameter Din_2 = 0.038 "Внутренний диаметр трубок теплообменника" annotation(
    Dialog(tab = "2-nd HE", group = "Конструктивные характеристики труб"));
  parameter Modelica.SIunits.Length delta_2 = 0.003 "Толщина стенки трубки теплообменника" annotation(
    Dialog(tab = "2-nd HE", group = "Конструктивные характеристики труб"));
  parameter Modelica.SIunits.Length ke_2 = 0.00014 "Абсолютная эквивалентная шероховатость" annotation(
    Dialog(tab = "2-nd HE", group = "Конструктивные характеристики труб"));
  //Характеристики оребрения
  parameter Modelica.SIunits.Length delta_fin_2 = 0.0008 "Средняя толщина ребра, м" annotation(
    Dialog(tab = "2-nd HE", group = "Характеристики оребрения"));
  parameter Modelica.SIunits.Length hfin_2 = 0.017 "Высота ребра, м" annotation(
    Dialog(tab = "2-nd HE", group = "Характеристики оребрения"));
  parameter Modelica.SIunits.Length sfin_2 = 0.00404 "Шаг ребер, м" annotation(
    Dialog(tab = "2-nd HE", group = "Характеристики оребрения"));
  //Характеристики металла
  parameter Modelica.SIunits.SpecificHeatCapacity C_m_2 = 578.05 "Удельная теплоемкость металла" annotation(
    Dialog(tab = "2-nd HE", group = "Характеристики металла"));
  parameter Modelica.SIunits.ThermalConductivity lambda_m_2 = 20 "Теплопроводность метала" annotation(
    Dialog(tab = "2-nd HE", group = "Характеристики металла"));  
  parameter Modelica.SIunits.Density rho_m_2 = 7800 "Плотность металла" annotation(
    Dialog(tab = "2-nd HE", group = "Характеристики металла"));
  //Поправки
  parameter Real k_gamma_gas_2 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов" annotation(
    Dialog(tab = "2-nd HE", group = "Поправки"));
  parameter Real k_weight_metal_2 = 1 "Поправка к массе металла поверхности нагрева"  annotation(
    Dialog(tab = "2-nd HE", group = "Поправки"));
  parameter Real k_volume_2 = 1 "Поправка к внутреннему объему трубок поверхности нагрева"  annotation(
    Dialog(tab = "2-nd HE", group = "Поправки"));
  parameter Real k_volume_gas_2 = 1 "Поправка к объему газов поверхности нагрева"  annotation(
    Dialog(tab = "2-nd HE", group = "Поправки"));
  //Параметры уравнений динамики
  parameter Types.Dynamics flowEnergyDynamics_2 = Types.Dynamics.FixedInitial "Параметры уравнения сохранения энергии вода/пар" annotation(
  Evaluate=true, Dialog(tab = "Assumptions 2-nd HE", group="Dynamics"));
  parameter Types.Dynamics flowMassDynamics_2 = Types.Dynamics.FixedInitial "Параметры уравнения сохранения массы вода/пар" annotation(
  Evaluate=true, Dialog(tab = "Assumptions 2-nd HE", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics flowMomentumDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyState "Параметры уравнения сохранения момента вода/пар" annotation(
  Evaluate=true, Dialog(tab = "Assumptions 2-nd HE", group="Dynamics"));
  parameter Types.Dynamics metalDynamics_2 = Types.Dynamics.FixedInitial "Параметры уравнения динамики прогрева металла" annotation(
  Evaluate=true, Dialog(tab = "Assumptions 2-nd HE", group="Dynamics")); 
  parameter Types.Dynamics gasEnergyDynamics_2 = Types.Dynamics.FixedInitial "Параметры уравнения сохранения энергии газов" annotation(
  Evaluate=true, Dialog(tab = "Assumptions 2-nd HE", group="Dynamics"));
  parameter Types.Dynamics gasMassDynamics_2 = Types.Dynamics.FixedInitial "Параметры уравнения сохранения массы газов" annotation(
  Evaluate=true, Dialog(tab = "Assumptions 2-nd HE", group="Dynamics"));  
  //Расчетные конструктивные параметры
  final parameter Modelica.SIunits.Length omega_2 = Modelica.Constants.pi * (Din_2 + 2 * delta_2) "Наружный периметр трубы";
  final parameter Modelica.SIunits.Length Dfin_2 = Din_2 + 2 * delta_2 + 2 * hfin_2 "Диаметр ребер, м";
  final parameter Real psi_fin_2 = 1 / (2 * (Din_2 + 2 * delta_2) * sfin_2) * (Dfin_2 ^ 2 - (Din_2 + 2 * delta_2) ^ 2 + 2 * Dfin_2 * delta_fin_2) + 1 - delta_fin_2 / sfin_2 "Коэффициент оребрения, равный отношению полной поверхности пучка к поверхности несущих труб на оребренном участке";
  //формула 7.22а нормативного метода
  final parameter Real sigma1_2 = s1_2 / (Din_2 + 2 * delta_2) "Относительный поперечный шаг";
  final parameter Real sigma2_2 = s2_2 / (Din_2 + 2 * delta_2) "Относительный продольный шаг";
  final parameter Real sigma3_2 = sqrt(0.25 * sigma1_2 ^ 2 + sigma2_2) "Средний относительный диагональный шаг труб";
  final parameter Real xfin_2 = sigma1_2 / sigma2_2 - 1.26 / psi_fin_2 - 2 "Параметр 'x' для шахматного пучка";
  final parameter Real phi_fin_2 = Modelica.Math.tanh(xfin_2) "Некий параметр 'фи'";
  final parameter Real n_fin_2 = 0.7 + 0.08 * phi_fin_2 + 0.005 * psi_fin_2 "Показатель степени 'n' в формуле коэффициента теплоотдачи";
  final parameter Real Cs_2 = (1.36 - phi_fin_2) * (11 / (psi_fin_2 + 8) - 0.14) "Коэффициент, определяемый в зависимости от от относительного поперечного и продольного шага труб в пучке, типа пучка и коэффициента оребрения";
  final parameter Real Cz_2 = if z2_2 < 8 and sigma1_2 / sigma2_2 < 2 then 3.15 * z2_2 ^ 0.05 - 2.5 elseif z2_2 < 8 and sigma1_2 / sigma2_2 >= 2 then 3.5 * z2_2 ^ 0.03 - 2.72 else 1 "Поправка на число рядов труб по ходу газов";
  final parameter Real Kaer_2 = (Din_2 + 2 * delta_2) ^ 0.611 * z2_2 / s1_2 ^ 0.412 / s2_2 ^ 0.515 "Коэффициент для расчета аэродинамического сопротивления";
  //Начальные значения
  parameter Modelica.SIunits.SpecificEnthalpy h_flow_start_2 = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(system.p_start) "Начальная энтальпия вода/пар" annotation(
  Dialog(tab = "Initialization 2-nd HE"));    
  parameter Modelica.SIunits.AbsolutePressure p_flow_start_2 = system.p_start "Начальное давление вода/пар" annotation(
  Dialog(tab = "Initialization 2-nd HE"));
  parameter Modelica.SIunits.MassFlowRate m_flow_start_2 = system.m_flow_start "Начальный массовый расход вода/пар" annotation(
  Dialog(tab = "Initialization 2-nd HE"));
  parameter Modelica.SIunits.Temperature T_m_start_2 = system.T_start "Начальная температура металла вода/пар" annotation(
  Dialog(tab = "Initialization 2-nd HE"));
  parameter Modelica.SIunits.Temperature T_gas_start_2 = system.T_start "Начальная температура газов" annotation(
  Dialog(tab = "Initialization 2-nd HE"));  
  parameter Modelica.SIunits.AbsolutePressure p_gas_start_2 = system.p_start "Начальное давление газов 2-nd HE" annotation(
  Dialog(tab = "Initialization 2-nd HE"));
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
end BaseParallelGFHE;
