within TPPSim.Valves;
model Desuperheater
  extends TPPSim.Valves.BaseClases.Icons.IconDesuperheater;
  replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Modelica.SIunits.Temperature down_T "Температура пара за БРОУ";
  outer Modelica.Fluid.System system;  
  Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {8, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  flowOut.h_outflow = Medium.specificEnthalpy_pT(flowOut.p, down_T);
  if noEvent((flowOut.h_outflow - inStream(flowIn.h_outflow)) > 0) then
    waterIn.m_flow = -(flowIn.m_flow * inStream(flowIn.h_outflow) + flowOut.m_flow * flowOut.h_outflow)/inStream(waterIn.h_outflow);
  else
    waterIn.m_flow = 0;
  end if;
  flowIn.h_outflow = inStream(flowOut.h_outflow);
  waterIn.h_outflow = inStream(flowOut.h_outflow);
  flowOut.m_flow = -(flowIn.m_flow + waterIn.m_flow);
  flowIn.p = flowOut.p;
end Desuperheater;
