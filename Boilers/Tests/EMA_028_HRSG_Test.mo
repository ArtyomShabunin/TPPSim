within TPPSim.Boilers.Tests;

model EMA_028_HRSG_Test
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  package Medium_G = TPPSim.Media.ExhaustGas;
  inner Modelica.Fluid.System system(T_start = 60 + 273.15,allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 2482.5 / 3.6, Tnom = 569.1 + 273.15, Tstart = system.T_start) annotation(
  //    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.combitable_startupGT GT(redeclare package Medium = Medium_G, fileName = "C:/Users/User/Documents/TPPSim/Gas_turbine/Tests/my.txt") annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 2, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant HP_CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-29, 61}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = 30 + 273.15, nPorts = 1, p = system.p_ambient)  annotation(
    Placement(visible = true, transformation(origin = {86, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible condPump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {59, 25}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Valves.ReducingStation HP_RS(redeclare package Medium = Medium_F, dp_nominal = 9.7e+06, m_flow_nominal = 77, p_nominal = 1.59e+07, rho_nominal(displayUnit = "kg/m3") = 45.13, set_down_T = 573.15, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {-34, 20}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 2.861e+06, m_flow_nominal = 82.86, p_nominal = 28.61e+05, rho_nominal = 7.827) annotation(
      Placement(visible = true, transformation(origin = {-44, 6}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  TPPSim.Boilers.EMA_028_HRSG boiler(redeclare package Medium_F = Medium_F, redeclare package Medium_G = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {10, 4}, extent = {{-30, -20}, {30, 20}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible LP_CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 371000, m_flow_nominal = 12.83, p_nominal = 3.71e+05, rho_nominal = 1.61) annotation(
    Placement(visible = true, transformation(origin = {10, 52}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible HP_FWP annotation(
    Placement(visible = true, transformation(origin = {31, -47}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible IP_FWP annotation(
    Placement(visible = true, transformation(origin = {33, -41}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.377, Lpipe = 155, delta = 0.05, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-17, 19}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe CRH_pipe(Din = 0.48, Lpipe = 65, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-35, 13}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HRH_pipe(Din = 0.48, Lpipe = 92.8, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-29, 7}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible LP_FWP annotation(
    Placement(visible = true, transformation(origin = {35, -35}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_ph deaerator(redeclare package Medium = Medium_F, h = 830000, nPorts = 4, p = 3.6e5, use_h_in = true)  annotation(
    Placement(visible = true, transformation(origin = {60, -42}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate HP_massFlowRate(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {18, -48}, extent = {{2, -2}, {-2, 2}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate IP_massFlowRate(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {22, -40}, extent = {{2, -2}, {-2, 2}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate LP_massFlowRate(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {26, -34}, extent = {{2, -2}, {-2, 2}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1(nin = 3)  annotation(
    Placement(visible = true, transformation(origin = {48, -2}, extent = {{-4, -4}, {4, 4}}, rotation = 90)));
  TPPSim.Valves.simpleValve cond_CV(dp = 100000, use_D_flow_in = true)  annotation(
    Placement(visible = true, transformation(origin = {32, -26}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant hd(k = 588.6e3)  annotation(
    Placement(visible = true, transformation(origin = {92, -38}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_HP(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-6, 32}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_CRH(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {2, 32}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_HRH(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-14, 32}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_LP(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {24, 36}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Tw_condout(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {4, -24}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  TPPSim.Sensors.Temperature ts(TemperatureType_set = TPPSim.Sensors.TemperatureType.saturation)  annotation(
    Placement(visible = true, transformation(origin = {-44, -40}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant overheating_after_BROU(k = 5)  annotation(
    Placement(visible = true, transformation(origin = {-45, -55}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum11(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {-63, -45}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable T_BROUout_table(columns = {2},fileName = "C:/Users/User/Documents/TPPSim/Boilers/Tests/T_BROUout.txt", tableName = "tabl", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-63, -31}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Max set_T_BROU_out annotation(
    Placement(visible = true, transformation(origin = {-79, -39}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable BROU_pos_table(columns = {2, 3},fileName = "C:/Users/User/Documents/TPPSim/Boilers/Tests/pos_BROU.txt", tableName = "tabl", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-69, 49}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
equation
  connect(HP_massFlowRate.port_b, HP_RS.waterIn) annotation(
    Line(points = {{16, -48}, {-36, -48}, {-36, 16}, {-36, 16}}, color = {0, 127, 255}));
  connect(BROU_pos_table.y[1], HP_RS.opening) annotation(
    Line(points = {{-64, 50}, {-32, 50}, {-32, 24}, {-32, 24}}, color = {0, 0, 127}, thickness = 0.5));
  connect(BROU_pos_table.y[2], CV.opening) annotation(
    Line(points = {{-64, 50}, {-44, 50}, {-44, 10}, {-44, 10}}, color = {0, 0, 127}, thickness = 0.5));
  connect(HP_CV_const.y, LP_CV.opening) annotation(
    Line(points = {{-23.5, 61}, {-26, 61}, {-26, 44}, {10, 44}, {10, 55}}, color = {0, 0, 127}));
  connect(set_T_BROU_out.y, HP_RS.T_in) annotation(
    Line(points = {{-84, -38}, {-86, -38}, {-86, 24}, {-38, 24}, {-38, 24}}, color = {0, 0, 127}));
  connect(sum11.y, set_T_BROU_out.u2) annotation(
    Line(points = {{-68, -44}, {-70, -44}, {-70, -42}, {-72, -42}, {-72, -42}}, color = {0, 0, 127}));
  connect(T_BROUout_table.y[1], set_T_BROU_out.u1) annotation(
    Line(points = {{-68, -30}, {-70, -30}, {-70, -36}, {-72, -36}, {-72, -36}}, color = {0, 0, 127}, thickness = 0.5));
  connect(ts.deltaTs, sum11.u[2]) annotation(
    Line(points = {{-46, -40}, {-54, -40}, {-54, -45}, {-57, -45}}, color = {0, 0, 127}));
  connect(overheating_after_BROU.y, sum11.u[1]) annotation(
    Line(points = {{-50, -54}, {-56, -54}, {-56, -48}, {-57, -48}, {-57, -45}}, color = {0, 0, 127}));
  connect(HP_RS.flowOut, ts.port) annotation(
    Line(points = {{-38, 20}, {-40, 20}, {-40, -44}, {-44, -44}, {-44, -44}}, color = {0, 127, 255}));
  connect(boiler.cond_Out, Tw_condout.port) annotation(
    Line(points = {{24, -14}, {24, -14}, {24, -28}, {4, -28}, {4, -28}}, color = {0, 127, 255}));
  connect(boiler.LP_Out, Ts_LP.port) annotation(
    Line(points = {{16, 12}, {14, 12}, {14, 28}, {24, 28}, {24, 32}, {24, 32}}, color = {0, 127, 255}));
  connect(boiler.RH_Out, Ts_HRH.port) annotation(
    Line(points = {{-8, 12}, {-10, 12}, {-10, 22}, {-14, 22}, {-14, 28}, {-14, 28}}, color = {0, 127, 255}));
  connect(Ts_CRH.port, boiler.RH_In) annotation(
    Line(points = {{2, 28}, {2, 28}, {2, 20}, {-4, 20}, {-4, 12}, {-4, 12}}, color = {0, 127, 255}));
  connect(boiler.HP_Out, Ts_HP.port) annotation(
    Line(points = {{-6, 12}, {-6, 12}, {-6, 28}, {-6, 28}}, color = {0, 127, 255}));
  connect(LP_CV.port_b, flowSink.ports[2]) annotation(
    Line(points = {{6, 52}, {-46, 52}, {-46, 32}, {-60, 32}, {-60, 30}}, color = {0, 127, 255}));
  connect(boiler.LP_Out, LP_CV.port_a) annotation(
    Line(points = {{15, 11}, {14, 11}, {14, 52}}, color = {0, 127, 255}));
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
  connect(HRH_pipe.waterOut, CV.port_a) annotation(
    Line(points = {{-32, 8}, {-36, 8}, {-36, 6}, {-40, 6}, {-40, 6}}, color = {0, 127, 255}));
  connect(boiler.RH_Out, HRH_pipe.waterIn) annotation(
    Line(points = {{-8, 12}, {-22, 12}, {-22, 8}, {-26, 8}, {-26, 8}}, color = {0, 127, 255}));
  connect(CV.port_b, flowSink.ports[1]) annotation(
    Line(points = {{-48, 6}, {-48, 30}, {-60, 30}}, color = {0, 127, 255}));
  connect(CRH_pipe.waterOut, boiler.RH_In) annotation(
    Line(points = {{-32, 14}, {-4, 14}, {-4, 12}, {-4, 12}}, color = {0, 127, 255}));
  connect(HP_RS.flowOut, CRH_pipe.waterIn) annotation(
    Line(points = {{-38, 20}, {-40, 20}, {-40, 12}, {-38, 12}, {-38, 14}}, color = {0, 127, 255}));
  connect(HP_RS.flowIn, HP_pipe.waterOut) annotation(
    Line(points = {{-30, 20}, {-20, 20}, {-20, 20}, {-20, 20}}, color = {0, 127, 255}));
  connect(boiler.HP_Out, HP_pipe.waterIn) annotation(
    Line(points = {{-6, 12}, {-6, 12}, {-6, 20}, {-14, 20}, {-14, 20}}, color = {0, 127, 255}));
  connect(GT.flowOut, boiler.gasIn) annotation(
    Line(points = {{-60, -10}, {-42, -10}, {-42, -9}, {-20, -9}}, color = {0, 127, 255}));
end EMA_028_HRSG_Test;
