within TPPSim.Valves.Tests;
model valve_Test
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  Modelica.Fluid.Sources.Boundary_pT flowOut(redeclare package Medium = Medium, T = 300 + 273.15, nPorts = 1, p = 30e5, use_T_in = true, use_p_in = true) annotation(
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = {2, 3, 4, 5, 6, 7, 8, 9},fileName = "C:/Users/User/Documents/TPPSim/Valves/Tests/pos_BROU_HP.txt", tableName = "tabl", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-64, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT flowIn(redeclare package Medium = Medium, T = 500 + 273.15, nPorts = 1, p = 129e5, use_T_in = true, use_p_in = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {28, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Water.SteamTurbineStodola steamTurbine(Kt = 0.0038, PRstart = 1, eta_iso_nom = 0.9, pnom = 130e5, wnom = 77)  annotation(
    Placement(visible = true, transformation(origin = {30, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed1(w_fixed = Modelica.Constants.pi * 50)  annotation(
    Placement(visible = true, transformation(origin = {58, -62}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible valveCompressible1(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1200, dp_nominal = 9e+06) annotation(
    Placement(visible = true, transformation(origin = {-2, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort1(redeclare package Medium = Medium, nPorts_b = 2)  annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-4, -10}, {4, 10}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort2(redeclare package Medium = Medium, nPorts_b = 2)  annotation(
    Placement(visible = true, transformation(origin = {46, 0}, extent = {{4, -10}, {-4, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {66, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.ReducingStation reducingStation1(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 600, dp_nominal = 9e+06, min_delta = 90, set_down_T = 573.15, use_T_in = true)  annotation(
    Placement(visible = true, transformation(origin = {4, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT waterIn(redeclare package Medium = Medium, T = 140 + 273.15, nPorts = 1, p = 3e5)  annotation(
    Placement(visible = true, transformation(origin = {-70, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 300 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-10, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(valveCompressible1.port_b, steamTurbine.inlet) annotation(
    Line(points = {{8, -50}, {22, -50}, {22, -54}}, color = {0, 127, 255}));
  connect(combiTimeTable1.y[2], valveCompressible1.opening) annotation(
    Line(points = {{-52, 50}, {-40, 50}, {-40, -30}, {-2, -30}, {-2, -42}}, color = {0, 0, 127}, thickness = 0.5));
  connect(multiPort1.ports_b[1], valveCompressible1.port_a) annotation(
    Line(points = {{-26, 0}, {-22, 0}, {-22, -50}, {-12, -50}}, color = {0, 127, 255}, thickness = 0.5));
  connect(const.y, reducingStation1.T_in) annotation(
    Line(points = {{2, 60}, {12, 60}, {12, 8}, {12, 8}}, color = {0, 0, 127}));
  connect(reducingStation1.flowOut, temperature.port) annotation(
    Line(points = {{14, 0}, {20, 0}, {20, -32}, {28, -32}, {28, -32}}, color = {0, 127, 255}));
  connect(waterIn.ports[1], reducingStation1.waterIn) annotation(
    Line(points = {{-60, -36}, {-48, -36}, {-48, -10}, {8, -10}, {8, -10}}, color = {0, 127, 255}, thickness = 0.5));
  connect(combiTimeTable1.y[1], reducingStation1.opening) annotation(
    Line(points = {{-52, 50}, {-36, 50}, {-36, 20}, {0, 20}, {0, 8}, {0, 8}}, color = {0, 0, 127}, thickness = 0.5));
  connect(reducingStation1.flowOut, multiPort2.ports_b[2]) annotation(
    Line(points = {{14, 0}, {42, 0}, {42, 0}, {42, 0}}, color = {0, 127, 255}));
  connect(multiPort1.ports_b[2], reducingStation1.flowIn) annotation(
    Line(points = {{-26, 0}, {-6, 0}, {-6, 0}, {-6, 0}}, color = {0, 127, 255}, thickness = 0.5));
  connect(steamTurbine.outlet, temperature1.port) annotation(
    Line(points = {{38, -54}, {42, -54}, {42, -40}, {66, -40}, {66, -40}}, color = {0, 0, 255}));
  connect(multiPort2.port_a, flowOut.ports[1]) annotation(
    Line(points = {{50, 0}, {60, 0}, {60, 0}, {60, 0}}, color = {0, 127, 255}));
  connect(steamTurbine.outlet, multiPort2.ports_b[1]) annotation(
    Line(points = {{38, -54}, {42, -54}, {42, 0}, {42, 0}}, color = {0, 0, 255}));
  connect(flowIn.ports[1], multiPort1.port_a) annotation(
    Line(points = {{-60, 0}, {-34, 0}, {-34, 0}, {-34, 0}}, color = {0, 127, 255}, thickness = 0.5));
  connect(constantSpeed1.flange, steamTurbine.shaft_b) annotation(
    Line(points = {{52, -62}, {38, -62}, {38, -62}, {36, -62}}));
  connect(combiTimeTable1.y[4], flowOut.T_in) annotation(
    Line(points = {{-52, 50}, {-30, 50}, {-30, 30}, {88, 30}, {88, 4}, {82, 4}, {82, 4}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[3], flowIn.T_in) annotation(
    Line(points = {{-52, 50}, {-52, 50}, {-52, 32}, {-86, 32}, {-86, 4}, {-82, 4}, {-82, 4}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[6], flowOut.p_in) annotation(
    Line(points = {{-52, 50}, {-34, 50}, {-34, 28}, {82, 28}, {82, 8}, {82, 8}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[5], flowIn.p_in) annotation(
    Line(points = {{-52, 50}, {-48, 50}, {-48, 30}, {-82, 30}, {-82, 8}, {-82, 8}}, color = {0, 0, 127}, thickness = 0.5));
end valve_Test;
