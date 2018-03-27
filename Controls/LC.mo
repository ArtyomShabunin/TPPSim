within TPPSim.Controls;

block LC "Регулятор уроня в барабане КУ"
  extends Modelica.Blocks.Interfaces.SISO;
  extends TPPSim.Controls.BaseClasses.Icons.IconLC;
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
  Modelica.Blocks.Continuous.Filter filter1(analogFilter = Modelica.Blocks.Types.AnalogFilter.CriticalDamping, f_cut = 1, order = 5)  annotation(
    Placement(visible = true, transformation(origin = {-26, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y1 annotation(
    Placement(visible = true, transformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant min(k = DFmin)  annotation(
    Placement(visible = true, transformation(origin = {10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = DFmin, uMin = 0)  annotation(
    Placement(visible = true, transformation(origin = {80, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(feedback1.y, limiter1.u) annotation(
    Line(points = {{60, 30}, {68, 30}, {68, 30}, {68, 30}}, color = {0, 0, 127}));
  connect(min.y, feedback1.u1) annotation(
    Line(points = {{21, 30}, {42, 30}}, color = {0, 0, 127}));
  connect(PI.y, feedback1.u2) annotation(
    Line(points = {{48, 0}, {50, 0}, {50, 22}}, color = {0, 0, 127}));
  connect(limiter1.y, y1) annotation(
    Line(points = {{92, 30}, {110, 30}}, color = {0, 0, 127}));
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
</ul></body></html>"));
end LC;
