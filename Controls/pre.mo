within TPPSim.Controls;
block pre
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.BooleanInput u1 "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput u2 "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
    y = if not u1 then u2 else pre(y);
    annotation (
 Icon(coordinateSystem(initialScale = 0.1),
        graphics={Text(lineColor = {0, 0, 127}, extent = {{-96, 28}, {94, -24}}, textString = "pre()")}),
        Documentation(info="<html>
<p>
</p>
</html>"));
end pre;
