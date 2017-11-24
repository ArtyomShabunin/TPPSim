within TPPSim.Gas_turbine.Tests;
model Table_test
  replaceable package Medium = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = {2, 3, 4, 5, 6, 7, 8, 9}, fileName = "C:/Users/User/Documents/TPPSim/Gas_turbine/Tests/my.txt", tableName = "tabl", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-52, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_X_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary1(redeclare package Medium = Medium, nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {60, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(combiTimeTable1.y[3:8], boundary.X_in) annotation(
    Line(points = {{-40, 0}, {-32, 0}, {-32, -4}, {2, -4}, {2, -4}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[2], boundary.T_in) annotation(
    Line(points = {{-40, 0}, {-24, 0}, {-24, 4}, {2, 4}, {2, 4}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[1], boundary.m_flow_in) annotation(
    Line(points = {{-40, 0}, {-30, 0}, {-30, 8}, {4, 8}, {4, 8}}, color = {0, 0, 127}, thickness = 0.5));
  connect(boundary.ports[1], boundary1.ports[1]) annotation(
    Line(points = {{24, 0}, {50, 0}, {50, 0}, {50, 0}}, color = {0, 127, 255}, thickness = 0.5));
end Table_test;
