within TPPSim.Nuclear.Tests;

model SodiumSideHE_Test
  package Medium_S = TPPSim.Media.Sodium_ph;
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  TPPSim.Nuclear.steam_generator steam_generator1(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_S = Medium_S, redeclare package Medium_F = Medium_F, T_m_start = 573.15, T_sodium_start = 573.15, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, h_flow_start = 1339e3, m_flow_start = 40, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 10, p_flow_start = 1.4e+07, sodiumEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial) annotation(
    Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T Source(redeclare package Medium = Medium_S, T = 300 + 273.15, m_flow = 373, nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium_S, nPorts = 1, p = 1e5)  annotation(
    Placement(visible = true, transformation(origin = {-62, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system(T_start = 573.15, m_flow_start = 10)  annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = 300 + 273.15, m_flow = 40, nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {88, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, nPorts = 1, p = 14e6)  annotation(
    Placement(visible = true, transformation(origin = {90, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(steam_generator1.sodiumOut, Sink.ports[1]) annotation(
    Line(points = {{-5, -7}, {-42, -7}, {-42, -8}, {-52, -8}}, color = {0, 127, 255}));
  connect(Source.ports[1], steam_generator1.sodiumIn) annotation(
    Line(points = {{-80, 10}, {-42, 10}, {-42, 11}, {-5, 11}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], steam_generator1.flowIn) annotation(
    Line(points = {{78, -10}, {42, -10}, {42, -7}, {5, -7}}, color = {0, 127, 255}));
  connect(steam_generator1.flowOut, flowSink.ports[1]) annotation(
    Line(points = {{5, 11}, {43, 11}, {43, 10}, {80, 10}}, color = {0, 127, 255}));
  annotation(
    Diagram,
    Icon,
    __OpenModelica_commandLineOptions = "");
end SodiumSideHE_Test;
