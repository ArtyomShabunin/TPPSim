within TPPSim.Pipes.Tests;
model Heating_1
  package Medium = Modelica.Media.Water.StandardWater;
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe2(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), Din = 0.1645, Lpipe = 16.316, delta = 0.040, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 5, p_flow_start = 3e+06) annotation(
    Placement(visible = true, transformation(origin = {-30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe3(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), Din = 0.2139, Lpipe = 38.317, delta = 0.055, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 8, p_flow_start = 3e+06)  annotation(
    Placement(visible = true, transformation(origin = {22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible valve(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 75.82, dp_nominal = 200000, m_flow_nominal = 6, p_nominal = 2e5) annotation(
    Placement(visible = true, transformation(origin = {54, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T(k = 300 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe1(Din = 0.1645, Lpipe = 15.916, delta = 0.040,massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 5, p_flow_start = 3e+06)  annotation(
    Placement(visible = true, transformation(origin = {-30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT source_1(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_p_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant P(k = 33e5)  annotation(
    Placement(visible = true, transformation(origin = {-70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT source_2(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_p_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe4(Din = 0.2139, Lpipe = 38.317, delta = 0.055, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 8, p_flow_start = 800000) annotation(
    Placement(visible = true, transformation(origin = {50, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe5(Din = 0.1645, Lpipe = 15.916, delta = 0.040, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 5, p_flow_start = 800000) annotation(
    Placement(visible = true, transformation(origin = {-10, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe6(Din = 0.1645, Lpipe = 15.916, delta = 0.040, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 5, p_flow_start = 800000) annotation(
    Placement(visible = true, transformation(origin = {-10, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Valves.Desuperheater desuperheater1(redeclare package Medium = Medium, set_down_T = 463.15)  annotation(
    Placement(visible = true, transformation(origin = {84, -22}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Fluid.Sources.FixedBoundary source_w(redeclare package Medium = Medium, h = 419e3, nPorts = 1, p = 1.013e5, use_T = false)  annotation(
    Placement(visible = true, transformation(origin = {90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium, nPorts = 1, p = 8e5)  annotation(
    Placement(visible = true, transformation(origin = {74, -100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Valves.heatSource RH1(redeclare package Medium = Medium, set_down_T = 573.15) annotation(
    Placement(visible = true, transformation(origin = {-50, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Valves.heatSource RH2(redeclare package Medium = Medium, set_down_T = 573.15) annotation(
    Placement(visible = true, transformation(origin = {-50, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe7(Din = 0.2139, Lpipe = 38.317, delta = 0.055, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 8, p_flow_start = 800000) annotation(
    Placement(visible = true, transformation(origin = {-10, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe8(Din = 0.2139, Lpipe = 38.317, delta = 0.055, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 8, p_flow_start = 800000) annotation(
    Placement(visible = true, transformation(origin = {-10, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe9(Din = 0.2139, Lpipe = 38.317, delta = 0.055, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 8, p_flow_start = 800000) annotation(
    Placement(visible = true, transformation(origin = {30, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Pipe9.waterOut, Sink.ports[1]) annotation(
    Line(points = {{42, -100}, {64, -100}, {64, -100}, {64, -100}}, color = {0, 127, 255}));
  connect(Pipe8.waterOut, Pipe9.waterIn) annotation(
    Line(points = {{2, -110}, {10, -110}, {10, -100}, {18, -100}, {18, -100}}, color = {0, 127, 255}));
  connect(Pipe7.waterOut, Pipe9.waterIn) annotation(
    Line(points = {{2, -90}, {10, -90}, {10, -100}, {18, -100}, {18, -100}}, color = {0, 127, 255}));
  connect(RH2.flowOut, Pipe7.waterIn) annotation(
    Line(points = {{-60, -60}, {-64, -60}, {-64, -90}, {-22, -90}, {-22, -90}}, color = {0, 127, 255}));
  connect(RH1.flowOut, Pipe8.waterIn) annotation(
    Line(points = {{-60, -40}, {-70, -40}, {-70, -110}, {-22, -110}, {-22, -110}}, color = {0, 127, 255}));
  connect(Pipe6.waterOut, RH2.flowIn) annotation(
    Line(points = {{-22, -60}, {-40, -60}}, color = {0, 127, 255}));
  connect(Pipe4.waterOut, Pipe6.waterIn) annotation(
    Line(points = {{37.9, -50}, {19.9, -50}, {19.9, -60}, {2, -60}}, color = {0, 127, 255}));
  connect(Pipe5.waterOut, RH1.flowIn) annotation(
    Line(points = {{-22, -40}, {-40, -40}, {-40, -40}, {-40, -40}}, color = {0, 127, 255}));
  connect(Pipe4.waterOut, Pipe5.waterIn) annotation(
    Line(points = {{37.9, -50}, {28.9, -50}, {28.9, -50}, {21.9, -50}, {21.9, -40}, {3.9, -40}, {3.9, -40}, {1.9, -40}, {1.9, -40}}, color = {0, 127, 255}));
  connect(desuperheater1.flowOut, Pipe4.waterIn) annotation(
    Line(points = {{84, -32}, {84, -50}, {62, -50}}, color = {0, 127, 255}));
  connect(source_w.ports[1], desuperheater1.waterIn) annotation(
    Line(points = {{90, 40}, {90, 40}, {90, 8}, {94, 8}, {94, -18}, {94, -18}}, color = {0, 127, 255}, thickness = 0.5));
  connect(const.y, valve.opening) annotation(
    Line(points = {{41, 30}, {55, 30}, {55, 8}, {54, 8}}, color = {0, 0, 127}));
  connect(valve.port_b, desuperheater1.flowIn) annotation(
    Line(points = {{64, 0}, {84, 0}, {84, -12}, {84, -12}}, color = {0, 127, 255}));
  connect(source_2.ports[1], Pipe2.waterIn) annotation(
    Line(points = {{-60, -10}, {-42, -10}}, color = {0, 127, 255}, thickness = 0.5));
  connect(P.y, source_2.p_in) annotation(
    Line(points = {{-81, 56}, {-89, 56}, {-89, -2}, {-82, -2}}, color = {0, 0, 127}));
  connect(T.y, source_2.T_in) annotation(
    Line(points = {{-81, 90}, {-93, 90}, {-93, -6}, {-82, -6}}, color = {0, 0, 127}));
  connect(Pipe2.waterOut, Pipe3.waterIn) annotation(
    Line(points = {{-18, -10}, {-8, -10}, {-8, 0}, {10, 0}}, color = {0, 127, 255}));
  connect(Pipe1.waterOut, Pipe3.waterIn) annotation(
    Line(points = {{-18, 20}, {-8, 20}, {-8, 0}, {10, 0}, {10, 0}}, color = {0, 127, 255}));
  connect(source_1.ports[1], Pipe1.waterIn) annotation(
    Line(points = {{-60, 20}, {-42, 20}}, color = {0, 127, 255}, thickness = 0.5));
  connect(P.y, source_1.p_in) annotation(
    Line(points = {{-81, 56}, {-89, 56}, {-89, 28}, {-82, 28}}, color = {0, 0, 127}));
  connect(T.y, source_1.T_in) annotation(
    Line(points = {{-81, 90}, {-93, 90}, {-93, 24}, {-82, 24}}, color = {0, 0, 127}));
  connect(Pipe3.waterOut, valve.port_a) annotation(
    Line(points = {{34.1, 0}, {34.2563, 0}, {34.2563, -2}, {34.4125, -2}, {34.4125, -2}, {34.725, -2}, {34.725, -2}, {35.35, -2}, {35.35, 0}, {36.6, 0}, {36.6, 0}, {39.1, 0}, {39.1, 0}, {44.1, 0}, {44.1, -2}, {44.1, -2}, {44.1, 0}, {44.1, 0}, {44.1, -2}, {44.1, -2}, {44.1, 0}, {44.1, 0}}, color = {0, 127, 255}));
annotation(
    Diagram,
    Icon,
    __OpenModelica_commandLineOptions = "");end Heating_1;
