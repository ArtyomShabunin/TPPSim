within TPPSim.Tests;
model drumOnly
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  TPPSim.Drums.Drum Drum(Din = 1, L = 9, delta = 0.02, ps_start = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T FW(redeclare package Medium = Medium, T = 60 + 273.15, nPorts = 1, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-48, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium, T = 60 + 273.15, nPorts = 1, p = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {72, 32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {35, 45}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV1(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {46, 32}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(CV1.port_b, Sink.ports[1]) annotation(
    Line(points = {{50, 32}, {62, 32}, {62, 32}, {62, 32}}, color = {0, 127, 255}));
  connect(Drum.steam, CV1.port_a) annotation(
    Line(points = {{18, 20}, {18, 20}, {18, 32}, {42, 32}, {42, 32}}, color = {0, 127, 255}));
  connect(constCV1.y, CV1.opening) annotation(
    Line(points = {{40, 46}, {46, 46}, {46, 36}, {46, 36}}, color = {0, 0, 127}));
  connect(Drum.FW_feedback, FW.m_flow_in) annotation(
    Line(points = {{22, 14}, {26, 14}, {26, -18}, {-72, -18}, {-72, 38}, {-58, 38}, {-58, 38}}, color = {0, 0, 127}));
  connect(FW.ports[1], Drum.fedWater) annotation(
    Line(points = {{-38, 30}, {2, 30}, {2, 20}, {4, 20}}, color = {0, 127, 255}));
  connect(Drum.upStr, Drum.downStr) annotation(
    Line(points = {{17, 1}, {15, 1}, {15, -15}, {1, -15}, {1, 1}, {3, 1}}, color = {0, 127, 255}));
initial equation
  der(Drum.ps) = 0;
end drumOnly;