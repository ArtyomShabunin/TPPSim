within TPPSim.Controls;

block dp_control
  extends Modelica.Blocks.Interfaces.SISO;
  Modelica.Blocks.Sources.Constant const(k = 0.5e5)  annotation(
    Placement(visible = true, transformation(origin = {-90, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI(T = 20, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 0.00001, y_start = 0)  annotation(
    Placement(visible = true, transformation(origin = {11, 5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {-65, -1}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 1, uMin = 0)  annotation(
    Placement(visible = true, transformation(origin = {51, 5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {51, 43}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Math.Gain gain1(k = 1 / 0.0001 / 0.8)  annotation(
    Placement(visible = true, transformation(origin = {-1, 67}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2 annotation(
    Placement(visible = true, transformation(origin = {-29, 5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(gain1.y, add2.u1) annotation(
    Line(points = {{-12, 68}, {-50, 68}, {-50, 10}, {-40, 10}, {-40, 12}}, color = {0, 0, 127}));
  connect(limiter1.y, add1.u2) annotation(
    Line(points = {{62, 6}, {68, 6}, {68, 22}, {57, 22}, {57, 31}}, color = {0, 0, 127}));
  connect(PI.y, add1.u1) annotation(
    Line(points = {{22, 6}, {30, 6}, {30, 22}, {45, 22}, {45, 31}}, color = {0, 0, 127}));
  connect(add1.y, gain1.u) annotation(
    Line(points = {{51, 54}, {48, 54}, {48, 67}, {11, 67}}, color = {0, 0, 127}));
  connect(limiter1.y, y) annotation(
    Line(points = {{62, 5}, {80, 5}, {80, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(PI.y, limiter1.u) annotation(
    Line(points = {{22, 5}, {39, 5}}, color = {0, 0, 127}));
  connect(add2.y, PI.u) annotation(
    Line(points = {{-18, 5}, {-1, 5}}, color = {0, 0, 127}));
  connect(feedback1.y, add2.u2) annotation(
    Line(points = {{-56, -1}, {-41, -1}}, color = {0, 0, 127}));
  connect(const.y, feedback1.u2) annotation(
    Line(points = {{-78, 32}, {-65, 32}, {-65, 7}}, color = {0, 0, 127}));
  connect(u, feedback1.u1) annotation(
    Line(points = {{-120, 0}, {-98, 0}, {-98, -1}, {-73, -1}}, color = {0, 0, 127}));
end dp_control;
