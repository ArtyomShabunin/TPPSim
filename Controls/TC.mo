within TPPSim.Controls;

block TC "Регулятор перегрева на выходе сепаратора прямоточного котла"
  extends TPPSim.Controls.BaseClasses.Icons.IconTC;
  parameter Real T_sprh = 10 "Перегрев, С";
  Modelica.Blocks.Continuous.LimPID PID( Ti = 10,controllerType = Modelica.Blocks.Types.SimpleController.PI,initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = 3e-005, yMax = 50, yMin = 20, y_start = 20)  annotation(
    Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = T_sprh)  annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput p annotation(
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput h annotation(
    Placement(visible = true, transformation(origin = {-120, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
    Placement(visible = true, transformation(origin = {-10, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.h_pt h_pt2 annotation(
    Placement(visible = true, transformation(origin = {30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ts_p ts_p1 annotation(
    Placement(visible = true, transformation(origin = {-70, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(p, ts_p1.p) annotation(
    Line(points = {{-120, -40}, {-84, -40}, {-84, -40}, {-82, -40}}, color = {0, 0, 127}));
  connect(PID.y, y) annotation(
    Line(points = {{72, 0}, {102, 0}, {102, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(h, PID.u_s) annotation(
    Line(points = {{-120, 50}, {-44, 50}, {-44, 0}, {48, 0}}, color = {0, 0, 127}));
  connect(h_pt2.h, PID.u_m) annotation(
    Line(points = {{41, -50}, {60, -50}, {60, -12}}, color = {0, 0, 127}));
  connect(p, h_pt2.p) annotation(
    Line(points = {{-120, -40}, {-90, -40}, {-90, -24}, {-12, -24}, {-12, -42}, {18, -42}, {18, -42}}, color = {0, 0, 127}));
  connect(ts_p1.ts, add1.u1) annotation(
    Line(points = {{-58, -40}, {-46, -40}, {-46, -52}, {-22, -52}, {-22, -52}}, color = {0, 0, 127}));
  connect(const.y, add1.u2) annotation(
    Line(points = {{-78, -70}, {-44, -70}, {-44, -64}, {-22, -64}, {-22, -64}}, color = {0, 0, 127}));
  connect(add1.y, h_pt2.T) annotation(
    Line(points = {{1, -58}, {18, -58}}, color = {0, 0, 127}));
  connect(PID.y, y) annotation(
    Line(points = {{41, 0}, {110, 0}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html><head></head><body>
    Простейший регулятор перегрева на выходе сепаратора.
    </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>Match 27, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(coordinateSystem(initialScale = 0.1)));
end TC;
