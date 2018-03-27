within TPPSim.Controls.BaseClasses.Icons;

partial model IconTC "Регулятор уроня в барабане КУ"
  annotation(
    Documentation(info = "<html><head></head><body>
    Простейший регулятор уровня в барабане.<br>
    Регулятор включается после того как производная по уровню становится меньше -1e-5.
    </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>July 08, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(lineColor = {255, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 100}, {100, -100}}), Rectangle(fillColor = {130, 130, 130}, fillPattern = FillPattern.Forward, extent = {{-100, 60}, {100, -60}}), Rectangle(lineColor = {0, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-100, 40}, {100, -40}}), Rectangle(origin = {57, 7}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{43, 33}, {-55, -47}}), Text(origin = {10, 5}, extent = {{-98, 35}, {78, -45}}, textString = "overheat\ncontrol", fontSize = 25)}));
end IconTC;
