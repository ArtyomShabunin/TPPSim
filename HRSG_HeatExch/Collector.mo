within TPPSim.HRSG_HeatExch;
model Collector
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching);
  parameter Integer zahod = 2;
  Modelica.Fluid.Interfaces.FluidPort_b flowOut[zahod](redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  for i in 1:zahod loop
    flowOut[i].m_flow + flowIn.m_flow / zahod = 0;
    flowOut[i].h_outflow = inStream(flowIn.h_outflow);
    flowOut[i].Xi_outflow = inStream(flowIn.Xi_outflow);
  end for;
  flowIn.p = sum(flowOut[i].p for i in 1:zahod) / zahod;
//flowOut.p = fill(flowIn.p, zahod);
//sum(flowOut[i].m_flow for i in 1:zahod) + flowIn.m_flow = 0;
  flowIn.h_outflow = sum(inStream(flowOut[i].h_outflow) * flowOut[i].m_flow for i in 1:zahod) / sum(flowOut[i].m_flow for i in 1:zahod);
  flowIn.Xi_outflow = inStream(flowOut[1].Xi_outflow);
end Collector;