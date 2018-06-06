within TPPSim.Controls;

block LC_sink "Регулятор уроня в сепараторе КУ, воздействует на слив"
  extends Modelica.Blocks.Interfaces.SISO;
  extends TPPSim.Controls.BaseClasses.Icons.IconLC;
  parameter Modelica.SIunits.MassFlowRate DFmax "Максимальный расход питательной воды";
  parameter Modelica.SIunits.MassFlowRate DFmin "Минимальный расход питательной воды";
  parameter Modelica.SIunits.Length L "Поддерживаемый уровень";
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI(T = 120, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 100, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = DFmax, uMin = DFmin) annotation(
    Placement(visible = true, transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant set_level(k = L) annotation(
    Placement(visible = true, transformation(origin = {-70,-30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(set_level.y, feedback.u2) annotation(
    Line(points = {{-58, -30}, {0, -30}, {0, -8}, {0, -8}}, color = {0, 0, 127}));
  connect(u, feedback.u1) annotation(
    Line(points = {{-120, 0}, {-8, 0}, {-8, 0}, {-8, 0}}, color = {0, 0, 127}));
  connect(limiter.y, y) annotation(
    Line(points = {{88, 0}, {102, 0}, {102, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(PI.y, limiter.u) annotation(
    Line(points = {{48, 0}, {64, 0}, {64, 0}, {64, 0}}, color = {0, 0, 127}));
  connect(feedback.y, PI.u) annotation(
    Line(points = {{10, 0}, {24, 0}, {24, 0}, {24, 0}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html><head></head><body>
    Модель регулирования уровня с воздействием на сливной клапан сепаратора.
    </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>May 23, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end LC_sink;
