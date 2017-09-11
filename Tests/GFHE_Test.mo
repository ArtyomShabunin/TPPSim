within TPPSim.Tests;
model GFHE_Test
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  parameter Real Tnom = 517.2 + 273.15;
  //parameter Real Gnom = 1292.6 / 3.6;
  parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
  package Medium_G = TPPSim.Media.ExhaustGas;
  parameter Real[6] set_X = {0.13, 0.01, 0.05, 1 - (0.13 + 0.01 + 0.05 + 0.004 + 0.004), 0.004, 0.004} "{O2, CO2, H2O, N2, Ar, SO2}";
  //Констуктивные характеристики поверхностей нагрева
  parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
  parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
  parameter Modelica.SIunits.Length delta = 0.002 "Толщина стенки трубки теплообменника";
  parameter Modelica.SIunits.Length s1 = 91.09e-3 "Поперечный шаг";
  parameter Modelica.SIunits.Length s2 = 79e-3 "Продольный шаг";
  parameter Integer zahod = 1 "заходность труб теплообменника";
  parameter Integer z1 = 58 "Число труб по ширине газохода";
  parameter Integer z2 = 8 "Число труб по ходу газов в теплообменнике";
  ///Оребрение труб
  parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
  parameter Modelica.SIunits.Length hfin = 0.015 "Высота ребра, м";
  parameter Modelica.SIunits.Length sfin = 2.215e-3 "Шаг ребер, м";
  //Исходные данные по разбиению
  parameter Integer numberOfVolumes = 1 "Число участков разбиения пароперегревателя" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Real k_gamma_gas = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
  parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(
    Dialog(group = "Конструктивные характеристики"));
  inner Modelica.Fluid.System system(allowFlowReversal = false, m_flow_small = 0.01, T_start = 60 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = system.T_start, m_flow = wflow, nPorts = 1, use_T_in = false, use_m_flow_in = false) annotation(
    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_start, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = system.T_start, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {70, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Tnom = Tnom, Tstart = system.T_start, gasSource.X = set_X) annotation(
    Placement(visible = true, transformation(origin = {70, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_glob GFHE(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE_glob flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, k_gamma_gas = k_gamma_gas, redeclare package Medium_F = Medium_F, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe, delta_fin = delta_fin, hfin = hfin, sfin = sfin, numberOfTubeSections = numberOfTubeSections, flow_DynamicMomentum = false, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
          Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  /*TPPSim.HRSG_HeatExch.GFHE_glob_simple GFHE(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE_glob flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, k_gamma_gas = k_gamma_gas, redeclare package Medium_F = Medium_F, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe, delta_fin = delta_fin, hfin = hfin, sfin = sfin, numberOfVolumes = numberOfVolumes, flow_DynamicMomentum = false, flow_DynamicMassBalance = false, flow_DynamicEnergyBalance = false, flow_DynamicTm = false, gas_DynamicMassBalance = false, gas_DynamicEnergyBalance = false) annotation(
    Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));*/
equation
  connect(flowSource.ports[1], GFHE.flowIn) annotation(
    Line(points = {{-60, 50}, {-4, 50}, {-4, 20}}, color = {0, 127, 255}, thickness = 0.5));
  connect(GFHE.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-5, 10}, {-60, 10}}, color = {0, 127, 255}));
  connect(GFHE.flowOut, flowSink.ports[1]) annotation(
    Line(points = {{4, 20}, {4, 20}, {4, 50}, {60, 50}, {60, 50}}, color = {0, 127, 255}));
  connect(GT.flowOut, GFHE.gasIn) annotation(
    Line(points = {{60, 10}, {5, 10}}, color = {0, 127, 255}));
  annotation(
    Documentation(info = "<html>
  <p>
Модель для тестирования 'GFHE'.
  </p>
  </html>", revisions = ""));
end GFHE_Test;
