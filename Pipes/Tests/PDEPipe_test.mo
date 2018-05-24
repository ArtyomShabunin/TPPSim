within TPPSim.Pipes.Tests;
model PDEPipe_test
  package Medium = Modelica.Media.Water.StandardWater;
  Modelica.Fluid.Sources.MassFlowSource_h Source(redeclare package Medium = Medium, h = 251e3, m_flow = 10, nPorts = 1, use_h_in = true, use_m_flow_in = false)  annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium, T = 500 + 273.15, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true)  annotation(
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.PDEPipe Pipe   annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 50, height = 126e3, offset = 251e3, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp1.y, Source.h_in) annotation(
    Line(points = {{-78, 70}, {-70, 70}, {-70, 38}, {-92, 38}, {-92, 4}, {-82, 4}, {-82, 4}}, color = {0, 0, 127}));
  connect(Pipe.waterOut, Sink.ports[1]) annotation(
    Line(points = {{12, 0}, {60, 0}, {60, 0}, {60, 0}}, color = {0, 127, 255}));
  connect(Source.ports[1], Pipe.waterIn) annotation(
    Line(points = {{-60, 0}, {-12, 0}, {-12, 0}, {-12, 0}}, color = {0, 127, 255}, thickness = 0.5));
end PDEPipe_test;
