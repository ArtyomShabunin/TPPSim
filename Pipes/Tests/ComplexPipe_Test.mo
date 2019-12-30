within TPPSim.Pipes.Tests;

model ComplexPipe_Test
  package Medium = TPPSim.Media.Sodium_ph;
    Modelica.Fluid.Sources.MassFlowSource_T Source(redeclare package Medium = Medium, T = 400 + 273.15, m_flow = 360, nPorts = 1, use_m_flow_in = true)  annotation(
      Placement(visible = true, transformation(origin = {-50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium, T = 500 + 273.15, nPorts = 1, p = 2e5, use_T = true, use_p = true)  annotation(
    Placement(visible = true, transformation(origin = {70, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system(T_start = 573.15)  annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe_2 Pipe(redeclare package Medium = Medium, redeclare TPPSim.Pipes.ElementaryPipe_2 Pipe, Lpiezo = -10, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, h_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(system.p_ambient, 300 + 273.15), massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial,momentumDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfVolumes = 5, t_m_start = 573.15)  annotation(
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 1000, height = -360 * 2, offset = 360, startTime = 60)  annotation(
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe_2 complexPipe_2(redeclare package Medium = Medium, redeclare TPPSim.Pipes.ElementaryPipe_2 Pipe, Lpiezo = -10, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, h_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(system.p_ambient, 300 + 273.15), massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial,momentumDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfVolumes = 5, t_m_start = 573.15) annotation(
    Placement(visible = true, transformation(origin = {0, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary Sink_2(redeclare package Medium = Medium, T = 500 + 273.15, nPorts = 1, p = 2e5, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {70, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT Source_2(redeclare package Medium = Medium, T = 300 + 273.15, nPorts = 1, use_p_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 1000, height = -2e5, offset = 3e5, startTime = 60)  annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp.y, Source.m_flow_in) annotation(
    Line(points = {{-78, 70}, {-72, 70}, {-72, 48}, {-60, 48}, {-60, 48}}, color = {0, 0, 127}));
  connect(complexPipe_2.waterOut, Sink_2.ports[1]) annotation(
    Line(points = {{12, -20}, {60, -20}, {60, -20}, {60, -20}}, color = {0, 127, 255}));
  connect(Source_2.ports[1], complexPipe_2.waterIn) annotation(
    Line(points = {{-40, -20}, {-12, -20}, {-12, -20}, {-12, -20}}, color = {0, 127, 255}));
  connect(Source.ports[1], Pipe.waterIn) annotation(
    Line(points = {{-40, 40}, {-12, 40}, {-12, 40}, {-12, 40}}, color = {0, 127, 255}));
  connect(Pipe.waterOut, Sink.ports[1]) annotation(
    Line(points = {{12, 40}, {60, 40}, {60, 40}, {60, 40}}, color = {0, 127, 255}));
  connect(ramp1.y, Source_2.p_in) annotation(
    Line(points = {{-78, 10}, {-72, 10}, {-72, -12}, {-62, -12}, {-62, -12}}, color = {0, 0, 127}));

annotation(
    experiment(StartTime = 0, StopTime = 3600, Tolerance = 1e-6, Interval = 7.2));
end ComplexPipe_Test;
