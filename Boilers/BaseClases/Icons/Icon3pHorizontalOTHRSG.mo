within TPPSim.Boilers.BaseClases.Icons;

partial model Icon3pHorizontalOTHRSG
  extends TPPSim.Boilers.BaseClases.Icons.IconHorizontalHRSG;
  annotation(
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}}, initialScale = 0.1), graphics = {Ellipse(origin = {-6, 90}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Ellipse(origin = {90, 90}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Text(origin = {-6, 90}, lineColor = {170, 0, 0}, extent = {{-20, 20}, {22, -20}}, textString = "IP"), Text(origin = {90, 90}, lineColor = {182, 121, 0}, extent = {{-20, 20}, {22, -20}}, textString = "LP"), Rectangle(origin = {-90, 74}, lineColor = {144, 144, 144}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-16, 50}, {10, -50}}), Rectangle(origin = {-93, -67}, lineColor = {144, 144, 144}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 85}, {5, -85}}), Polygon(origin = {-93, 21}, lineColor = {144, 144, 144}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, points = {{-13, 3}, {13, 3}, {5, -3}, {-5, -3}, {-5, -3}, {-13, 3}}), Text(origin = {-92, 90}, lineColor = {115, 0, 0}, extent = {{-20, 20}, {22, -20}}, textString = "HP")}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    __OpenModelica_commandLineOptions = "");
end Icon3pHorizontalOTHRSG;
