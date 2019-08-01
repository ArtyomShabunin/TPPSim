within TPPSim.Nuclear.Tests;

model SteamGenerator_Test
  package Medium_S = TPPSim.Media.Sodium_ph;
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  inner Modelica.Fluid.System system(m_flow_start = 10, p_ambient = 1.3e+06) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = 190 + 273.15, m_flow = 20, nPorts = 2, use_T_in = false, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {86, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, nPorts = 1, p = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {90, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature loop_2_low_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature loop_1_high_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-56, 38}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature loop_1_low_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-66, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature loop_2_high_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-16, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  Modelica.Fluid.Sensors.Temperature Steam_out_temp(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {18, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Water_in_temp(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {44, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe steam_pipe(Din = 0.15, Lpipe = 10, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 2, numberOfVolumes = 5, t_m_start = 463.15) annotation(
    Placement(visible = true, transformation(origin = {38, 42}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible RS(redeclare package Medium = Medium_F, dp_nominal = 1.4e+12, filteredOpening = true, m_flow_nominal = 40 * 8, p_nominal = 140e5, rho_nominal = 44.35)  annotation(
    Placement(visible = true, transformation(origin = {58, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SteamGenerator steamGenerator1(n_sg = 8)  annotation(
    Placement(visible = true, transformation(origin = {4, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Nuclear.SodiumHE IHX(redeclare TPPSim.HRSG_HeatExch.GlycolSideHE flowHE(redeclare TPPSim.thermal.alfaSodium_inside alpha(section = section)), redeclare package Medium_S = Medium_S, redeclare package Medium_F = Medium_S, Dcase = 3, Din = 0.03, Lpipe = 20, T_m_start = 463.15, T_sodium_start = 463.15, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, h_flow_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(system.p_ambient, 190 + 273.15), k_gamma_sodium = 1, m_flow_start = 2981, metalDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfVolumes = 10, p_flow_start = system.p_ambient, p_sodium_start = 250000, sodiumEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, z = 5000) annotation(
    Placement(visible = true, transformation(origin = {-34, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Nuclear.Reactor CFR600(redeclare TPPSim.HRSG_HeatExch.GlycolSideHE flowHE(redeclare TPPSim.thermal.alfaSodium_inside alpha(section = section)), redeclare package Medium_F = Medium_S, Dcase = 3, Din = 0.03, Lpipe = 20, T_m_start = 463.15, T_sodium_start = 463.15, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, h_flow_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(system.p_ambient, 190 + 273.15), k_gamma_sodium = 1, m_flow_start = 0.01, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = system.p_ambient, p_sodium_start = 250000, sodiumEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, z = 5000) annotation(
    Placement(visible = true, transformation(origin = {-72, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  TPPSim.Pumps.circPump circPump_2(redeclare package Medium = Medium_S, setD_flow = 2981, setp_flow = 250000, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-20, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.circPump circPump_1(redeclare package Medium = Medium_S, setD_flow = 3502, setp_flow = 150000, use_D_flow_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID s_temp_control_1( Ti = 1,controllerType = Modelica.Blocks.Types.SimpleController.PI,initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = -0.2, limitsAtInit = true, yMax = 315.25, yMin = 20, y_start = 20)  annotation(
    Placement(visible = true, transformation(origin = {50, -74}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant set_stemp_1(k = 308 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {8, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable input_data(columns = {2, 3, 4, 5}, fileName = "C:/Users/ASShabunin/TPPSim/Nuclear/Tests/CFR600_case1_5.txt", tableName = "tabl", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-174, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant nom_power(k = 750e6 / 100)  annotation(
    Placement(visible = true, transformation(origin = {-174, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {-142, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product2 annotation(
    Placement(visible = true, transformation(origin = {-142, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product3 annotation(
    Placement(visible = true, transformation(origin = {-142, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant circ_pump1_nom(k = 3502 / 100)  annotation(
    Placement(visible = true, transformation(origin = {-174, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant circ_pump2_nom(k = 2981 / 100)  annotation(
    Placement(visible = true, transformation(origin = {-174, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure steam_pressure(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {44, 74}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID pressure_control(Ti = 20, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = -0.000001, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 1)  annotation(
    Placement(visible = true, transformation(origin = {14, 92}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant RS_pos(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {106, 58}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant set_T_loop_1(k = 539 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-136, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID loop1_control(Ti = 1,controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = -1, limitsAtInit = true, yMax = 3502, yMin = 1750, y_start = 1750)  annotation(
    Placement(visible = true, transformation(origin = {-98, -82}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant set_T_loop_2(k = 502 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-58, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID loop2_control(Ti = 1, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = -1, limitsAtInit = true, yMax = 2981, yMin = 1490.5, y_start = 1490.5)  annotation(
    Placement(visible = true, transformation(origin = {-28, -98}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
equation
  connect(pressure_control.y, RS.opening) annotation(
    Line(points = {{26, 92}, {58, 92}, {58, 50}, {58, 50}}, color = {0, 0, 127}));
  connect(steam_pipe.waterOut, steam_pressure.port) annotation(
    Line(points = {{42, 42}, {44, 42}, {44, 64}, {44, 64}}, color = {0, 127, 255}));
  connect(loop_2_high_temp.T, loop2_control.u_m) annotation(
    Line(points = {{-8, 50}, {-4, 50}, {-4, 38}, {-10, 38}, {-10, 22}, {-18, 22}, {-18, -14}, {-34, -14}, {-34, -68}, {-28, -68}, {-28, -86}, {-28, -86}}, color = {0, 0, 127}));
  connect(loop2_control.y, circPump_2.D_flow_in) annotation(
    Line(points = {{-16, -98}, {-12, -98}, {-12, -54}, {-6, -54}, {-6, -18}, {-20, -18}, {-20, -28}, {-20, -28}}, color = {0, 0, 127}));
  connect(set_T_loop_2.y, loop2_control.u_s) annotation(
    Line(points = {{-46, -98}, {-40, -98}, {-40, -98}, {-40, -98}}, color = {0, 0, 127}));
  connect(IHX.sodiumOut, loop_1_low_temp.port) annotation(
    Line(points = {{-38, -2}, {-42, -2}, {-42, -74}, {-66, -74}}, color = {0, 127, 255}));
  connect(loop1_control.y, circPump_1.D_flow_in) annotation(
    Line(points = {{-86, -82}, {-80, -82}, {-80, -20}, {-60, -20}, {-60, -30}, {-60, -30}}, color = {0, 0, 127}));
  connect(loop_1_high_temp.T, loop1_control.u_m) annotation(
    Line(points = {{-62, 38}, {-98, 38}, {-98, -70}, {-98, -70}}, color = {0, 0, 127}));
  connect(set_T_loop_1.y, loop1_control.u_s) annotation(
    Line(points = {{-124, -82}, {-112, -82}, {-112, -82}, {-110, -82}}, color = {0, 0, 127}));
  connect(CFR600.flowOut, loop_1_high_temp.port) annotation(
    Line(points = {{-62, 4}, {-56, 4}, {-56, 28}}, color = {0, 127, 255}));
  connect(steam_pressure.p, pressure_control.u_m) annotation(
    Line(points = {{34, 74}, {32, 74}, {32, 114}, {14, 114}, {14, 104}, {14, 104}}, color = {0, 0, 127}));
  connect(input_data.y[4], pressure_control.u_s) annotation(
    Line(points = {{-162, 34}, {-122, 34}, {-122, 92}, {2, 92}}, color = {0, 0, 127}));
  connect(steamGenerator1.waterOut, Steam_out_temp.port) annotation(
    Line(points = {{14, 22}, {14, 32}, {18, 32}, {18, 42}}, color = {0, 127, 255}));
  connect(input_data.y[3], product3.u1) annotation(
    Line(points = {{-162, 34}, {-160, 34}, {-160, -42}, {-154, -42}, {-154, -42}}, color = {0, 0, 127}));
  connect(input_data.y[2], product2.u1) annotation(
    Line(points = {{-162, 34}, {-158, 34}, {-158, -6}, {-154, -6}, {-154, -6}}, color = {0, 0, 127}));
  connect(circ_pump2_nom.y, product3.u2) annotation(
    Line(points = {{-162, -54}, {-154, -54}, {-154, -54}, {-154, -54}}, color = {0, 0, 127}));
  connect(circ_pump1_nom.y, product2.u2) annotation(
    Line(points = {{-162, -18}, {-154, -18}, {-154, -18}, {-154, -18}}, color = {0, 0, 127}));
  connect(product1.y, CFR600.heat_in) annotation(
    Line(points = {{-130, 46}, {-116, 46}, {-116, 16}, {-82, 16}, {-82, 16}}, color = {0, 0, 127}));
  connect(nom_power.y, product1.u1) annotation(
    Line(points = {{-162, 66}, {-160, 66}, {-160, 52}, {-154, 52}, {-154, 52}}, color = {0, 0, 127}));
  connect(input_data.y[1], product1.u2) annotation(
    Line(points = {{-162, 34}, {-160, 34}, {-160, 40}, {-154, 40}, {-154, 40}}, color = {0, 0, 127}));
  connect(loop_2_low_temp.T, s_temp_control_1.u_m) annotation(
    Line(points = {{28, -40}, {50, -40}, {50, -62}, {50, -62}}, color = {0, 0, 127}));
  connect(circPump_2.port_b, loop_2_low_temp.port) annotation(
    Line(points = {{-30, -38}, {-30, -38}, {-30, -50}, {20, -50}, {20, -50}}, color = {0, 127, 255}));
  connect(steamGenerator1.sodiumOut, circPump_2.port_a) annotation(
    Line(points = {{-2, 14}, {-2, 14}, {-2, -38}, {-10, -38}, {-10, -38}}, color = {0, 127, 255}));
  connect(circPump_2.port_b, IHX.flowIn) annotation(
    Line(points = {{-30, -38}, {-30, -38}, {-30, -2}, {-28, -2}}, color = {0, 127, 255}));
  connect(s_temp_control_1.y, flowSource.m_flow_in) annotation(
    Line(points = {{62, -74}, {112, -74}, {112, -2}, {96, -2}}, color = {0, 0, 127}));
  connect(flowSource.ports[2], Water_in_temp.port) annotation(
    Line(points = {{76, -10}, {44, -10}, {44, -2}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], steamGenerator1.waterIn) annotation(
    Line(points = {{76, -10}, {10, -10}, {10, 0}, {-14, 0}, {-14, 16}, {-6, 16}}, color = {0, 127, 255}));
  connect(set_stemp_1.y, s_temp_control_1.u_s) annotation(
    Line(points = {{20, -74}, {38, -74}, {38, -74}, {38, -74}}, color = {0, 0, 127}));
  connect(IHX.flowOut, loop_2_high_temp.port) annotation(
    Line(points = {{-28, 18}, {-28, 40}, {-16, 40}}, color = {0, 127, 255}));
  connect(CFR600.flowOut, IHX.sodiumIn) annotation(
    Line(points = {{-62, 4}, {-56, 4}, {-56, 18}, {-38, 18}, {-38, 18}}, color = {0, 127, 255}));
  connect(circPump_1.port_b, CFR600.flowIn) annotation(
    Line(points = {{-70, -40}, {-72, -40}, {-72, -2}, {-72, -2}}, color = {0, 127, 255}));
  connect(IHX.sodiumOut, circPump_1.port_a) annotation(
    Line(points = {{-38, -2}, {-40, -2}, {-40, -16}, {-46, -16}, {-46, -40}, {-50, -40}, {-50, -40}}, color = {0, 127, 255}));
  connect(IHX.flowOut, steamGenerator1.sodiumIn) annotation(
    Line(points = {{-28, 18}, {-28, 18}, {-28, 28}, {-22, 28}, {-22, 6}, {10, 6}, {10, 20}, {10, 20}}, color = {0, 127, 255}));
  connect(steamGenerator1.waterOut, steam_pipe.waterIn) annotation(
    Line(points = {{14, 22}, {22, 22}, {22, 42}, {34, 42}, {34, 42}}, color = {0, 127, 255}));
  connect(steam_pipe.waterOut, RS.port_a) annotation(
    Line(points = {{42, 42}, {48, 42}, {48, 42}, {48, 42}}, color = {0, 127, 255}));
  connect(RS.port_b, flowSink.ports[1]) annotation(
    Line(points = {{68, 42}, {70, 42}, {70, 10}, {80, 10}, {80, 10}}, color = {0, 127, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    __OpenModelica_commandLineOptions = "",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
  experiment(StartTime = 0, StopTime = 5000, Tolerance = 0.01, Interval = 10));
end SteamGenerator_Test;
