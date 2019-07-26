within TPPSim.Nuclear.Tests;

model IHX_Test
  package Medium_S = TPPSim.Media.Sodium_ph;
  SodiumHE IHX(redeclare TPPSim.HRSG_HeatExch.GlycolSideHE flowHE(redeclare TPPSim.thermal.alfaSodium_inside alpha(section = section)), redeclare package Medium_S = Medium_S, redeclare package Medium_F = Medium_S, Dcase = 3, Din = 0.03, Lpipe = 20, T_m_start = 463.15, T_sodium_start = 463.15, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, h_flow_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(system.p_ambient, 190 + 273.15), k_gamma_sodium = 1, m_flow_start = 0.01, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 10, p_flow_start = system.p_ambient, p_sodium_start = 250000, sodiumEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, z = 5000) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T Source_1(redeclare package Medium = Medium_S, T = 190 + 273.15,m_flow = 3502, nPorts = 2, use_T_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary Sink_1(redeclare package Medium = Medium_S, nPorts = 1, p = 1.5e5)  annotation(
    Placement(visible = true, transformation(origin = {-70, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary Sink_2(redeclare package Medium = Medium_S, nPorts = 1, p = 2.5e5)  annotation(
    Placement(visible = true, transformation(origin = {70, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T Source_2(redeclare package Medium = Medium_S, T = 190 + 273.15, m_flow = 2981, nPorts = 2, use_T_in = true)  annotation(
    Placement(visible = true, transformation(origin = {70, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_1(duration = 100, height = 350, offset = 190 + 273.15, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature t_1_in(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature t_1_out(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature t_2_in(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {32, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature t_2_out(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_2(duration = 100, height = 118, offset = 190 + 273.15, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp_2.y, Source_2.T_in) annotation(
    Line(points = {{82, -70}, {100, -70}, {100, -16}, {82, -16}, {82, -16}}, color = {0, 0, 127}));
  connect(IHX.flowOut, t_2_out.port) annotation(
    Line(points = {{6, 10}, {6, 10}, {6, 20}, {30, 20}, {30, 40}, {30, 40}}, color = {0, 127, 255}));
  connect(Source_2.ports[2], t_2_in.port) annotation(
    Line(points = {{60, -20}, {32, -20}, {32, -10}, {32, -10}}, color = {0, 127, 255}));
  connect(IHX.sodiumOut, t_1_out.port) annotation(
    Line(points = {{-4, -10}, {-6, -10}, {-6, -20}, {-30, -20}, {-30, -10}, {-30, -10}}, color = {0, 127, 255}));
  connect(Source_1.ports[2], t_1_in.port) annotation(
    Line(points = {{-60, 20}, {-30, 20}, {-30, 40}, {-30, 40}}, color = {0, 127, 255}));
  connect(ramp_1.y, Source_1.T_in) annotation(
    Line(points = {{-78, 70}, {-68, 70}, {-68, 44}, {-94, 44}, {-94, 24}, {-82, 24}, {-82, 24}}, color = {0, 0, 127}));
  connect(Source_2.ports[1], IHX.flowIn) annotation(
    Line(points = {{60, -20}, {6, -20}, {6, -10}, {6, -10}}, color = {0, 127, 255}));
  connect(Sink_2.ports[1], IHX.flowOut) annotation(
    Line(points = {{60, 20}, {6, 20}, {6, 10}, {6, 10}}, color = {0, 127, 255}));
  connect(Sink_1.ports[1], IHX.sodiumOut) annotation(
    Line(points = {{-60, -20}, {-6, -20}, {-6, -10}, {-4, -10}}, color = {0, 127, 255}));
  connect(Source_1.ports[1], IHX.sodiumIn) annotation(
    Line(points = {{-60, 20}, {-6, 20}, {-6, 10}, {-4, 10}}, color = {0, 127, 255}));
annotation(
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-3, Interval = 0.1));
end IHX_Test;
