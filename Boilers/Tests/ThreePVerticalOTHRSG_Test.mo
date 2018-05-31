within TPPSim.Boilers.Tests;

model ThreePVerticalOTHRSG_Test
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  package Medium_G = TPPSim.Media.ExhaustGas;
  inner Modelica.Fluid.System system(T_start = 60 + 273.15, allowFlowReversal = false, m_flow_small = 0.01, m_flow_start = 0.0001) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 2482.5 / 3.6, Tnom = 569.1 + 273.15, Tstart = system.T_start) annotation(
  //    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.combitable_startupGT GT(redeclare package Medium = Medium_G, fileName = "C:/Users/ASShabunin/TPPSim/Gas_turbine/Tests/TEC_16_GT_1.txt") annotation(
    Placement(visible = true, transformation(origin = {-24, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = 30 + 273.15, nPorts = 1, p = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {90, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible condPump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {59, 11}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible IP_FWP annotation(
    Placement(visible = true, transformation(origin = {35, -63}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.377, Lpipe = 155, delta = 0.05, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-41, 17}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe CRH_pipe(Din = 0.48, Lpipe = 65, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-71, 39}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HRH_pipe(Din = 0.48, Lpipe = 92.8, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-39, 1}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible LP_FWP annotation(
    Placement(visible = true, transformation(origin = {37, -57}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_ph deaerator(redeclare package Medium = Medium_F, h = 830000, nPorts = 4, p = 3.6e5, use_h_in = true) annotation(
    Placement(visible = true, transformation(origin = {62, -64}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate HP_massFlowRate(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {20, -70}, extent = {{2, -2}, {-2, 2}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate IP_massFlowRate(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {24, -62}, extent = {{2, -2}, {-2, 2}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate LP_massFlowRate(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {28, -56}, extent = {{2, -2}, {-2, 2}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1(nin = 3) annotation(
    Placement(visible = true, transformation(origin = {50, -24}, extent = {{-4, -4}, {4, 4}}, rotation = 90)));
  TPPSim.Valves.simpleValve cond_CV(dp = 100000, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {34, -48}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant hd(k = 588.6e3) annotation(
    Placement(visible = true, transformation(origin = {94, -60}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_HP(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-30, 24}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_CRH(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-20, 24}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_HRH(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-32, 12}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_LP(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-10, 24}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Tw_condout(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {4, -62}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable BROU_pos_table(columns = {2, 3, 4, 5}, fileName = "C:/Users/ASShabunin/TPPSim/Boilers/Tests/pos_BROU.txt", tableName = "tabl", tableOnFile = true) annotation(
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
  TPPSim.Controls.control_EMA_028 control_EMA_0281(HP_P_activation = 300000, HP_pos_start = 0.01, IP_P_activation = 300000, IP_pos_start = 0.01, LP_P_activation = 150000, LP_pos_start = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-52, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure LP_pressure(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-28, 56}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  TPPSim.Boilers.ThreePVerticalOTHRSG boiler annotation(
    Placement(visible = true, transformation(origin = {10, -6}, extent = {{20, -30}, {-20, 30}}, rotation = 0)));
equation
  connect(boiler.check_valve_pos, control_EMA_0281.sensorBus.check_valve_pos) annotation(
    Line(points = {{-10, -6}, {-14, -6}, {-14, 44}, {-56, 44}, {-56, 52}, {-56, 52}}, color = {255, 0, 255}));
  connect(boiler.HP_p_sep, control_EMA_0281.sensorBus.HP_p_sensor) annotation(
    Line(points = {{30, 18}, {34, 18}, {34, 44}, {-56, 44}, {-56, 52}, {-56, 52}}, color = {0, 0, 127}));
  connect(boiler.HP_Out, Ts_HRH.port) annotation(
    Line(points = {{-10, -14}, {-22, -14}, {-22, 8}, {-32, 8}, {-32, 8}}, color = {0, 127, 255}));
  connect(boiler.RH_Out, HRH_pipe.waterIn) annotation(
    Line(points = {{-10, -18}, {-26, -18}, {-26, 2}, {-36, 2}, {-36, 2}}, color = {0, 127, 255}));
  connect(boiler.HP_Out, Ts_HP.port) annotation(
    Line(points = {{-10, -14}, {-22, -14}, {-22, 16}, {-30, 16}, {-30, 20}, {-30, 20}}, color = {0, 127, 255}));
  connect(boiler.HP_Out, HP_pipe.waterIn) annotation(
    Line(points = {{-10, -14}, {-22, -14}, {-22, 16}, {-38, 16}, {-38, 18}}, color = {0, 127, 255}));
  connect(boiler.LP_Out, LP_pressure.port) annotation(
    Line(points = {{-10, -4}, {-16, -4}, {-16, 52}, {-28, 52}, {-28, 52}}, color = {0, 127, 255}));
  connect(boiler.LP_Out, Ts_LP.port) annotation(
    Line(points = {{-10, -4}, {-16, -4}, {-16, 18}, {-10, 18}, {-10, 20}, {-10, 20}}, color = {0, 127, 255}));
  connect(boiler.LP_Out, ST.LP) annotation(
    Line(points = {{-10, -4}, {-16, -4}, {-16, 32}, {-74, 32}, {-74, 22}, {-74, 22}}, color = {0, 127, 255}));
  connect(boiler.RH_In, Ts_CRH.port) annotation(
    Line(points = {{-10, -10}, {-18, -10}, {-18, 14}, {-20, 14}, {-20, 20}, {-20, 20}}, color = {0, 127, 255}));
  connect(CRH_pipe.waterOut, boiler.RH_In) annotation(
    Line(points = {{-68, 40}, {-18, 40}, {-18, -10}, {-10, -10}, {-10, -10}}, color = {0, 127, 255}));
  connect(control_EMA_0281.actuatorsBus.HP_vent_pos, boiler.HP_vent_pos) annotation(
    Line(points = {{-48, 52}, {-48, 52}, {-48, 34}, {24, 34}, {24, 24}, {22, 24}}, color = {255, 204, 51}, thickness = 0.5));
  connect(control_EMA_0281.actuatorsBus.IP_vent_pos, boiler.RH_vent_pos) annotation(
    Line(points = {{-48, 52}, {-48, 52}, {-48, 34}, {28, 34}, {28, 24}, {30, 24}}, color = {255, 204, 51}, thickness = 0.5));
  connect(HP_massFlowRate.port_b, boiler.HP_FW_In) annotation(
    Line(points = {{18, -70}, {18, -70}, {18, -32}, {32, -32}, {32, -12}, {30, -12}, {30, -12}}, color = {0, 127, 255}));
  connect(IP_massFlowRate.port_b, boiler.IP_FW_In) annotation(
    Line(points = {{22, -62}, {22, -62}, {22, -36}, {36, -36}, {36, -10}, {30, -10}, {30, -10}}, color = {0, 127, 255}));
  connect(LP_massFlowRate.port_b, boiler.LP_FW_In) annotation(
    Line(points = {{26, -56}, {26, -56}, {26, -40}, {40, -40}, {40, -4}, {30, -4}, {30, -4}}, color = {0, 127, 255}));
  connect(boiler.condOut, Tw_condout.port) annotation(
    Line(points = {{-10, 2}, {-12, 2}, {-12, -48}, {-4, -48}, {-4, -66}, {4, -66}, {4, -66}}, color = {0, 127, 255}));
  connect(boiler.condOut, cond_CV.flowIn) annotation(
    Line(points = {{-10, 2}, {-12, 2}, {-12, -48}, {30, -48}, {30, -48}}, color = {0, 127, 255}));
  connect(condPump.port_b, boiler.condIn) annotation(
    Line(points = {{54, 11}, {40, 11}, {40, 3}, {30, 3}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], condPump.port_a) annotation(
    Line(points = {{80, 10}, {75, 10}, {75, 11}, {64, 11}}, color = {0, 127, 255}, thickness = 0.5));
  connect(deaerator.ports[3], HP_massFlowRate.port_a) annotation(
    Line(points = {{52, -64}, {42, -64}, {42, -70}, {22, -70}, {22, -70}, {22, -70}}, color = {0, 127, 255}, thickness = 0.5));
  connect(GT.flowOut, boiler.gasIn) annotation(
    Line(points = {{-14, -28}, {-10, -28}}, color = {0, 127, 255}));
  connect(hd.y, deaerator.h_in) annotation(
    Line(points = {{87.4, -60}, {74.4, -60}}, color = {0, 0, 127}));
  connect(cond_CV.flowOut, deaerator.ports[4]) annotation(
    Line(points = {{38, -48}, {45, -48}, {45, -48}, {52, -48}, {52, -64}, {52, -64}, {52, -64}, {52, -64}}, color = {0, 127, 255}));
  connect(sum1.y, cond_CV.D_flow_in) annotation(
    Line(points = {{50, -19.6}, {50, -19.6}, {50, -19.6}, {50, -19.6}, {50, -17.6}, {44, -17.6}, {44, -43.6}, {34, -43.6}, {34, -47.6}, {34, -47.6}, {34, -47.6}, {34, -47.6}}, color = {0, 0, 127}));
  connect(HP_massFlowRate.m_flow, sum1.u[3]) annotation(
    Line(points = {{20, -67.8}, {18, -67.8}, {18, -67.8}, {16, -67.8}, {16, -73.8}, {78, -73.8}, {78, -35.8}, {50, -35.8}, {50, -27.8}}, color = {0, 0, 127}));
  connect(IP_massFlowRate.m_flow, sum1.u[2]) annotation(
    Line(points = {{24, -59.8}, {37, -59.8}, {37, -59.8}, {50, -59.8}, {50, -27.8}}, color = {0, 0, 127}));
  connect(LP_massFlowRate.m_flow, sum1.u[1]) annotation(
    Line(points = {{28, -53.8}, {39, -53.8}, {39, -53.8}, {50, -53.8}, {50, -40.8}, {50, -40.8}, {50, -27.8}}, color = {0, 0, 127}));
  connect(LP_FWP.port_b, LP_massFlowRate.port_a) annotation(
    Line(points = {{34, -57}, {33, -57}, {33, -57}, {32, -57}, {32, -57}, {30, -57}, {30, -57}, {30, -57}, {30, -57}, {30, -57}, {30, -57}, {30, -57}, {30, -57}, {30, -57}}, color = {0, 127, 255}));
  connect(IP_massFlowRate.port_a, IP_FWP.port_b) annotation(
    Line(points = {{26, -62}, {29, -62}, {29, -62}, {32, -62}, {32, -63}}, color = {0, 127, 255}));
  connect(ST.cooling_water, HP_massFlowRate.port_b) annotation(
    Line(points = {{-62, 14}, {-58, 14}, {-58, -70}, {18, -70}}, color = {0, 127, 255}));
  connect(deaerator.ports[2], IP_FWP.port_a) annotation(
    Line(points = {{52, -64}, {50.25, -64}, {50.25, -64}, {48.5, -64}, {48.5, -64}, {45, -64}, {45, -64}, {38, -64}, {38, -62}, {38, -62}, {38, -62}, {38, -62}, {38, -62}, {38, -62}}, color = {0, 127, 255}, thickness = 0.5));
  connect(deaerator.ports[1], LP_FWP.port_a) annotation(
    Line(points = {{52, -64}, {51, -64}, {51, -64}, {50, -64}, {50, -64}, {48, -64}, {48, -64}, {44, -64}, {44, -56}, {42, -56}, {42, -56}, {41, -56}, {41, -56}, {40, -56}}, color = {0, 127, 255}, thickness = 0.5));
  connect(LP_pressure.p, control_EMA_0281.sensorBus.LP_p_sensor) annotation(
    Line(points = {{-32, 56}, {-32, 46}, {-56, 46}, {-56, 52}}, color = {0, 0, 127}));
  connect(ST.IP_CV_apos, control_EMA_0281.sensorBus.IP_CV_apos) annotation(
    Line(points = {{-90, -18}, {-90, -24}, {-56, -24}, {-56, 52}}, color = {0, 0, 127}));
  connect(ST.IP_RS_apos, control_EMA_0281.sensorBus.IP_RS_apos) annotation(
    Line(points = {{-92, -18}, {-92, -28}, {-56, -28}, {-56, 52}}, color = {0, 0, 127}));
  connect(ST.HP_RS_apos, control_EMA_0281.sensorBus.HP_RS_apos) annotation(
    Line(points = {{-96, -18}, {-96, -32}, {-56, -32}, {-56, 52}}, color = {0, 0, 127}));
  connect(ST.HP_CV_apos, control_EMA_0281.sensorBus.HP_CV_apos) annotation(
    Line(points = {{-98, -18}, {-98, -36}, {-56, -36}, {-56, 52}}, color = {0, 0, 127}));
  connect(control_EMA_0281.actuatorsBus.HP_RS_pos, ST.HP_RS_pos) annotation(
    Line(points = {{-48, 52}, {-48, 38}, {-98, 38}, {-98, 22}}, color = {255, 204, 51}, thickness = 0.5));
  connect(control_EMA_0281.actuatorsBus.IP_RS_pos, ST.IP_RS_pos) annotation(
    Line(points = {{-48, 52}, {-48, 34}, {-78, 34}, {-78, 26}, {-90, 26}, {-90, 22}}, color = {255, 204, 51}, thickness = 0.5));
  connect(IP_pressure.p, control_EMA_0281.sensorBus.IP_p_sensor) annotation(
    Line(points = {{-46, 6}, {-26, 6}, {-26, 42}, {-56, 42}, {-56, 52}}, color = {0, 0, 127}));
  connect(control_EMA_0281.actuatorsBus.LP_RS_pos, ST.LP_CV_pos) annotation(
    Line(points = {{-48, 52}, {-48, 48}, {-84, 48}, {-84, 22}}, color = {255, 204, 51}, thickness = 0.5));
  connect(BROU_pos_table.y[4], ST.IP_CV_pos) annotation(
    Line(points = {{-95.5, 85}, {-86, 85}, {-86, 22}}, color = {0, 0, 127}, thickness = 0.5));
  connect(BROU_pos_table.y[2], ST.HP_CV_pos) annotation(
    Line(points = {{-95.5, 85}, {-74, 85}, {-74, 62}, {-88, 62}, {-88, 30}, {-92, 30}, {-92, 22}}, color = {0, 0, 127}, thickness = 0.5));
  connect(HRH_pipe.waterOut, ST.HRH) annotation(
    Line(points = {{-42, 2}, {-60, 2}, {-60, 24}, {-100, 24}, {-100, 24}, {-104, 24}, {-104, 22}, {-104, 22}}, color = {0, 127, 255}));
  connect(HRH_pipe.waterOut, Ts_HRH_2.port) annotation(
    Line(points = {{-42, 2}, {-42, 2}, {-42, -12}, {-48, -12}, {-48, -12}}, color = {0, 127, 255}));
  connect(HRH_pipe.waterOut, IP_pressure.port) annotation(
    Line(points = {{-43, 1}, {-50, 1}, {-50, 2}}, color = {0, 127, 255}));
  connect(ST.CRH, CRH_pipe.waterIn) annotation(
    Line(points = {{-122, 22}, {-122, 30}, {-102, 30}, {-102, 40}, {-73, 40}, {-73, 39}}, color = {0, 127, 255}));
  connect(ST.RP_RS_t, set_T_HPRS.y) annotation(
    Line(points = {{-96, 22}, {-96, 22}, {-96, 42}, {-110, 42}, {-110, 42}}, color = {0, 0, 127}));
  connect(HP_pipe.waterOut, ST.HP) annotation(
    Line(points = {{-44, 18}, {-58, 18}, {-58, 28}, {-108, 28}, {-108, 22}, {-108, 22}}, color = {0, 127, 255}));
  connect(HP_pressure.port, HP_pipe.waterOut) annotation(
    Line(points = {{-46, 22}, {-46, 18}, {-45, 18}, {-45, 17}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, Ts_HP_2.port) annotation(
    Line(points = {{-45, 17}, {-54, 17}, {-54, 20}}, color = {0, 127, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-140, -100}, {100, 100}})),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
    experiment(StartTime = 0, StopTime = 5000, Tolerance = 1e-2, Interval = 10));
end ThreePVerticalOTHRSG_Test;
