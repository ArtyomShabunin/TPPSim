within TPPSim.Pipes.Tests;
model Heating_01
  package Medium = Modelica.Media.Water.StandardWater;
  Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium, T = 300 + 273.15, nPorts = 2, p = system.p_ambient, use_T = true, use_p = true)  annotation(
    Placement(visible = true, transformation(origin = {90, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe1(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForPipeHeating alpha(section = section)), Din = 0.1645, Lpipe = 40, delta = 0.040, h_start = 251.2e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 5, p_flow_start = 101300)  annotation(
    Placement(visible = true, transformation(origin = {-24, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible valve(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 75.82, dp_nominal = 200000, m_flow_nominal = 6, p_nominal = 2e5) annotation(
    Placement(visible = true, transformation(origin = {54, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {34, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T(k = 300 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp D(duration = 20 * 60, height = 13.5, offset = 0.0001, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-70, -4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T source_1(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_m_flow_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.pressure_control_2 pressure_control(P_activation = 120000, T = 20, k = 0.000001, pos_start = 0, set_p = 3e+06, speed_p = 30e5 / 60 / 20)  annotation(
    Placement(visible = true, transformation(origin = {30, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Fluid.Valves.ValveCompressible valveCompressible1(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 200, dp_nominal = 200000, m_flow_nominal = 6, p_nominal = 2e5) annotation(
    Placement(visible = true, transformation(origin = {-40, -8}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(k = false)  annotation(
    Placement(visible = true, transformation(origin = {-10, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure pressure1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {4, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {20, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.Drain drain1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {6, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(drain1.flowOut, valve.port_a) annotation(
    Line(points = {{10, -40}, {20, -40}, {20, -60}, {44, -60}, {44, -60}}, color = {0, 127, 255}));
  connect(Pipe1.waterOut, drain1.flowIn) annotation(
    Line(points = {{-12, -40}, {2, -40}, {2, -40}, {2, -40}}, color = {0, 127, 255}));
  connect(Pipe1.waterIn, pressure1.port) annotation(
    Line(points = {{-36, -40}, {-40, -40}, {-40, -28}, {4, -28}, {4, -28}}, color = {0, 127, 255}));
  connect(Pipe1.waterIn, valveCompressible1.port_a) annotation(
    Line(points = {{-36, -40}, {-40, -40}, {-40, -18}, {-40, -18}}, color = {0, 127, 255}));
  connect(const1.y, valve.opening) annotation(
    Line(points = {{32, -86}, {68, -86}, {68, -42}, {54, -42}, {54, -52}, {54, -52}}, color = {0, 0, 127}));
  connect(pressure1.p, pressure_control.u2) annotation(
    Line(points = {{16, -18}, {68, -18}, {68, 10}, {42, 10}, {42, 10}}, color = {0, 0, 127}));
  connect(const.y, pressure_control.u3) annotation(
    Line(points = {{46, -30}, {60, -30}, {60, 2}, {42, 2}, {42, 2}}, color = {0, 0, 127}));
  connect(const.y, pressure_control.u1) annotation(
    Line(points = {{46, -30}, {52, -30}, {52, -2}, {42, -2}, {42, -2}}, color = {0, 0, 127}));
  connect(booleanConstant1.y, pressure_control.u4) annotation(
    Line(points = {{2, 72}, {36, 72}, {36, 16}, {36, 16}}, color = {255, 0, 255}));
  connect(pressure_control.y, valveCompressible1.opening) annotation(
    Line(points = {{19, 4}, {5, 4}, {5, 4}, {-9, 4}, {-9, -8}, {-33, -8}, {-33, -8}, {-33, -8}, {-33, -8}}, color = {0, 0, 127}));
  connect(valveCompressible1.port_b, Sink.ports[2]) annotation(
    Line(points = {{-40, 2}, {-40, 2}, {-40, 2}, {-40, 2}, {-40, 20}, {74, 20}, {74, -58}, {80, -58}, {80, -59}, {80, -59}, {80, -60}}, color = {0, 127, 255}));
  connect(T.y, source_1.T_in) annotation(
    Line(points = {{-81, 30}, {-88, 30}, {-88, 30}, {-95, 30}, {-95, -36}, {-83, -36}, {-83, -36}, {-83, -36}, {-83, -36}}, color = {0, 0, 127}));
  connect(D.y, source_1.m_flow_in) annotation(
    Line(points = {{-81, -4}, {-89, -4}, {-89, -32}, {-81, -32}, {-81, -32}, {-81, -32}, {-81, -32}}, color = {0, 0, 127}));
  connect(source_1.ports[1], Pipe1.waterIn) annotation(
    Line(points = {{-60, -40}, {-36, -40}}, color = {0, 127, 255}, thickness = 0.5));
  connect(valve.port_b, Sink.ports[1]) annotation(
    Line(points = {{64, -60}, {80, -60}}, color = {0, 127, 255}));
end Heating_01;
