within TPPSim.Controls;

block p_set_2 "Блок задания давления в регуляторе давления"
  extends Modelica.Blocks.Icons.Block;
  parameter Real set_p "Задатчик давления";
  Modelica.Blocks.Interfaces.BooleanInput u1 "Сигнал активации блока задания давления"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput u2 "Давление в точке регулирования"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput y "Задание давления на выходе блока"
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
      start_p = pre(start_p); 
    else
      start_time = time;
      y = start_p + (time - start_time) * speed_p;
      start_p = u2;     
    end if;  
  end if;
annotation(
    Documentation(info = "<html>
<style>
p {
  text-indent: 20px;
  text-align: 'justify';
 }
</style>
<p>Блок предназначен для корректировки задания по давлению с учетом ограничения по скорости его нарастания.</p>
<p>Блок задания давления работает по следующему алгориму:</p>
<ul>
  <li>В случае отсутсвия сигнала активации блока 'u1', задание давление на выходе блока 'y' равно входному сигналу 'u2'. Создается условие заданное давление равно текущему давлению.</li>
  <li>После активации блока, при условии, что текущее давление 'u2' меньше заданного 'set_p' формируется задание по давлению на выходе блока 'y' с учетом заданной скорости нарастания давления 'speed_p'.</li>
</ul>
<p>Алгоритм работы блок не предполагает изменения задания давления 'set_p'. Изменение заданной скорости нарастания давления обрабатывается.</p>
<p>Предусмотрен входной сигнал 'refresh' для обновления внутренних переменных 'start_time' и 'start_p'.</p>
<li><i>07 July 2018</i>
by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
   Создан.</li>
</ul>
</html>"));

end p_set_2;
