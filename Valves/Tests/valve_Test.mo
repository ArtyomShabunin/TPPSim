within TPPSim.Valves.Tests;
model valve_Test
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  Modelica.Fluid.Sources.Boundary_pT flowOut(redeclare package Medium = Medium, T = 300 + 273.15, nPorts = 1, p = 30e5, use_T_in = true, use_p_in = true) annotation(
    Placement(visible = true, transformation(origin = {70, -28}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = {2, 3, 4, 5, 6, 7, 8, 9},fileName = "C:/Users/User/Documents/TPPSim/Valves/Tests/pos_BROU_HP.txt", tableName = "tabl", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-64, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  Modelica.Fluid.Sources.Boundary_pT flowIn(redeclare package Medium = Medium, T = 500 + 273.15, nPorts = 1, p = 129e5, use_T_in = true, use_p_in = true) annotation(
  //    Placement(visible = true, transformation(origin = {-70, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {28, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Water.SteamTurbineStodola steamTurbine(Kt = 0.0038, PRstart = 1, eta_iso_nom = 0.9, pnom = 130e5, wnom = 77)  annotation(
    Placement(visible = true, transformation(origin = {30, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed1(w_fixed = Modelica.Constants.pi * 50)  annotation(
    Placement(visible = true, transformation(origin = {58, -90}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible valveCompressible1(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1200, dp_nominal = 9e+06) annotation(
    Placement(visible = true, transformation(origin = {-2, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort1(redeclare package Medium = Medium, nPorts_b = 2)  annotation(
    Placement(visible = true, transformation(origin = {-30, -28}, extent = {{-4, -10}, {4, 10}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort2(redeclare package Medium = Medium, nPorts_b = 2)  annotation(
    Placement(visible = true, transformation(origin = {46, -28}, extent = {{4, -10}, {-4, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {66, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.ReducingStation reducingStation1(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 600, dp_nominal = 9e+06, min_delta = 90, p_nominal = 1.3e+07, set_down_T = 573.15, use_T_in = true)  annotation(
    Placement(visible = true, transformation(origin = {4, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT waterIn(redeclare package Medium = Medium, T = 140 + 273.15, nPorts = 1, p = 3e5)  annotation(
    Placement(visible = true, transformation(origin = {-70, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 300 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-10, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure pressure1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-12, -12}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flowIn(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-70, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.pressure_control_2 pressure_control1(set_p = 6.7e+06, speed_p = 1e5 / 60)   annotation(
    Placement(visible = true, transformation(origin = {30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(valveCompressible1.opening_actual, pressure_control1.u3) annotation(
    Line(points = {{6, -76}, {16, -76}, {16, 52}, {10, 52}, {10, 68}, {10, 68}, {10, 72}, {18, 72}, {18, 72}}, color = {0, 0, 127}));
  connect(reducingStation1.opening_actual, pressure_control1.u1) annotation(
    Line(points = {{6, -24}, {54, -24}, {54, 88}, {6, 88}, {6, 76}, {18, 76}, {18, 76}}, color = {0, 0, 127}));
  connect(pressure_control1.y, reducingStation1.opening) annotation(
    Line(points = {{42, 70}, {50, 70}, {50, -12}, {28, -12}, {28, -14}, {0, -14}, {0, -20}, {0, -20}}, color = {0, 0, 127}));
  connect(pressure1.p, pressure_control1.u2) annotation(
    Line(points = {{-6, -12}, {6, -12}, {6, 64}, {18, 64}, {18, 64}}, color = {0, 0, 127}));
  connect(combiTimeTable1.y[7], flowIn.m_flow_in) annotation(
    Line(points = {{-52, 22}, {-46, 22}, {-46, -4}, {-82, -4}, {-82, -20}, {-80, -20}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[3], flowIn.T_in) annotation(
    Line(points = {{-52, 22}, {-50, 22}, {-50, 0}, {-92, 0}, {-92, -24}, {-82, -24}, {-82, -24}}, color = {0, 0, 127}, thickness = 0.5));
  connect(flowIn.ports[1], multiPort1.port_a) annotation(
    Line(points = {{-60, -28}, {-34, -28}}, color = {0, 127, 255}, thickness = 0.5));
  connect(reducingStation1.flowIn, pressure1.port) annotation(
    Line(points = {{-6, -28}, {-12, -28}, {-12, -18}, {-12, -18}}, color = {0, 127, 255}));
  connect(const.y, reducingStation1.T_in) annotation(
    Line(points = {{1, 32}, {13, 32}, {13, -20}, {11, -20}, {11, -20}, {11, -20}}, color = {0, 0, 127}));
  connect(waterIn.ports[1], reducingStation1.waterIn) annotation(
    Line(points = {{-60, -64}, {-48, -64}, {-48, -38}, {8, -38}, {8, -38}}, color = {0, 127, 255}, thickness = 0.5));
  connect(multiPort1.ports_b[2], reducingStation1.flowIn) annotation(
    Line(points = {{-26, -28}, {-6, -28}, {-6, -28}, {-6, -28}}, color = {0, 127, 255}, thickness = 0.5));
  connect(reducingStation1.flowOut, multiPort2.ports_b[2]) annotation(
    Line(points = {{14, -28}, {42, -28}, {42, -28}, {42, -28}}, color = {0, 127, 255}));
  connect(reducingStation1.flowOut, temperature.port) annotation(
    Line(points = {{14, -28}, {20, -28}, {20, -60}, {28, -60}, {28, -60}}, color = {0, 127, 255}));
  connect(steamTurbine.outlet, temperature1.port) annotation(
    Line(points = {{38, -82}, {40, -82}, {40, -82}, {42, -82}, {42, -68}, {66, -68}, {66, -68}}, color = {0, 0, 255}));
  connect(steamTurbine.outlet, multiPort2.ports_b[1]) annotation(
    Line(points = {{38, -82}, {40, -82}, {40, -82}, {42, -82}, {42, -28}, {42, -28}, {42, -28}, {42, -28}}, color = {0, 0, 255}));
  connect(multiPort2.port_a, flowOut.ports[1]) annotation(
    Line(points = {{50, -28}, {60, -28}, {60, -28}, {60, -28}, {60, -28}, {60, -28}}, color = {0, 127, 255}));
  connect(multiPort1.ports_b[1], valveCompressible1.port_a) annotation(
    Line(points = {{-26, -28}, {-24, -28}, {-24, -28}, {-22, -28}, {-22, -78}, {-17, -78}, {-17, -78}, {-12, -78}}, color = {0, 127, 255}, thickness = 0.5));
  connect(combiTimeTable1.y[2], valveCompressible1.opening) annotation(
    Line(points = {{-53, 22}, {-46, 22}, {-46, 22}, {-39, 22}, {-39, -58}, {-1, -58}, {-1, -65}, {-3, -65}, {-3, -70}}, color = {0, 0, 127}, thickness = 0.5));
  connect(valveCompressible1.port_b, steamTurbine.inlet) annotation(
    Line(points = {{8, -78}, {22, -78}, {22, -82}}, color = {0, 127, 255}));
  connect(constantSpeed1.flange, steamTurbine.shaft_b) annotation(
    Line(points = {{52, -90}, {38, -90}, {38, -90}, {36, -90}}));
  connect(combiTimeTable1.y[6], flowOut.p_in) annotation(
    Line(points = {{-53, 22}, {-44, 22}, {-44, 22}, {-33, 22}, {-33, 0}, {83, 0}, {83, -20}, {81, -20}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[4], flowOut.T_in) annotation(
    Line(points = {{-53, 22}, {-42, 22}, {-42, 22}, {-29, 22}, {-29, 2}, {89, 2}, {89, -24}, {83, -24}, {83, -25}, {81, -25}, {81, -24}}, color = {0, 0, 127}, thickness = 0.5));
end valve_Test;
