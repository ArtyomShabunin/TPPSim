within TPPSim.Valves;
model simpleValve "Упрощенная модель клапана"
  extends TPPSim.Valves.BaseClases.Icons.IconValve; 
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Boolean use_D_flow_in = false "Ипользвать порт 'D_flow_in' для задания расхода";
  parameter Modelica.SIunits.MassFlowRate setD_flow "Расход через клапан" annotation(
    Evaluate = true,
    Dialog(enable = not use_D_flow_in));
  parameter Modelica.SIunits.AbsolutePressure dp "Перепад давления на клапане";
  outer Modelica.Fluid.System system;   
  Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput D_flow_in if use_D_flow_in annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 20}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
protected
  Modelica.Blocks.Interfaces.RealInput D_flow_in_internal;
equation
  connect(D_flow_in, D_flow_in_internal) annotation(
    Line);
  if not use_D_flow_in then
    D_flow_in_internal = setD_flow;
  end if;
  flowOut.m_flow = -max(D_flow_in_internal, system.m_flow_small);
  flowIn.m_flow = max(D_flow_in_internal, system.m_flow_small);
  flowOut.h_outflow = inStream(flowIn.h_outflow);
  flowIn.h_outflow = inStream(flowOut.h_outflow);
  flowIn.p - flowOut.p = dp;
  annotation(
    Documentation(info = "<html><head></head><body>Модель клапана которая, по сути, является точкой с фиксирванным расходом среды и перепадом давления между портами.</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>September 11, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon);
end simpleValve;
