within TPPSim.Boilers;

model OnePVerticalHRSG
  extends TPPSim.Boilers.BaseClases.Icons.Icon1pVerticalHRSG;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  outer Modelica.Fluid.System system;
  inner parameter Boolean SH_cold_start = true "Исходное состояние - холодное" annotation(
    Dialog(group = "Исходное состояние"));
  parameter Modelica.SIunits.AbsolutePressure HP_p_flow_start = system.p_ambient "Начальное давление пара в БВД" annotation(
    Dialog(group = "Контур ВД"));
  parameter Modelica.SIunits.Temperature HP_t_m_steam_start = 100 + 273.15 "Начальная температура металла верха БВД" annotation(
    Dialog(group = "Контур ВД"));
  parameter Modelica.SIunits.Temperature HP_t_m_water_start = 100 + 273.15 "Начальная температура металла низа БВД" annotation(
    Dialog(group = "Контур ВД"));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-18, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Контур ВД
  //Экономайзер ВД
  //Параллельный экономайзер ВД/СД
  TPPSim.HRSG_HeatExch.ParallelGFHE_simple IP_ECO_HP_ECO_1(redeclare package Medium_F = Medium_F, redeclare package Medium_G = Medium_G, Din_1 = 24e-3, Din_2 = 24e-3, HRSG_type_set_1 = TPPSim.Choices.HRSG_type.verticalTop, HRSG_type_set_2 = TPPSim.Choices.HRSG_type.verticalTop, Lpipe_1 = 20.04, Lpipe_2 = 20.4, delta_1 = 3e-3, delta_2 = 4e-3, delta_fin_1 = 0.8e-3, delta_fin_2 = 0.8e-3, flowEnergyDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowEnergyDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMassDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin_1 = 17e-3, hfin_2 = 17e-3, metalDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, metalDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes_1 = 2, numberOfVolumes_2 = 2, s1_1 = 75.02e-3, s1_2 = 82.7e-3, s2_1 = 79e-3, s2_2 = 79e-3, sfin_1 = 2.93e-3, sfin_2 = 3.133e-3, z1_1 = 20, z1_2 = 154, z2_1 = 6, z2_2 = 10, zahod_1 = 1, zahod_2 = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 66}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  //Испаритель ВД
  TPPSim.HRSG_HeatExch.GFHE IP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, h_flow_start = 251.2e3, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Барабан ВД
  TPPSim.Drums.Drum HP_drum(Din = 1.718, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.5, L = 9, delta = 0.02, ps_start = HP_p_flow_start, t_m_steam_start = HP_t_m_steam_start, t_m_water_start = HP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {24, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump IP_circPump(redeclare package Medium = Medium_F, setD_flow = 0.001, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {3, 33}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //Пароперегреватель ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 6.4e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -120}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 3.6e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -146}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы ВД
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {46, -108}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //ПЭН и РПК ВД
  TPPSim.Pumps.pressurePump HP_FW_pump(redeclare package Medium = Medium_F, set_p = 6e+06, use_p_in = true) annotation(
    Placement(visible = true, transformation(origin = {-73, 5}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveIncompressible HP_FWCV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 200, dp_nominal = 100000, filteredOpening = true, leakageOpening = 1e-4, m_flow_small = system.m_flow_small, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-51, 5}, extent = {{-7, 7}, {7, -7}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure HPFW_p(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-37, 19}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add HPFW_add annotation(
    Placement(visible = true, transformation(origin = {-61, 27}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant HPFW_CV_dp(k = 1e5) annotation(
    Placement(visible = true, transformation(origin = {-37, 37}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  //Регуляторы
  TPPSim.Controls.LC LC(DFmax = 46, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {64, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Контур СД
  //Экономайзер СД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 2.162e-3, z1 = 174, z2 = 5, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Параллельный экономайзер ВД/СД
  //Испаритель ВД
  TPPSim.HRSG_HeatExch.GFHE HP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, h_flow_start = 251.2e3, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -94}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Барабан СД
  TPPSim.Drums.Drum IP_drum(Din = 1.718, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.5, L = 9, delta = 0.02, ps_start = HP_p_flow_start, t_m_steam_start = HP_t_m_steam_start, t_m_water_start = HP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {22, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump HP_circPump(redeclare package Medium = Medium_F, setD_flow = 0.001, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {3, -91}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //Пароперегреватель ВД
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 6.4e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 3.6e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы ВД
  TPPSim.Pipes.ComplexPipe IP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {38, 10}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //ПЭН и РПК ВД
  TPPSim.Pumps.pressurePump IP_FW_pump(redeclare package Medium = Medium_F, set_p = 6e+06, use_p_in = true) annotation(
    Placement(visible = true, transformation(origin = {-75, 69}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveIncompressible IP_FWCV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 200, dp_nominal = 100000, filteredOpening = true, leakageOpening = 1e-4, m_flow_small = system.m_flow_small, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-49, 69}, extent = {{-7, 7}, {7, -7}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure IPFW_p(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-37, 81}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add IPFW_add annotation(
    Placement(visible = true, transformation(origin = {-61, 93}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant IPFW_CV_dp(k = 1e5) annotation(
    Placement(visible = true, transformation(origin = {-37, 97}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  //Регуляторы
  TPPSim.Controls.LC IP_LC(DFmax = 46, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {66, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-18, -200}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -224}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b HP_steam(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {96, -134}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a HP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b IP_steam(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a IP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp set_flow(duration = 20, height = 25, offset = 0.01, startTime = 3) annotation(
    Placement(visible = true, transformation(origin = {22, -64}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp IP_set_flow(duration = 20, height = 25, offset = 0.01, startTime = 3) annotation(
    Placement(visible = true, transformation(origin = {22, 68}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
equation
  connect(IP_drum.downStr, IP_circPump.port_a) annotation(
    Line(points = {{16, 32}, {8, 32}, {8, 33}}, color = {0, 127, 255}));
  connect(IP_circPump.port_b, IP_EVO.flowIn) annotation(
    Line(points = {{-2, 33}, {-8, 33}, {-8, 30}}, color = {0, 127, 255}));
  connect(IP_set_flow.y, IP_circPump.D_flow_in) annotation(
    Line(points = {{18, 68}, {3, 68}, {3, 38.5}}, color = {0, 0, 127}));
  connect(IP_ECO_HP_ECO_1.flowOut_1, IP_drum.fedWater) annotation(
    Line(points = {{-28, 62}, {-32, 62}, {-32, 56}, {14, 56}, {14, 50}, {16, 50}}, color = {0, 127, 255}));
  connect(IP_drum.waterLevel, IP_LC.u) annotation(
    Line(points = {{34, 46}, {44, 46}, {44, 50}, {54, 50}, {54, 50}}, color = {0, 0, 127}));
  connect(IP_EVO.flowOut, IP_drum.upStr) annotation(
    Line(points = {{-8, 22}, {28, 22}, {28, 32}, {30, 32}}, color = {0, 127, 255}));
  connect(IP_drum.steam, IP_pipe.waterIn) annotation(
    Line(points = {{30, 50}, {30, 50}, {30, 54}, {38, 54}, {38, 14}, {38, 14}}, color = {0, 127, 255}));
  connect(HP_drum.waterLevel, LC.u) annotation(
    Line(points = {{36, -86}, {40, -86}, {40, -62}, {50, -62}, {50, -62}, {52, -62}}, color = {0, 0, 127}));
  connect(HP_drum.steam, HP_pipe.waterIn) annotation(
    Line(points = {{32, -82}, {42, -82}, {42, -102}, {46, -102}, {46, -104}}, color = {0, 127, 255}));
  connect(HP_EVO.flowOut, HP_drum.upStr) annotation(
    Line(points = {{-8, -98}, {2, -98}, {2, -106}, {32, -106}, {32, -100}, {32, -100}}, color = {0, 127, 255}));
  connect(HP_drum.downStr, HP_circPump.port_a) annotation(
    Line(points = {{18, -100}, {10, -100}, {10, -92}, {8, -92}, {8, -90}}, color = {0, 127, 255}));
  connect(HP_ECO_2.flowOut, HP_drum.fedWater) annotation(
    Line(points = {{-8, -30}, {8, -30}, {8, -78}, {16, -78}, {16, -82}, {18, -82}}, color = {0, 127, 255}));
  connect(set_flow.y, HP_circPump.D_flow_in) annotation(
    Line(points = {{18, -64}, {14, -64}, {14, -74}, {8, -74}, {8, -74}, {2, -74}, {2, -86}, {4, -86}}, color = {0, 0, 127}));
  connect(HP_pipe.waterOut, HP_SH_1.flowIn) annotation(
    Line(points = {{46, -112}, {46, -112}, {46, -116}, {-8, -116}, {-8, -116}}, color = {0, 127, 255}));
  connect(LC.y, HP_FWCV.opening) annotation(
    Line(points = {{76, -62}, {80, -62}, {80, -42}, {-52, -42}, {-52, 0}, {-50, 0}}, color = {0, 0, 127}));
  connect(HP_circPump.port_b, HP_EVO.flowIn) annotation(
    Line(points = {{-2, -90}, {-8, -90}, {-8, -90}, {-8, -90}}, color = {0, 127, 255}));
  connect(HP_SH_1.flowOut, HP_SH_2.flowIn) annotation(
    Line(points = {{-8, -124}, {-2, -124}, {-2, -142}, {-8, -142}, {-8, -142}}, color = {0, 127, 255}));
  connect(HP_SH_2.flowOut, HP_steam) annotation(
    Line(points = {{-8, -150}, {60, -150}, {60, -136}, {96, -136}, {96, -134}}, color = {0, 127, 255}));
  connect(HP_SH_2.gasIn, gasIn) annotation(
    Line(points = {{-18, -150}, {-18, -150}, {-18, -200}, {-18, -200}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasIn, HP_SH_2.gasOut) annotation(
    Line(points = {{-18, -124}, {-18, -124}, {-18, -140}, {-18, -140}}, color = {0, 127, 255}));
  connect(HP_EVO.gasIn, HP_SH_1.gasOut) annotation(
    Line(points = {{-18, -98}, {-18, -98}, {-18, -114}, {-18, -114}}, color = {0, 127, 255}));
  connect(IP_SH_2.gasIn, HP_EVO.gasOut) annotation(
    Line(points = {{-18, -64}, {-18, -64}, {-18, -88}, {-18, -88}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasIn, IP_SH_2.gasOut) annotation(
    Line(points = {{-18, -30}, {-18, -30}, {-18, -54}, {-18, -54}}, color = {0, 127, 255}));
  connect(IP_SH_1.gasIn, HP_ECO_2.gasOut) annotation(
    Line(points = {{-18, -8}, {-18, -8}, {-18, -20}, {-18, -20}}, color = {0, 127, 255}));
  connect(IP_EVO.gasIn, IP_SH_1.gasOut) annotation(
    Line(points = {{-18, 22}, {-18, 22}, {-18, 2}, {-18, 2}}, color = {0, 127, 255}));
  connect(IP_ECO_HP_ECO_1.gasIn, IP_EVO.gasOut) annotation(
    Line(points = {{-18, 60}, {-18, 60}, {-18, 32}, {-18, 32}}, color = {0, 127, 255}));
  connect(IP_SH_2.flowOut, IP_steam) annotation(
    Line(points = {{-8, -64}, {12, -64}, {12, -8}, {100, -8}, {100, -10}}, color = {0, 127, 255}));
  connect(IP_SH_1.flowOut, IP_SH_2.flowIn) annotation(
    Line(points = {{-8, -8}, {0, -8}, {0, -56}, {-8, -56}, {-8, -56}}, color = {0, 127, 255}));
  connect(IP_pipe.waterOut, IP_SH_1.flowIn) annotation(
    Line(points = {{38, 6}, {38, 6}, {38, 0}, {-8, 0}, {-8, 0}}, color = {0, 127, 255}));
  connect(HPFW_add.y, HP_FW_pump.p_in) annotation(
    Line(points = {{-66, 28}, {-72, 28}, {-72, 12}, {-72, 12}}, color = {0, 0, 127}));
  connect(HPFW_CV_dp.y, HPFW_add.u1) annotation(
    Line(points = {{-42, 38}, {-48, 38}, {-48, 30}, {-54, 30}, {-54, 30}}, color = {0, 0, 127}));
  connect(HPFW_p.p, HPFW_add.u2) annotation(
    Line(points = {{-42, 20}, {-48, 20}, {-48, 24}, {-54, 24}, {-54, 24}}, color = {0, 0, 127}));
  connect(HP_FWCV.port_b, HPFW_p.port) annotation(
    Line(points = {{-44, 6}, {-36, 6}, {-36, 14}, {-36, 14}}, color = {0, 127, 255}));
  connect(IP_LC.y, IP_FWCV.opening) annotation(
    Line(points = {{78, 50}, {82, 50}, {82, 62}, {30, 62}, {30, 58}, {-50, 58}, {-50, 64}, {-48, 64}}, color = {0, 0, 127}));
  connect(IP_ECO_HP_ECO_1.flowOut_2, HP_ECO_2.flowIn) annotation(
    Line(points = {{-8, 62}, {-4, 62}, {-4, -22}, {-8, -22}, {-8, -22}}, color = {0, 127, 255}));
  connect(HP_FWCV.port_b, IP_ECO_HP_ECO_1.flowIn_2) annotation(
    Line(points = {{-44, 6}, {-30, 6}, {-30, 54}, {-38, 54}, {-38, 66}, {-34, 66}, {-34, 76}, {-8, 76}, {-8, 70}, {-8, 70}}, color = {0, 127, 255}));
  connect(HP_FW_pump.port_b, HP_FWCV.port_a) annotation(
    Line(points = {{-66, 6}, {-58, 6}, {-58, 6}, {-58, 6}}, color = {0, 127, 255}));
  connect(HP_FW_In, HP_FW_pump.port_a) annotation(
    Line(points = {{-100, 6}, {-80, 6}, {-80, 6}, {-80, 6}}));
  connect(IPFW_add.y, IP_FW_pump.p_in) annotation(
    Line(points = {{-66, 94}, {-74, 94}, {-74, 76}, {-74, 76}}, color = {0, 0, 127}));
  connect(IPFW_CV_dp.y, IPFW_add.u1) annotation(
    Line(points = {{-42, 98}, {-48, 98}, {-48, 96}, {-54, 96}, {-54, 96}, {-54, 96}}, color = {0, 0, 127}));
  connect(IPFW_p.p, IPFW_add.u2) annotation(
    Line(points = {{-42, 82}, {-48, 82}, {-48, 90}, {-54, 90}, {-54, 90}}, color = {0, 0, 127}));
  connect(IP_FWCV.port_b, IPFW_p.port) annotation(
    Line(points = {{-42, 70}, {-38, 70}, {-38, 76}, {-36, 76}}, color = {0, 127, 255}));
  connect(IP_FWCV.port_b, IP_ECO_HP_ECO_1.flowIn_1) annotation(
    Line(points = {{-42, 70}, {-34, 70}, {-34, 70}, {-28, 70}, {-28, 70}}, color = {0, 127, 255}));
  connect(IP_FW_pump.port_b, IP_FWCV.port_a) annotation(
    Line(points = {{-68, 70}, {-56, 70}, {-56, 70}, {-56, 70}}, color = {0, 127, 255}));
  connect(IP_FW_In, IP_FW_pump.port_a) annotation(
    Line(points = {{-100, 70}, {-82, 70}, {-82, 70}, {-82, 70}}));
  connect(IP_ECO_HP_ECO_1.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-18, 72}, {-18, 72}, {-18, 100}, {-18, 100}}, color = {0, 127, 255}));
protected
  annotation(
    Documentation(info = "<html>
  <p>
  Модель трехконтурного барабанного котла-утилизатора.
  </p>
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>September 07, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(coordinateSystem(extent = {{-200, -300}, {200, 300}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-100, -200}, {100, 200}})),
    __OpenModelica_commandLineOptions = "");
end OnePVerticalHRSG;
