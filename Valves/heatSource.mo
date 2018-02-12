within TPPSim.Valves;
model heatSource
  extends TPPSim.Valves.BaseClases.Icons.IconHeatSource;
  replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Modelica.SIunits.Temperature set_down_T "Температура за источником тепла";
  outer Modelica.Fluid.System system;  
  Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation  
  flowIn.h_outflow = inStream(flowOut.h_outflow);
  flowOut.h_outflow = Medium.specificEnthalpy_pT(flowOut.p, set_down_T);
  flowOut.m_flow = -flowIn.m_flow;
  flowIn.p = flowOut.p;
end heatSource;
