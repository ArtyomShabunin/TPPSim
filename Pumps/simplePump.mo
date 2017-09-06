within TPPSim.Pumps;
model simplePump "Сильно упрощеная модель насоса"
  extends TPPSim.Pumps.BaseClases.Icons.IconPump;
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Boolean use_D_flow_in = false "Ипользвать порт 'D_flow_in' для задания расхода";
  parameter Modelica.SIunits.MassFlowRate setD_flow = 1 "Производительность насоса" annotation(
    Evaluate = true,
    Dialog(enable = not use_D_flow_in));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput D_flow_in if use_D_flow_in annotation(
    Placement(visible = true, transformation(origin = {-8, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
protected
  Modelica.Blocks.Interfaces.RealInput D_flow_in_internal;
equation
  if not use_D_flow_in then
    D_flow_in_internal = setD_flow;
  end if;
  connect(D_flow_in, D_flow_in_internal);
  port_b.m_flow = -D_flow_in_internal;
  port_a.m_flow = -port_b.m_flow;
  port_b.h_outflow = inStream(port_a.h_outflow);
  port_a.h_outflow = port_b.h_outflow;
  annotation(
    Documentation(info = "<html><head></head><body>Модель насоса которая, по сути, является точкой с фиксирванным расходом среды.</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>July 08, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end simplePump;