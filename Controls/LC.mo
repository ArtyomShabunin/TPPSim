﻿within TPPSim.Controls;
block LC "Регулятор уроня в барабане КУ"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Modelica.SIunits.Length levelSP;
  parameter Modelica.SIunits.MassFlowRate DFmax "Максимальный расход питательной воды";
  parameter Modelica.SIunits.MassFlowRate DFmin "Минимальный расход питательной воды";
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant levelSet(k = levelSP) annotation(
    Placement(visible = true, transformation(origin = {-49, -1}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI(T = 120, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 100, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = DFmax, uMin = DFmin) annotation(
    Placement(visible = true, transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(limiter.y, y) annotation(
    Line(points = {{88, 0}, {102, 0}, {102, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(PI.y, limiter.u) annotation(
    Line(points = {{48, 0}, {64, 0}, {64, 0}, {64, 0}}, color = {0, 0, 127}));
  connect(feedback.y, PI.u) annotation(
    Line(points = {{10, 0}, {24, 0}, {24, 0}, {24, 0}}, color = {0, 0, 127}));
  connect(u, feedback.u2) annotation(
    Line(points = {{-120, 0}, {-80, 0}, {-80, -40}, {0, -40}, {0, -8}, {0, -8}}, color = {0, 0, 127}));
  connect(levelSet.y, feedback.u1) annotation(
    Line(points = {{-38, 0}, {-8, 0}, {-8, 0}, {-8, 0}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html><head></head><body>Простейший регулятор уровня в барабане</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>July 08, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(graphics = {Text(origin = {4, 54}, extent = {{-104, 26}, {96, -16}}, textString = "Level", fontSize = 30), Text(origin = {4, 10}, extent = {{-104, 26}, {96, -16}}, textString = "Controller", fontSize = 30), Text(origin = {4, -46}, lineColor = {0, 170, 0}, extent = {{-104, 26}, {96, -16}}, textString = "SP %levelSP m", fontSize = 30, textStyle = {TextStyle.Bold})}));
end LC;