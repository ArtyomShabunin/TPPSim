within TPPSim;
model flowLimiter
  parameter Medium.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  //Переменные
  Medium.AbsolutePressure p;
  Medium.SpecificEnthalpy h;
  Medium.MassFlowRate D;
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
//Граничные условия
  D = max(waterIn.m_flow, m_flow_small);
  waterOut.m_flow = -D;
  waterOut.p = p;
  waterIn.p = p;
  h = inStream(waterIn.h_outflow);
  waterOut.h_outflow = h;
  waterIn.h_outflow = h;
  annotation(
    Documentation(info = "<HTML>Ограничитель расхода.</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
end flowLimiter;