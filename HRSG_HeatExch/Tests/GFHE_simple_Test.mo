within TPPSim.HRSG_HeatExch.Tests;

model GFHE_simple_Test
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  inner Modelica.Fluid.System system(T_start = 333.15, allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T gas_source(redeclare package Medium = Medium_G, T = 60 + 273.15, m_flow = 0, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {70, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gas_sink(redeclare package Medium = Medium_G, T = 300 + 273.15, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flow_source_1(redeclare package Medium = Medium_F, T = 60 + 273.15, m_flow = 0, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {70, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flow_sink_1(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = system.p_start, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {70, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));

  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 7.702e-3, z1 = 174, z2 = 10, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {1.9984e-15, 10}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));

equation
  connect(gas_source.ports[1], HP_ECO_2.gasIn) annotation(
    Line(points = {{60, -20}, {0, -20}, {0, 0}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasOut, gas_sink.ports[1]) annotation(
    Line(points = {{0, 20}, {0, 40}, {-60, 40}}, color = {0, 127, 255}));
  connect(flow_source_1.ports[1], HP_ECO_2.flowIn) annotation(
    Line(points = {{60, 50}, {20, 50}, {20, 18}}, color = {0, 127, 255}));
  connect(HP_ECO_2.flowOut, flow_sink_1.ports[1]) annotation(
    Line(points = {{20, 2}, {40, 2}, {40, 20}, {60, 20}}, color = {0, 127, 255}));
end GFHE_simple_Test;
