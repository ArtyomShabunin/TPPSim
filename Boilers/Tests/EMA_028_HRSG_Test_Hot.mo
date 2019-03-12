within TPPSim.Boilers.Tests;

model EMA_028_HRSG_Test_Hot
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  inner Modelica.Fluid.System system(T_start = 60 + 273.15, allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 2482.5 / 3.6, Tnom = 569.1 + 273.15, Tstart = system.T_start) annotation(
  //    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.combitable_startupGT GT(redeclare package Medium = Medium_G, fileName = "C:/Users/ASShabunin/TPPSim/Gas_turbine/Tests/TEC_16_GT_2.txt") annotation(
    Placement(visible = true, transformation(origin = {-16, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = 30 + 273.15, nPorts = 1, p = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {86, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible condPump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {59, 25}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Boilers.EMA_028_HRSG boiler(redeclare package Medium_F = Medium_F, redeclare package Medium_G = Medium_G, HP_p_flow_start = 900000, HP_t_m_steam_start = 473.15, HP_t_m_water_start = 448.15, IP_SH_h_start = Modelica.Media.Water.IF97_Utilities.h_pT(4.5e5, 173 + 273.15), IP_p_flow_start = 450000, IP_pipe2_h_start = Modelica.Media.Water.IF97_Utilities.h_pT(4.5e5, 173 + 273.15), IP_t_m_steam_start = 428.15, IP_t_m_water_start = 418.15, LP_SH_h_start = Modelica.Media.Water.IF97_Utilities.h_pT(2.3e5, 135 + 273.15), LP_p_flow_start = 230000, LP_t_m_steam_start = 397.15, LP_t_m_water_start = 397.15, SH_cold_start = false) annotation(
    Placement(visible = true, transformation(origin = {10, 4}, extent = {{-30, -20}, {30, 20}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible HP_FWP annotation(
    Placement(visible = true, transformation(origin = {31, -47}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible IP_FWP annotation(
    Placement(visible = true, transformation(origin = {33, -41}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.377, Lpipe = 155, delta = 0.05, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2, p_flow_start = 900000) annotation(
    Placement(visible = true, transformation(origin = {-41, 17}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe CRH_pipe(Din = 0.48, Lpipe = 65, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2, p_flow_start = 450000) annotation(
    Placement(visible = true, transformation(origin = {-71, 39}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HRH_pipe(Din = 0.48, Lpipe = 92.8, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2, p_flow_start = 450000) annotation(
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
  Modelica.Blocks.Sources.CombiTimeTable BROU_pos_table(columns = {2, 3, 4, 5}, fileName = "C:/Users/ASShabunin/TPPSim/Boilers/Tests/pos_BROU_2.txt", tableName = "tabl", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-101, 85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant set_T_HPRS(k = 300 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-115, 41}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_HP_2(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-54, 24}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_HRH_2(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-48, -8}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure HP_pressure(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-46, 26}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure IP_pressure(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-50, 6}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  TPPSim.Steam_turbine.dummy_ST ST annotation(
    Placement(visible = true, transformation(origin = {-92, 2}, extent = {{-30, -20}, {30, 20}}, rotation = 0)));
  TPPSim.Controls.control_EMA_028 control_EMA_0281(HP_P_activation = 1e+06, HP_pos_start = 0.03, IP_P_activation = 500000, IP_pos_start = 0.03, IP_speed_p = 500, LP_P_activation = 250000, LP_pos_start = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-50, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure LP_pressure(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {16, 56}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant vent_pos(k = 0)  annotation(
    Placement(visible = true, transformation(origin = {-21, 35}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
equation
  connect(vent_pos.y, boiler.HP_vent_pos) annotation(
    Line(points = {{-18, 36}, {-10, 36}, {-10, 24}, {-10, 24}}, color = {0, 0, 127}));
  connect(vent_pos.y, boiler.RH_vent_pos) annotation(
    Line(points = {{-18, 36}, {-16, 36}, {-16, 24}, {-16, 24}}, color = {0, 0, 127}));
  connect(boiler.HP_p_drum, control_EMA_0281.sensorBus.HP_p_sensor) annotation(
    Line(points = {{-4, 24}, {-4, 44}, {-54, 44}, {-54, 52}}, color = {0, 0, 127}));
  connect(boiler.check_valve_pos, control_EMA_0281.sensorBus.check_valve_pos) annotation(
    Line(points = {{6, 24}, {6, 44}, {-54, 44}, {-54, 52}}, color = {255, 0, 255}));
  connect(ST.IP_CV_apos, control_EMA_0281.sensorBus.IP_CV_apos) annotation(
    Line(points = {{-90, -18}, {-90, -24}, {-56, -24}, {-56, 52}, {-54, 52}}, color = {0, 0, 127}));
  connect(ST.IP_RS_apos, control_EMA_0281.sensorBus.IP_RS_apos) annotation(
    Line(points = {{-92, -18}, {-92, -28}, {-56, -28}, {-56, 52}, {-54, 52}}, color = {0, 0, 127}));
  connect(ST.HP_RS_apos, control_EMA_0281.sensorBus.HP_RS_apos) annotation(
    Line(points = {{-96, -18}, {-96, -32}, {-56, -32}, {-56, 52}, {-54, 52}}, color = {0, 0, 127}));
  connect(ST.HP_CV_apos, control_EMA_0281.sensorBus.HP_CV_apos) annotation(
    Line(points = {{-98, -18}, {-98, -36}, {-56, -36}, {-56, 52}, {-54, 52}}, color = {0, 0, 127}));
  connect(control_EMA_0281.actuatorsBus.HP_RS_pos, ST.HP_RS_pos) annotation(
    Line(points = {{-46, 52}, {-46, 38}, {-98, 38}, {-98, 22}}, color = {255, 204, 51}, thickness = 0.5));
  connect(control_EMA_0281.actuatorsBus.IP_RS_pos, ST.IP_RS_pos) annotation(
    Line(points = {{-46, 52}, {-46, 34}, {-78, 34}, {-78, 26}, {-90, 26}, {-90, 22}}, color = {255, 204, 51}, thickness = 0.5));
  connect(IP_pressure.p, control_EMA_0281.sensorBus.IP_p_sensor) annotation(
    Line(points = {{-46, 6}, {-26, 6}, {-26, 42}, {-56, 42}, {-56, 52}, {-54, 52}}, color = {0, 0, 127}));
  connect(LP_pressure.p, control_EMA_0281.sensorBus.LP_p_sensor) annotation(
    Line(points = {{12, 56}, {-26, 56}, {-26, 46}, {-54, 46}, {-54, 52}}, color = {0, 0, 127}));
  connect(control_EMA_0281.actuatorsBus.LP_RS_pos, ST.LP_CV_pos) annotation(
    Line(points = {{-46, 52}, {-46, 48}, {-84, 48}, {-84, 22}}, color = {255, 204, 51}, thickness = 0.5));
  connect(boiler.LP_Out, LP_pressure.port) annotation(
    Line(points = {{16, 24}, {16, 24}, {16, 52}, {16, 52}}, color = {0, 127, 255}));
  connect(BROU_pos_table.y[4], ST.IP_CV_pos) annotation(
    Line(points = {{-95.5, 85}, {-86, 85}, {-86, 22}}, color = {0, 0, 127}, thickness = 0.5));
  connect(BROU_pos_table.y[2], ST.HP_CV_pos) annotation(
    Line(points = {{-95.5, 85}, {-74, 85}, {-74, 62}, {-88, 62}, {-88, 30}, {-92, 30}, {-92, 22}}, color = {0, 0, 127}, thickness = 0.5));
  connect(ST.cooling_water, HP_massFlowRate.port_b) annotation(
    Line(points = {{-62, 14}, {-58, 14}, {-58, -48}, {16, -48}, {16, -48}}, color = {0, 127, 255}));
  connect(boiler.LP_Out, Ts_LP.port) annotation(
    Line(points = {{16, 24}, {20, 24}, {20, 32}}, color = {0, 127, 255}));
  connect(boiler.RH_In, Ts_CRH.port) annotation(
    Line(points = {{0, 24}, {0, 24}, {0, 36}, {10, 36}, {10, 36}}, color = {0, 127, 255}));
  connect(HRH_pipe.waterOut, ST.HRH) annotation(
    Line(points = {{-42, 2}, {-60, 2}, {-60, 24}, {-100, 24}, {-100, 24}, {-104, 24}, {-104, 22}, {-104, 22}}, color = {0, 127, 255}));
  connect(boiler.RH_Out, Ts_HRH.port) annotation(
    Line(points = {{-20, 14}, {-22, 14}, {-22, 8}, {-32, 8}, {-32, 8}}, color = {0, 127, 255}));
  connect(HRH_pipe.waterOut, Ts_HRH_2.port) annotation(
    Line(points = {{-42, 2}, {-42, 2}, {-42, -12}, {-48, -12}, {-48, -12}}, color = {0, 127, 255}));
  connect(HRH_pipe.waterOut, IP_pressure.port) annotation(
    Line(points = {{-43, 1}, {-50, 1}, {-50, 2}}, color = {0, 127, 255}));
  connect(boiler.RH_Out, HRH_pipe.waterIn) annotation(
    Line(points = {{-20, 14}, {-22, 14}, {-22, 2}, {-36, 2}, {-36, 2}}, color = {0, 127, 255}));
  connect(boiler.HP_Out, Ts_HP.port) annotation(
    Line(points = {{-20, 18}, {-30, 18}, {-30, 20}}, color = {0, 127, 255}));
  connect(CRH_pipe.waterOut, boiler.RH_In) annotation(
    Line(points = {{-65, 39}, {0, 39}, {0, 24}}, color = {0, 127, 255}));
  connect(ST.CRH, CRH_pipe.waterIn) annotation(
    Line(points = {{-122, 22}, {-122, 30}, {-102, 30}, {-102, 40}, {-73, 40}, {-73, 39}}, color = {0, 127, 255}));
  connect(ST.RP_RS_t, set_T_HPRS.y) annotation(
    Line(points = {{-96, 22}, {-96, 22}, {-96, 42}, {-110, 42}, {-110, 42}}, color = {0, 0, 127}));
  connect(boiler.LP_Out, ST.LP) annotation(
    Line(points = {{16, 24}, {16, 30}, {-74, 30}, {-74, 22}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, ST.HP) annotation(
    Line(points = {{-44, 18}, {-58, 18}, {-58, 28}, {-108, 28}, {-108, 22}, {-108, 22}}, color = {0, 127, 255}));
  connect(HP_pressure.port, HP_pipe.waterOut) annotation(
    Line(points = {{-46, 22}, {-46, 18}, {-45, 18}, {-45, 17}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, Ts_HP_2.port) annotation(
    Line(points = {{-45, 17}, {-54, 17}, {-54, 20}}, color = {0, 127, 255}));
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
    Diagram(coordinateSystem(extent = {{-140, -100}, {100, 100}}, initialScale = 0.1)),
    experiment(StartTime = 0, StopTime = 2000, Tolerance = 1e-2, Interval = 10));
end EMA_028_HRSG_Test_Hot;
