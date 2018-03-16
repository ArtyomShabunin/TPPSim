within TPPSim.Pipes.Tests;

model Heating "Модель прогрева паропроводов бл.9 ТЭЦ-22"
  package Medium = Modelica.Media.Water.StandardWater;
  Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium, T = 300 + 273.15, nPorts = 3, p = 1.013e5, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {66, -132}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  inner Modelica.Fluid.System system(T_start = 303.15) annotation(
    Placement(visible = true, transformation(origin = {134, 190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HP_pipe_1(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.hfrForPipeHeating Q_calc(section = section)), Din = 0.1645, Lpipe = 15.916, delta = 0.040, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 3, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {-40, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HP_pipe_2(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.hfrForPipeHeating Q_calc(section = section)), Din = 0.2139, Lpipe = 38.317, delta = 0.055, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 5, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {-8, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible heat_RS(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 75.82, dp_nominal = 200000, filteredOpening = false, m_flow_nominal = 6, p_nominal = 2e5, riseTime = 30) annotation(
    Placement(visible = true, transformation(origin = {52, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {28, 132}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant T(k = 300 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-138, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp D(duration = 20 * 60, height = 10, offset = 0.0005, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-138, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T source_1(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-86, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.pressure_control_2 HP_RS_control(P_activation = 120000, T = 5, k = 0.000001, pos_start = 0, set_p = 3.3e+06, speed_p = 30e5 / 60 / 20) annotation(
    Placement(visible = true, transformation(origin = {-12, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Fluid.Valves.ValveCompressible HP_RS(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1000, dp_nominal = 200000, m_flow_nominal = 6, p_nominal = 2e5) annotation(
    Placement(visible = true, transformation(origin = {-64, 88}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(k = false) annotation(
    Placement(visible = true, transformation(origin = {-22, 174}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Sensors.Pressure pressure1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-32, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe CRH_pipe_2(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.hfrForPipeHeating Q_calc(section = section)), Din = 0.398, Lpipe = 12.070, delta = 0.014, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 4, numberOfVolumes = 3, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {-22, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe CRH_pipe_1(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.hfrForPipeHeating Q_calc(section = section)), Din = 0.494, Lpipe = 113.845, delta = 0.018, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 3, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {42, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Valves.heatSource RH(redeclare package Medium = Medium, set_down_T = 573.15) annotation(
    Placement(visible = true, transformation(origin = {-88, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible HRH_RS(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 320, dp_nominal = 200000, m_flow_nominal = 6, p_nominal = 2e5) annotation(
    Placement(visible = true, transformation(origin = {-12, -92}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  TPPSim.Controls.pressure_control_2 HRH_control(P_activation = 1e+06, T = 1, k = 0.0000001, pos_start = 0, set_p = 800000, speed_p = 500) annotation(
    Placement(visible = true, transformation(origin = {-50, -130}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2(k = false) annotation(
    Placement(visible = true, transformation(origin = {-84, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure pressure2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-86, -66}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-94, -148}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HRH_pipe_1(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.hfrForPipeHeating Q_calc(section = section)), Din = 0.417, Lpipe = 61.1347, delta = 0.020, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 4, numberOfVolumes = 6, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {-94, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HRH_pipe_3(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.hfrForPipeHeating Q_calc(section = section)), Din = 0.560, Lpipe = 13.897, delta = 0.025, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 3, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {0, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HRH_pipe_2(redeclare TPPSim.Pipes.ElementarySteamPipe Pipe(redeclare TPPSim.thermal.hfrForPipeHeating Q_calc(section = section)), Din = 0.417, Lpipe = 57.617, delta = 0.020, h_start = 125.8e3, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 4, numberOfVolumes = 3, p_flow_start = 101300) annotation(
    Placement(visible = true, transformation(origin = {-30, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible drain_valve(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1730, dp_nominal = 6.987e+10, dp_start = 0, m_flow_nominal = 1.55555555555555555555555555, p_nominal = 8e5, rho_nominal = 3.085) annotation(
    Placement(visible = true, transformation(origin = {38, -66}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  TPPSim.Pipes.Drain drain3 annotation(
    Placement(visible = true, transformation(origin = {28, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.Drain drain4 annotation(
    Placement(visible = true, transformation(origin = {-62, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.Drain drain2 annotation(
    Placement(visible = true, transformation(origin = {-54, 4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.Drain drain1 annotation(
    Placement(visible = true, transformation(origin = {22, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature HP_temp(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {0, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature RH_temp(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {20, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature CRH_temp(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {44, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.Desuperheater RS_desuperheater(redeclare package Medium = Medium, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {94, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = Medium, T = 40 + 273.15, nPorts = 1, p = 2e5) annotation(
    Placement(visible = true, transformation(origin = {90, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  TPPSim.Sensors.Temperature CRH_temp_2(TemperatureType_set = TPPSim.Sensors.TemperatureType.saturation) annotation(
    Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
    Placement(visible = true, transformation(origin = {124, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const3(k = 40) annotation(
    Placement(visible = true, transformation(origin = {130, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(const1.y, drain_valve.opening) annotation(
    Line(points = {{-82, -148}, {20, -148}, {20, -66}, {30, -66}, {30, -66}}, color = {0, 0, 127}));
  connect(drain_valve.port_b, Sink.ports[3]) annotation(
    Line(points = {{38, -76}, {38, -80}, {66, -80}, {66, -122}}, color = {0, 127, 255}));
  connect(drain3.flowOut, drain_valve.port_a) annotation(
    Line(points = {{32, -38}, {35, -38}, {35, -36}, {38, -36}, {38, -56}}, color = {0, 127, 255}));
  connect(HRH_RS.port_b, Sink.ports[2]) annotation(
    Line(points = {{-2, -92}, {64, -92}, {64, -122}, {66, -122}}, color = {0, 127, 255}));
  connect(drain4.flowOut, HRH_RS.port_a) annotation(
    Line(points = {{-58, -38}, {-50, -38}, {-50, -92}, {-22, -92}}, color = {0, 127, 255}));
  connect(HRH_control.y, HRH_RS.opening) annotation(
    Line(points = {{-39, -130}, {-11.5, -130}, {-11.5, -100}, {-12, -100}}, color = {0, 0, 127}));
  connect(const1.y, HRH_control.u3) annotation(
    Line(points = {{-83, -148}, {-79, -148}, {-79, -130}, {-71.5, -130}, {-71.5, -132}, {-66.75, -132}, {-66.75, -132}, {-62, -132}}, color = {0, 0, 127}));
  connect(const1.y, HRH_control.u1) annotation(
    Line(points = {{-83, -148}, {-71, -148}, {-71, -134}, {-66.5, -134}, {-66.5, -136}, {-65.25, -136}, {-65.25, -136}, {-62, -136}}, color = {0, 0, 127}));
  connect(booleanConstant2.y, HRH_control.u4) annotation(
    Line(points = {{-73, -110}, {-67, -110}, {-67, -110}, {-59, -110}, {-59, -116}, {-59, -116}, {-59, -118}, {-57, -118}, {-57, -118}, {-55, -118}}, color = {255, 0, 255}));
  connect(pressure2.p, HRH_control.u2) annotation(
    Line(points = {{-97, -66}, {-105, -66}, {-105, -124}, {-62, -124}}, color = {0, 0, 127}));
  connect(add1.y, RS_desuperheater.T_in) annotation(
    Line(points = {{124, -5}, {123, -5}, {123, 3}, {124, 3}, {124, 81}, {94, 81}, {94, 69}, {92, 69}, {92, 67}, {94, 67}}, color = {0, 0, 127}));
  connect(CRH_temp_2.deltaTs, add1.u1) annotation(
    Line(points = {{107, -40}, {118, -40}, {118, -28}}, color = {0, 0, 127}));
  connect(const3.y, add1.u2) annotation(
    Line(points = {{130, -45}, {130, -28}}, color = {0, 0, 127}));
  connect(boundary.ports[1], RS_desuperheater.waterIn) annotation(
    Line(points = {{90, 44}, {90, 48}}, color = {0, 127, 255}, thickness = 0.5));
  connect(const.y, heat_RS.opening) annotation(
    Line(points = {{18, 132}, {12, 132}, {12, 90}, {52, 90}, {52, 66}, {52, 66}}, color = {0, 0, 127}));
  connect(drain1.flowOut, heat_RS.port_a) annotation(
    Line(points = {{26, 58}, {42, 58}}, color = {0, 127, 255}));
  connect(heat_RS.port_b, RS_desuperheater.flowIn) annotation(
    Line(points = {{62, 58}, {84, 58}}, color = {0, 127, 255}));
  connect(HP_RS.port_b, Sink.ports[1]) annotation(
    Line(points = {{-64, 98}, {-64, 102}, {144, 102}, {144, -100}, {68, -100}, {68, -122}, {66, -122}}, color = {0, 127, 255}));
  connect(HP_RS_control.y, HP_RS.opening) annotation(
    Line(points = {{-23, 136}, {-45, 136}, {-45, 88}, {-56, 88}}, color = {0, 0, 127}));
  connect(HP_pipe_1.waterIn, HP_RS.port_a) annotation(
    Line(points = {{-52, 58}, {-54, 58}, {-54, 60}, {-64, 60}, {-64, 78}}, color = {0, 127, 255}));
  connect(CRH_pipe_1.waterIn, CRH_temp_2.port) annotation(
    Line(points = {{54, 8}, {54, 8}, {54, -36}, {82, -36}, {82, -50}, {100, -50}, {100, -50}, {100, -50}, {100, -50}}, color = {0, 127, 255}));
  connect(CRH_pipe_1.waterIn, RS_desuperheater.flowOut) annotation(
    Line(points = {{54, 8}, {104, 8}, {104, 33}, {104, 33}, {104, 58}}, color = {0, 127, 255}));
  connect(CRH_pipe_1.waterIn, CRH_temp.port) annotation(
    Line(points = {{54, 8}, {54, 8}, {54, -24}, {44, -24}, {44, -24}, {44, -24}, {44, -24}}, color = {0, 127, 255}));
  connect(HRH_pipe_3.waterOut, RH_temp.port) annotation(
    Line(points = {{12.1, -38}, {18.1, -38}, {18.1, -24}, {19.1, -24}, {19.1, -24}, {20.1, -24}}, color = {0, 127, 255}));
  connect(HP_pipe_2.waterOut, HP_temp.port) annotation(
    Line(points = {{4.1, 58}, {7.1, 58}, {7.1, 60}, {8.1, 60}, {8.1, 68}, {-1.9, 68}, {-1.9, 68}, {0.0999996, 68}, {0.0999996, 68}}, color = {0, 127, 255}));
  connect(HP_pipe_2.waterOut, drain1.flowIn) annotation(
    Line(points = {{4.1, 58}, {18.1, 58}}, color = {0, 127, 255}));
  connect(CRH_pipe_2.waterOut, drain2.flowIn) annotation(
    Line(points = {{-34.1, 8}, {-50, 8}}, color = {0, 127, 255}));
  connect(drain2.flowOut, RH.flowIn) annotation(
    Line(points = {{-58, 8}, {-78, 8}}, color = {0, 127, 255}));
  connect(HRH_pipe_1.waterOut, drain4.flowIn) annotation(
    Line(points = {{-81.9, -38}, {-65.9, -38}}, color = {0, 127, 255}));
  connect(drain4.flowOut, HRH_pipe_2.waterIn) annotation(
    Line(points = {{-58, -38}, {-42, -38}}, color = {0, 127, 255}));
  connect(HRH_pipe_3.waterOut, drain3.flowIn) annotation(
    Line(points = {{12.1, -38}, {24.2, -38}}, color = {0, 127, 255}));
  connect(HRH_pipe_2.waterOut, HRH_pipe_3.waterIn) annotation(
    Line(points = {{-17.9, -38}, {-12, -38}}, color = {0, 127, 255}));
  connect(HRH_pipe_1.waterOut, pressure2.port) annotation(
    Line(points = {{-81.9, -38}, {-73.9, -38}, {-73.9, -76}, {-85.9, -76}, {-85.9, -76}, {-85.9, -76}, {-85.9, -76}}, color = {0, 127, 255}));
  connect(RH.flowOut, HRH_pipe_1.waterIn) annotation(
    Line(points = {{-98, 8}, {-110, 8}, {-110, -38}, {-106, -38}}, color = {0, 127, 255}));
  connect(CRH_pipe_1.waterOut, CRH_pipe_2.waterIn) annotation(
    Line(points = {{29.9, 8}, {-10.2, 8}}, color = {0, 127, 255}));
  connect(pressure1.p, HP_RS_control.u2) annotation(
    Line(points = {{-21, 82}, {-13, 82}, {-13, 108}, {49, 108}, {49, 152}, {11, 152}, {11, 142}, {1, 142}, {1, 142}, {-1, 142}, {-1, 142}}, color = {0, 0, 127}));
  connect(HP_pipe_1.waterIn, pressure1.port) annotation(
    Line(points = {{-52, 58}, {-52, 65}, {-52, 65}, {-52, 72}, {-32, 72}}, color = {0, 127, 255}));
  connect(booleanConstant1.y, HP_RS_control.u4) annotation(
    Line(points = {{-22, 163}, {-22, 157}, {-7, 157}, {-7, 148}}, color = {255, 0, 255}));
  connect(const.y, HP_RS_control.u1) annotation(
    Line(points = {{17, 132}, {11, 132}, {11, 130}, {-1, 130}}, color = {0, 0, 127}));
  connect(const.y, HP_RS_control.u3) annotation(
    Line(points = {{17, 132}, {11, 132}, {11, 134}, {-1, 134}}, color = {0, 0, 127}));
  connect(D.y, source_1.m_flow_in) annotation(
    Line(points = {{-127, 90}, {-113, 90}, {-113, 66}, {-95, 66}, {-95, 66}, {-97, 66}, {-97, 66}}, color = {0, 0, 127}));
  connect(T.y, source_1.T_in) annotation(
    Line(points = {{-127, 62}, {-99, 62}, {-99, 62}, {-99, 62}}, color = {0, 0, 127}));
  connect(source_1.ports[1], HP_pipe_1.waterIn) annotation(
    Line(points = {{-76, 58}, {-52, 58}}, color = {0, 127, 255}, thickness = 0.5));
  connect(HP_pipe_1.waterOut, HP_pipe_2.waterIn) annotation(
    Line(points = {{-27.9, 58}, {-19.9, 58}}, color = {0, 127, 255}));
  annotation(
    Documentation(info = "<html><head></head><body>
      Расчет прогрева паропроводов блока №9 ТЭЦ-22
      </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>Match 07, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Diagram(coordinateSystem(extent = {{-150, -200}, {150, 200}}, initialScale = 0.1), graphics = {Rectangle(origin = {-11, 152}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-69, 38}, {69, -38}}), Text(origin = {-57, 158}, extent = {{23, -8}, {-19, 2}}, textString = "Регулятор БРОУ ВД", fontSize = 4), Rectangle(origin = {-80, 93}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Solid, extent = {{28, -17}, {-28, 17}}), Text(origin = {-93, 106}, extent = {{23, -8}, {-19, 2}}, textString = "БРОУ ВД", fontSize = 4), Rectangle(origin = {59, 70}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Solid, extent = {{-21, 28}, {59, -52}}), Text(origin = {75, 96}, extent = {{23, -8}, {-19, 2}}, textString = "Растопочное РОУ", fontSize = 4), Rectangle(origin = {119, -48}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-31, 46}, {31, -46}}), Text(origin = {113, -78}, extent = {{21, -10}, {-19, 2}}, textString = "Регулятор\nтемпературы пара\nза пусковым РОУ", fontSize = 4), Rectangle(origin = {-74, -135}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 41}, {40, -41}}), Text(origin = {-77, -166}, extent = {{23, -8}, {-19, 2}}, textString = "Регулятор БРОУ ГПП", fontSize = 4), Rectangle(origin = {-13, -84}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Solid, extent = {{-19, 22}, {19, -22}}), Text(origin = {-17, -66}, extent = {{23, -8}, {-19, 2}}, textString = "БРОУ ГПП", fontSize = 4), Rectangle(origin = {48, -72}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Solid, extent = {{-34, 18}, {34, -18}}), Text(origin = {43, -82}, extent = {{23, -8}, {-19, 2}}, textString = "Линия обеспаривания", fontSize = 4)}),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    __OpenModelica_commandLineOptions = "");
end Heating;
