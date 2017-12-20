within TPPSim.Controls;

block pressure_control
  extends Modelica.Blocks.Interfaces.SI2SO;
  parameter Modelica.SIunits.AbsolutePressure set_p "Поддерживаемое давление";
  Modelica.Blocks.Continuous.PI PI(T = 10, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 0.001, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {-8, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {-48, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 1, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {30, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater1 annotation(
    Placement(visible = true, transformation(origin = {-50, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = set_p) annotation(
    Placement(visible = true, transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.pre pre1 annotation(
    Placement(visible = true, transformation(origin = {34, -62}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  TPPSim.Controls.onAuto onAuto1 annotation(
    Placement(visible = true, transformation(origin = {-8, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater2 annotation(
    Placement(visible = true, transformation(origin = {-50, 60}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.003)  annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u3 annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater3 annotation(
    Placement(visible = true, transformation(origin = {-52, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {-16, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {50, -28}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Blocks.Math.Max max1 annotation(
    Placement(visible = true, transformation(origin = {66, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(u1, y) annotation(
    Line(points = {{-120, 60}, {-88, 60}, {-88, 46}, {88, 46}, {88, 0}, {110, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(u1, max1.u1) annotation(
    Line(points = {{-120, 60}, {-84, 60}, {-84, 40}, {44, 40}, {44, 26}, {54, 26}, {54, 26}}, color = {0, 0, 127}));
  connect(limiter1.y, max1.u2) annotation(
    Line(points = {{42, 14}, {54, 14}, {54, 14}, {54, 14}}, color = {0, 0, 127}));
  connect(switch1.y, feedback1.u2) annotation(
    Line(points = {{50, -16}, {48, -16}, {48, -8}, {-48, -8}, {-48, 6}, {-48, 6}}, color = {0, 0, 127}));
  connect(u2, switch1.u3) annotation(
    Line(points = {{-120, -60}, {-62, -60}, {-62, -50}, {42, -50}, {42, -40}, {42, -40}}, color = {0, 0, 127}));
  connect(pre1.y, switch1.u1) annotation(
    Line(points = {{46, -62}, {58, -62}, {58, -40}, {58, -40}}, color = {0, 0, 127}));
  connect(and1.y, switch1.u2) annotation(
    Line(points = {{-4, -28}, {12, -28}, {12, -46}, {50, -46}, {50, -40}, {50, -40}}, color = {255, 0, 255}));
  connect(greater2.y, and1.u1) annotation(
    Line(points = {{-38, 60}, {-32, 60}, {-32, -28}, {-28, -28}, {-28, -28}}, color = {255, 0, 255}));
  connect(greater3.y, and1.u2) annotation(
    Line(points = {{-40, -36}, {-28, -36}, {-28, -36}, {-28, -36}}, color = {255, 0, 255}));
  connect(u2, greater3.u1) annotation(
    Line(points = {{-120, -60}, {-96, -60}, {-96, -36}, {-64, -36}}, color = {0, 0, 127}));
  connect(u3, greater3.u2) annotation(
    Line(points = {{-120, 0}, {-72, 0}, {-72, -44}, {-64, -44}}, color = {0, 0, 127}));
  connect(u1, greater2.u1) annotation(
    Line(points = {{-120, 60}, {-62, 60}, {-62, 60}, {-62, 60}}, color = {0, 0, 127}));
  connect(u3, pre1.u2) annotation(
    Line(points = {{-120, 0}, {-90, 0}, {-90, -54}, {22, -54}, {22, -54}}, color = {0, 0, 127}));
  connect(const.y, greater2.u2) annotation(
    Line(points = {{-78, 90}, {-72, 90}, {-72, 68}, {-62, 68}, {-62, 68}}, color = {0, 0, 127}));
  connect(feedback1.y, PI.u) annotation(
    Line(points = {{-38, 14}, {-20, 14}, {-20, 14}, {-20, 14}}, color = {0, 0, 127}));
  connect(u2, feedback1.u1) annotation(
    Line(points = {{-120, -60}, {-76, -60}, {-76, 14}, {-56, 14}, {-56, 14}}, color = {0, 0, 127}));
  connect(onAuto1.y, pre1.u1) annotation(
    Line(points = {{4, -70}, {22, -70}, {22, -70}, {22, -70}}, color = {255, 0, 255}));
  connect(greater1.y, onAuto1.u) annotation(
    Line(points = {{-38, -70}, {-20, -70}, {-20, -70}, {-20, -70}}, color = {255, 0, 255}));
  connect(PI.y, limiter1.u) annotation(
    Line(points = {{3, 14}, {10, 14}, {10, 14}, {17, 14}, {17, 14}, {17, 14}}, color = {0, 0, 127}));
  connect(const1.y, greater1.u2) annotation(
    Line(points = {{-78, -90}, {-72, -90}, {-72, -78}, {-62, -78}, {-62, -78}}, color = {0, 0, 127}));
  connect(u2, greater1.u1) annotation(
    Line(points = {{-120, -60}, {-92, -60}, {-92, -70}, {-62, -70}}, color = {0, 0, 127}));
end pressure_control;
