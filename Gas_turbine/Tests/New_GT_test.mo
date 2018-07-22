within TPPSim.Gas_turbine.Tests;
model New_GT_test
  replaceable package Medium = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary1(redeclare package Medium = Medium, nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {60, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.GT_param.GT_param GT_1(N_init = 5e6)   annotation(
    Placement(visible = true, transformation(origin = {-34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant N_set(k = 300e6)  annotation(
    Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant derN_set(k = 4e6 / 60)  annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(derN_set.y, GT_1.derN_set) annotation(
    Line(points = {{-58, 30}, {-32, 30}, {-32, 10}, {-30, 10}}, color = {0, 0, 127}));
  connect(N_set.y, GT_1.N_set) annotation(
    Line(points = {{-58, 60}, {-26, 60}, {-26, 10}, {-26, 10}}, color = {0, 0, 127}));
  connect(GT_1.flowOut, boundary1.ports[1]) annotation(
    Line(points = {{-24, 0}, {50, 0}, {50, 0}, {50, 0}}, color = {0, 127, 255}));
end New_GT_test;
