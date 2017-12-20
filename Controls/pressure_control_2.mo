within TPPSim.Controls;

block pressure_control_2
  extends Modelica.Blocks.Interfaces.SI2SO;
  parameter Modelica.SIunits.AbsolutePressure set_p "Поддерживаемое давление";
  parameter Real speed_p "Скорость повышения давления";
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {-46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater1 annotation(
    Placement(visible = true, transformation(origin = {-48, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 2e5) annotation(
    Placement(visible = true, transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.onAuto onAuto1 annotation(
    Placement(visible = true, transformation(origin = {-8, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u3 annotation(
    Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 1, uMin = 0)  annotation(
    Placement(visible = true, transformation(origin = {32, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI(T = 10, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 0.001, y_start = 0.01)  annotation(
    Placement(visible = true, transformation(origin = {-6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  p_set p_set1(set_p = set_p, speed_p = speed_p) annotation(
    Placement(visible = true, transformation(origin = {28, -52}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.001)  annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Less less1 annotation(
    Placement(visible = true, transformation(origin = {-50, 60}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater2 annotation(
    Placement(visible = true, transformation(origin = {-32, 20}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.pre pre1 annotation(
    Placement(visible = true, transformation(origin = {70, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(and1.y, pre1.u1) annotation(
    Line(points = {{22, 50}, {50, 50}, {50, 16}, {58, 16}, {58, 16}}, color = {255, 0, 255}));
  connect(pre1.y, y) annotation(
    Line(points = {{82, 8}, {88, 8}, {88, 0}, {110, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(limiter1.y, pre1.u2) annotation(
    Line(points = {{44, 0}, {58, 0}, {58, 0}, {58, 0}}, color = {0, 0, 127}));
  connect(greater2.y, and1.u2) annotation(
    Line(points = {{-20, 20}, {-12, 20}, {-12, 42}, {-2, 42}, {-2, 42}}, color = {255, 0, 255}));
  connect(less1.y, and1.u1) annotation(
    Line(points = {{-38, 60}, {-14, 60}, {-14, 50}, {-2, 50}, {-2, 50}}, color = {255, 0, 255}));
  connect(const.y, greater2.u2) annotation(
    Line(points = {{-78, 90}, {-20, 90}, {-20, 42}, {-52, 42}, {-52, 28}, {-44, 28}, {-44, 28}}, color = {0, 0, 127}));
  connect(u3, greater2.u1) annotation(
    Line(points = {{-120, 20}, {-44, 20}, {-44, 20}, {-44, 20}}, color = {0, 0, 127}));
  connect(u1, less1.u1) annotation(
    Line(points = {{-120, 60}, {-64, 60}, {-64, 60}, {-62, 60}}, color = {0, 0, 127}));
  connect(const.y, less1.u2) annotation(
    Line(points = {{-78, 90}, {-74, 90}, {-74, 68}, {-62, 68}, {-62, 68}}, color = {0, 0, 127}));
  connect(u2, feedback1.u1) annotation(
    Line(points = {{-120, -60}, {-88, -60}, {-88, 0}, {-54, 0}, {-54, 0}}, color = {0, 0, 127}));
  connect(p_set1.y, feedback1.u2) annotation(
    Line(points = {{40, -52}, {46, -52}, {46, -28}, {-44, -28}, {-44, -8}, {-46, -8}}, color = {0, 0, 127}));
  connect(onAuto1.y, p_set1.u1) annotation(
    Line(points = {{4, -60}, {16, -60}, {16, -60}, {16, -60}}, color = {255, 0, 255}));
  connect(u2, p_set1.u2) annotation(
    Line(points = {{-120, -60}, {-80, -60}, {-80, -44}, {16, -44}, {16, -44}}, color = {0, 0, 127}));
  connect(feedback1.y, PI.u) annotation(
    Line(points = {{-37, 0}, {-28, 0}, {-28, 0}, {-19, 0}, {-19, 0}, {-19, 0}, {-19, 0}, {-19, 0}}, color = {0, 0, 127}));
  connect(PI.y, limiter1.u) annotation(
    Line(points = {{5, 0}, {8.5, 0}, {8.5, 0}, {12, 0}, {12, 0}, {19, 0}, {19, 0}, {19, 0}, {19, 0}, {19, 0}}, color = {0, 0, 127}));
  connect(greater1.y, onAuto1.u) annotation(
    Line(points = {{-37, -60}, {-20, -60}}, color = {255, 0, 255}));
  connect(u2, greater1.u1) annotation(
    Line(points = {{-120, -60}, {-60, -60}}, color = {0, 0, 127}));
  connect(const1.y, greater1.u2) annotation(
    Line(points = {{-78, -90}, {-72, -90}, {-72, -68}, {-60, -68}}, color = {0, 0, 127}));
end pressure_control_2;
