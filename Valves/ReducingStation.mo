within TPPSim.Valves;
model ReducingStation
  extends TPPSim.Valves.BaseClases.Icons.IconReducingStation;
  replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  //Параметры клапана
  parameter Modelica.SIunits.AbsolutePressure dp_nominal annotation(
    Dialog(group = "Параметры клапана"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal annotation(
    Dialog(group = "Параметры клапана"));
  parameter Modelica.SIunits.AbsolutePressure p_nominal annotation(
    Dialog(group = "Параметры клапана"));
  parameter Modelica.SIunits.Density rho_nominal annotation(
    Dialog(group = "Параметры клапана"));
  //Параметры пароохладителя
  parameter Modelica.SIunits.Temperature down_T "Температура пара за БРОУ" annotation(
    Dialog(group = "Параметры пароохладителя"));
  outer Modelica.Fluid.System system;  
  Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {26, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  Modelica.Fluid.Valves.ValveCompressible valve(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = dp_nominal, m_flow_nominal = m_flow_nominal, p_nominal = p_nominal, rho_nominal = rho_nominal) annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput opening annotation(
    Placement(visible = true, transformation(origin = {-30, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-32, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  TPPSim.Valves.Desuperheater desuperheater(redeclare package Medium = Medium, down_T = 573.15) annotation(
    Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(desuperheater.flowOut, flowOut) annotation(
    Line(points = {{40, 0}, {100, 0}, {100, 0}, {100, 0}}, color = {0, 127, 255}));
  connect(desuperheater.waterIn, waterIn) annotation(
    Line(points = {{26, -10}, {26, -100}}, color = {0, 127, 255}));
  connect(valve.port_b, desuperheater.flowIn) annotation(
    Line(points = {{-20, 0}, {20, 0}, {20, 0}, {20, 0}}, color = {0, 127, 255}));
  connect(opening, valve.opening) annotation(
    Line(points = {{-30, 100}, {-30, 100}, {-30, 8}, {-30, 8}}, color = {0, 0, 127}));
  connect(flowIn, valve.port_a) annotation(
    Line(points = {{-100, 0}, {-40, 0}, {-40, 0}, {-40, 0}}));
  /*flowOut.h_outflow = Medium.specificEnthalpy_pT(flowOut.p, down_T);
  waterIn.m_flow = -(valve.port_b.m_flow * inStream(valve.port_b.h_outflow) + flowOut.m_flow * flowOut.h_outflow)/inStream(waterIn.h_outflow);
  valve.port_b.h_outflow = inStream(flowOut.h_outflow);
  waterIn.h_outflow = inStream(flowOut.h_outflow);
  flowOut.m_flow = -(valve.port_b.m_flow + waterIn.m_flow);
  flowOut.p = valve.port_b.p;*/
end ReducingStation;
