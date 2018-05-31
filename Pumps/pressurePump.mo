within TPPSim.Pumps;
model pressurePump "Сильно упрощеная модель насоса для поддержания требуемого давления"
  extends TPPSim.Pumps.BaseClases.Icons.IconPump;
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Boolean use_p_in = false "Ипользвать порт 'p_in' для задания давления";
  parameter Modelica.SIunits.AbsolutePressure set_p = 1.013e5 "Давление на напоре насоса" annotation(
    Evaluate = true,
    Dialog(enable = not use_p_in));
  Modelica.Blocks.Interfaces.RealInput p_in if use_p_in annotation(
    Placement(visible = true, transformation(origin = {0, 110}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
protected
  Modelica.Blocks.Interfaces.RealInput p_in_internal;
equation
  if use_p_in then
    connect(p_in, p_in_internal);  
  else
   p_in_internal = set_p;
  end if;  
algorithm
  port_b.p := p_in_internal; 
  port_a.m_flow := -port_b.m_flow;
  port_b.h_outflow := inStream(port_a.h_outflow);
  port_a.h_outflow := inStream(port_b.h_outflow);
  annotation(
    Documentation(info = "<html><head></head><body>Модель насоса которая, поддержание заданного давления.</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>May 24, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end pressurePump;
