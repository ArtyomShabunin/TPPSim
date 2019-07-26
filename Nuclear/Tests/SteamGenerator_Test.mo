within TPPSim.Nuclear.Tests;

model SteamGenerator_Test
  package Medium_S = TPPSim.Media.Sodium_ph;
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  inner Modelica.Fluid.System system(m_flow_start = 10, p_ambient = 1.3e+06) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = 190 + 273.15, m_flow = 315.25, nPorts = 2, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {88, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, nPorts = 1, p = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {90, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp T_sodium(duration = 1000, height = 750e6, offset = 0, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature loop_2_low_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature loop_1_high_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature loop_1_low_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-56, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature loop_2_high_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-16, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  Modelica.Fluid.Sensors.Temperature Steam_out_temp(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {22, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Water_in_temp(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {44, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe steam_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, h_start = 807.6e3, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, t_m_start = 463.15) annotation(
    Placement(visible = true, transformation(origin = {38, 42}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible RS(redeclare package Medium = Medium_F, dp_nominal = 1.4e+12, m_flow_nominal = 40 * 8, p_nominal = 140e5, rho_nominal = 44.35)  annotation(
    Placement(visible = true, transformation(origin = {58, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant RS_pos(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {32, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SteamGenerator steamGenerator1(n_sg = 8)  annotation(
    Placement(visible = true, transformation(origin = {4, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Nuclear.SodiumHE IHX(redeclare TPPSim.HRSG_HeatExch.GlycolSideHE flowHE(redeclare TPPSim.thermal.alfaSodium_inside alpha(section = section)), redeclare package Medium_S = Medium_S, redeclare package Medium_F = Medium_S, Dcase = 3, Din = 0.03, Lpipe = 20, T_m_start = 463.15, T_sodium_start = 463.15, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, h_flow_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(system.p_ambient, 190 + 273.15), k_gamma_sodium = 1, m_flow_start = 2981, metalDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfVolumes = 10, p_flow_start = system.p_ambient, p_sodium_start = 250000, sodiumEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, z = 5000) annotation(
    Placement(visible = true, transformation(origin = {-34, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Nuclear.Reactor CFR600(redeclare TPPSim.HRSG_HeatExch.GlycolSideHE flowHE(redeclare TPPSim.thermal.alfaSodium_inside alpha(section = section)), redeclare package Medium_F = Medium_S, Dcase = 3, Din = 0.03, Lpipe = 20, T_m_start = 463.15, T_sodium_start = 463.15, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, h_flow_start = TPPSim.Media.Sodium_ph.specificEnthalpy_pT(system.p_ambient, 190 + 273.15), k_gamma_sodium = 1, m_flow_start = 0.01, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 10, p_flow_start = system.p_ambient, p_sodium_start = 250000, sodiumEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, z = 5000) annotation(
    Placement(visible = true, transformation(origin = {-72, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  TPPSim.Pumps.circPump circPump_2(redeclare package Medium = Medium_S, setD_flow = 2981, setp_flow = 250000) annotation(
    Placement(visible = true, transformation(origin = {-24, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.circPump circPump_1(redeclare package Medium = Medium_S, setD_flow = 3502, setp_flow = 150000)  annotation(
    Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  connect(steamGenerator1.sodiumOut, loop_2_low_temp.port) annotation(
    Line(points = {{-2, 14}, {-2, 14}, {-2, -50}, {20, -50}, {20, -50}}, color = {0, 127, 255}));
  connect(IHX.flowOut, loop_2_high_temp.port) annotation(
    Line(points = {{-28, 18}, {-28, 40}, {-16, 40}}, color = {0, 127, 255}));
  connect(IHX.sodiumOut, loop_1_low_temp.port) annotation(
    Line(points = {{-38, -2}, {-42, -2}, {-42, -80}, {-56, -80}, {-56, -80}}, color = {0, 127, 255}));
  connect(CFR600.flowOut, loop_1_high_temp.port) annotation(
    Line(points = {{-62, 4}, {-56, 4}, {-56, 40}, {-50, 40}, {-50, 40}}, color = {0, 127, 255}));
  connect(T_sodium.y, CFR600.heat_in) annotation(
    Line(points = {{-78, 70}, {-70, 70}, {-70, 42}, {-96, 42}, {-96, 16}, {-82, 16}, {-82, 16}}, color = {0, 0, 127}));
  connect(CFR600.flowOut, IHX.sodiumIn) annotation(
    Line(points = {{-62, 4}, {-56, 4}, {-56, 18}, {-38, 18}, {-38, 18}}, color = {0, 127, 255}));
  connect(circPump_1.port_b, CFR600.flowIn) annotation(
    Line(points = {{-70, -40}, {-72, -40}, {-72, -2}, {-72, -2}}, color = {0, 127, 255}));
  connect(IHX.sodiumOut, circPump_1.port_a) annotation(
    Line(points = {{-38, -2}, {-40, -2}, {-40, -16}, {-46, -16}, {-46, -40}, {-50, -40}, {-50, -40}}, color = {0, 127, 255}));
  connect(IHX.flowOut, steamGenerator1.sodiumIn) annotation(
    Line(points = {{-28, 18}, {-28, 18}, {-28, 28}, {-22, 28}, {-22, 6}, {10, 6}, {10, 20}, {10, 20}}, color = {0, 127, 255}));
  connect(circPump_2.port_b, IHX.flowIn) annotation(
    Line(points = {{-34, -38}, {-36, -38}, {-36, -16}, {-28, -16}, {-28, -2}, {-28, -2}}, color = {0, 127, 255}));
  connect(steamGenerator1.sodiumOut, circPump_2.port_a) annotation(
    Line(points = {{-2, 14}, {-2, -38}, {-14, -38}}, color = {0, 127, 255}));
  connect(steamGenerator1.waterOut, Steam_out_temp.port) annotation(
    Line(points = {{14, 22}, {22, 22}, {22, 48}, {22, 48}}, color = {0, 127, 255}));
  connect(steamGenerator1.waterOut, steam_pipe.waterIn) annotation(
    Line(points = {{14, 22}, {22, 22}, {22, 42}, {34, 42}, {34, 42}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], steamGenerator1.waterIn) annotation(
    Line(points = {{78, -10}, {10, -10}, {10, 0}, {-14, 0}, {-14, 16}, {-6, 16}, {-6, 16}}, color = {0, 127, 255}));
  connect(flowSource.ports[2], Water_in_temp.port) annotation(
    Line(points = {{78, -10}, {44, -10}, {44, -2}, {44, -2}}, color = {0, 127, 255}));
  connect(steam_pipe.waterOut, RS.port_a) annotation(
    Line(points = {{42, 42}, {48, 42}, {48, 42}, {48, 42}}, color = {0, 127, 255}));
  connect(RS_pos.y, RS.opening) annotation(
    Line(points = {{44, 90}, {58, 90}, {58, 50}, {58, 50}}, color = {0, 0, 127}));
  connect(RS.port_b, flowSink.ports[1]) annotation(
    Line(points = {{68, 42}, {70, 42}, {70, 10}, {80, 10}, {80, 10}}, color = {0, 127, 255}));
  annotation(
    Diagram,
    Icon,
    __OpenModelica_commandLineOptions = "",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
  experiment(StartTime = 0, StopTime = 4000, Tolerance = 1e-3, Interval = 0.1));
end SteamGenerator_Test;
