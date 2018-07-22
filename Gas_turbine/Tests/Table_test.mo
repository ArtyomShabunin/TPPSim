within TPPSim.Gas_turbine.Tests;
model Table_test
  replaceable package Medium = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = {2, 3, 4, 5},fileName = "C:/Users/ASShabunin/TPPSim/Gas_turbine/Tests/new_GT.txt", startTime = 0, tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-52, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

end Table_test;
