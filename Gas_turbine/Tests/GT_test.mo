within TPPSim.Gas_turbine.Tests;
model GT_test
  replaceable package Medium = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary1(redeclare package Medium = Medium, nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {60, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.combitable_startupGT GT(fileName = "C:/Users/User/Documents/TPPSim/Gas_turbine/Tests/my.txt")  annotation(
    Placement(visible = true, transformation(origin = {-34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(GT.flowOut, boundary1.ports[1]) annotation(
    Line(points = {{-24, 0}, {50, 0}, {50, 0}, {50, 0}}, color = {0, 127, 255}));
end GT_test;
