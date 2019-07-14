within TPPSim.Boilers.TPE_223_pack.Tests;

model Test_1
  replaceable package Medium_G = TPPSim.Media.ExhaustGas_Furnance constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;

  TPPSim.Boilers.TPE_223_pack.TPE_223_furnace furnace annotation(
    Placement(visible = true, transformation(origin = {0, -2}, extent = {{-6, -10}, {6, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T airSource(redeclare package Medium = Medium_G, m_flow = 1000, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Fuel.Sources.MassFlowSource coilSource(m_flow = 100) annotation(
    Placement(visible = true, transformation(origin = {-70, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {70, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T waterSource(redeclare package Medium = Medium_F, T = 100 + 273.15, m_flow = 10, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {-70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary waterSink(redeclare package Medium = Medium_F, nPorts = 1, p = 1e6) annotation(
    Placement(visible = true, transformation(origin = {-70, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature waterIn_temp(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {34, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature waterOut_temp(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-6, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(furnace.waterOut, waterSink.ports[1]) annotation(
    Line(points = {{-6, 8}, {-6, 42}, {-60, 42}}, color = {0, 127, 255}));
  connect(furnace.waterIn, waterIn_temp.port) annotation(
    Line(points = {{6, -12}, {34, -12}, {34, -12}, {34, -12}}, color = {0, 127, 255}));
  connect(furnace.waterOut, waterOut_temp.port) annotation(
    Line(points = {{-6, 8}, {-6, 60}}, color = {0, 127, 255}));
  connect(furnace.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{0, 8}, {0, 8}, {0, 50}, {60, 50}, {60, 50}}, color = {0, 127, 255}));
  connect(waterSource.ports[1], furnace.waterIn) annotation(
    Line(points = {{-60, -60}, {6, -60}, {6, -10}, {6, -10}}, color = {0, 127, 255}, thickness = 0.5));
  connect(airSource.ports[1], furnace.airIn) annotation(
    Line(points = {{-60, -30}, {-26, -30}, {-26, -6}, {-6, -6}, {-6, -6}}, color = {0, 127, 255}, thickness = 0.5));
  connect(coilSource.port_b, furnace.fuelIn) annotation(
    Line(points = {{-60, -4}, {-6, -4}}, color = {170, 85, 0}));
end Test_1;
