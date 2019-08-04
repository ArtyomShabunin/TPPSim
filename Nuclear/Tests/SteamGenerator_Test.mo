within TPPSim.Nuclear.Tests;

model SteamGenerator_Test
  package Medium_S = TPPSim.Media.Sodium_ph;
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  inner Modelica.Fluid.System system(m_flow_start = 10, p_ambient = 1.3e+06) annotation(
    Placement(visible = true, transformation(origin = {190, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = 190 + 273.15, m_flow = 315.25, nPorts = 2, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {120, -12}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, nPorts = 1, p = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {124, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature loop_2_low_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {54, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature loop_1_high_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-12, 36}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature loop_1_low_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-32,-66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature loop_2_high_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {18, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  Modelica.Fluid.Sensors.Temperature Steam_out_temp(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = { 52, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Water_in_temp(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {78, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe steam_pipe(Din = 0.15, Lpipe = 10, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 2, numberOfVolumes = 5, t_m_start = 463.15) annotation(
    Placement(visible = true, transformation(origin = {72, 40}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible RS(redeclare package Medium = Medium_F, dp_nominal = 1.4e+12, filteredOpening = true, m_flow_nominal = 40 * 8, p_nominal = 140e5, rho_nominal = 44.35)  annotation(
    Placement(visible = true, transformation(origin = {92, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Nuclear.SteamGenerator steamGenerator1(n_sg = 8)  annotation(
    Placement(visible = true, transformation(origin = {38, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Nuclear.SodiumHE IHX(redeclare TPPSim.HRSG_HeatExch.GlycolSideHE flowHE(redeclare TPPSim.thermal.alfaSodium_inside alpha(section = section)), redeclare package Medium_S = Medium_S, redeclare package Medium_F = Medium_S, Dcase = 3, Din = 0.03, Lpipe = 20, T_m_start = 463.15, T_sodium_start = 463.15, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, h_flow_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(system.p_ambient, 190 + 273.15), k_volume = 2, k_volume_sodium = 2, k_weight_metal = 2, m_flow_start = 2981, metalDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfVolumes = 10, p_flow_start = system.p_ambient, p_sodium_start = 250000, sodiumEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, z = 4500) annotation(
    Placement(visible = true, transformation(origin = {0, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Nuclear.Reactor CFR600(redeclare TPPSim.HRSG_HeatExch.GlycolSideHE flowHE(redeclare TPPSim.thermal.alfaSodium_inside alpha(section = section)), redeclare package Medium_F = Medium_S, Dcase = 3, Din = 0.03, Lpipe = 20, T_m_start = 463.15, T_sodium_start = 463.15, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, h_flow_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(system.p_ambient, 190 + 273.15), k_gamma_sodium = 1, m_flow_start = 0.01, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = system.p_ambient, p_sodium_start = 150000, sodiumEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, z = 5000) annotation(
    Placement(visible = true, transformation(origin = {-40, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  TPPSim.Pumps.circPump circPump_2(redeclare package Medium = Medium_S, setD_flow = 2981, setp_flow = 250000, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {14, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.circPump circPump_1(redeclare package Medium = Medium_S, setD_flow = 3502, setp_flow = 150000, use_D_flow_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-48, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID s_temp_control_1( Ti = 10,controllerType = Modelica.Blocks.Types.SimpleController.PI,initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = -0.5, limitsAtInit = true, yMax = 315.25, yMin = 100, y_start = 100)  annotation(
    Placement(visible = true, transformation(origin = {88, -100}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant set_stemp_1(k = 308 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {46, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable input_data(columns = {2, 3, 4, 5}, fileName = "C:/Users/ASShabunin/TPPSim/Nuclear/Tests/CFR600_case1_5.txt", tableName = "tabl", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-140, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant nom_power(k = 750e6 / 100)  annotation(
    Placement(visible = true, transformation(origin = {-140, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {-108, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product2 annotation(
    Placement(visible = true, transformation(origin = {-108, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product3 annotation(
    Placement(visible = true, transformation(origin = {-108, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant circ_pump1_nom(k = 3502 / 100)  annotation(
    Placement(visible = true, transformation(origin = {-140, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant circ_pump2_nom(k = 2981 / 100)  annotation(
    Placement(visible = true, transformation(origin = {-140, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure steam_pressure(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {78, 72}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID pressure_control(Ti = 20, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = -0.000001, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 1)  annotation(
    Placement(visible = true, transformation(origin = {48, 90}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant RS_pos(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {140, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant set_T_loop_1(k = 539 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-102, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID loop1_control(Ti = 1,controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = -1, limitsAtInit = true, yMax = 3502, yMin = 1750, y_start = 1750)  annotation(
    Placement(visible = true, transformation(origin = {-64, -100}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant set_T_loop_2(k = 502 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-24, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID loop2_control(Ti = 1, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = -1, limitsAtInit = true, yMax = 2981, yMin = 1490.5, y_start = 1490.5)  annotation(
    Placement(visible = true, transformation(origin = {6, -100}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable FW_temperature(columns = {2}, fileName = "C:/Users/ASShabunin/TPPSim/Nuclear/Tests/CFR600_FW_case1_5.txt", tableName = "tabl", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {172, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe_2 sodium_pipe_11(redeclare package Medium = Medium_S, Din = 0.8, Lpipe = 25, delta = 0.02, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, h_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(1.5, 190 + 273.15), k_volume = 10, k_weight_metal = 10, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 3, numberOfVolumes = 3, p_flow_start = 150000, t_m_start = 463.15)  annotation(
    Placement(visible = true, transformation(origin = {-21, -41}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe_2 sodium_pipe_12(redeclare package Medium = Medium_S, Din = 0.8, Lpipe = 25, delta = 0.02, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, h_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(1.5, 190 + 273.15), k_volume = 10, k_weight_metal = 10, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 3, numberOfVolumes = 3, p_flow_start = 150000, t_m_start = 463.15) annotation(
    Placement(visible = true, transformation(origin = {-19, 15}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe_2 sodium_pipe_21(redeclare package Medium = Medium_S, Din = 0.8, Lpipe = 25, delta = 0.02, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, h_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(1.5, 190 + 273.15), k_volume = 10, k_weight_metal = 10, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 3, p_flow_start = 150000, t_m_start = 463.15) annotation(
    Placement(visible = true, transformation(origin = {33, -17}, extent = {{5, -5}, {-5, 5}}, rotation = 90)));
  TPPSim.Pipes.ComplexPipe_2 sodium_pipe_22(redeclare package Medium = Medium_S, Din = 0.8, Lpipe = 25, delta = 0.02, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, h_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(1.5, 190 + 273.15), k_volume = 10, k_weight_metal = 10, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 3, p_flow_start = 150000, t_m_start = 463.15) annotation(
    Placement(visible = true, transformation(origin = {11, 29}, extent = {{5, -5}, {-5, 5}}, rotation = 180)));
equation
  connect(steamGenerator1.sodiumOut, loop_2_low_temp.port) annotation(
    Line(points = {{32, 12}, {32, 12}, {32, -8}, {38, -8}, {38, -52}, {54, -52}, {54, -52}}, color = {0, 127, 255}));
  connect(pressure_control.y, RS.opening) annotation(
    Line(points = {{60, 90}, {92, 90}, {92, 48}, {92, 48}}, color = {0, 0, 127}));
  connect(sodium_pipe_22.waterOut, loop_2_high_temp.port) annotation(
    Line(points = {{18, 30}, {18, 30}, {18, 38}, {18, 38}}, color = {0, 127, 255}));
  connect(sodium_pipe_22.waterOut, steamGenerator1.sodiumIn) annotation(
    Line(points = {{18, 30}, {22, 30}, {22, 6}, {44, 6}, {44, 18}, {44, 18}}, color = {0, 127, 255}));
  connect(IHX.flowOut, sodium_pipe_22.waterIn) annotation(
    Line(points = {{6, 16}, {4, 16}, {4, 30}, {6, 30}}, color = {0, 127, 255}));
  connect(steamGenerator1.sodiumOut, sodium_pipe_21.waterIn) annotation(
    Line(points = {{32, 12}, {32, 12}, {32, -10}, {34, -10}}, color = {0, 127, 255}));
  connect(sodium_pipe_21.waterOut, circPump_2.port_a) annotation(
    Line(points = {{34, -24}, {32, -24}, {32, -40}, {24, -40}, {24, -40}}, color = {0, 127, 255}));
  connect(sodium_pipe_12.waterOut, loop_1_high_temp.port) annotation(
    Line(points = {{-12, 16}, {-12, 16}, {-12, 26}, {-12, 26}}, color = {0, 127, 255}));
  connect(loop_1_high_temp.T, loop1_control.u_m) annotation(
    Line(points = {{-19, 36}, {-64, 36}, {-64, -88}}, color = {0, 0, 127}));
  connect(sodium_pipe_12.waterOut, IHX.sodiumIn) annotation(
    Line(points = {{-12, 16}, {-6, 16}, {-6, 16}, {-4, 16}}, color = {0, 127, 255}));
  connect(CFR600.flowOut, sodium_pipe_12.waterIn) annotation(
    Line(points = {{-30, 2}, {-26, 2}, {-26, 16}, {-24, 16}}, color = {0, 127, 255}));
  connect(sodium_pipe_11.waterOut, circPump_1.port_a) annotation(
    Line(points = {{-27, -41}, {-36, -41}, {-36, -42}, {-38, -42}}, color = {0, 127, 255}));
  connect(sodium_pipe_11.waterIn, IHX.sodiumOut) annotation(
    Line(points = {{-15, -41}, {-6, -41}, {-6, -4}, {-4, -4}}, color = {0, 127, 255}));
  connect(product2.y, circPump_1.D_flow_in) annotation(
    Line(points = {{-97, -14}, {-25, -14}, {-25, -32}, {-48, -32}}, color = {0, 0, 127}));
  connect(circPump_1.port_b, CFR600.flowIn) annotation(
    Line(points = {{-58, -42}, {-58, -23}, {-40, -23}, {-40, -4}}, color = {0, 127, 255}));
  connect(product1.y, CFR600.heat_in) annotation(
    Line(points = {{-97, 44}, {-81, 44}, {-81, 14}, {-50, 14}}, color = {0, 0, 127}));
  connect(set_stemp_1.y, s_temp_control_1.u_s) annotation(
    Line(points = {{57, -100}, {61.5, -100}, {61.5, -100}, {66, -100}, {66, -100}, {77, -100}, {77, -100}, {76, -100}, {76, -100}, {75, -100}}, color = {0, 0, 127}));
  connect(loop_2_low_temp.T, s_temp_control_1.u_m) annotation(
    Line(points = {{61, -42}, {85, -42}, {85, -88}, {88, -88}}, color = {0, 0, 127}));
  connect(s_temp_control_1.y, flowSource.m_flow_in) annotation(
    Line(points = {{99, -100}, {147, -100}, {147, -4}, {129, -4}}, color = {0, 0, 127}));
  connect(set_T_loop_1.y, loop1_control.u_s) annotation(
    Line(points = {{-91, -100}, {-77, -100}, {-77, -100}, {-78, -100}, {-78, -100}, {-77, -100}}, color = {0, 0, 127}));
  connect(FW_temperature.y[1], flowSource.T_in) annotation(
    Line(points = {{162, -8}, {134, -8}, {134, -8}, {132, -8}}, color = {0, 0, 127}));
  connect(set_T_loop_2.y, loop2_control.u_s) annotation(
    Line(points = {{-13, -100}, {-7, -100}, {-7, -100}, {-5, -100}, {-5, -100}, {-5, -100}, {-5, -100}, {-7, -100}}, color = {0, 0, 127}));
  connect(loop_2_high_temp.T, loop2_control.u_m) annotation(
    Line(points = {{25, 48}, {31, 48}, {31, 36}, {25, 36}, {25, 20}, {17, 20}, {17, -16}, {1, -16}, {1, -70}, {7, -70}, {7, -88}, {5, -88}}, color = {0, 0, 127}));
  connect(input_data.y[4], pressure_control.u_s) annotation(
    Line(points = {{-129, 32}, {-106, 32}, {-106, 32}, {-87, 32}, {-87, 90}, {-25, 90}, {-25, 90}, {35, 90}}, color = {0, 0, 127}));
  connect(steam_pressure.p, pressure_control.u_m) annotation(
    Line(points = {{67, 72}, {67, 72}, {67, 112}, {49, 112}, {49, 102}, {47, 102}}, color = {0, 0, 127}));
  connect(steam_pipe.waterOut, steam_pressure.port) annotation(
    Line(points = {{76.84, 40}, {78.84, 40}, {78.84, 62}, {78.84, 62}}, color = {0, 127, 255}));
  connect(circ_pump2_nom.y, product3.u2) annotation(
    Line(points = {{-129, -56}, {-125, -56}, {-125, -56}, {-119, -56}, {-119, -56}, {-121, -56}}, color = {0, 0, 127}));
  connect(circ_pump1_nom.y, product2.u2) annotation(
    Line(points = {{-129, -20}, {-119, -20}, {-119, -20}, {-121, -20}}, color = {0, 0, 127}));
  connect(product3.y, circPump_2.D_flow_in) annotation(
    Line(points = {{-97, -50}, {-91, -50}, {-91, -50}, {-83, -50}, {-83, -22}, {15, -22}, {15, -30}, {13, -30}}, color = {0, 0, 127}));
  connect(input_data.y[3], product3.u1) annotation(
    Line(points = {{-129, 32}, {-126, 32}, {-126, 32}, {-125, 32}, {-125, -44}, {-119, -44}, {-119, -44}, {-121, -44}, {-121, -44}}, color = {0, 0, 127}));
  connect(input_data.y[2], product2.u1) annotation(
    Line(points = {{-129, 32}, {-125, 32}, {-125, 32}, {-123, 32}, {-123, -8}, {-119, -8}, {-119, -8}, {-121, -8}, {-121, -8}}, color = {0, 0, 127}));
  connect(input_data.y[1], product1.u2) annotation(
    Line(points = {{-129, 32}, {-125, 32}, {-125, 32}, {-125, 32}, {-125, 38}, {-119, 38}, {-119, 38}, {-121, 38}, {-121, 38}}, color = {0, 0, 127}));
  connect(nom_power.y, product1.u1) annotation(
    Line(points = {{-129, 64}, {-126, 64}, {-126, 64}, {-125, 64}, {-125, 50}, {-119, 50}, {-119, 50}, {-121, 50}, {-121, 50}}, color = {0, 0, 127}));
  connect(circPump_2.port_b, IHX.flowIn) annotation(
    Line(points = {{4, -40}, {4, -40}, {4, -4}, {5, -4}, {5, -4}, {6, -4}}, color = {0, 127, 255}));
  connect(IHX.sodiumOut, loop_1_low_temp.port) annotation(
    Line(points = {{-5, -3.2}, {-7, -3.2}, {-7, -3.2}, {-7, -3.2}, {-7, -75.2}, {-19, -75.2}, {-19, -75.2}, {-33, -75.2}}, color = {0, 127, 255}));
  connect(steamGenerator1.waterOut, steam_pipe.waterIn) annotation(
    Line(points = {{48, 19.4}, {54, 19.4}, {54, 21.4}, {56, 21.4}, {56, 41.4}, {68, 41.4}, {68, 39.4}, {68, 39.4}, {68, 39.4}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], steamGenerator1.waterIn) annotation(
    Line(points = {{110, -12}, {79, -12}, {79, -12}, {44, -12}, {44, -2}, {20, -2}, {20, 14}, {28, 14}}, color = {0, 127, 255}));
  connect(steamGenerator1.waterOut, Steam_out_temp.port) annotation(
    Line(points = {{48, 19.4}, {48, 31.4}, {52, 31.4}, {52, 39.4}}, color = {0, 127, 255}));
  connect(RS.port_b, flowSink.ports[1]) annotation(
    Line(points = {{102, 40}, {105, 40}, {105, 40}, {104, 40}, {104, 8}, {114, 8}, {114, 8}, {114, 8}, {114, 8}}, color = {0, 127, 255}));
  connect(steam_pipe.waterOut, RS.port_a) annotation(
    Line(points = {{76.84, 40}, {82.84, 40}, {82.84, 40}, {81.84, 40}, {81.84, 40}, {82.84, 40}}, color = {0, 127, 255}));
  connect(flowSource.ports[2], Water_in_temp.port) annotation(
    Line(points = {{110, -12}, {96, -12}, {96, -12}, {78, -12}, {78, -8}, {78, -8}, {78, -4}}, color = {0, 127, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -120}, {200, 120}})),
    Icon(coordinateSystem(extent = {{-200, -120}, {200, 120}})),
    __OpenModelica_commandLineOptions = "",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
  experiment(StartTime = 0, StopTime = 15000, Tolerance = 0.01, Interval = 10));
end SteamGenerator_Test;
