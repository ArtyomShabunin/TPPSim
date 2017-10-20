within TPPSim.Controls.BaseClasses.Icons;

block IconLC "Регулятор уроня в барабане КУ"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Modelica.SIunits.MassFlowRate DFmax "Максимальный расход питательной воды";
  parameter Modelica.SIunits.MassFlowRate DFmin "Минимальный расход питательной воды";
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI(T = 120, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 100, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = DFmax, uMin = DFmin) annotation(
    Placement(visible = true, transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Less less annotation(
    Placement(visible = true, transformation(origin = {10, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant min_der(k = -1e-5) annotation(
    Placement(visible = true, transformation(origin = {-30, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.onAuto onAuto1 annotation(
    Placement(visible = true, transformation(origin = {50, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.pre pre1 annotation(
    Placement(visible = true, transformation(origin = {-44, -8}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Derivative derivative1(initType = Modelica.Blocks.Types.Init.SteadyState)  annotation(
    Placement(visible = true, transformation(origin = {-70, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Filter filter1(f_cut = 2)  annotation(
    Placement(visible = true, transformation(origin = {-26, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(filter1.y, less.u1) annotation(
    Line(points = {{-14, -50}, {-2, -50}, {-2, -50}, {-2, -50}}, color = {0, 0, 127}));
  connect(derivative1.y, filter1.u) annotation(
    Line(points = {{-58, -50}, {-40, -50}, {-40, -50}, {-38, -50}}, color = {0, 0, 127}));
  connect(onAuto1.y, pre1.u1) annotation(
    Line(points = {{62, -50}, {76, -50}, {76, -28}, {-66, -28}, {-66, -16}, {-56, -16}, {-56, -16}}, color = {255, 0, 255}));
  connect(min_der.y, less.u2) annotation(
    Line(points = {{-18, -82}, {-10, -82}, {-10, -58}, {-2, -58}, {-2, -58}}, color = {0, 0, 127}));
  connect(derivative1.u, u) annotation(
    Line(points = {{-82, -50}, {-86, -50}, {-86, 0}, {-120, 0}}, color = {0, 0, 127}));
  connect(less.y, onAuto1.u) annotation(
    Line(points = {{21, -50}, {38, -50}}, color = {255, 0, 255}));
  connect(u, feedback.u2) annotation(
    Line(points = {{-120, 0}, {-74, 0}, {-74, -24}, {0, -24}, {0, -8}, {0, -8}}, color = {0, 0, 127}));
  connect(pre1.y, feedback.u1) annotation(
    Line(points = {{-32, -8}, {-20, -8}, {-20, 0}, {-8, 0}, {-8, 0}}, color = {0, 0, 127}));
  connect(u, pre1.u2) annotation(
    Line(points = {{-120, 0}, {-58, 0}, {-58, 0}, {-56, 0}}, color = {0, 0, 127}));
  connect(limiter.y, y) annotation(
    Line(points = {{88, 0}, {102, 0}, {102, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(PI.y, limiter.u) annotation(
    Line(points = {{48, 0}, {64, 0}, {64, 0}, {64, 0}}, color = {0, 0, 127}));
  connect(feedback.y, PI.u) annotation(
    Line(points = {{10, 0}, {24, 0}, {24, 0}, {24, 0}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html><head></head><body>
    Простейший регулятор уровня в барабане.<br>
    Регулятор включается после того как производная по уровню становится меньше -1e-5.
    </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>July 08, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Polygon(origin = {0, -54}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{-100, -46}, {-100, 40}, {-88, 44}, {-70, 46}, {-60, 46}, {-44, 44}, {-18, 40}, {12, 34}, {32, 34}, {52, 36}, {88, 42}, {100, 42}, {100, -46}, {-100, -46}}), Rectangle(origin = {-48, -10}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-22, 22}, {22, -22}}, radius = 8), Polygon(origin = {-48, 17}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Solid, points = {{-8, -5}, {8, -5}, {4, 5}, {-4, 5}, {-8, -5}}), Rectangle(origin = {89, 68}, fillColor = {135, 135, 135}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-11, 8}, {11, -12}}), Ellipse(origin = {77, 66}, fillColor = {135, 135, 135}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-11, 10}, {11, -10}}, endAngle = 360), Rectangle(origin = {29, 45.5}, rotation = 21, fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-87, 4}, {67, -2}}, radius = 3), Ellipse(origin = {-48, 17}, fillColor = {39, 39, 39}, fillPattern = FillPattern.Solid, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {81, 66.5}, fillColor = {39, 39, 39}, fillPattern = FillPattern.Solid, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Rectangle(origin = {76, 24}, rotation = -45, fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-48, 4}, {40, -4}}, radius = 4), Ellipse(origin = {46.5, 53.5}, fillColor = {39, 39, 39}, fillPattern = FillPattern.Solid, extent = {{-3, 3}, {3, -3}}, endAngle = 360)}));
end IconLC;
