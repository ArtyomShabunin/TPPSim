within TPPSim.Boilers.Tests;

model OnePVerticalHRSG_Test  
  inner Modelica.Fluid.System system(T_start = 333.15, allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 1292.6 / 3.6, Tnom = 517.2 + 273.15, Tstart = system.T_start) annotation(
    Placement(visible = true, transformation(origin = {-70, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-11, 39}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {-36, 2}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = system.p_ambient)  annotation(
    Placement(visible = true, transformation(origin = {86, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible FW_Pump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {57, 5}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Boilers.OnePVerticalHRSG boiler  annotation(
    Placement(visible = true, transformation(origin = {18, 10}, extent = {{20, -30}, {-20, 30}}, rotation = 0)));
//  TPPSim.Pipes.ComplexPipe HRH_pipe(Din = 0.48, Lpipe = 92.8, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
//    Placement(visible = true, transformation(origin = {-17, 1}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
equation
  connect(boiler.IP_Out, CV.port_a) annotation(
    Line(points = {{-2, 2}, {-32, 2}, {-32, 2}, {-32, 2}}, color = {0, 127, 255}));
  connect(CV.port_b, flowSink.ports[1]) annotation(
    Line(points = {{-40, 2}, {-46, 2}, {-46, 30}, {-60, 30}, {-60, 30}}, color = {0, 127, 255}));
  connect(CV_const.y, CV.opening) annotation(
    Line(points = {{-16, 40}, {-36, 40}, {-36, 5}}, color = {0, 0, 127}));
  connect(FW_Pump.port_b, boiler.IP_FW_In) annotation(
    Line(points = {{52, 6}, {48, 6}, {48, 16}, {38, 16}, {38, 16}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], FW_Pump.port_a) annotation(
    Line(points = {{76, 20}, {71, 20}, {71, 5}, {62, 5}}, color = {0, 127, 255}, thickness = 0.5));
  connect(GT.flowOut, boiler.gasIn) annotation(
    Line(points = {{-60, -12}, {-2, -12}, {-2, -12}, {-2, -12}}, color = {0, 127, 255}));
annotation(
    experiment(StartTime = 0, StopTime = 2000, Tolerance = 0.0001, Interval = 10));end OnePVerticalHRSG_Test;
