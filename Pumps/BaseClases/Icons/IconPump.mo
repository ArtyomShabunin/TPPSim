within TPPSim.Pumps.BaseClases.Icons;
model IconPump
  annotation(
    Icon(graphics = {Ellipse(fillColor = {85, 255, 127}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Polygon(origin = {-60, 0}, fillColor = {0, 85, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-40, 0}, {40, 60}, {40, -60}, {-40, 0}}), Text(origin = {-15, -112}, extent = {{-85, 12}, {115, -28}}, textString = "%name")}));
end IconPump;