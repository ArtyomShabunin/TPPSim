within TPPSim.Valves;
model Desuperheater
  extends TPPSim.Valves.BaseClases.Icons.IconDesuperheater;
  replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Modelica.SIunits.Temperature set_down_T "Температура пара за БРОУ";
  parameter Boolean use_T_in = false "Ипользвать порт 'T_in' для задания температуры";
  outer Modelica.Fluid.System system;  
  Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {8, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput T_in if use_T_in annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
protected
  Modelica.SIunits.MassFlowRate m_temp;
  Modelica.SIunits.SpecificEnthalpy h_temp;
  Modelica.Blocks.Interfaces.RealInput down_T_in_internal;
equation
  if not use_T_in then
    down_T_in_internal = set_down_T;
  end if;
  connect(T_in, down_T_in_internal);  
  h_temp = Medium.specificEnthalpy_pT(flowOut.p, down_T_in_internal);
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
