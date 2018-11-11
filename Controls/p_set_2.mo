within TPPSim.Controls;

block p_set_2 "Блок задания давления в регуляторе давления"
  extends Modelica.Blocks.Icons.Block;
  parameter Real set_p "Задатчик давления";
//  parameter Real speed_p "Скорость повышения давления";
  Modelica.Blocks.Interfaces.BooleanInput u1 "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput u2 "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Real start_time;
  Real start_p;
  Boolean p_inc(start = true, fixed = true) "Состояние рост давления";
  Modelica.Blocks.Interfaces.BooleanInput refresh annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
protected
  Modelica.Blocks.Interfaces.RealInput speed_p;
equation
  when u2 > set_p then
    p_inc = false;
  end when;

  if initial() or not u1 then
    start_time = time;
    y = u2;
    start_p = u2;
  elseif noEvent(refresh) then
    start_time = time;
    y = pre(y);
    start_p = u2; 
  elseif not p_inc then
    start_time = pre(start_time);
    y = set_p;
    start_p = pre(start_p);       
  else
    if speed_p == pre(speed_p) then
      start_time = pre(start_time);
      y = start_p + (time - start_time) * speed_p;
//    y = pre(y) + (time - pre(time)) * speed_p;
      start_p = pre(start_p); 
    else
      start_time = time;
      y = start_p + (time - start_time) * speed_p;
      start_p = u2;     
    end if;  
  end if;
annotation(
    Documentation(info = "<html><head></head><body>Тоже что и 'p_set' но с возможностью обновления стартовой точки по давлению от которой идет расчет задаваемых значений с учетом скорости.</body></html>"));
end p_set_2;
