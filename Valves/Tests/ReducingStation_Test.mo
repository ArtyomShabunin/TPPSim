within TPPSim.Valves.Tests;
model ReducingStation_Test
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowIn(redeclare package Medium = Medium, T = 500 + 273.15, nPorts = 1, p = 100e5, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowOut(redeclare package Medium = Medium, T = 30 + 273.15, nPorts = 2, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {70, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary waterIn(redeclare package Medium = Medium, T = 30 + 273.15, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-50, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.ReducingStation reducingStation(redeclare package Medium = Medium, dp_nominal = 1.3e+06, m_flow_nominal = 100, p_nominal = 130e5, rho_nominal = 40.78, set_down_T = 573.15, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump direction(redeclare package Medium = Medium, setD_flow = 100) annotation(
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump pump(setD_flow = 1000)  annotation(
    Placement(visible = true, transformation(origin = {-10, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature T_hot_steam(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-30, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature T_water(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-10, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature T_cold_steam(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Sensors.Temperature ts(TemperatureType_set = TPPSim.Sensors.TemperatureType.saturation)  annotation(
    Placement(visible = true, transformation(origin = {-80, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = {2},fileName = "C:/Users/User/Documents/TPPSim/Boilers/Tests/T_BROUout.txt", tableName = "tabl", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation(
    Placement(visible = true, transformation(origin = {2, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 5)  annotation(
    Placement(visible = true, transformation(origin = {-90, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const1.y, sum1.u[2]) annotation(
    Line(points = {{-78, 74}, {-70, 74}, {-70, 70}, {-62, 70}, {-62, 70}}, color = {0, 0, 127}));
  connect(ts.deltaTs, sum1.u[1]) annotation(
    Line(points = {{-72, 48}, {-70, 48}, {-70, 70}, {-62, 70}, {-62, 70}}, color = {0, 0, 127}));
  connect(sum1.y, max1.u2) annotation(
    Line(points = {{-38, 70}, {-30, 70}, {-30, 74}, {-10, 74}, {-10, 74}}, color = {0, 0, 127}));
  connect(reducingStation.flowOut, ts.port) annotation(
    Line(points = {{20, 10}, {26, 10}, {26, 30}, {-80, 30}, {-80, 38}, {-80, 38}}, color = {0, 127, 255}));
  connect(combiTimeTable1.y[1], max1.u1) annotation(
    Line(points = {{-59, 90}, {-18, 90}, {-18, 86}, {-10, 86}}, color = {0, 0, 127}, thickness = 0.5));
  connect(max1.y, reducingStation.T_in) annotation(
    Line(points = {{14, 80}, {18, 80}, {18, 18}, {18, 18}}, color = {0, 0, 127}));
  connect(T_cold_steam.port, reducingStation.flowOut) annotation(
    Line(points = {{30, 40}, {30, 40}, {30, 10}, {20, 10}, {20, 10}}, color = {0, 127, 255}));
  connect(T_water.port, pump.port_b) annotation(
    Line(points = {{-10, -88}, {0, -88}, {0, -50}, {0, -50}, {0, -50}}, color = {0, 127, 255}));
  connect(T_hot_steam.port, reducingStation.flowIn) annotation(
    Line(points = {{-30, -22}, {-20, -22}, {-20, 4}, {-12, 4}, {-12, 10}, {0, 10}, {0, 10}}, color = {0, 127, 255}));
  connect(const.y, reducingStation.opening) annotation(
    Line(points = {{-18, 50}, {6, 50}, {6, 18}, {6, 18}}, color = {0, 0, 127}));
  connect(waterIn.ports[1], pump.port_a) annotation(
    Line(points = {{-40, -50}, {-20, -50}, {-20, -50}, {-20, -50}}, color = {0, 127, 255}, thickness = 0.5));
  connect(pump.port_b, reducingStation.waterIn) annotation(
    Line(points = {{0, -50}, {14, -50}, {14, 0}, {14, 0}}, color = {0, 127, 255}));
  connect(pump.port_b, flowOut.ports[2]) annotation(
    Line(points = {{0, -50}, {40, -50}, {40, 8}, {60, 8}, {60, 10}}, color = {0, 127, 255}));
  connect(reducingStation.flowOut, flowOut.ports[1]) annotation(
    Line(points = {{20, 10}, {24, 10}, {24, 10}, {60, 10}, {60, 10}}, color = {0, 127, 255}));
  connect(direction.port_b, reducingStation.flowIn) annotation(
    Line(points = {{-20, 10}, {0, 10}, {0, 10}, {0, 10}}, color = {0, 127, 255}));
  connect(flowIn.ports[1], direction.port_a) annotation(
    Line(points = {{-60, 10}, {-40, 10}, {-40, 10}, {-40, 10}}, color = {0, 127, 255}, thickness = 0.5));
end ReducingStation_Test;
