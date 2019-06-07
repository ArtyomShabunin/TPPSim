within TPPSim.Boilers.Tests;

model EMA_028_with_param_GT
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  package Medium_G = TPPSim.Media.ExhaustGas;
  inner Modelica.Fluid.System system(T_start = 60 + 273.15, allowFlowReversal = false, m_flow_small = 0.01, m_flow_start = 0.0001) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 2482.5 / 3.6, Tnom = 569.1 + 273.15, Tstart = system.T_start) annotation(
  //    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.combitable_startupGT GT(redeclare package Medium = Medium_G, fileName = "C:/Users/ASShabunin/TPPSim/Gas_turbine/Tests/TEC_16_GT_1.txt") annotation(
    Placement(visible = true, transformation(origin = {-16, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = 30 + 273.15, nPorts = 1, p = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {86, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible condPump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {59, 25}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Boilers.EMA_028_HRSG boiler(redeclare package Medium_F = Medium_F, redeclare package Medium_G = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {10, 4}, extent = {{-30, -20}, {30, 20}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible HP_FWP annotation(
    Placement(visible = true, transformation(origin = {31, -47}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible IP_FWP annotation(
    Placement(visible = true, transformation(origin = {33, -41}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.377, Lpipe = 155, delta = 0.05, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-41, 17}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe CRH_pipe(Din = 0.48, Lpipe = 65, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-23, 39}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HRH_pipe(Din = 0.48, Lpipe = 92.8, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-39, 1}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible LP_FWP annotation(
    Placement(visible = true, transformation(origin = {35, -35}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_ph deaerator(redeclare package Medium = Medium_F, h = 830000, nPorts = 4, p = 3.6e5, use_h_in = true) annotation(
    Placement(visible = true, transformation(origin = {60, -42}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate HP_massFlowRate(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {18, -48}, extent = {{2, -2}, {-2, 2}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate IP_massFlowRate(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {22, -40}, extent = {{2, -2}, {-2, 2}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate LP_massFlowRate(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {26, -34}, extent = {{2, -2}, {-2, 2}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1(nin = 3) annotation(
    Placement(visible = true, transformation(origin = {48, -2}, extent = {{-4, -4}, {4, 4}}, rotation = 90)));
  TPPSim.Valves.simpleValve cond_CV(dp = 100000, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {32, -26}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant hd(k = 588.6e3) annotation(
    Placement(visible = true, transformation(origin = {92, -38}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_HP(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-30, 24}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_CRH(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {10, 40}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_HRH(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-32, 12}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_LP(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {20, 36}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Tw_condout(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {4, -24}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_HRH_2(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-48, -8}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure HP_pressure(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-46, 26}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure LP_pressure(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {16, 56}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 2, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-110, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant const(k = 0)  annotation(
    Placement(visible = true, transformation(origin = {-45, 69}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible IP_RS(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1800, dp_nominal = 3e+06, m_flow_start = system.m_flow_small, p_nominal = 60e5)  annotation(
    Placement(visible = true, transformation(origin = {-65, 1}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-107, 27}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible HP_RS(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 600, dp_nominal = 9e+06, m_flow_start = system.m_flow_small)  annotation(
    Placement(visible = true, transformation(origin = {-37, 39}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
//  ThermoPower.Water.ValveVap HP_RS(CvData = ThermoPower.Choices.Valve.CvTypes.Kv, Kv = 600, dpnom = 9e+06, pin_start = 1.013e5, pnom = 120e5, theta_fix = 1, useThetaInput = false) annotation(
//    Placement(visible = true, transformation(origin = {-41, 39}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
equation
  connect(const1.y, HP_RS.opening) annotation(
    Line(points = {{-100, 28}, {-90, 28}, {-90, 52}, {-38, 52}, {-38, 44}, {-36, 44}}, color = {0, 0, 127}));
  connect(HP_RS.port_b, CRH_pipe.waterIn) annotation(
    Line(points = {{-30, 40}, {-26, 40}, {-26, 40}, {-26, 40}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, HP_RS.port_a) annotation(
    Line(points = {{-44, 18}, {-56, 18}, {-56, 38}, {-44, 38}, {-44, 40}}, color = {0, 127, 255}));
  connect(CRH_pipe.waterOut, boiler.RH_In) annotation(
    Line(points = {{-20, 40}, {0, 40}, {0, 24}, {0, 24}}, color = {0, 127, 255}));
  connect(const.y, boiler.RH_vent_pos) annotation(
    Line(points = {{-37, 69}, {-16, 69}, {-16, 24}}, color = {0, 0, 127}));
  connect(const.y, boiler.HP_vent_pos) annotation(
    Line(points = {{-37, 69}, {-10, 69}, {-10, 24}}, color = {0, 0, 127}));
  connect(const1.y, IP_RS.opening) annotation(
    Line(points = {{-100, 28}, {-66, 28}, {-66, 6}, {-64, 6}}, color = {0, 0, 127}));
  connect(IP_RS.port_b, flowSink.ports[1]) annotation(
    Line(points = {{-72, 2}, {-100, 2}, {-100, 0}, {-100, 0}}, color = {0, 127, 255}));
  connect(HRH_pipe.waterOut, IP_RS.port_a) annotation(
    Line(points = {{-42, 2}, {-58, 2}, {-58, 2}, {-58, 2}}, color = {0, 127, 255}));
  connect(boiler.LP_Out, flowSink.ports[2]) annotation(
    Line(points = {{16, 24}, {16, 24}, {16, 48}, {-80, 48}, {-80, 2}, {-100, 2}, {-100, 0}}, color = {0, 127, 255}));
  connect(boiler.LP_Out, LP_pressure.port) annotation(
    Line(points = {{16, 24}, {16, 24}, {16, 52}, {16, 52}}, color = {0, 127, 255}));
  connect(boiler.LP_Out, Ts_LP.port) annotation(
    Line(points = {{16, 24}, {20, 24}, {20, 32}}, color = {0, 127, 255}));
  connect(boiler.RH_In, Ts_CRH.port) annotation(
    Line(points = {{0, 24}, {0, 24}, {0, 36}, {10, 36}, {10, 36}}, color = {0, 127, 255}));
  connect(boiler.RH_Out, Ts_HRH.port) annotation(
    Line(points = {{-20, 14}, {-22, 14}, {-22, 8}, {-32, 8}, {-32, 8}}, color = {0, 127, 255}));
  connect(HRH_pipe.waterOut, Ts_HRH_2.port) annotation(
    Line(points = {{-42, 2}, {-42, 2}, {-42, -12}, {-48, -12}, {-48, -12}}, color = {0, 127, 255}));
  connect(boiler.RH_Out, HRH_pipe.waterIn) annotation(
    Line(points = {{-20, 14}, {-22, 14}, {-22, 2}, {-36, 2}, {-36, 2}}, color = {0, 127, 255}));
  connect(boiler.HP_Out, Ts_HP.port) annotation(
    Line(points = {{-20, 18}, {-30, 18}, {-30, 20}}, color = {0, 127, 255}));
  connect(HP_pressure.port, HP_pipe.waterOut) annotation(
    Line(points = {{-46, 22}, {-46, 18}, {-45, 18}, {-45, 17}}, color = {0, 127, 255}));
  connect(boiler.HP_Out, HP_pipe.waterIn) annotation(
    Line(points = {{-20, 18}, {-30, 18}, {-30, 17}, {-37, 17}}, color = {0, 127, 255}));
  connect(GT.flowOut, boiler.gasIn) annotation(
    Line(points = {{-26, -30}, {-30, -30}, {-30, -8}, {-20, -8}}, color = {0, 127, 255}));
  connect(boiler.cond_Out, Tw_condout.port) annotation(
    Line(points = {{24, -14}, {24, -14}, {24, -28}, {4, -28}, {4, -28}}, color = {0, 127, 255}));
  connect(hd.y, deaerator.h_in) annotation(
    Line(points = {{85, -38}, {72, -38}}, color = {0, 0, 127}));
  connect(sum1.y, cond_CV.D_flow_in) annotation(
    Line(points = {{48, 2}, {48, 2}, {48, 4}, {42, 4}, {42, -22}, {32, -22}, {32, -26}, {32, -26}}, color = {0, 0, 127}));
  connect(cond_CV.flowOut, deaerator.ports[4]) annotation(
    Line(points = {{36, -26}, {50, -26}, {50, -42}, {50, -42}}, color = {0, 127, 255}));
  connect(boiler.cond_Out, cond_CV.flowIn) annotation(
    Line(points = {{24, -14}, {24, -14}, {24, -26}, {28, -26}, {28, -26}}, color = {0, 127, 255}));
  connect(LP_FWP.port_b, LP_massFlowRate.port_a) annotation(
    Line(points = {{32, -35}, {30, -35}, {30, -35}, {28, -35}, {28, -35}, {28, -35}, {28, -35}, {28, -35}}, color = {0, 127, 255}));
  connect(LP_massFlowRate.port_b, boiler.LP_FW_In) annotation(
    Line(points = {{24, -34}, {20, -34}, {20, -14}}, color = {0, 127, 255}));
  connect(LP_massFlowRate.m_flow, sum1.u[1]) annotation(
    Line(points = {{26, -32}, {48, -32}, {48, -6}}, color = {0, 0, 127}));
  connect(IP_massFlowRate.port_a, IP_FWP.port_b) annotation(
    Line(points = {{24, -40}, {27, -40}, {27, -40}, {30, -40}, {30, -41}}, color = {0, 127, 255}));
  connect(IP_massFlowRate.port_b, boiler.IP_FW_In) annotation(
    Line(points = {{20, -40}, {18, -40}, {18, -14}}, color = {0, 127, 255}));
  connect(IP_massFlowRate.m_flow, sum1.u[2]) annotation(
    Line(points = {{22, -38}, {48, -38}, {48, -6}}, color = {0, 0, 127}));
  connect(HP_FWP.port_b, HP_massFlowRate.port_a) annotation(
    Line(points = {{28, -47}, {20, -47}, {20, -48}}, color = {0, 127, 255}));
  connect(HP_massFlowRate.port_b, boiler.HP_FW_In) annotation(
    Line(points = {{16, -48}, {16, -14}}, color = {0, 127, 255}));
  connect(HP_massFlowRate.m_flow, sum1.u[3]) annotation(
    Line(points = {{18, -46}, {14, -46}, {14, -52}, {76, -52}, {76, -14}, {48, -14}, {48, -6}}, color = {0, 0, 127}));
  connect(deaerator.ports[1], LP_FWP.port_a) annotation(
    Line(points = {{50, -42}, {46, -42}, {46, -42}, {42, -42}, {42, -34}, {38, -34}}, color = {0, 127, 255}, thickness = 0.5));
  connect(deaerator.ports[2], IP_FWP.port_a) annotation(
    Line(points = {{50, -42}, {43, -42}, {43, -42}, {36, -42}, {36, -40}, {36, -40}, {36, -40}, {36, -40}}, color = {0, 127, 255}, thickness = 0.5));
  connect(deaerator.ports[3], HP_FWP.port_a) annotation(
    Line(points = {{50, -42}, {46, -42}, {46, -42}, {42, -42}, {42, -46}, {34, -46}, {34, -46}}, color = {0, 127, 255}, thickness = 0.5));
  connect(flowSource.ports[1], condPump.port_a) annotation(
    Line(points = {{76, 20}, {71, 20}, {71, 25}, {64, 25}}, color = {0, 127, 255}, thickness = 0.5));
  connect(condPump.port_b, boiler.cond_In) annotation(
    Line(points = {{54, 25}, {24, 25}, {24, 11}, {25, 11}}, color = {0, 127, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-140, -100}, {100, 100}})),
    experiment(StartTime = 0, StopTime = 17000, Tolerance = 1e-2, Interval = 10));

end EMA_028_with_param_GT;
