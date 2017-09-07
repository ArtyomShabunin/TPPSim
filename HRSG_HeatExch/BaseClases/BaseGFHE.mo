within TPPSim.HRSG_HeatExch.BaseClases;
partial model BaseGFHE
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconHE;
  //Исходные данные для газовой стороны
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  inner parameter Real k_gamma_gas = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
  //Исходные данные для водяной стороны
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter TPPSim.Choices.HRSG_type HRSG_type_set = Choices.HRSG_type.horizontalBottom "Выбор типа КУ (горизонтальный/вертикальный)";
  inner parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
  inner parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника";
  inner parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
  inner parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
    Dialog(group = "Металл"));
  inner parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(
    Dialog(group = "Металл"));
  parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг";
  parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг";
  parameter Integer zahod = 1 "Заходность труб теплообменника";
  parameter Integer z1 = 126 "Число труб по ширине газохода";
  parameter Integer z2 = 4 "Число труб по ходу газов в теплообменнике";
  parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки";
  //Характеристики металла
  parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
    Dialog(group = "Металл"));
  parameter Boolean flow_DynamicMomentum = false "Использовать или нет уравнение сохранения момента";
  parameter Boolean flow_DynamicMassBalance = true "Использовать или нет уравнение сохранение массы с производными";
  parameter Boolean flow_DynamicEnergyBalance = true "Использовать или нет уравнение сохранения энергии с производными";
  parameter Boolean flow_DynamicTm = true "Использовать или нет производную по температуре металла";
  parameter Boolean gas_DynamicMassBalance = true "Использовать или нет уравнение сохранение массы с производными";
  parameter Boolean gas_DynamicEnergyBalance = true "Использовать или нет уравнение сохранения энергии с производными";
  ///Оребрение
  parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
  parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м";
  parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м";
  outer Modelica.Fluid.System system;
  inner Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {50, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-50, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {50, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {40, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-40, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter Modelica.SIunits.Length omega = Modelica.Constants.pi * (Din + 2 * delta) "Наружный периметр трубы";
  //Характеристики оребрения
  parameter Modelica.SIunits.Length Dfin = Din + 2 * delta + 2 * hfin "Диаметр ребер, м";
  parameter Real psi_fin = 1 / (2 * (Din + 2 * delta) * sfin) * (Dfin ^ 2 - (Din + 2 * delta) ^ 2 + 2 * Dfin * delta_fin) + 1 - delta_fin / sfin "Коэффициент оребрения, равный отношению полной поверхности пучка к поверхности несущих труб на оребренном участке";
  //формула 7.22а нормативного метода
  parameter Real sigma1 = s1 / (Din + 2 * delta) "Относительный поперечный шаг";
  parameter Real sigma2 = s2 / (Din + 2 * delta) "Относительный продольный шаг";
  parameter Real sigma3 = sqrt(0.25 * sigma1 ^ 2 + sigma2) "Средний относительный диагональный шаг труб";
  parameter Real xfin = sigma1 / sigma2 - 1.26 / psi_fin - 2 "Параметр 'x' для шахматного пучка";
  parameter Real phi_fin = Modelica.Math.tanh(xfin) "Некий параметр 'фи'";
  inner parameter Real n_fin = 0.7 + 0.08 * phi_fin + 0.005 * psi_fin "Показатель степени 'n' в формуле коэффициента теплоотдачи";
  inner parameter Real Cs = (1.36 - phi_fin) * (11 / (psi_fin + 8) - 0.14) "Коэффициент, определяемый в зависимости от от относительного поперечного и продольного шага труб в пучке, типа пучка и коэффициента оребрения";
  inner parameter Real Cz = if z2 < 8 and sigma1 / sigma2 < 2 then 3.15 * z2 ^ 0.05 - 2.5 elseif z2 < 8 and sigma1 / sigma2 >= 2 then 3.5 * z2 ^ 0.03 - 2.72 else 1 "Поправка на число рядов труб по ходу газов";
  inner parameter Real Kaer = (Din + 2 * delta) ^ 0.611 * z2 / s1 ^ 0.412 / s2 ^ 0.515 "Коэффициент для расчета аэродинамического сопротивления";
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    version = "",
    uses,
    Icon(coordinateSystem(extent = {{-50, -100}, {50, 100}})),
    Diagram(coordinateSystem(extent = {{-50, -100}, {50, 100}})),
    __OpenModelica_commandLineOptions = "");
end BaseGFHE;
