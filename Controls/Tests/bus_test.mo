within TPPSim.Controls.Tests;
block bus_test
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus subControlBus1 annotation(
    Placement(visible = true, transformation(origin = {90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-68, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const annotation(
    Placement(visible = true, transformation(origin = {-70, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1 annotation(
    Placement(visible = true, transformation(origin = {-72, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(booleanConstant1.y, subControlBus1.b) annotation(
    Line(points = {{-60, -28}, {90, -28}, {90, -10}, {90, -10}}, color = {255, 0, 255}));
  connect(const.y, subControlBus1.k) annotation(
    Line(points = {{-58, 52}, {88, 52}, {88, -10}, {90, -10}}, color = {0, 0, 127}));

end bus_test;