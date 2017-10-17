within TPPSim.HRSG_HeatExch;
model ParallelGFHE_simple
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseParallelGFHE; 
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  //Настройки первого теплообменника
  //Параметры разбиения
  parameter Integer numberOfVolumes_1 "Число участков разбиения" annotation(
    Dialog(tab = "1-st HE", group = "Параметры разбиения"));
  //Настройки второго теплообменника
  //Параметры разбиения
  parameter Integer numberOfVolumes_2 "Число участков разбиения" annotation(
    Dialog(tab = "2-nd HE", group = "Параметры разбиения"));  
  final parameter Real x_gasflow_1 = (1 - (Din_1 + 2 * delta_1) / s1_1 * (1 + 2 * hfin_1 * delta_fin_1 / sfin_1 / (Din_1 + 2 * delta_1))) /
  ((1 - (Din_1 + 2 * delta_1) / s1_1 * (1 + 2 * hfin_1 * delta_fin_1 / sfin_1 / (Din_1 + 2 * delta_1))) + 
  (1 - (Din_2 + 2 * delta_2) / s1_2 * (1 + 2 * hfin_2 * delta_fin_2 / sfin_2 / (Din_2 + 2 * delta_2)))) "Относительный расход газов через первый теплообменник";  
//Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a flowIn_1(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-50, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-40, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut_1(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {50, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {54, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a flowIn_2(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-50, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut_2(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {50, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple GFHE_1(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = Din_1, ke = ke_1, HRSG_type_set = HRSG_type_set_1, Lpipe = Lpipe_1, delta = delta_1, delta_fin = delta_fin_1, flowEnergyDynamics = flowEnergyDynamics_1, flowMassDynamics = flowMassDynamics_1, flowMomentumDynamics = flowMomentumDynamics_1, gasEnergyDynamics = gasEnergyDynamics_1, gasMassDynamics = gasMassDynamics_1, hfin = hfin_1, k_gamma_gas = k_gamma_gas_1, metalDynamics = metalDynamics_1, numberOfVolumes = numberOfVolumes_1, s1 = s1_1, s2 = s2_1, sfin = sfin_1, z1 = z1_1, z2 = z2_1, zahod = zahod_1) annotation(
    Placement(visible = true, transformation(origin = {-7.10543e-15, 46}, extent = {{-34, -34}, {34, 34}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple GFHE_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = Din_2, ke = ke_2, HRSG_type_set = HRSG_type_set_2, Lpipe = Lpipe_2, delta = delta_2, delta_fin = delta_fin_2, flowEnergyDynamics = flowEnergyDynamics_2, flowMassDynamics = flowMassDynamics_2, flowMomentumDynamics = flowMomentumDynamics_2, gasEnergyDynamics = gasEnergyDynamics_2, gasMassDynamics = gasMassDynamics_2, hfin = hfin_2, k_gamma_gas = k_gamma_gas_2, metalDynamics = metalDynamics_2, numberOfVolumes = numberOfVolumes_2, s1 = s1_2, s2 = s2_2, sfin = sfin_2, z1 = z1_2, z2 = z2_2, zahod = zahod_2) annotation(
    Placement(visible = true, transformation(origin = {0, -46}, extent = {{-34, 34}, {34, -34}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GasSplitterFoeParallelHE splitter(redeclare package Medium = Medium_G, x_gasflow_1 = x_gasflow_1) annotation(
    Placement(visible = true, transformation(origin = {32, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(splitter.gasOut_1, GFHE_1.gasIn) annotation(
    Line(points = {{22, 6}, {22, 46}, {16, 46}}, color = {0, 127, 255}));
  connect(splitter.gasOut_2, GFHE_2.gasIn) annotation(
    Line(points = {{22, -6}, {22, -46}, {18, -46}}, color = {0, 127, 255}));
  connect(gasIn, splitter.gasIn) annotation(
    Line(points = {{50, 0}, {42, 0}}));
  connect(gasOut, GFHE_2.gasOut) annotation(
    Line(points = {{-50, 0}, {-36, 0}, {-36, -46}, {-16, -46}, {-16, -46}}));
  connect(gasOut, GFHE_1.gasOut) annotation(
    Line(points = {{-50, 0}, {-36, 0}, {-36, 46}, {-18, 46}, {-18, 46}}));
  connect(flowIn_1, GFHE_1.flowIn) annotation(
    Line(points = {{-50, 80}, {-14, 80}, {-14, 80}, {-14, 80}}));
  connect(flowOut_1, GFHE_1.flowOut) annotation(
    Line(points = {{50, 80}, {14, 80}, {14, 80}, {14, 80}}));
  connect(flowOut_2, GFHE_2.flowOut) annotation(
    Line(points = {{50, -80}, {14, -80}, {14, -80}, {14, -80}}));
  connect(flowIn_2, GFHE_2.flowIn) annotation(
    Line(points = {{-50, -80}, {-14, -80}, {-14, -80}, {-14, -80}}));
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    version = "",
    uses);
end ParallelGFHE_simple;
