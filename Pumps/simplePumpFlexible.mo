within TPPSim.Pumps;
model simplePumpFlexible "Сильно упрощеная модель насоса (не определяющая расход среды)"
  extends TPPSim.Pumps.BaseClases.Icons.IconPump;
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  port_b.m_flow + port_a.m_flow = 0;
  port_b.h_outflow = inStream(port_a.h_outflow);
  port_a.h_outflow = inStream(port_b.h_outflow);
  annotation(
    Documentation(info = "<html><head></head><body>Модель насоса которая, обеспечивает требуемое повышение давления.</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>September 11, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end simplePumpFlexible;
