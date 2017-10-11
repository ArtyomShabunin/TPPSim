within TPPSim.Boilers.BaseClases.Icons;

partial model Icon3pHorizontalHRSG
  extends TPPSim.Boilers.BaseClases.Icons.IconHorizontalHRSG;
  annotation(
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}}, initialScale = 0.1), graphics = {Ellipse(origin = {-82, 90}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Ellipse(origin = {-6, 90}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Ellipse(origin = {90, 90}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-30, 30}, {30, -30}}, endAngle = 360)}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    __OpenModelica_commandLineOptions = "");
end Icon3pHorizontalHRSG;
