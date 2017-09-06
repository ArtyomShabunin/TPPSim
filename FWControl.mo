within TPPSim;
block FWControl
  Modelica.Blocks.Interfaces.RealInput gasFlow_in annotation(
    Placement(visible = true, transformation(origin = {-122, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput gasFlow_out annotation(
    Placement(visible = true, transformation(origin = {-122, 58}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput gasEnt_in annotation(
    Placement(visible = true, transformation(origin = {-122, 18}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput gasEnt_out annotation(
    Placement(visible = true, transformation(origin = {-122, -26}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput flowPress_out annotation(
    Placement(visible = true, transformation(origin = {-122, -64}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput flowEnt_in annotation(
    Placement(visible = true, transformation(origin = {-122, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput FWflow annotation(
    Placement(visible = true, transformation(origin = {112, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {114, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  package Medium = Modelica.Media.Water.StandardWater;
  Medium.Temperature ts;
  Medium.SpecificEnthalpy flowEnt_out;
  Medium.MassFlowRate FWflow_temp;
equation

algorithm
  ts := Medium.saturationTemperature_sat(Medium.setSat_p(flowPress_out));
  flowEnt_out := Medium.specificEnthalpy_pT(flowPress_out, ts - 5);
  FWflow_temp := (gasFlow_in * gasEnt_in - gasFlow_out * gasEnt_out) / (flowEnt_out - flowEnt_in);
  FWflow := if FWflow_temp < 58 / 3.6 then 58 / 3.6 else FWflow_temp;
end FWControl;