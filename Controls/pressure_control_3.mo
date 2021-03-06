﻿within TPPSim.Controls;

block pressure_control_3
  extends Modelica.Blocks.Interfaces.SI2SO;
  parameter Modelica.SIunits.AbsolutePressure P_activation "Давление при котором регулятор переходит в автоматический режим";
  parameter Modelica.SIunits.AbsolutePressure set_p "Поддерживаемое давление";
  parameter Real pos_start = 0.002 "Исходное УП регулирующего клапана";
  parameter Real speed_p "Скорость повышения давления";
  parameter Real k = 0.001 "Коэффициент усиления" 
   annotation(Dialog(group = "Параметры регулятора"));
  parameter Real T = 10 "Постоянная времени" 
   annotation(Dialog(group = "Параметры регулятора"));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater1 annotation(
    Placement(visible = true, transformation(origin = {-60, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_1(k = P_activation) annotation(
    Placement(visible = true, transformation(origin = {-92, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.onAuto onAuto1 annotation(
    Placement(visible = true, transformation(origin = {18, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u3 annotation(
    Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI(T = T, initType = Modelica.Blocks.Types.Init.InitialOutput, k = k, y_start = pos_start)  annotation(
    Placement(visible = true, transformation(origin = {-6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.p_set p_set1(set_p = set_p, speed_p = speed_p) annotation(
    Placement(visible = true, transformation(origin = {48, -70}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.9)  annotation(
    Placement(visible = true, transformation(origin = {-52, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Less less1 annotation(
    Placement(visible = true, transformation(origin = {-50, 60}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater2 annotation(
    Placement(visible = true, transformation(origin = {-32, 20}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {70, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Gain gain1(k = 1 / k / 0.8)  annotation(
    Placement(visible = true, transformation(origin = {38, -98}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2 annotation(
    Placement(visible = true, transformation(origin = {-40, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter1 annotation(
    Placement(visible = true, transformation(origin = {34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant max_lim(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant min_lim_1(k = pos_start)  annotation(
    Placement(visible = true, transformation(origin = {50, 90}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant min_lim_2(k = 0)  annotation(
    Placement(visible = true, transformation(origin = {12, 90}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {56, 48}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanOutput y2 annotation(
    Placement(visible = true, transformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput u4 annotation(
    Placement(visible = true, transformation(origin = {-34, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-34, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  TPPSim.Controls.pre pre2 annotation(
    Placement(visible = true, transformation(origin = {-6, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.onAuto onAuto2 annotation(
    Placement(visible = true, transformation(origin = {-34, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.And and11 annotation(
    Placement(visible = true, transformation(origin = {-12, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 0.05)  annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(and1.y, switch1.u2) annotation(
    Line(points = {{22, 50}, {34, 50}, {34, 66}, {56, 66}, {56, 60}, {56, 60}}, color = {255, 0, 255}));
  connect(variableLimiter1.y, switch1.u3) annotation(
    Line(points = {{46, 0}, {80, 0}, {80, 62}, {64, 62}, {64, 60}}, color = {0, 0, 127}));
  connect(switch1.y, y) annotation(
    Line(points = {{56, 38}, {56, 38}, {56, 18}, {82, 18}, {82, 0}, {110, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(min_lim_1.y, variableLimiter1.limit2) annotation(
    Line(points = {{40, 90}, {34, 90}, {34, 70}, {70, 70}, {70, -16}, {22, -16}, {22, -8}, {22, -8}}, color = {0, 0, 127}));
  connect(const1.y, less1.u2) annotation(
    Line(points = {{-78, 90}, {-74, 90}, {-74, 68}, {-62, 68}, {-62, 68}}, color = {0, 0, 127}));
  connect(const.y, greater2.u2) annotation(
    Line(points = {{-41, 90}, {-20, 90}, {-20, 42}, {-52, 42}, {-52, 28}, {-44, 28}}, color = {0, 0, 127}));
  connect(onAuto1.y, p_set1.u1) annotation(
    Line(points = {{29, -78}, {36, -78}}, color = {255, 0, 255}));
  connect(p_set1.y, feedback1.u2) annotation(
    Line(points = {{60, -70}, {64, -70}, {64, -56}, {-70, -56}, {-70, -8}, {-70, -8}}, color = {0, 0, 127}));
  connect(pre2.y, p_set1.u2) annotation(
    Line(points = {{6, -42}, {14, -42}, {14, -62}, {36, -62}}, color = {0, 0, 127}));
  connect(onAuto2.y, and11.u1) annotation(
    Line(points = {{-22, -34}, {-22, -34}, {-22, -62}, {-28, -62}, {-28, -74}, {-28, -74}, {-28, -78}, {-24, -78}, {-24, -78}}, color = {255, 0, 255}));
  connect(u4, and11.u2) annotation(
    Line(points = {{-34, -120}, {-34, -120}, {-34, -86}, {-24, -86}, {-24, -86}}, color = {255, 0, 255}));
  connect(and11.y, onAuto1.u) annotation(
    Line(points = {{-1, -78}, {6, -78}}, color = {255, 0, 255}));
  connect(onAuto2.y, y2) annotation(
    Line(points = {{-22, -34}, {-20, -34}, {-20, -28}, {54, -28}, {54, -90}, {110, -90}, {110, -90}}, color = {255, 0, 255}));
  connect(greater1.y, onAuto2.u) annotation(
    Line(points = {{-48, -82}, {-42, -82}, {-42, -64}, {-58, -64}, {-58, -34}, {-46, -34}, {-46, -34}}, color = {255, 0, 255}));
  connect(onAuto2.y, pre2.u1) annotation(
    Line(points = {{-22, -34}, {-20, -34}, {-20, -34}, {-18, -34}}, color = {255, 0, 255}));
  connect(u2, pre2.u2) annotation(
    Line(points = {{-120, -60}, {-74, -60}, {-74, -50}, {-18, -50}, {-18, -50}}, color = {0, 0, 127}));
  connect(const_1.y, greater1.u2) annotation(
    Line(points = {{-81, -90}, {-72, -90}}, color = {0, 0, 127}));
  connect(u2, greater1.u1) annotation(
    Line(points = {{-120, -60}, {-96, -60}, {-96, -82}, {-72, -82}}, color = {0, 0, 127}));
  connect(add1.y, gain1.u) annotation(
    Line(points = {{70, -52}, {70, -98}, {50, -98}}, color = {0, 0, 127}));
  connect(gain1.y, add2.u2) annotation(
    Line(points = {{27, -98}, {-30, -98}, {-30, -30}, {-54, -30}, {-54, -12}, {-52, -12}}, color = {0, 0, 127}));
  connect(variableLimiter1.y, add1.u1) annotation(
    Line(points = {{46, 0}, {50, 0}, {50, -12}, {76, -12}, {76, -28}, {76, -28}}, color = {0, 0, 127}));
  connect(min_lim_2.y, switch1.u1) annotation(
    Line(points = {{0, 90}, {-8, 90}, {-8, 70}, {26, 70}, {26, 62}, {48, 62}, {48, 60}}, color = {0, 0, 127}));
  connect(max_lim.y, variableLimiter1.limit1) annotation(
    Line(points = {{78, 90}, {74, 90}, {74, 28}, {22, 28}, {22, 28}, {14, 28}, {14, 8}, {22, 8}, {22, 8}}, color = {0, 0, 127}));
  connect(PI.y, variableLimiter1.u) annotation(
    Line(points = {{6, 0}, {22, 0}, {22, 0}, {22, 0}}, color = {0, 0, 127}));
  connect(add2.y, PI.u) annotation(
    Line(points = {{-28, -6}, {-26, -6}, {-26, 0}, {-18, 0}, {-18, 0}}, color = {0, 0, 127}));
  connect(feedback1.y, add2.u1) annotation(
    Line(points = {{-60, 0}, {-54, 0}, {-54, 0}, {-52, 0}}, color = {0, 0, 127}));
  connect(u2, feedback1.u1) annotation(
    Line(points = {{-120, -60}, {-88, -60}, {-88, 0}, {-78, 0}}, color = {0, 0, 127}));
  connect(PI.y, add1.u2) annotation(
    Line(points = {{6, 0}, {12, 0}, {12, -22}, {64, -22}, {64, -28}, {64, -28}}, color = {0, 0, 127}));
  connect(greater2.y, and1.u2) annotation(
    Line(points = {{-20, 20}, {-12, 20}, {-12, 42}, {-2, 42}, {-2, 42}}, color = {255, 0, 255}));
  connect(less1.y, and1.u1) annotation(
    Line(points = {{-38, 60}, {-14, 60}, {-14, 50}, {-2, 50}, {-2, 50}}, color = {255, 0, 255}));
  connect(u3, greater2.u1) annotation(
    Line(points = {{-120, 20}, {-44, 20}, {-44, 20}, {-44, 20}}, color = {0, 0, 127}));
  connect(u1, less1.u1) annotation(
    Line(points = {{-120, 60}, {-64, 60}, {-64, 60}, {-62, 60}}, color = {0, 0, 127}));
end pressure_control_3;
