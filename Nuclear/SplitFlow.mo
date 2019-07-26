within TPPSim.Nuclear;

model SplitFlow
  replaceable package Medium = Modelica.Media.Water.WaterIF97_ph;
  Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Integer n = 1 "Число потоков";
equation
  flowOut.h_outflow = actualStream(flowIn.h_outflow);
  flowIn.h_outflow = actualStream(flowOut.h_outflow);
  flowOut.m_flow = -flowIn.m_flow / n;
  flowOut.p = flowIn.p;

end SplitFlow;
