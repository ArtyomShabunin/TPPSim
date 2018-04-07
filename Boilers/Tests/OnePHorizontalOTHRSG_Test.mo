within TPPSim.Boilers.Tests;

model OnePHorizontalOTHRSG_Test
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  package Medium_G = TPPSim.Media.ExhaustGas;
  inner Modelica.Fluid.System system(T_start = 333.15,allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 1292.6 / 3.6, Tnom = 517.2 + 273.15, Tstart = system.T_start) annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-11, 39}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {-24, 12}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {86, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible FW_Pump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {57, 35}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Boilers.OnePHorizontalOTHRSG Boiler(redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {18, 2}, extent = {{-30, -20}, {30, 20}}, rotation = 0)));
equation
  connect(FW_Pump.port_b, Boiler.HP_FW_In) annotation(
    Line(points = {{52, 35}, {34, 35}, {34, 10}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], FW_Pump.port_a) annotation(
    Line(points = {{76, 20}, {68, 20}, {68, 35}, {62, 35}}, color = {0, 127, 255}, thickness = 0.5));
  connect(Boiler.HP_Out, CV.port_a) annotation(
    Line(points = {{2, 8}, {2, 8}, {2, 12}, {-20, 12}, {-20, 12}}, color = {0, 127, 255}));
  connect(CV.port_b, flowSink.ports[1]) annotation(
    Line(points = {{-28, 12}, {-30, 12}, {-30, 30}, {-60, 30}}, color = {0, 127, 255}));
  connect(CV_const.y, CV.opening) annotation(
    Line(points = {{-16, 40}, {-24, 40}, {-24, 15}}, color = {0, 0, 127}));
  connect(GT.flowOut, Boiler.gasIn) annotation(
    Line(points = {{-60, -10}, {-39, -10}, {-39, -11}, {-12, -11}}, color = {0, 127, 255}));
annotation(
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
    experiment(StartTime = 0, StopTime = 5000, Tolerance = 1e-2, Interval = 10));
  end OnePHorizontalOTHRSG_Test;