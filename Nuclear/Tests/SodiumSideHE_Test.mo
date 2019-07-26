within TPPSim.Nuclear.Tests;

model SodiumSideHE_Test
  package Medium_S = TPPSim.Media.Sodium_ph;
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  TPPSim.Nuclear.SodiumHE EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_S = Medium_S, redeclare package Medium_F = Medium_F, T_m_start = 463.15, T_sodium_start = 463.15, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, k_gamma_sodium = 0.6, m_flow_start = 40, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 10, p_flow_start = system.p_ambient, p_sodium_start = 250000, sodiumEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) annotation(
    Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T Source(redeclare package Medium = Medium_S, T = 300 + 273.15, m_flow = 372.625, nPorts = 2, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {-80, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium_S, nPorts = 1, p = 2.5e5) annotation(
    Placement(visible = true, transformation(origin = {-62, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system(m_flow_start = 10, p_ambient = 1.3e+06) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = 190 + 273.15, m_flow = 39.41, nPorts = 2, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {88, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, nPorts = 1, p = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {90, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp T_sodium(duration = 1000, height = 315, offset = 190 + 273.15, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Drums.Separator2 separator(redeclare package Medium = Medium_F, ps_start = 140e5) annotation(
    Placement(visible = true, transformation(origin = {22, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Nuclear.SodiumHE SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_S = Medium_S, redeclare package Medium_F = Medium_F, Dcase = 0.745, Din = 0.016, Lpipe = 7.9, T_m_start = 463.15, T_sodium_start = 463.15, delta = 0.003, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, k_gamma_sodium = 0.6, m_flow_start = 0.01, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 10, p_flow_start = system.p_ambient, p_sodium_start = 250000, sodiumEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, z = 349) annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Sodium_out_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-24, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Sodium_in_temp(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-40, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Flow_out_temp(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {30, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Flow_in_temp(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {44, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe steam_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, h_start = 807.6e3, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, t_m_start = 463.15) annotation(
    Placement(visible = true, transformation(origin = {38, 42}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible RS(redeclare package Medium = Medium_F, dp_nominal = 1.4e+12, m_flow_nominal = 40, p_nominal = 140e5, rho_nominal = 44.35)  annotation(
    Placement(visible = true, transformation(origin = {58, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant RS_pos(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {32, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(steam_pipe.waterOut, RS.port_a) annotation(
    Line(points = {{42, 42}, {48, 42}, {48, 42}, {48, 42}}, color = {0, 127, 255}));
  connect(SH.flowOut, steam_pipe.waterIn) annotation(
    Line(points = {{6, 42}, {32, 42}, {32, 42}, {34, 42}}, color = {0, 127, 255}));
  connect(RS_pos.y, RS.opening) annotation(
    Line(points = {{44, 90}, {58, 90}, {58, 50}, {58, 50}}, color = {0, 0, 127}));
  connect(RS.port_b, flowSink.ports[1]) annotation(
    Line(points = {{68, 42}, {70, 42}, {70, 10}, {80, 10}, {80, 10}}, color = {0, 127, 255}));
  connect(SH.flowOut, Flow_out_temp.port) annotation(
    Line(points = {{6, 42}, {30, 42}, {30, 48}, {30, 48}}, color = {0, 127, 255}));
  connect(flowSource.ports[2], Flow_in_temp.port) annotation(
    Line(points = {{78, -10}, {44, -10}, {44, -2}, {44, -2}}, color = {0, 127, 255}));
  connect(Source.ports[2], Sodium_in_temp.port) annotation(
    Line(points = {{-70, 10}, {-40, 10}, {-40, 46}, {-40, 46}}, color = {0, 127, 255}));
  connect(EVO.sodiumOut, Sodium_out_temp.port) annotation(
    Line(points = {{-4, -8}, {-24, -8}, {-24, 0}, {-24, 0}}, color = {0, 127, 255}));
  connect(SH.sodiumOut, EVO.sodiumIn) annotation(
    Line(points = {{-4, 22}, {-6, 22}, {-6, 12}, {-4, 12}}, color = {0, 127, 255}));
  connect(Source.ports[1], SH.sodiumIn) annotation(
    Line(points = {{-70, 10}, {-40, 10}, {-40, 42}, {-4, 42}, {-4, 42}}, color = {0, 127, 255}));
  connect(separator.steam, SH.flowIn) annotation(
    Line(points = {{22, 26}, {10, 26}, {10, 22}, {6, 22}, {6, 22}}, color = {0, 127, 255}));
  connect(EVO.flowOut, separator.fedWater) annotation(
    Line(points = {{6, 12}, {14, 12}, {14, 22}, {16, 22}}, color = {0, 127, 255}));
  connect(T_sodium.y, Source.T_in) annotation(
    Line(points = {{-78, 70}, {-62, 70}, {-62, 40}, {-98, 40}, {-98, 14}, {-92, 14}, {-92, 14}}, color = {0, 0, 127}));
  connect(EVO.sodiumOut, Sink.ports[1]) annotation(
    Line(points = {{-5, -7}, {-42, -7}, {-42, -8}, {-52, -8}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], EVO.flowIn) annotation(
    Line(points = {{78, -10}, {42, -10}, {42, -7}, {5, -7}}, color = {0, 127, 255}));
  annotation(
    Diagram,
    Icon,
    __OpenModelica_commandLineOptions = "",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end SodiumSideHE_Test;
