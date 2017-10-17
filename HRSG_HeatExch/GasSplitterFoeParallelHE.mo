within TPPSim.HRSG_HeatExch;
model GasSplitterFoeParallelHE
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconGasSplitter;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching);
  parameter Real x_gasflow_1; 
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b gasOut_1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b gasOut_2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  gasOut_1.m_flow = -gasIn.m_flow * x_gasflow_1;
  gasOut_2.m_flow = -gasIn.m_flow * (1 - x_gasflow_1);
  gasOut_1.h_outflow = inStream(gasIn.h_outflow);
  gasOut_2.h_outflow = inStream(gasIn.h_outflow);
  gasOut_1.Xi_outflow =inStream(gasIn.Xi_outflow);
  gasOut_2.Xi_outflow =inStream(gasIn.Xi_outflow);
  gasIn.p = gasOut_1.p;
  gasIn.h_outflow = inStream(gasOut_1.h_outflow);
  gasIn.Xi_outflow = inStream(gasOut_1.Xi_outflow);
end GasSplitterFoeParallelHE;
