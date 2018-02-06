within TPPSim.Pipes.Tests;
model Heating_1
  package Medium = Modelica.Media.Water.StandardWater;
  Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium, T = 300 + 273.15, nPorts = 2, p = system.p_ambient, use_T = true, use_p = true)  annotation(
    Placement(visible = true, transformation(origin = {90, -24}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe2(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), Din = 0.1645, Lpipe = 16.316, delta = 0.040, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 5, p_flow_start = 3e+06) annotation(
    Placement(visible = true, transformation(origin = {-24, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe3(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), Din = 0.2139, Lpipe = 38.317, delta = 0.055, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 8, p_flow_start = 3e+06)  annotation(
    Placement(visible = true, transformation(origin = {22, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible valve(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 75.82, dp_nominal = 200000, m_flow_nominal = 6, p_nominal = 2e5) annotation(
    Placement(visible = true, transformation(origin = {54, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T(k = 300 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-70, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe1(Din = 0.1645, Lpipe = 15.916, delta = 0.040,massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 5, p_flow_start = 3e+06)  annotation(
    Placement(visible = true, transformation(origin = {-24, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT source_1(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_p_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant P(k = 40e5)  annotation(
    Placement(visible = true, transformation(origin = {-70, 46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT source_2(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_p_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-72, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {30, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T.y, source_2.T_in) annotation(
    Line(points = {{-81, 80}, {-93, 80}, {-93, -40}, {-85, -40}}, color = {0, 0, 127}));
  connect(T.y, source_1.T_in) annotation(
    Line(points = {{-81, 80}, {-93, 80}, {-93, 0}, {-83, 0}}, color = {0, 0, 127}));
  connect(const.y, valve.opening) annotation(
    Line(points = {{41, 46}, {55, 46}, {55, -16}, {53, -16}, {53, -16}, {53, -16}}, color = {0, 0, 127}));
  connect(P.y, source_2.p_in) annotation(
    Line(points = {{-81, 46}, {-89, 46}, {-89, -36}, {-83, -36}, {-83, -36}, {-83, -36}, {-83, -36}}, color = {0, 0, 127}));
  connect(source_2.ports[1], Pipe2.waterIn) annotation(
    Line(points = {{-62, -44}, {-36, -44}, {-36, -44}, {-36, -44}, {-36, -44}, {-36, -44}}, color = {0, 127, 255}, thickness = 0.5));
  connect(P.y, source_1.p_in) annotation(
    Line(points = {{-81, 46}, {-89, 46}, {-89, 4}, {-81, 4}, {-81, 4}, {-81, 4}, {-81, 4}}, color = {0, 0, 127}));
  connect(source_1.ports[1], Pipe1.waterIn) annotation(
    Line(points = {{-60, -4}, {-48, -4}, {-48, -4}, {-36, -4}, {-36, -4}, {-36, -4}, {-36, -4}, {-36, -4}}, color = {0, 127, 255}, thickness = 0.5));
  connect(Pipe1.waterOut, Pipe3.waterIn) annotation(
    Line(points = {{-11.9, -4}, {-6.85, -4}, {-6.85, -4}, {-1.8, -4}, {-1.8, -24}, {4.15, -24}, {4.15, -24}, {10.1, -24}}, color = {0, 127, 255}));
  connect(valve.port_b, Sink.ports[1]) annotation(
    Line(points = {{64, -24}, {80, -24}}, color = {0, 127, 255}));
  connect(Pipe3.waterOut, valve.port_a) annotation(
    Line(points = {{34.1, -24}, {35.35, -24}, {35.35, -24}, {36.6, -24}, {36.6, -24}, {39.1, -24}, {39.1, -24}, {44.1, -24}, {44.1, -24}, {44.1, -24}}, color = {0, 127, 255}));
  connect(Pipe2.waterOut, Pipe3.waterIn) annotation(
    Line(points = {{-11.9, -44}, {-6.8, -44}, {-6.8, -44}, {-1.7, -44}, {-1.7, -24}, {4.2, -24}, {4.2, -24}, {10.1, -24}}, color = {0, 127, 255}));
end Heating_1;
