within TPPSim.Pipes.Tests;
model Heating
  package Medium = Modelica.Media.Water.StandardWater;
  Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium, T = 300 + 273.15, nPorts = 3, p = 1.013e5, use_T = true, use_p = true)  annotation(
    Placement(visible = true, transformation(origin = {90, -170}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe1(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForPipeHeating alpha(section = section)), Din = 0.1645, Lpipe = 15.916, delta = 0.040, h_start = 251.2e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 1, p_flow_start = 101300)  annotation(
    Placement(visible = true, transformation(origin = {-24, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe3(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForPipeHeating alpha(section = section)), Din = 0.2139, Lpipe = 38.317, delta = 0.055, h_start = 251.2e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 5, p_flow_start = 101300)  annotation(
    Placement(visible = true, transformation(origin = {14, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible valve(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 75.82, dp_nominal = 200000, filteredOpening = false, m_flow_nominal = 6, p_nominal = 2e5, riseTime = 30) annotation(
    Placement(visible = true, transformation(origin = {58, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {34, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T(k = 300 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-70, 66}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp D(duration = 20 * 60, height = 27, offset = 0.0005, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T source_1(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_m_flow_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.pressure_control_2 pressure_control(P_activation = 120000, T = 5, k = 0.000001, pos_start = 0, set_p = 3.3e+06, speed_p = 30e5 / 60 / 20)  annotation(
    Placement(visible = true, transformation(origin = {30, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Fluid.Valves.ValveCompressible valveCompressible1(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 450, dp_nominal = 200000, m_flow_nominal = 6, p_nominal = 2e5) annotation(
    Placement(visible = true, transformation(origin = {-40, 26}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(k = false)  annotation(
    Placement(visible = true, transformation(origin = {-10, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure pressure1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {4, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.Drain drain1 annotation(
    Placement(visible = true, transformation(origin = {38, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe6(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForPipeHeating alpha(section = section)), Din = 0.398, Lpipe = 12.070, delta = 0.014, h_start = 251.2e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 4, numberOfVolumes = 1, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {-6, -66}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe4(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForPipeHeating alpha(section = section)), Din = 0.494, Lpipe = 113.845, delta = 0.018, h_start = 251.2e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 1, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {34, -66}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Valves.heatSource RH11(redeclare package Medium = Medium, set_down_T = 573.15) annotation(
    Placement(visible = true, transformation(origin = {-72, -66}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.Drain drain2 annotation(
    Placement(visible = true, transformation(origin = {-38, -70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible valveCompressible2(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 320, dp_nominal = 200000, m_flow_nominal = 6, p_nominal = 2e5) annotation(
    Placement(visible = true, transformation(origin = {22, -194}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  TPPSim.Controls.pressure_control_2 pressure_control_21(P_activation = 120000, T = 5, k = 0.0000001, pos_start = 0, set_p = 800000, speed_p = 500) annotation(
    Placement(visible = true, transformation(origin = {-18, -198}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2(k = false) annotation(
    Placement(visible = true, transformation(origin = {-78, -202}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure pressure2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {22, -136}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-58, -244}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe10(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForPipeHeating alpha(section = section)), Din = 0.417, Lpipe = 61.1347, delta = 0.020, h_start = 251.2e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 4, numberOfVolumes = 6, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {-62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe19(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForPipeHeating alpha(section = section)), Din = 0.560, Lpipe = 13.897, delta = 0.025, h_start = 251.2e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 3, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {20, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe Pipe15(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForPipeHeating alpha(section = section)), Din = 0.417, Lpipe = 57.617, delta = 0.020, h_start = 251.2e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 4, numberOfVolumes = 2, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {-14, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible valveCompressible3(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 50, dp_nominal = 200000, m_flow_nominal = 6, p_nominal = 2e5) annotation(
    Placement(visible = true, transformation(origin = {54, -130}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  TPPSim.Pipes.Drain drain3 annotation(
    Placement(visible = true, transformation(origin = {44, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(drain3.flowOut, valveCompressible3.port_a) annotation(
    Line(points = {{48, -104}, {54, -104}, {54, -120}, {54, -120}}, color = {0, 127, 255}));
  connect(Pipe19.waterOut, drain3.flowIn) annotation(
    Line(points = {{32.1, -104}, {40.1, -104}, {40.1, -104}, {40.1, -104}}, color = {0, 127, 255}));
  connect(valveCompressible3.port_b, Sink.ports[3]) annotation(
    Line(points = {{54, -140}, {54, -170}, {80, -170}}, color = {0, 127, 255}));
  connect(const1.y, valveCompressible3.opening) annotation(
    Line(points = {{-47, -244}, {-24.5, -244}, {-24.5, -244}, {-2, -244}, {-2, -244}, {41, -244}, {41, -130}, {45, -130}}, color = {0, 0, 127}));
  connect(Pipe10.waterOut, Pipe15.waterIn) annotation(
    Line(points = {{-49.9, -104}, {-26, -104}}, color = {0, 127, 255}));
  connect(Pipe15.waterOut, Pipe19.waterIn) annotation(
    Line(points = {{-1.9, -104}, {8, -104}}, color = {0, 127, 255}));
  connect(Pipe10.waterOut, valveCompressible2.port_a) annotation(
    Line(points = {{-49.9, -104}, {-39.9, -104}, {-39.9, -160}, {20, -160}, {20, -172}, {22, -172}, {22, -184}}, color = {0, 127, 255}));
  connect(Pipe10.waterOut, pressure2.port) annotation(
    Line(points = {{-49.9, -104}, {-33.9, -104}, {-33.9, -146}, {22, -146}}, color = {0, 127, 255}));
  connect(RH11.flowOut, Pipe10.waterIn) annotation(
    Line(points = {{-82, -66}, {-94, -66}, {-94, -104}, {-74, -104}}, color = {0, 127, 255}));
  connect(const1.y, pressure_control_21.u1) annotation(
    Line(points = {{-47, -244}, {-45, -244}, {-45, -244}, {-43, -244}, {-43, -244}, {-39, -244}, {-39, -204}, {-30, -204}}, color = {0, 0, 127}));
  connect(const1.y, pressure_control_21.u3) annotation(
    Line(points = {{-47, -244}, {-45, -244}, {-45, -244}, {-45, -244}, {-45, -200}, {-36.5, -200}, {-36.5, -200}, {-33.25, -200}, {-33.25, -200}, {-30, -200}}, color = {0, 0, 127}));
  connect(pressure2.p, pressure_control_21.u2) annotation(
    Line(points = {{33, -136}, {32.5, -136}, {32.5, -136}, {34, -136}, {34, -170}, {-42, -170}, {-42, -192}, {-37, -192}, {-37, -192}, {-34.5, -192}, {-34.5, -192}, {-30, -192}}, color = {0, 0, 127}));
  connect(booleanConstant2.y, pressure_control_21.u4) annotation(
    Line(points = {{-67, -202}, {-65, -202}, {-65, -202}, {-65, -202}, {-65, -202}, {-59, -202}, {-59, -172}, {-27, -172}, {-27, -186}, {-27, -186}, {-27, -186}, {-26, -186}, {-26, -186}, {-23.5, -186}, {-23.5, -186}, {-23, -186}}, color = {255, 0, 255}));
  connect(pressure_control_21.y, valveCompressible2.opening) annotation(
    Line(points = {{-7, -198}, {-2, -198}, {-2, -198}, {3, -198}, {3, -194}, {8, -194}, {8, -194}, {13, -194}}, color = {0, 0, 127}));
  connect(valveCompressible2.port_b, Sink.ports[2]) annotation(
    Line(points = {{22, -204}, {22, -220}, {60, -220}, {60, -174}, {80, -174}, {80, -170}}, color = {0, 127, 255}));
  connect(drain2.flowOut, RH11.flowIn) annotation(
    Line(points = {{-42, -66}, {-62, -66}}, color = {0, 127, 255}));
  connect(Pipe6.waterOut, drain2.flowIn) annotation(
    Line(points = {{-18.1, -66}, {-34, -66}}, color = {0, 127, 255}));
  connect(valve.port_b, Pipe4.waterIn) annotation(
    Line(points = {{68, -26}, {80, -26}, {80, -66}, {46, -66}}, color = {0, 127, 255}));
  connect(Pipe4.waterOut, Pipe6.waterIn) annotation(
    Line(points = {{21.9, -66}, {5.9, -66}}, color = {0, 127, 255}));
  connect(valveCompressible1.port_b, Sink.ports[1]) annotation(
    Line(points = {{-40, 36}, {-40, 52}, {80, 52}, {80, -170}}, color = {0, 127, 255}));
  connect(D.y, source_1.m_flow_in) annotation(
    Line(points = {{-81, 30}, {-89, 30}, {-89, -18}, {-80, -18}}, color = {0, 0, 127}));
  connect(source_1.ports[1], Pipe1.waterIn) annotation(
    Line(points = {{-60, -26}, {-36, -26}}, color = {0, 127, 255}, thickness = 0.5));
  connect(T.y, source_1.T_in) annotation(
    Line(points = {{-81, 66}, {-95, 66}, {-95, -22}, {-82, -22}}, color = {0, 0, 127}));
  connect(Pipe1.waterIn, pressure1.port) annotation(
    Line(points = {{-36, -26}, {-36, 6}, {4, 6}}, color = {0, 127, 255}));
  connect(Pipe1.waterIn, valveCompressible1.port_a) annotation(
    Line(points = {{-36, -26}, {-40, -26}, {-40, 16}}, color = {0, 127, 255}));
  connect(Pipe1.waterOut, Pipe3.waterIn) annotation(
    Line(points = {{-12, -26}, {2, -26}}, color = {0, 127, 255}));
  connect(drain1.flowOut, valve.port_a) annotation(
    Line(points = {{42, -26}, {48, -26}, {48, -26}, {48, -26}}, color = {0, 127, 255}));
  connect(Pipe3.waterOut, drain1.flowIn) annotation(
    Line(points = {{26, -26}, {34, -26}, {34, -26}, {34, -26}}, color = {0, 127, 255}));
  connect(const.y, valve.opening) annotation(
    Line(points = {{46, 4}, {58, 4}, {58, -18}}, color = {0, 0, 127}));
  connect(pressure1.p, pressure_control.u2) annotation(
    Line(points = {{15, 16}, {69, 16}, {69, 44}, {41, 44}, {41, 44}, {41, 44}, {41, 44}}, color = {0, 0, 127}));
  connect(pressure_control.y, valveCompressible1.opening) annotation(
    Line(points = {{19, 38}, {12, 38}, {12, 40}, {3, 40}, {3, 40}, {-11, 40}, {-11, 26}, {-33, 26}, {-33, 28}, {-35, 28}, {-35, 27}, {-33, 27}, {-33, 26}}, color = {0, 0, 127}));
  connect(booleanConstant1.y, pressure_control.u4) annotation(
    Line(points = {{2, 72}, {35, 72}, {35, 50}}, color = {255, 0, 255}));
  connect(const.y, pressure_control.u1) annotation(
    Line(points = {{45, 4}, {53, 4}, {53, 32}, {41, 32}, {41, 32}, {41, 32}, {41, 32}}, color = {0, 0, 127}));
  connect(const.y, pressure_control.u3) annotation(
    Line(points = {{45, 4}, {61, 4}, {61, 36}, {43, 36}, {43, 37}, {41, 37}, {41, 36}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -300}, {100, 100}})),
    Icon(coordinateSystem(extent = {{-100, -300}, {100, 100}})),
    __OpenModelica_commandLineOptions = "");end Heating;
