within TPPSim.Boilers.BaseClases.Icons;

partial model Icon3pHorizontalHRSG
  extends TPPSim.Boilers.BaseClases.Icons.IconHorizontalHRSG;
  annotation(
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}}, initialScale = 0.1), graphics = {Ellipse(origin = {-82, 90}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Ellipse(origin = {-6, 90}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Ellipse(origin = {90, 90}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Text(origin = {-82, 92}, lineColor = {115, 0, 0}, extent = {{-20, 20}, {22, -20}}, textString = "HP"), Text(origin = {-6, 90}, lineColor = {170, 0, 0}, extent = {{-20, 20}, {22, -20}}, textString = "IP"), Text(origin = {90, 90}, lineColor = {182, 121, 0}, extent = {{-20, 20}, {22, -20}}, textString = "LP")}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    __OpenModelica_commandLineOptions = "");
end Icon3pHorizontalHRSG;
