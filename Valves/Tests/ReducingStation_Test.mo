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
  TPPSim.Valves.ReducingStation reducingStation(redeclare package Medium = Medium, down_T = 573.15, up_p = 120e5) annotation(
    Placement(visible = true, transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump direction(redeclare package Medium = Medium, setD_flow = 100) annotation(
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump pump(setD_flow = 1000)  annotation(
    Placement(visible = true, transformation(origin = {-10, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
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
