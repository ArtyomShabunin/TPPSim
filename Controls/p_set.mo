within TPPSim.Controls;
block p_set
  extends Modelica.Blocks.Icons.Block;
  parameter Real set_p "Задатчик давления";
  parameter Real speed_p "Скорость повышения давления";
  Modelica.Blocks.Interfaces.BooleanInput u1 "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput u2 "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Real start_time;
  Real start_p;
equation
  if initial() or not u1 then
    start_time = time;
    y = u2;
    start_p = u2;
  elseif noEvent(time > start_time + (set_p - start_p) / speed_p) then
    start_time = pre(start_time);
    y = set_p;
    start_p = pre(start_p);       
  else
    start_time = pre(start_time);
    y = start_p + (time - start_time) * speed_p;
    start_p = pre(start_p);      
  end if;
end p_set;
