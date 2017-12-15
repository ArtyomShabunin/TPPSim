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
    Placement(visible = true, transformation(origin = {-64, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.ReducingStation reducingStation(redeclare package Medium = Medium, dp_nominal = 1.3e+06, m_flow_nominal = 100, p_nominal = 130e5, rho_nominal = 40.78, set_down_T = 573.15, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump direction(redeclare package Medium = Medium, setD_flow = 100) annotation(
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump pump(setD_flow = 1000)  annotation(
    Placement(visible = true, transformation(origin = {-24, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature T_hot_steam(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-30, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature T_water(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {62, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 300 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-16, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-16, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const1.y, reducingStation.opening) annotation(
    Line(points = {{-4, 50}, {6, 50}, {6, 18}, {6, 18}}, color = {0, 0, 127}));
  connect(const.y, reducingStation.T_in) annotation(
    Line(points = {{-5, 82}, {18, 82}, {18, 18}}, color = {0, 0, 127}));
  connect(T_water.port, pump.port_b) annotation(
    Line(points = {{62, -50}, {62, -59}, {-14, -59}, {-14, -40}}, color = {0, 127, 255}));
  connect(pump.port_b, flowOut.ports[2]) annotation(
    Line(points = {{-14, -40}, {26, -40}, {26, 8}, {60, 8}, {60, 10}}, color = {0, 127, 255}));
  connect(pump.port_b, reducingStation.waterIn) annotation(
    Line(points = {{-14, -40}, {0, -40}, {0, -25}, {14, -25}, {14, 0}}, color = {0, 127, 255}));
  connect(waterIn.ports[1], pump.port_a) annotation(
    Line(points = {{-54, -40}, {-45, -40}, {-45, -40}, {-34, -40}, {-34, -40}, {-35, -40}, {-35, -40}, {-34, -40}}, color = {0, 127, 255}, thickness = 0.5));
  connect(T_hot_steam.port, reducingStation.flowIn) annotation(
    Line(points = {{-30, -22}, {-20, -22}, {-20, 4}, {-12, 4}, {-12, 10}, {0, 10}, {0, 10}}, color = {0, 127, 255}));
  connect(reducingStation.flowOut, flowOut.ports[1]) annotation(
    Line(points = {{20, 10}, {24, 10}, {24, 10}, {60, 10}, {60, 10}}, color = {0, 127, 255}));
  connect(direction.port_b, reducingStation.flowIn) annotation(
    Line(points = {{-20, 10}, {0, 10}, {0, 10}, {0, 10}}, color = {0, 127, 255}));
  connect(flowIn.ports[1], direction.port_a) annotation(
    Line(points = {{-60, 10}, {-40, 10}, {-40, 10}, {-40, 10}}, color = {0, 127, 255}, thickness = 0.5));
end ReducingStation_Test;
