within TPPSim.Boilers.Tests;

model EMA_028_HRSG_Test
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  package Medium_G = TPPSim.Media.ExhaustGas;
  inner Modelica.Fluid.System system(T_start = 60 + 273.15,allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 2482.5 / 3.6, Tnom = 569.1 + 273.15, Tstart = system.T_start) annotation(
  //    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.combitable_startupGT GT(redeclare package Medium = Medium_G, fileName = "C:/Users/User/Documents/TPPSim/Gas_turbine/Tests/my.txt") annotation(
    Placement(visible = true, transformation(origin = {-14, -34}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 3, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-90, 54}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant HP_CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {31, 67}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = 30 + 273.15, nPorts = 1, p = system.p_ambient)  annotation(
    Placement(visible = true, transformation(origin = {86, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible condPump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {59, 25}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Valves.ReducingStation HP_RS(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 600, dp_nominal = 9e+06, min_delta = 90, set_down_T = 573.15, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {-34, 20}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible IP_RS(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1800, dp_nominal = 3e+06) annotation(
      Placement(visible = true, transformation(origin = {-56, 2}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
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
    Placement(visible = true, transformation(origin = {-29, 13}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HRH_pipe(Din = 0.48, Lpipe = 92.8, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-27, 3}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
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
  Modelica.Blocks.Sources.CombiTimeTable BROU_pos_table(columns = {2, 3, 4, 5},fileName = "C:/Users/User/Documents/TPPSim/Boilers/Tests/pos_BROU.txt", tableName = "tabl", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-83, 85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant set_T_HPRS(k = 300 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-45, 55}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  ThermoPower.Water.SteamTurbineStodola HPT(Kt = 0.0038, PRstart = 1, eta_iso_nom = 0.9, pnom = 130e5, wnom = 77)  annotation(
    Placement(visible = true, transformation(origin = {-62, 28}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible HPCV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1000, dp_nominal = 9e+06) annotation(
    Placement(visible = true, transformation(origin = {-46, 36}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort1(redeclare package Medium = Medium_F, nPorts_b = 2)  annotation(
    Placement(visible = true, transformation(origin = {-25.6, 36}, extent = {{2.4, -6}, {-2.4, 6}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort2(redeclare package Medium = Medium_F, nPorts_b = 2) annotation(
    Placement(visible = true, transformation(origin = {-43.6, 12}, extent = {{2.4, -6}, {-2.4, 6}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort3(redeclare package Medium = Medium_F, nPorts_b = 2) annotation(
    Placement(visible = true, transformation(origin = {-43.6, 2}, extent = {{2.4, -6}, {-2.4, 6}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible IPT(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1230, dp_nominal = 3e+06) annotation(
    Placement(visible = true, transformation(origin = {-68, -8}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed1(w_fixed = Modelica.Constants.pi * 50)  annotation(
    Placement(visible = true, transformation(origin = {-89, 27}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_HP_2(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-18, 50}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_HRH_2(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-52, -16}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable BROU_P_table(columns = {2, 3}, fileName = "C:/Users/User/Documents/TPPSim/Boilers/Tests/P_BROU_inlet.txt", tableName = "tabl", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-11, 87}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  TPPSim.Controls.pressure_control_2 HP_pressure_control(P_activation = 500000, T = 50, k = 0.000005, pos_start = 0.01, set_p = 6.7e+06, speed_p = 1e5 / 60)  annotation(
    Placement(visible = true, transformation(origin = {-28, 64}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Fluid.Sensors.Pressure HP_pressure(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-24, 26}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure IP_pressure(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-32, -4}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  TPPSim.Controls.pressure_control_3 IP_pressure_control(P_activation = 300000, T = 35, k = 0.000005, pos_start = 0.01,set_p = 1.8e+06, speed_p = 0.4e5 / 60) annotation(
    Placement(visible = true, transformation(origin = {-64, 60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(k = false)  annotation(
    Placement(visible = true, transformation(origin = {-82, 70}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater1 annotation(
    Placement(visible = true, transformation(origin = {47, 51}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant check_valve_pos_const(k = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {32, 38}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
equation
  connect(greater1.y, IP_pressure_control.u4) annotation(
    Line(points = {{52, 52}, {56, 52}, {56, 78}, {-74, 78}, {-74, 64}, {-72, 64}, {-72, 64}}, color = {255, 0, 255}));
  connect(check_valve_pos_const.y, greater1.u2) annotation(
    Line(points = {{36, 38}, {38, 38}, {38, 48}, {40, 48}, {40, 46}}, color = {0, 0, 127}));
  connect(boiler.check_valve_pos, greater1.u1) annotation(
    Line(points = {{6, 24}, {6, 24}, {6, 42}, {18, 42}, {18, 50}, {40, 50}, {40, 52}}, color = {0, 0, 127}));
  connect(IP_pressure.p, IP_pressure_control.u2) annotation(
    Line(points = {{-28, -4}, {-26, -4}, {-26, 8}, {-52, 8}, {-52, 72}, {-68, 72}, {-68, 68}, {-68, 68}}, color = {0, 0, 127}));
  connect(booleanConstant1.y, HP_pressure_control.u4) annotation(
    Line(points = {{-76, 70}, {-44, 70}, {-44, 68}, {-36, 68}, {-36, 68}}, color = {255, 0, 255}));
  connect(boiler.HP_p_drum, HP_pressure_control.u2) annotation(
    Line(points = {{0, 16}, {-2, 16}, {-2, 80}, {-32, 80}, {-32, 72}, {-32, 72}}, color = {0, 0, 127}));
  connect(IPT.opening_actual, IP_pressure_control.u3) annotation(
    Line(points = {{-70, -8}, {-70, -8}, {-70, 10}, {-66, 10}, {-66, 40}, {-66, 40}, {-66, 70}, {-62, 70}, {-62, 68}, {-62, 68}}, color = {0, 0, 127}));
  connect(IP_RS.opening_actual, IP_pressure_control.u1) annotation(
    Line(points = {{-58, 2}, {-58, 2}, {-58, 76}, {-60, 76}, {-60, 68}, {-60, 68}, {-60, 68}}, color = {0, 0, 127}));
  connect(HPCV.opening_actual, HP_pressure_control.u3) annotation(
    Line(points = {{-48, 36}, {-48, 36}, {-48, 74}, {-34, 74}, {-34, 74}, {-28, 74}, {-28, 72}, {-28, 72}}, color = {0, 0, 127}));
  connect(HP_RS.opening_actual, HP_pressure_control.u1) annotation(
    Line(points = {{-34, 22}, {-32, 22}, {-32, 54}, {-18, 54}, {-18, 76}, {-24, 76}, {-24, 72}, {-24, 72}}, color = {0, 0, 127}));
  connect(HP_pressure_control.y, HP_RS.opening) annotation(
    Line(points = {{-28, 58}, {-28, 58}, {-28, 52}, {-32, 52}, {-32, 24}, {-32, 24}}, color = {0, 0, 127}));
  connect(BROU_pos_table.y[2], HPCV.opening) annotation(
    Line(points = {{-78, 86}, {-46, 86}, {-46, 40}, {-46, 40}}, color = {0, 0, 127}, thickness = 0.5));
  connect(IP_pressure_control.y, IP_RS.opening) annotation(
    Line(points = {{-64, 54}, {-64, 54}, {-64, 46}, {-56, 46}, {-56, 6}, {-56, 6}}, color = {0, 0, 127}));
  connect(HRH_pipe.waterOut, IP_pressure.port) annotation(
    Line(points = {{-30, 4}, {-34, 4}, {-34, -8}, {-32, -8}, {-32, -8}}, color = {0, 127, 255}));
  connect(HP_pressure.port, HP_pipe.waterOut) annotation(
    Line(points = {{-24, 22}, {-24, 22}, {-24, 18}, {-20, 18}, {-20, 20}}, color = {0, 127, 255}));
  connect(Ts_HRH_2.port, multiPort3.port_a) annotation(
    Line(points = {{-52, -20}, {-42, -20}, {-42, 2}, {-42, 2}}, color = {0, 127, 255}));
  connect(multiPort1.port_a, Ts_HP_2.port) annotation(
    Line(points = {{-24, 36}, {-18, 36}, {-18, 46}, {-18, 46}}, color = {0, 127, 255}));
  connect(multiPort2.port_a, CRH_pipe.waterIn) annotation(
    Line(points = {{-41, 12}, {-38, 12}, {-38, 13}, {-33, 13}}, color = {0, 127, 255}));
  connect(HPT.outlet, multiPort2.ports_b[1]) annotation(
    Line(points = {{-70, 36}, {-70, 12}, {-46, 12}}, color = {0, 0, 255}));
  connect(HP_RS.flowOut, multiPort2.ports_b[2]) annotation(
    Line(points = {{-38, 20}, {-50, 20}, {-50, 12}, {-46, 12}}, color = {0, 127, 255}));
  connect(HPT.shaft_b, constantSpeed1.flange) annotation(
    Line(points = {{-68, 28}, {-84, 28}, {-84, 27}}));
  connect(BROU_pos_table.y[4], IPT.opening) annotation(
    Line(points = {{-78, 86}, {-72, 86}, {-72, 6}, {-68, 6}, {-68, -4}, {-68, -4}}, color = {0, 0, 127}, thickness = 0.5));
  connect(IPT.port_b, flowSink.ports[3]) annotation(
    Line(points = {{-72, -8}, {-76, -8}, {-76, 52}, {-80, 52}, {-80, 54}}, color = {0, 127, 255}));
  connect(multiPort3.ports_b[1], IPT.port_a) annotation(
    Line(points = {{-46, 2}, {-46, 2}, {-46, -8}, {-64, -8}, {-64, -8}}, color = {0, 127, 255}, thickness = 0.5));
  connect(HRH_pipe.waterOut, multiPort3.port_a) annotation(
    Line(points = {{-30, 4}, {-40, 4}, {-40, 2}, {-42, 2}}, color = {0, 127, 255}));
  connect(multiPort3.ports_b[2], IP_RS.port_a) annotation(
    Line(points = {{-46, 2}, {-52, 2}, {-52, 2}, {-52, 2}}, color = {0, 127, 255}, thickness = 0.5));
  connect(boiler.RH_Out, HRH_pipe.waterIn) annotation(
    Line(points = {{-8, 12}, {-22, 12}, {-22, 3}, {-23, 3}}, color = {0, 127, 255}));
  connect(IP_RS.port_b, flowSink.ports[1]) annotation(
    Line(points = {{-60, 2}, {-80, 2}, {-80, 54}}, color = {0, 127, 255}));
  connect(CRH_pipe.waterOut, boiler.RH_In) annotation(
    Line(points = {{-25, 13}, {-4, 13}, {-4, 12}}, color = {0, 127, 255}));
  connect(multiPort1.ports_b[2], HP_RS.flowIn) annotation(
    Line(points = {{-28, 36}, {-28, 36}, {-28, 20}, {-30, 20}, {-30, 20}}, color = {0, 127, 255}, thickness = 0.5));
  connect(multiPort1.ports_b[1], HPCV.port_a) annotation(
    Line(points = {{-28, 36}, {-42, 36}, {-42, 36}, {-42, 36}}, color = {0, 127, 255}, thickness = 0.5));
  connect(HP_pipe.waterOut, multiPort1.port_a) annotation(
    Line(points = {{-20, 20}, {-20, 20}, {-20, 36}, {-24, 36}, {-24, 36}}, color = {0, 127, 255}));
  connect(HPT.inlet, HPCV.port_b) annotation(
    Line(points = {{-54, 36}, {-50, 36}}, color = {0, 0, 255}));
  connect(set_T_HPRS.y, HP_RS.T_in) annotation(
    Line(points = {{-40, 56}, {-38, 56}, {-38, 24}, {-38, 24}}, color = {0, 0, 127}));
  connect(LP_CV.port_b, flowSink.ports[2]) annotation(
    Line(points = {{6, 52}, {0, 52}, {0, 96}, {-94, 96}, {-94, 70}, {-80, 70}, {-80, 54}, {-80, 54}}, color = {0, 127, 255}));
  connect(HP_CV_const.y, LP_CV.opening) annotation(
    Line(points = {{26, 68}, {10, 68}, {10, 56}, {10, 56}}, color = {0, 0, 127}));
  connect(GT.flowOut, boiler.gasIn) annotation(
    Line(points = {{-24, -34}, {-30, -34}, {-30, -8}, {-20, -8}, {-20, -8}}, color = {0, 127, 255}));
  connect(HP_massFlowRate.port_b, HP_RS.waterIn) annotation(
    Line(points = {{16, -48}, {-36, -48}, {-36, 16}, {-36, 16}}, color = {0, 127, 255}));
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
  connect(boiler.HP_Out, HP_pipe.waterIn) annotation(
    Line(points = {{-6, 12}, {-6, 12}, {-6, 20}, {-14, 20}, {-14, 20}}, color = {0, 127, 255}));
end EMA_028_HRSG_Test;
