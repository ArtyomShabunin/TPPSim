within TPPSim.Controls.BaseClasses.Icons;

partial model IconLC "Регулятор уроня в барабане КУ"
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
