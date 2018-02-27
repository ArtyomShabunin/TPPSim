within TPPSim.Pipes.Tests;

model Heating
  package Medium = Modelica.Media.Water.StandardWater;
  Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium, T = 300 + 273.15, nPorts = 3, p = 1.013e5, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {90, -170}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system(T_start = 303.15) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HP_pipe_1(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForSHandECO alpha), Din = 0.1645, Lpipe = 15.916, delta = 0.040, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 3, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {-24, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HP_pipe_2(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForSHandECO alpha), Din = 0.2139, Lpipe = 38.317, delta = 0.055, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 5, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {8, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible heat_RS(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 75.82, dp_nominal = 200000, filteredOpening = false, m_flow_nominal = 6, p_nominal = 2e5, riseTime = 30) annotation(
    Placement(visible = true, transformation(origin = {58, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {38, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T(k = 300 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-70, 66}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp D(duration = 20 * 60, height = 27, offset = 0.0005, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T source_1(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-70, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.pressure_control_2 HP_RS_control(P_activation = 120000, T = 5, k = 0.000001, pos_start = 0, set_p = 1e+06, speed_p = 30e5 / 60 / 20) annotation(
    Placement(visible = true, transformation(origin = {30, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Fluid.Valves.ValveCompressible HP_RS(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1000, dp_nominal = 200000, m_flow_nominal = 6, p_nominal = 2e5) annotation(
    Placement(visible = true, transformation(origin = {-40, 26}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(k = false) annotation(
    Placement(visible = true, transformation(origin = {-10, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure pressure1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {4, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe CRH_pipe_2(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForSHandECO alpha), Din = 0.398, Lpipe = 12.070, delta = 0.014, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 4, numberOfVolumes = 3, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {-6, -58}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe CRH_pipe_1(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForSHandECO alpha), Din = 0.494, Lpipe = 113.845, delta = 0.018, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 3, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {34, -58}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Valves.heatSource RH(redeclare package Medium = Medium, set_down_T = 573.15) annotation(
    Placement(visible = true, transformation(origin = {-72, -58}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible HRH_RS(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 320, dp_nominal = 200000, m_flow_nominal = 6, p_nominal = 2e5) annotation(
    Placement(visible = true, transformation(origin = {24, -194}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  TPPSim.Controls.pressure_control_2 HRH_control(P_activation = 120000, T = 1, k = 0.0000001, pos_start = 0, set_p = 800000, speed_p = 500) annotation(
    Placement(visible = true, transformation(origin = {-18, -194}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2(k = false) annotation(
    Placement(visible = true, transformation(origin = {-78, -202}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure pressure2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {22, -136}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-58, -244}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HRH_pipe_1(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForSHandECO alpha), Din = 0.417, Lpipe = 61.1347, delta = 0.020, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 4, numberOfVolumes = 6, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {-76, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HRH_pipe_3(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForSHandECO alpha), Din = 0.560, Lpipe = 13.897, delta = 0.025, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 3, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {16, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HRH_pipe_2(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.alfaForSHandECO alpha), Din = 0.417, Lpipe = 57.617, delta = 0.020, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 4, numberOfVolumes = 3, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {-14, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible drain_valve(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 2000, dp_nominal = 6.987e+10, dp_start = 0, m_flow_nominal = 1.55555555555555555555555555, p_nominal = 8e5, rho_nominal = 3.085) annotation(
    Placement(visible = true, transformation(origin = {54, -130}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const2(k = 1) annotation(
    Placement(visible = true, transformation(origin = {86, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Drain drain3 annotation(
    Placement(visible = true, transformation(origin = {44, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Drain drain4 annotation(
    Placement(visible = true, transformation(origin = {-44, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.Drain drain2 annotation(
    Placement(visible = true, transformation(origin = {-38, -62}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.Drain drain1 annotation(
    Placement(visible = true, transformation(origin = {38, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature HP_temp(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {16, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature RH_temp(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {36, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(HRH_pipe_3.waterOut, RH_temp.port) annotation(
    Line(points = {{28, -104}, {36, -104}, {36, -90}, {36, -90}}, color = {0, 127, 255}));
  connect(HRH_pipe_2.waterOut, HRH_pipe_3.waterIn) annotation(
    Line(points = {{-1.9, -104}, {4, -104}}, color = {0, 127, 255}));
  connect(HRH_pipe_3.waterOut, drain3.flowIn) annotation(
    Line(points = {{28, -104}, {40.1, -104}}, color = {0, 127, 255}));
  connect(CRH_pipe_2.waterOut, drain2.flowIn) annotation(
    Line(points = {{-18.1, -58}, {-34, -58}}, color = {0, 127, 255}));
  connect(drain2.flowOut, RH.flowIn) annotation(
    Line(points = {{-42, -58}, {-62, -58}}, color = {0, 127, 255}));
  connect(RH.flowOut, HRH_pipe_1.waterIn) annotation(
    Line(points = {{-82, -58}, {-94, -58}, {-94, -104}, {-88, -104}}, color = {0, 127, 255}));
  connect(CRH_pipe_1.waterOut, CRH_pipe_2.waterIn) annotation(
    Line(points = {{21.9, -58}, {5.9, -58}}, color = {0, 127, 255}));
  connect(heat_RS.port_b, CRH_pipe_1.waterIn) annotation(
    Line(points = {{68, -26}, {80, -26}, {80, -58}, {46, -58}}, color = {0, 127, 255}));
  connect(HP_pipe_2.waterOut, HP_temp.port) annotation(
    Line(points = {{20, -26}, {26, -26}, {26, -16}, {16, -16}, {16, -16}}, color = {0, 127, 255}));
  connect(const.y, HP_RS_control.u3) annotation(
    Line(points = {{49, 10}, {61, 10}, {61, 36}, {43, 36}, {43, 37}, {41, 37}, {41, 36}}, color = {0, 0, 127}));
  connect(const.y, HP_RS_control.u1) annotation(
    Line(points = {{49, 10}, {53, 10}, {53, 32}, {41, 32}}, color = {0, 0, 127}));
  connect(HP_pipe_1.waterOut, HP_pipe_2.waterIn) annotation(
    Line(points = {{-12, -26}, {-4, -26}}, color = {0, 127, 255}));
  connect(HP_pipe_2.waterOut, drain1.flowIn) annotation(
    Line(points = {{20, -26}, {34, -26}}, color = {0, 127, 255}));
  connect(drain1.flowOut, heat_RS.port_a) annotation(
    Line(points = {{42, -26}, {48, -26}, {48, -26}, {48, -26}}, color = {0, 127, 255}));
  connect(T.y, source_1.T_in) annotation(
    Line(points = {{-81, 66}, {-95, 66}, {-95, -22}, {-82, -22}}, color = {0, 0, 127}));
  connect(source_1.ports[1], HP_pipe_1.waterIn) annotation(
    Line(points = {{-60, -26}, {-36, -26}}, color = {0, 127, 255}, thickness = 0.5));
  connect(D.y, source_1.m_flow_in) annotation(
    Line(points = {{-81, 30}, {-89, 30}, {-89, -18}, {-80, -18}}, color = {0, 0, 127}));
  connect(HRH_pipe_1.waterOut, drain4.flowIn) annotation(
    Line(points = {{-64, -104}, {-48, -104}, {-48, -104}, {-48, -104}}, color = {0, 127, 255}));
  connect(drain4.flowOut, HRH_pipe_2.waterIn) annotation(
    Line(points = {{-40, -104}, {-26, -104}, {-26, -104}, {-26, -104}}, color = {0, 127, 255}));
  connect(drain4.flowOut, HRH_RS.port_a) annotation(
    Line(points = {{-40, -104}, {-32, -104}, {-32, -158}, {24, -158}, {24, -184}, {24, -184}}, color = {0, 127, 255}));
  connect(drain3.flowOut, drain_valve.port_a) annotation(
    Line(points = {{48, -104}, {54, -104}, {54, -120}, {54, -120}}, color = {0, 127, 255}));
  connect(const2.y, heat_RS.opening) annotation(
    Line(points = {{98, 2}, {94, 2}, {94, -14}, {58, -14}, {58, -18}, {58, -18}}, color = {0, 0, 127}));
  connect(HRH_pipe_1.waterOut, pressure2.port) annotation(
    Line(points = {{-64, -104}, {-52, -104}, {-52, -146}, {22, -146}, {22, -146}}, color = {0, 127, 255}));
  connect(HRH_control.y, HRH_RS.opening) annotation(
    Line(points = {{-7, -194}, {16, -194}}, color = {0, 0, 127}));
  connect(booleanConstant2.y, HRH_control.u4) annotation(
    Line(points = {{-67, -202}, {-59, -202}, {-59, -172}, {-27, -172}, {-27, -182}, {-23, -182}}, color = {255, 0, 255}));
  connect(pressure2.p, HRH_control.u2) annotation(
    Line(points = {{33, -136}, {34, -136}, {34, -170}, {-42, -170}, {-42, -188}, {-30, -188}}, color = {0, 0, 127}));
  connect(const1.y, HRH_control.u3) annotation(
    Line(points = {{-47, -244}, {-45, -244}, {-45, -196}, {-30, -196}}, color = {0, 0, 127}));
  connect(const1.y, HRH_control.u1) annotation(
    Line(points = {{-47, -244}, {-39, -244}, {-39, -200}, {-30, -200}}, color = {0, 0, 127}));
  connect(HRH_RS.port_b, Sink.ports[2]) annotation(
    Line(points = {{24, -204}, {24, -220}, {60, -220}, {60, -174}, {80, -174}, {80, -170}}, color = {0, 127, 255}));
  connect(drain_valve.port_b, Sink.ports[3]) annotation(
    Line(points = {{54, -140}, {54, -170}, {80, -170}}, color = {0, 127, 255}));
  connect(const1.y, drain_valve.opening) annotation(
    Line(points = {{-47, -244}, {-24.5, -244}, {-24.5, -244}, {-2, -244}, {-2, -244}, {41, -244}, {41, -130}, {45, -130}}, color = {0, 0, 127}));
  connect(HP_RS.port_b, Sink.ports[1]) annotation(
    Line(points = {{-40, 36}, {-40, 52}, {80, 52}, {80, -170}}, color = {0, 127, 255}));
  connect(HP_pipe_1.waterIn, pressure1.port) annotation(
    Line(points = {{-36, -26}, {-36, 6}, {4, 6}}, color = {0, 127, 255}));
  connect(HP_pipe_1.waterIn, HP_RS.port_a) annotation(
    Line(points = {{-36, -26}, {-40, -26}, {-40, 16}}, color = {0, 127, 255}));
  connect(pressure1.p, HP_RS_control.u2) annotation(
    Line(points = {{15, 16}, {69, 16}, {69, 44}, {41, 44}, {41, 44}, {41, 44}, {41, 44}}, color = {0, 0, 127}));
  connect(HP_RS_control.y, HP_RS.opening) annotation(
    Line(points = {{19, 38}, {12, 38}, {12, 40}, {3, 40}, {3, 40}, {-11, 40}, {-11, 26}, {-33, 26}, {-33, 28}, {-35, 28}, {-35, 27}, {-33, 27}, {-33, 26}}, color = {0, 0, 127}));
  connect(booleanConstant1.y, HP_RS_control.u4) annotation(
    Line(points = {{2, 72}, {35, 72}, {35, 50}}, color = {255, 0, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -300}, {100, 100}})),
    Icon(coordinateSystem(extent = {{-100, -300}, {100, 100}})),
    __OpenModelica_commandLineOptions = "");
end Heating;
