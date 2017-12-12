﻿within TPPSim.Valves;
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
protected
  Modelica.SIunits.MassFlowRate m_temp;
  Modelica.SIunits.SpecificEnthalpy h_temp;
equation
  h_temp = Medium.specificEnthalpy_pT(flowOut.p, down_T);
  m_temp = flowIn.m_flow * (h_temp - inStream(flowIn.h_outflow))/(inStream(waterIn.h_outflow) - h_temp);
  if noEvent(m_temp < 0) then
    waterIn.m_flow = 0;
    flowOut.h_outflow = inStream(flowIn.h_outflow);    
  else
    waterIn.m_flow = m_temp;
    flowOut.h_outflow = h_temp;
  end if;
  flowIn.h_outflow = inStream(flowOut.h_outflow);
  waterIn.h_outflow = inStream(flowOut.h_outflow);
  flowOut.m_flow = -(flowIn.m_flow + waterIn.m_flow);
  flowIn.p = flowOut.p;
end Desuperheater;
