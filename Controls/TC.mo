within TPPSim.Controls;

block TC "Регулятор перегрева на выходе сепаратора прямоточного котла"
  extends TPPSim.Controls.BaseClasses.Icons.IconTC;
  parameter Real T_sprh = 10 "Перегрев, С";
  //Параметры PI-регулятора
  parameter Real k = 3e-005 "Коэффициент усиления" annotation(
    Dialog(group = "Параметры PI-регулятора"));
  parameter Real Ti = 10 "Постоянная времени интегрирования" annotation(
    Dialog(group = "Параметры PI-регулятора"));
  parameter Modelica.SIunits.MassFlowRate yMax = 50 "Максимальный расход пара" annotation(
    Dialog(group = "Параметры PI-регулятора"));
  parameter Modelica.SIunits.MassFlowRate y_start = 20 "Начальный/минимальный расход пара" annotation(
    Dialog(group = "Параметры PI-регулятора"));
  Modelica.Blocks.Continuous.LimPID PID(Ti = Ti, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = k, yMax = yMax, yMin = y_start, y_start = y_start) annotation(
    Placement(visible = true, transformation(origin = {48, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = T_sprh) annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput p annotation(
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput h annotation(
    Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
    Placement(visible = true, transformation(origin = {-10, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.h_pt h_pt2 annotation(
    Placement(visible = true, transformation(origin = {30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ts_p ts_p1 annotation(
    Placement(visible = true, transformation(origin = {-70, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput t_g annotation(
    Placement(visible = true, transformation(origin = {-120, 84}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 84}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Logical.Less less1 annotation(
    Placement(visible = true, transformation(origin = {-34, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 100 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {80, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 0)  annotation(
    Placement(visible = true, transformation(origin = {66, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const2.y, switch1.u1) annotation(
    Line(points = {{78, 58}, {82, 58}, {82, 28}, {62, 28}, {62, 16}, {68, 16}, {68, 16}}, color = {0, 0, 127}));
  connect(less1.y, switch1.u2) annotation(
    Line(points = {{-22, 84}, {52, 84}, {52, 8}, {68, 8}, {68, 8}}, color = {255, 0, 255}));
  connect(switch1.y, y) annotation(
    Line(points = {{92, 8}, {94, 8}, {94, -2}, {110, -2}, {110, 0}}, color = {0, 0, 127}));
  connect(PID.y, switch1.u3) annotation(
    Line(points = {{60, 0}, {68, 0}}, color = {0, 0, 127}));
  connect(h_pt2.h, PID.u_m) annotation(
    Line(points = {{41, -50}, {48, -50}, {48, -12}}, color = {0, 0, 127}));
  connect(h, PID.u_s) annotation(
    Line(points = {{-120, 20}, {-38, 20}, {-38, 0}, {36, 0}}, color = {0, 0, 127}));
  connect(const1.y, less1.u2) annotation(
    Line(points = {{-78, 60}, {-68, 60}, {-68, 76}, {-46, 76}, {-46, 76}}, color = {0, 0, 127}));
  connect(t_g, less1.u1) annotation(
    Line(points = {{-120, 84}, {-46, 84}, {-46, 84}, {-46, 84}}, color = {0, 0, 127}));
  connect(p, ts_p1.p) annotation(
    Line(points = {{-120, -40}, {-84, -40}, {-84, -40}, {-82, -40}}, color = {0, 0, 127}));
  connect(p, h_pt2.p) annotation(
    Line(points = {{-120, -40}, {-90, -40}, {-90, -24}, {-12, -24}, {-12, -42}, {18, -42}, {18, -42}}, color = {0, 0, 127}));
  connect(ts_p1.ts, add1.u1) annotation(
    Line(points = {{-58, -40}, {-46, -40}, {-46, -52}, {-22, -52}, {-22, -52}}, color = {0, 0, 127}));
  connect(const.y, add1.u2) annotation(
    Line(points = {{-78, -70}, {-44, -70}, {-44, -64}, {-22, -64}, {-22, -64}}, color = {0, 0, 127}));
  connect(add1.y, h_pt2.T) annotation(
    Line(points = {{1, -58}, {18, -58}}, color = {0, 0, 127}));
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
