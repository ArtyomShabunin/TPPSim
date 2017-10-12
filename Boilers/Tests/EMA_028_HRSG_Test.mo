within TPPSim.Boilers.Tests;

model EMA_028_HRSG_Test
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  package Medium_G = TPPSim.Media.ExhaustGas;
  inner Modelica.Fluid.System system(T_start = 60 + 273.15,allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 2482.5 / 3.6, Tnom = 569.1 + 273.15, Tstart = system.T_start) annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant HP_CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-37, 35}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = system.T_start, nPorts = 1, p = system.p_ambient)  annotation(
    Placement(visible = true, transformation(origin = {86, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible condPump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {59, 23}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
//  TPPSim.Valves.ReducingStation HP_RS(redeclare package Medium = Medium_F, down_T = 873.15, dp_nominal = 1.2431e+07, m_flow_nominal = 72, p_nominal = 1.2431e+07, rho_nominal (displayUnit = "kg/m3") = 36.72) annotation(
//    Placement(visible = true, transformation(origin = {-30, 20}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 1.2431e+07, m_flow_nominal = 72, p_nominal = 1.2431e+07, rho_nominal = 36.72) annotation(
    Placement(visible = true, transformation(origin = {-22, 12}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  TPPSim.Boilers.EMA_028_HRSG boiler annotation(
    Placement(visible = true, transformation(origin = {12, 0}, extent = {{-30, -20}, {30, 20}}, rotation = 0)));
equation
  connect(HP_CV_const.y, CV.opening) annotation(
    Line(points = {{-32, 36}, {-22, 36}, {-22, 16}, {-22, 16}}, color = {0, 0, 127}));
  connect(CV.port_b, flowSink.ports[1]) annotation(
    Line(points = {{-26, 12}, {-48, 12}, {-48, 30}, {-60, 30}, {-60, 30}}, color = {0, 127, 255}));
  connect(boiler.steamOut, CV.port_a) annotation(
    Line(points = {{-4, 8}, {-4, 8}, {-4, 12}, {-18, 12}, {-18, 12}}, color = {0, 127, 255}));
  connect(GT.flowOut, boiler.gasIn) annotation(
    Line(points = {{-60, -10}, {-39, -10}, {-39, -14}, {-18, -14}}, color = {0, 127, 255}));
  connect(condPump.port_b, boiler.FW_In) annotation(
    Line(points = {{54, 23}, {27, 23}, {27, 7}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], condPump.port_a) annotation(
    Line(points = {{76, 20}, {71, 20}, {71, 23}, {64, 23}}, color = {0, 127, 255}, thickness = 0.5));
end EMA_028_HRSG_Test;
