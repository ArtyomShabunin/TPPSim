within TPPSim.Boilers.BaseClases.Icons;
partial model Icon3pVerticalOTHRSG
  extends TPPSim.Boilers.BaseClases.Icons.IconVerticalHRSG;
  annotation(
    Icon(graphics = {Ellipse(origin = {126, 161}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-28, 29}, {32, -31}}, endAngle = 360), Ellipse(origin = {60, 161}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-28, 29}, {32, -31}}, endAngle = 360), Rectangle(origin = {-158, 130}, lineColor = {144, 144, 144}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-16, 50}, {10, -50}}), Rectangle(origin = {-161, -9}, lineColor = {144, 144, 144}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 85}, {5, -85}}), Polygon(origin = {-161, 77}, lineColor = {144, 144, 144}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, points = {{-13, 3}, {13, 3}, {5, -3}, {-5, -3}, {-5, -3}, {-13, 3}}), Text(origin = {-160, 160}, lineColor = {115, 0, 0}, extent = {{-20, 20}, {22, -20}}, textString = "HP"), Text(origin = {64, 162}, lineColor = {170, 0, 0}, extent = {{-20, 20}, {22, -20}}, textString = "IP"), Text(origin = {128, 160}, lineColor = {182, 121, 0}, extent = {{-20, 20}, {22, -20}}, textString = "LP")}, coordinateSystem(extent = {{-200, -300}, {200, 300}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    __OpenModelica_commandLineOptions = "");
end Icon3pVerticalOTHRSG;
