within TPPSim.Pipes.Tests;
model TestPipe
  package Medium = Modelica.Media.Water.StandardWater;
  Modelica.Fluid.Sources.MassFlowSource_h Source(redeclare package Medium = Medium, h = 3.4e6, m_flow = 360, nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium, T = 500 + 273.15, nPorts = 1, p = 130e5, use_T = true, use_p = true)  annotation(
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe(DynamicMomentum = false, numberOfVolumes = 2)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Pipe.waterOut, Sink.ports[1]) annotation(
    Line(points = {{12, 0}, {60, 0}, {60, 0}, {60, 0}}, color = {0, 127, 255}));
  connect(Source.ports[1], Pipe.waterIn) annotation(
    Line(points = {{-60, 0}, {-12, 0}, {-12, 0}, {-12, 0}}, color = {0, 127, 255}, thickness = 0.5));
end TestPipe;
