within TPPSim.HRSG_HeatExch.Tests;

model ParallelGFHE_Test
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  TPPSim.HRSG_HeatExch.ParallelGFHE_simple parallelGFHE(redeclare package Medium_F = Medium_F, redeclare package Medium_G = Medium_G, Din_1 = 38.1e-3, Din_2 = 38.1e-3, HRSG_type_set_1 = TPPSim.Choices.HRSG_type.horizontalBottom, HRSG_type_set_2 = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe_1 = 18.29, Lpipe_2 = 18.29, delta_1 = 3.404e-3, delta_2 = 2.108e-3, delta_fin_1 = 0.9906e-3, delta_fin_2 = 0.9906e-3, flowEnergyDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowEnergyDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMassDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin_1 = 15.88e-3, hfin_2 = 15.88e-3, metalDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, metalDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes_1 = 2, numberOfVolumes_2 = 2, s1_1 = 89.93e-3, s1_2 = 85.05e-3, s2_1 = 111.1e-3, s2_2 = 111.1e-3, sfin_1 = 2.67e-3, sfin_2 = 3.156e-3, z1_1 = 98, z1_2 = 22, z2_1 = 10, z2_2 = 8, zahod_1 = 1, zahod_2 = 1) annotation(
    Placement(visible = true, transformation(origin = {0, -2.66454e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T gas_source(redeclare package Medium = Medium_G, T = 300 + 273.15, m_flow = 1292.6 / 3.6, nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gas_sink(redeclare package Medium = Medium_G, T = 300 + 273.15, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flow_source_1(redeclare package Medium = Medium_F, T = 60 + 273.15, m_flow = 250 / 3.6, nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {-68, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flow_sink_1(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = 120e5, use_T = true, use_p = true)  annotation(
    Placement(visible = true, transformation(origin = {70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flow_source_2(redeclare package Medium = Medium_F, T = 60 + 273.15, m_flow = 64 / 3.6, nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flow_sink_2(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = 3e5, use_T = true, use_p = true)  annotation(
    Placement(visible = true, transformation(origin = {70, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(flow_sink_1.ports[1], parallelGFHE.flowOut_1) annotation(
    Line(points = {{60, 30}, {8, 30}, {8, 20}, {8, 20}}, color = {0, 127, 255}, thickness = 0.5));
  connect(flow_source_1.ports[1], parallelGFHE.flowIn_1) annotation(
    Line(points = {{-58, 32}, {-8, 32}, {-8, 20}, {-8, 20}}, color = {0, 127, 255}, thickness = 0.5));
  connect(flow_source_2.ports[1], parallelGFHE.flowIn_2) annotation(
    Line(points = {{-60, -30}, {-8, -30}, {-8, -20}, {-8, -20}}, color = {0, 127, 255}, thickness = 0.5));
  connect(flow_sink_2.ports[1], parallelGFHE.flowOut_2) annotation(
    Line(points = {{60, -30}, {8, -30}, {8, -20}, {8, -20}}, color = {0, 127, 255}, thickness = 0.5));
  connect(gas_sink.ports[1], parallelGFHE.gasOut) annotation(
    Line(points = {{-60, 0}, {-12, 0}, {-12, 0}, {-10, 0}}, color = {0, 127, 255}, thickness = 0.5));
  connect(gas_source.ports[1], parallelGFHE.gasIn) annotation(
    Line(points = {{60, 0}, {12, 0}, {12, 0}, {10, 0}}, color = {0, 127, 255}, thickness = 0.5));

end ParallelGFHE_Test;
