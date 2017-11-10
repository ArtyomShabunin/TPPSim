within TPPSim.Controls;

block vent_control "Регулятор уроня в барабане КУ"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Real event_value "Значение при достижении которого происходит переключение";
  parameter Real start_out "Выход до переключения";
  parameter Real finish_out "Выход после переключения";
  Modelica.Blocks.Logical.Greater gr annotation(
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant min(k = event_value) annotation(
    Placement(visible = true, transformation(origin = {-80, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.onAuto onAuto1 annotation(
    Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant start(k = start_out) annotation(
    Placement(visible = true, transformation(origin = {10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant finish(k = finish_out) annotation(
    Placement(visible = true, transformation(origin = {10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(switch1.y, y) annotation(
    Line(points = {{62, 0}, {104, 0}, {104, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(finish.y, switch1.u1) annotation(
    Line(points = {{22, 30}, {26, 30}, {26, 8}, {38, 8}, {38, 8}}, color = {0, 0, 127}));
  connect(start.y, switch1.u3) annotation(
    Line(points = {{22, -30}, {26, -30}, {26, -8}, {38, -8}, {38, -8}}, color = {0, 0, 127}));
  connect(onAuto1.y, switch1.u2) annotation(
    Line(points = {{14, 0}, {36, 0}, {36, 0}, {38, 0}}, color = {255, 0, 255}));
  connect(gr.y, onAuto1.u) annotation(
    Line(points = {{-29, 0}, {-10, 0}}, color = {255, 0, 255}));
  connect(min.y, gr.u2) annotation(
    Line(points = {{-69, -32}, {-61, -32}, {-61, -8}, {-53, -8}, {-53, -8}, {-53, -8}, {-53, -8}}, color = {0, 0, 127}));
  connect(u, gr.u1) annotation(
    Line(points = {{-120, 0}, {-52, 0}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html><head></head><body>
    Простейший регулятор уровня в барабане.<br>
    Регулятор включается после того как производная по уровню становится меньше -1e-5.
    </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>July 08, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end vent_control;
