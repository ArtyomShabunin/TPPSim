within TPPSim.Controls;

block LC "Регулятор уроня в барабане КУ"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Modelica.SIunits.Length levelSP;
  parameter Modelica.SIunits.MassFlowRate DFmax "Максимальный расход питательной воды";
  parameter Modelica.SIunits.MassFlowRate DFmin "Минимальный расход питательной воды";
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI(T = 120, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 100, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = DFmax, uMin = DFmin) annotation(
    Placement(visible = true, transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Less less annotation(
    Placement(visible = true, transformation(origin = {-12, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant min_der(k = -1e-5) annotation(
    Placement(visible = true, transformation(origin = {-50, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.onAuto onAuto1 annotation(
    Placement(visible = true, transformation(origin = {22, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.pre pre1 annotation(
    Placement(visible = true, transformation(origin = {-44, -8}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Derivative derivative1(initType = Modelica.Blocks.Types.Init.SteadyState)  annotation(
    Placement(visible = true, transformation(origin = {-60, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(derivative1.u, u) annotation(
    Line(points = {{-72, -50}, {-86, -50}, {-86, 0}, {-120, 0}, {-120, 0}}, color = {0, 0, 127}));
  connect(less.u1, derivative1.y) annotation(
    Line(points = {{-24, -50}, {-50, -50}, {-50, -50}, {-48, -50}}, color = {0, 0, 127}));
  connect(u, feedback.u2) annotation(
    Line(points = {{-120, 0}, {-74, 0}, {-74, -24}, {0, -24}, {0, -8}, {0, -8}}, color = {0, 0, 127}));
  connect(pre1.y, feedback.u1) annotation(
    Line(points = {{-32, -8}, {-20, -8}, {-20, 0}, {-8, 0}, {-8, 0}}, color = {0, 0, 127}));
  connect(u, pre1.u2) annotation(
    Line(points = {{-120, 0}, {-58, 0}, {-58, 0}, {-56, 0}}, color = {0, 0, 127}));
  connect(onAuto1.y, pre1.u1) annotation(
    Line(points = {{34, -50}, {42, -50}, {42, -30}, {-66, -30}, {-66, -16}, {-56, -16}, {-56, -16}}, color = {255, 0, 255}));
  connect(less.y, onAuto1.u) annotation(
    Line(points = {{0, -50}, {10, -50}, {10, -50}, {10, -50}}, color = {255, 0, 255}));
  connect(min_der.y, less.u2) annotation(
    Line(points = {{-38, -82}, {-34, -82}, {-34, -58}, {-24, -58}, {-24, -58}}, color = {0, 0, 127}));
  connect(limiter.y, y) annotation(
    Line(points = {{88, 0}, {102, 0}, {102, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(PI.y, limiter.u) annotation(
    Line(points = {{48, 0}, {64, 0}, {64, 0}, {64, 0}}, color = {0, 0, 127}));
  connect(feedback.y, PI.u) annotation(
    Line(points = {{10, 0}, {24, 0}, {24, 0}, {24, 0}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html><head></head><body>Простейший регулятор уровня в барабане</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>July 08, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(graphics = {Text(origin = {4, 54}, extent = {{-104, 26}, {96, -16}}, textString = "Level", fontSize = 30), Text(origin = {4, 10}, extent = {{-104, 26}, {96, -16}}, textString = "Controller", fontSize = 30), Text(origin = {4, -46}, lineColor = {0, 170, 0}, extent = {{-104, 26}, {96, -16}}, textString = "SP %levelSP m", fontSize = 30, textStyle = {TextStyle.Bold})}));
end LC;
