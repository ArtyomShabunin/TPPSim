within TPPSim.Controls;

block pressure_control_4 "Регулятор давления"
  parameter Modelica.SIunits.AbsolutePressure P_activation "Давление при котором регулятор переходит в автоматический режим";
  parameter Modelica.SIunits.AbsolutePressure set_p "Поддерживаемое давление";
  parameter Real pos_start = 0.002 "Исходное УП регулирующего клапана";
  parameter Boolean use_p_speed_in = false "Ипользвать порт 'p_speed_in' для задания скорости нарастания давления";
  parameter Real speed_p "Скорость повышения давления" annotation(
    Evaluate = true,
    Dialog(enable = not use_p_speed_in));
  parameter Real k = 0.001 "Коэффициент усиления" annotation(
    Dialog(group = "Параметры регулятора"));
  parameter Real T = 10 "Постоянная времени" annotation(
    Dialog(group = "Параметры регулятора"));
  Modelica.Blocks.Interfaces.RealInput u1 "Connector of Real input signal 1" annotation(
    Placement(visible = true, transformation(extent = {{-140, 90}, {-100, 130}}, rotation = 0), iconTransformation(extent = {{-140, 70}, {-100, 110}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u2 "Connector of Real input signal 2" annotation(
    Placement(visible = true, transformation(extent = {{-140, -126}, {-100, -86}}, rotation = 0), iconTransformation(extent = {{-140, -110}, {-100, -70}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput p_speed_in if use_p_speed_in annotation(
    Placement(visible = true, transformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal" annotation(
    Placement(visible = true, transformation(extent = {{100, 14}, {120, 34}}, rotation = 0), iconTransformation(extent = {{100, 20}, {120, 40}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y2 annotation(
    Placement(visible = true, transformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {-68, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater1 annotation(
    Placement(visible = true, transformation(origin = {-60, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_1(k = P_activation) annotation(
    Placement(visible = true, transformation(origin = {-90, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.onAuto onAuto1 annotation(
    Placement(visible = true, transformation(origin = {2, -136}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u3 annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI(T = T, initType = Modelica.Blocks.Types.Init.InitialOutput, k = k, y_start = pos_start) annotation(
    Placement(visible = true, transformation(origin = {-4, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.p_set_2 p_set1(set_p = set_p) annotation(
    Placement(visible = true, transformation(origin = {34, -120}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-50, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Less less1 annotation(
    Placement(visible = true, transformation(origin = {-50, 110}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater2 annotation(
    Placement(visible = true, transformation(origin = {-30, 80}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {10, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {72, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Gain gain1(k = 1 / k / 0.8) annotation(
    Placement(visible = true, transformation(origin = {-14, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2 annotation(
    Placement(visible = true, transformation(origin = {-38, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter1 annotation(
    Placement(visible = true, transformation(origin = {36, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant max_lim(k = 1) annotation(
    Placement(visible = true, transformation(origin = {90, 140}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant min_lim_1(k = 0) annotation(
    Placement(visible = true, transformation(origin = {50, 140}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant min_lim_2(k = 0) annotation(
    Placement(visible = true, transformation(origin = {12, 140}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {58, 98}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const1(k = 0.05) annotation(
    Placement(visible = true, transformation(origin = {-90, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Derivative dp_hp annotation(
    Placement(visible = true, transformation(origin = {-48, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater3 annotation(
    Placement(visible = true, transformation(origin = {2, -94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater4 annotation(
    Placement(visible = true, transformation(origin = {2, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant RS_is_open(k = 0.98) annotation(
    Placement(visible = true, transformation(origin = {-88, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.And and11 annotation(
    Placement(visible = true, transformation(origin = {34, -80}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1(realFalse = 1, realTrue = 0)  annotation(
    Placement(visible = true, transformation(origin = {74, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  Modelica.Blocks.Interfaces.RealInput p_speed_in_internal;
equation
  connect(switch1.y, y) annotation(
    Line(points = {{58, 87}, {58, 18}, {92, 18}, {92, 24}, {110, 24}}, color = {0, 0, 127}));
  connect(const1.y, less1.u2) annotation(
    Line(points = {{-79, 140}, {-77, 140}, {-77, 140}, {-75, 140}, {-75, 118}, {-63, 118}, {-63, 119}, {-63, 119}, {-63, 118.5}, {-63, 118.5}, {-63, 118}}, color = {0, 0, 127}));
  connect(and1.y, switch1.u2) annotation(
    Line(points = {{21, 100}, {28, 100}, {28, 100}, {33, 100}, {33, 118}, {57, 118}, {57, 115}, {57, 115}, {57, 110}}, color = {255, 0, 255}));
  connect(variableLimiter1.y, switch1.u3) annotation(
    Line(points = {{47, 24}, {83, 24}, {83, 116}, {65.5, 116}, {65.5, 110}, {66, 110}}, color = {0, 0, 127}));
  connect(min_lim_2.y, switch1.u1) annotation(
    Line(points = {{1, 140}, {-3, 140}, {-3, 140}, {-9, 140}, {-9, 120}, {25, 120}, {25, 112}, {49, 112}, {49, 112}, {51, 112}, {51, 110}}, color = {0, 0, 127}));
  connect(min_lim_1.y, variableLimiter1.limit2) annotation(
    Line(points = {{39, 140}, {32, 140}, {32, 122}, {70, 122}, {70, 8}, {18, 8}, {18, 14}, {24, 14}, {24, 16}}, color = {0, 0, 127}));
  connect(max_lim.y, variableLimiter1.limit1) annotation(
    Line(points = {{79, 140}, {74, 140}, {74, 78}, {14, 78}, {14, 32}, {24, 32}}, color = {0, 0, 127}));
  connect(less1.y, and1.u1) annotation(
    Line(points = {{-39, 110}, {-27, 110}, {-27, 110}, {-15, 110}, {-15, 100}, {-3, 100}, {-3, 101}, {-3, 101}, {-3, 100}}, color = {255, 0, 255}));
  connect(greater2.y, and1.u2) annotation(
    Line(points = {{-19, 80}, {-18.125, 80}, {-18.125, 80}, {-17.25, 80}, {-17.25, 80}, {-15.5, 80}, {-15.5, 80}, {-12, 80}, {-12, 92}, {-7, 92}, {-7, 92}, {-4.5, 92}, {-4.5, 92}, {-4.25, 92}, {-4.25, 92}, {-2, 92}}, color = {255, 0, 255}));
  connect(u3, greater2.u1) annotation(
    Line(points = {{-120, 80}, {-42, 80}}, color = {0, 0, 127}));
  connect(const.y, greater2.u2) annotation(
    Line(points = {{-39, 140}, {-36.625, 140}, {-36.625, 140}, {-34.25, 140}, {-34.25, 140}, {-29.5, 140}, {-29.5, 140}, {-20, 140}, {-20, 92}, {-52, 92}, {-52, 88}, {-47, 88}, {-47, 88}, {-44.5, 88}, {-44.5, 88}, {-42, 88}}, color = {0, 0, 127}));
  connect(u1, less1.u1) annotation(
    Line(points = {{-120, 110}, {-107, 110}, {-107, 110}, {-92, 110}, {-92, 110}, {-64, 110}, {-64, 110}, {-63, 110}, {-63, 110}, {-62.5, 110}, {-62.5, 110}, {-62, 110}}, color = {0, 0, 127}));
  connect(u1, greater4.u1) annotation(
    Line(points = {{-120, 110}, {-88, 110}, {-88, -72}, {-10, -72}}, color = {0, 0, 127}));
  connect(PI.y, variableLimiter1.u) annotation(
    Line(points = {{7, 24}, {23, 24}, {23, 24}, {23, 24}}, color = {0, 0, 127}));
  connect(variableLimiter1.y, add1.u1) annotation(
    Line(points = {{47, 24}, {51, 24}, {51, 12}, {77, 12}, {77, -4}, {77, -4}}, color = {0, 0, 127}));
  connect(feedback1.y, add2.u1) annotation(
    Line(points = {{-59, 24}, {-56, 24}, {-56, 24}, {-53, 24}, {-53, 24}, {-52, 24}, {-52, 24}, {-51, 24}}, color = {0, 0, 127}));
  connect(add2.y, PI.u) annotation(
    Line(points = {{-27, 18}, {-25, 18}, {-25, 24}, {-17, 24}, {-17, 24}, {-17, 24}, {-17, 24}}, color = {0, 0, 127}));
  connect(gain1.y, add2.u2) annotation(
    Line(points = {{-25, -6}, {-38.5, -6}, {-38.5, -6}, {-52, -6}, {-52, 12}, {-51, 12}, {-51, 12}, {-50, 12}}, color = {0, 0, 127}));
  connect(add1.y, gain1.u) annotation(
    Line(points = {{72, -27}, {72, -29}, {56, -29}, {56, -5}, {27, -5}, {27, -7}, {-2, -7}}, color = {0, 0, 127}));
  connect(PI.y, add1.u2) annotation(
    Line(points = {{7, 24}, {13, 24}, {13, 2}, {65, 2}, {65, -4}, {65, -4}}, color = {0, 0, 127}));
  connect(p_set1.y, feedback1.u2) annotation(
    Line(points = {{45, -120}, {52, -120}, {52, -22}, {-64, -22}, {-64, 16}, {-68, 16}}, color = {0, 0, 127}));
  connect(u2, feedback1.u1) annotation(
    Line(points = {{-120, -106}, {-74, -106}, {-74, 16}, {-84, 16}, {-84, 24}, {-76, 24}}, color = {0, 0, 127}));
  connect(booleanToReal1.y, y2) annotation(
    Line(points = {{86, -90}, {102, -90}, {102, -90}, {110, -90}}, color = {0, 0, 127}));
  connect(onAuto1.y, booleanToReal1.u) annotation(
    Line(points = {{14, -136}, {58, -136}, {58, -90}, {62, -90}, {62, -90}}, color = {255, 0, 255}));
  connect(greater1.y, onAuto1.u) annotation(
    Line(points = {{-49, -120}, {-27.75, -120}, {-27.75, -136}, {-10, -136}}, color = {255, 0, 255}));
  connect(u2, dp_hp.u) annotation(
    Line(points = {{-120, -106}, {-68, -106}, {-68, -88}, {-60, -88}, {-60, -88}}, color = {0, 0, 127}));
  connect(const_1.y, greater1.u2) annotation(
    Line(points = {{-78, -140}, {-76, -140}, {-76, -128}, {-72, -128}, {-72, -128}}, color = {0, 0, 127}));
  connect(u2, greater1.u1) annotation(
    Line(points = {{-120, -106}, {-96, -106}, {-96, -120}, {-72, -120}}, color = {0, 0, 127}));
  connect(u2, p_set1.u2) annotation(
    Line(points = {{-120, -106}, {-48, -106}, {-48, -112}, {22, -112}}, color = {0, 0, 127}));
  connect(RS_is_open.y, greater4.u2) annotation(
    Line(points = {{-77, -80}, {-10, -80}}, color = {0, 0, 127}));
  connect(onAuto1.y, p_set1.u1) annotation(
    Line(points = {{13, -136}, {16.5, -136}, {16.5, -128}, {22, -128}}, color = {255, 0, 255}));
  connect(and11.y, p_set1.refresh) annotation(
    Line(points = {{46, -80}, {46, -80}, {46, -106}, {14, -106}, {14, -120}, {22, -120}, {22, -120}}, color = {255, 0, 255}));
  connect(greater3.y, and11.u1) annotation(
    Line(points = {{14, -94}, {18, -94}, {18, -80}, {22, -80}}, color = {255, 0, 255}));
  connect(greater4.y, and11.u2) annotation(
    Line(points = {{14, -72}, {22, -72}}, color = {255, 0, 255}));
  connect(p_set1.speed_p, p_speed_in_internal) annotation(
    Line);
  connect(dp_hp.y, greater3.u1) annotation(
    Line(points = {{-37, -88}, {-19.5, -88}, {-19.5, -94}, {-10, -94}}, color = {0, 0, 127}));
  if use_p_speed_in then
    connect(p_speed_in, p_speed_in_internal);
  else
    p_speed_in_internal = speed_p;
  end if;
  connect(greater3.u2, p_speed_in_internal);
  annotation(
    Documentation(info = "<html>
<style>
p {
  text-indent: 20px;
  text-align: 'justify';
 }
</style>
<p>Регулятор давления имеет средующие входы:</p>
<ul>
  <li>u1 - прожение реглирующего клапана БРОУ;</li>
  <li>u2 - показания датчика давления, регулируемая величина;</li>
  <li>u3 - положение РК ПТУ;</li>
  <li>p_speed_in - задание скорости нарастания давления.</li>
</ul>
<p>Регулятор имеет следующие выходы:</p>
<ul>
  <li>y - управляющий сигнал БРОУ;</li>
  <li>y1 - управляющий сигнал на задвижки продувочных линий КУ.</li>
</ul>
<p>Функциональную схему регулятора условно можно разделить на три состаляющие:</p>
<ol>
  <li>Формирование задания по давлению;</li>
  <li>PI регулятор;</li>
  <li>Ограничения по УП клапанов.</li>
</ol>
<p>При формировании сигнала по давлению учитывается заданное значение, которое должно поддерживаться регулятором, и заданная скорость нарастания. С случае превышения скорости нарастания давления заданной величины обновляются внутренние переменные блока 'set_p'.</p>
</html>", revisions = "<html>
<ul>
<li><i>07 July 2018</i>
by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
   Создан.</li>
</ul>
</html>"),
    Icon(graphics = {Text(lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Ellipse(origin = {-62, -1}, lineColor = {0, 0, 255}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-36, 87}, {36, -87}}, endAngle = 360), Line(origin = {22.78, -53.61}, points = {{-56, 0}, {76, 0}}, color = {0, 0, 255}, thickness = 1, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 15), Polygon(origin = {33, -53}, lineColor = {0, 0, 255}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{-21, -11}, {-21, 11}, {21, -11}, {21, 11}, {21, 11}, {-21, -11}}), Line(origin = {-11, -3}, points = {{-45, 41}, {45, 41}, {45, -41}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}, arrowSize = 15)}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Diagram(graphics = {Rectangle(origin = {0, -105}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 65}, {100, -45}}), Rectangle(origin = {0, 105}, fillColor = {255, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-100, -45}, {100, 45}}), Rectangle(fillColor = {101, 203, 150}, fillPattern = FillPattern.Solid, extent = {{-100, 60}, {100, -40}}), Text(origin = {-41, -52}, extent = {{-33, 12}, {93, 0}}, textString = "Формирование задания по давлению", fontSize = 5), Text(origin = {-65, 46}, extent = {{-33, 12}, {41, 2}}, textString = "PI регулятор", fontSize = 5), Text(origin = {-39, 58}, extent = {{-33, 12}, {41, 2}}, textString = "Ограничения по УП клапанов", fontSize = 5)}, coordinateSystem(extent = {{-100, -150}, {100, 150}})),
    __OpenModelica_commandLineOptions = "");
end pressure_control_4;
