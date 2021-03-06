within TPPSim.Pumps;

model circPump
  extends TPPSim.Pumps.BaseClases.Icons.IconFixFlow;
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Boolean use_D_flow_in = false "Ипользвать порт 'D_flow_in' для задания расхода";
  parameter Boolean use_p_flow = false "Ипользвать порт 'p_flow_in' для задания напора насоса";
  parameter Modelica.SIunits.MassFlowRate setD_flow = 1 "Производительность насоса" annotation(
    Evaluate = true,
    Dialog(enable = not use_D_flow_in));
  parameter Modelica.SIunits.AbsolutePressure setp_flow = 1.013e5 "Напор насоса" annotation(
    Evaluate = true,
    Dialog(enable = not use_p_flow));
  outer Modelica.Fluid.System system;
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput D_flow_in if use_D_flow_in annotation(
    Placement(visible = true, transformation(origin = {-20, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput p_flow if use_p_flow annotation(
    Placement(visible = true, transformation(origin = {40, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {60, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
protected
  Modelica.Blocks.Interfaces.RealInput D_flow_in_internal;
  Modelica.Blocks.Interfaces.RealInput p_flow_internal;
equation
  connect(D_flow_in, D_flow_in_internal) annotation(
    Line);
  connect(p_flow, p_flow_internal) annotation(
    Line);
  if not use_D_flow_in then
    D_flow_in_internal = setD_flow;
  end if;
  if not use_p_flow then
    p_flow_internal = setp_flow;
  end if;
  
  port_b.m_flow = -max(D_flow_in_internal, system.m_flow_small);
  port_b.h_outflow = inStream(port_a.h_outflow);
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.p = p_flow_internal;
  annotation(
    Documentation(info = "<html><head></head><body>Модель насоса которая, по сути, является точкой с фиксирванным расходом среды.</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>July 08, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end circPump;
