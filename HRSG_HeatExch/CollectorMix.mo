within TPPSim.HRSG_HeatExch;
model CollectorMix
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching);
  parameter Integer zahod = 2;
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a flowIn[zahod](redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  flowOut.h_outflow = sum(inStream(flowIn[i].h_outflow) * flowIn[i].m_flow for i in 1:zahod) / sum(flowIn[i].m_flow for i in 1:zahod);
  flowIn.p = fill(flowOut.p, zahod);
  sum(flowIn[i].m_flow for i in 1:zahod) + flowOut.m_flow = 0;
  for i in 1:zahod loop
    flowIn[i].h_outflow = inStream(flowOut.h_outflow);
    flowIn[i].Xi_outflow = inStream(flowOut.Xi_outflow);
  end for;
  flowOut.Xi_outflow = inStream(flowIn[1].Xi_outflow);
end CollectorMix;