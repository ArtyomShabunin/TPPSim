within TPPSim.Sensors;
model Temperature "Ideal one port temperature sensor"
  Modelica.Fluid.Interfaces.FluidPort_a port(redeclare package Medium = Medium, m_flow(min = 0)) annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput deltaTs "Temperature in port medium" annotation(
    Placement(transformation(extent = {{60, -10}, {80, 10}})));
  parameter TemperatureType TemperatureType_set = TemperatureType.subcooling;
protected
  package Medium = Modelica.Media.Water.StandardWater;
  Medium.Temperature ts;
  Medium.Temperature T;
equation
  T = Medium.temperature(Medium.setState_phX(port.p, inStream(port.h_outflow), inStream(port.Xi_outflow)));
  ts = Medium.saturationTemperature_sat(Medium.setSat_p(port.p));
  if TemperatureType_set == TemperatureType.subcooling then
    deltaTs = ts - T;
  elseif TemperatureType_set == TemperatureType.overheating then
    deltaTs = T - ts;
  elseif TemperatureType_set == TemperatureType.saturation then
    deltaTs = ts;
  end if;
  port.m_flow = 0;
  port.h_outflow = Medium.h_default;
  port.Xi_outflow = Medium.X_default[1:Medium.nXi];
  port.C_outflow = zeros(Medium.nC);
  annotation(
    defaultComponentName = "temperature",
    Documentation(info = "<html>
<p>
This component monitors the temperature of the fluid passing its port.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{0, -70}, {0, -100}}, color = {0, 0, 127}), Ellipse(extent = {{-20, -98}, {20, -60}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-12, 40}, {12, -68}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-12, 40}, {-12, 80}, {-10, 86}, {-6, 88}, {0, 90}, {6, 88}, {10, 86}, {12, 80}, {12, 40}, {-12, 40}}, lineColor = {0, 0, 0}, lineThickness = 0.5), Line(points = {{-12, 40}, {-12, -64}}, thickness = 0.5), Line(points = {{12, 40}, {12, -64}}, thickness = 0.5), Line(points = {{-40, -20}, {-12, -20}}), Line(points = {{-40, 20}, {-12, 20}}), Line(points = {{-40, 60}, {-12, 60}}), Line(points = {{12, 0}, {60, 0}}, color = {0, 0, 127})}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent = {{-20, -88}, {20, -50}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-12, 50}, {12, -58}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-12, 50}, {-12, 90}, {-10, 96}, {-6, 98}, {0, 100}, {6, 98}, {10, 96}, {12, 90}, {12, 50}, {-12, 50}}, lineColor = {0, 0, 0}, lineThickness = 0.5), Line(points = {{-12, 50}, {-12, -54}}, thickness = 0.5), Line(points = {{12, 50}, {12, -54}}, thickness = 0.5), Line(points = {{-40, -10}, {-12, -10}}), Line(points = {{-40, 30}, {-12, 30}}), Line(points = {{-40, 70}, {-12, 70}}), Text(extent = {{126, -30}, {6, -60}}, lineColor = {0, 0, 0}, textString = "T"), Text(extent = {{-150, 110}, {150, 150}}, textString = "%name", lineColor = {0, 0, 255}), Line(points = {{12, 0}, {60, 0}}, color = {0, 0, 127})}));
end Temperature;
