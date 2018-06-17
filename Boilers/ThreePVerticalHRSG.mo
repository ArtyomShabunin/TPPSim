within TPPSim.Boilers;

model ThreePVerticalHRSG
  extends TPPSim.Boilers.BaseClases.Icons.Icon3pVerticalHRSG;
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
    Placement(visible = true, transformation(origin = {-18, 190}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
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
    Placement(visible = true, transformation(origin = {24, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump IP_circPump(redeclare package Medium = Medium_F, setD_flow = 0.001, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {3, 33}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //Пароперегреватель ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 6.4e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -138}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 3.6e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -188}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 3.6e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -242}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы ВД
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {46, -126}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
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
    Placement(visible = true, transformation(origin = {64, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Контур СД
  //Экономайзер СД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 2.162e-3, z1 = 174, z2 = 5, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO_3(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 2.162e-3, z1 = 174, z2 = 5, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -58}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

  //Промежуточный пароперегреватель
  TPPSim.HRSG_HeatExch.GFHE_simple RH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 3.6e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -162}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple RH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 3.6e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -214}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple RH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 3.6e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -266}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Параллельный экономайзер ВД/СД
  //Испаритель ВД
  TPPSim.HRSG_HeatExch.GFHE HP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, h_flow_start = 251.2e3, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -112}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Барабан СД
  TPPSim.Drums.Drum IP_drum(Din = 1.718, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.5, L = 9, delta = 0.02, ps_start = HP_p_flow_start, t_m_steam_start = HP_t_m_steam_start, t_m_water_start = HP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {22, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump HP_circPump(redeclare package Medium = Medium_F, setD_flow = 0.001, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {3, -109}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //Пароперегреватель ВД
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 6.4e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 3.6e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -78}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы ВД
  TPPSim.Pipes.ComplexPipe IP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {38, 18}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
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
    
  //Контур НД
  //Испаритель НД
  TPPSim.HRSG_HeatExch.GFHE LP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, h_flow_start = 251.2e3, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 102}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Барабан НД
  TPPSim.Drums.Drum LP_drum(Din = 1.718, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.5, L = 9, delta = 0.02, ps_start = HP_p_flow_start, t_m_steam_start = HP_t_m_steam_start, t_m_water_start = HP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {20, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump LP_circPump(redeclare package Medium = Medium_F, setD_flow = 0.001, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {3, 107}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));  
  Modelica.Blocks.Sources.Ramp LP_set_flow(duration = 20, height = 25, offset = 0.01, startTime = 3) annotation(
    Placement(visible = true, transformation(origin = {14, 142}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  //Трубопровод НД
  TPPSim.Pipes.ComplexPipe LP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {36, 102}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //Пароперегреватель НД
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 6.4e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, 84}, extent = {{-10, -10}, {10, 10}}, rotation = -90))); 
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 6.4e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, 46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));  
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 6.4e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));   
  //ГПК
  TPPSim.HRSG_HeatExch.GFHE_simple cond_HE(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 2.162e-3, z1 = 174, z2 = 5, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 154}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));  
  
  //Регуляторы НД
  TPPSim.Controls.LC LP_LC(DFmax = 46, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {58, 126}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //ПЭН и РПК НД
  TPPSim.Pumps.pressurePump cond_pump(redeclare package Medium = Medium_F, set_p = 6e+06, use_p_in = true) annotation(
    Placement(visible = true, transformation(origin = {-75, 117}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveIncompressible LP_FWCV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 200, dp_nominal = 100000, filteredOpening = true, leakageOpening = 1e-4, m_flow_small = system.m_flow_small, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-47, 117}, extent = {{-7, 7}, {7, -7}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure LPFW_p(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-31, 129}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add LPFW_add annotation(
    Placement(visible = true, transformation(origin = {-61, 143}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant LPFW_CV_dp(k = 1e5) annotation(
    Placement(visible = true, transformation(origin = {-41, 149}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));


   
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-18, -292}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -224}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b HP_steam(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {96, -152}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b IP_steam(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -220}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b LP_steam(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a cond_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp set_flow(duration = 20, height = 25, offset = 0.01, startTime = 3) annotation(
    Placement(visible = true, transformation(origin = {22, -82}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp IP_set_flow(duration = 20, height = 25, offset = 0.01, startTime = 3) annotation(
    Placement(visible = true, transformation(origin = {18, 68}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
equation
  connect(RH_1.gasOut, HP_SH_1.gasIn) annotation(
    Line(points = {{-18, -156}, {-18, -156}, {-18, -142}, {-18, -142}}, color = {0, 127, 255}));
  connect(HP_SH_2.gasOut, RH_1.gasIn) annotation(
    Line(points = {{-18, -182}, {-18, -182}, {-18, -166}, {-18, -166}}, color = {0, 127, 255}));
  connect(RH_2.gasOut, HP_SH_2.gasIn) annotation(
    Line(points = {{-18, -208}, {-18, -208}, {-18, -192}, {-18, -192}}, color = {0, 127, 255}));
  connect(HP_SH_3.gasOut, RH_2.gasIn) annotation(
    Line(points = {{-18, -236}, {-18, -236}, {-18, -218}, {-18, -218}}, color = {0, 127, 255}));
  connect(RH_3.gasOut, HP_SH_3.gasIn) annotation(
    Line(points = {{-18, -260}, {-18, -260}, {-18, -246}, {-18, -246}}, color = {0, 127, 255}));
  connect(gasIn, RH_3.gasIn) annotation(
    Line(points = {{-18, -292}, {-18, -292}, {-18, -270}, {-18, -270}}));
  connect(RH_3.flowOut, IP_steam) annotation(
    Line(points = {{-8, -270}, {72, -270}, {72, -220}, {100, -220}, {100, -220}}, color = {0, 127, 255}));
  connect(RH_2.flowOut, RH_3.flowIn) annotation(
    Line(points = {{-8, -218}, {6, -218}, {6, -262}, {-8, -262}, {-8, -262}}, color = {0, 127, 255}));
  connect(RH_1.flowOut, RH_2.flowIn) annotation(
    Line(points = {{-8, -166}, {6, -166}, {6, -210}, {-8, -210}, {-8, -210}}, color = {0, 127, 255}));
  connect(IP_SH_2.flowOut, RH_1.flowIn) annotation(
    Line(points = {{-8, -82}, {-4, -82}, {-4, -158}, {-8, -158}, {-8, -158}}, color = {0, 127, 255}));
  connect(HP_SH_3.flowOut, HP_steam) annotation(
    Line(points = {{-8, -246}, {60, -246}, {60, -152}, {96, -152}, {96, -152}}, color = {0, 127, 255}));
  connect(HP_SH_2.flowOut, HP_SH_3.flowIn) annotation(
    Line(points = {{-8, -192}, {-2, -192}, {-2, -238}, {-8, -238}, {-8, -238}}, color = {0, 127, 255}));
  connect(HP_SH_1.flowOut, HP_SH_2.flowIn) annotation(
    Line(points = {{-8, -142}, {-2, -142}, {-2, -184}, {-8, -184}}, color = {0, 127, 255}));
  connect(HP_ECO_3.flowOut, HP_drum.fedWater) annotation(
    Line(points = {{-8, -62}, {6, -62}, {6, -100}, {18, -100}, {18, -100}}, color = {0, 127, 255}));
  connect(HP_ECO_2.flowOut, HP_ECO_3.flowIn) annotation(
    Line(points = {{-8, -22}, {-4, -22}, {-4, -52}, {-4, -52}, {-4, -54}, {-8, -54}, {-8, -54}}, color = {0, 127, 255}));
  connect(LP_SH_3.flowOut, LP_steam) annotation(
    Line(points = {{-8, -42}, {66, -42}, {66, 20}, {100, 20}, {100, 20}}, color = {0, 127, 255}));
  connect(LP_SH_2.flowOut, LP_SH_3.flowIn) annotation(
    Line(points = {{-8, 42}, {-6, 42}, {-6, -28}, {-6, -28}, {-6, -34}, {-8, -34}, {-8, -34}}, color = {0, 127, 255}));
  connect(LC.y, HP_FWCV.opening) annotation(
    Line(points = {{76, -80}, {80, -80}, {80, -50}, {-52, -50}, {-52, 0}, {-50, 0}}, color = {0, 0, 127}));
  connect(HP_ECO_3.gasIn, IP_SH_2.gasOut) annotation(
    Line(points = {{-18, -62}, {-18, -62}, {-18, -72}, {-18, -72}}, color = {0, 127, 255}));
  connect(LP_SH_3.gasIn, HP_ECO_3.gasOut) annotation(
    Line(points = {{-18, -42}, {-18, -42}, {-18, -52}, {-18, -52}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasIn, LP_SH_3.gasOut) annotation(
    Line(points = {{-18, -22}, {-18, -22}, {-18, -32}, {-18, -32}}, color = {0, 127, 255}));
  connect(set_flow.y, HP_circPump.D_flow_in) annotation(
    Line(points = {{17.6, -82}, {13.6, -82}, {13.6, -92}, {7.6, -92}, {7.6, -92}, {1.6, -92}, {1.6, -104}, {2.6, -104}, {2.6, -104}, {3.6, -104}}, color = {0, 0, 127}));
  connect(IP_SH_2.gasIn, HP_EVO.gasOut) annotation(
    Line(points = {{-18, -83}, {-18, -83}, {-18, -107}, {-18, -107}, {-18, -107}, {-18, -107}}, color = {0, 127, 255}));
  connect(IP_SH_1.flowOut, IP_SH_2.flowIn) annotation(
    Line(points = {{-8, 0}, {0, 0}, {0, -74}, {-8, -74}}, color = {0, 127, 255}));
  connect(HP_circPump.port_b, HP_EVO.flowIn) annotation(
    Line(points = {{-2, -109}, {-5, -109}, {-5, -109}, {-8, -109}, {-8, -109}, {-8, -109}, {-8, -109}, {-8, -109}}, color = {0, 127, 255}));
  connect(HP_drum.downStr, HP_circPump.port_a) annotation(
    Line(points = {{17, -119}, {13, -119}, {13, -119}, {9, -119}, {9, -111}, {7, -111}, {7, -111}, {7, -111}, {7, -109}}, color = {0, 127, 255}));
  connect(HP_EVO.gasIn, HP_SH_1.gasOut) annotation(
    Line(points = {{-18, -117}, {-18, -117}, {-18, -117}, {-18, -117}, {-18, -133}, {-18, -133}, {-18, -133}, {-18, -133}}, color = {0, 127, 255}));
  connect(HP_EVO.flowOut, HP_drum.upStr) annotation(
    Line(points = {{-8, -116}, {2, -116}, {2, -124}, {32, -124}, {32, -118}, {32, -118}, {32, -118}, {32, -118}}, color = {0, 127, 255}));
  connect(HP_drum.waterLevel, LC.u) annotation(
    Line(points = {{35, -104}, {37, -104}, {37, -104}, {39, -104}, {39, -80}, {49, -80}, {49, -80}, {51, -80}}, color = {0, 0, 127}));
  connect(HP_pipe.waterOut, HP_SH_1.flowIn) annotation(
    Line(points = {{46, -130.84}, {46, -130.84}, {46, -130.84}, {46, -130.84}, {46, -134.84}, {-8, -134.84}, {-8, -133.84}, {-8, -133.84}, {-8, -134.84}}, color = {0, 127, 255}));
  connect(HP_drum.steam, HP_pipe.waterIn) annotation(
    Line(points = {{31, -101}, {36, -101}, {36, -101}, {41, -101}, {41, -121}, {45, -121}, {45, -123}, {45, -123}, {45, -123}}, color = {0, 127, 255}));
  connect(IP_pipe.waterOut, IP_SH_1.flowIn) annotation(
    Line(points = {{38, 13}, {38, 8}, {-8, 8}}, color = {0, 127, 255}));
  connect(IP_drum.steam, IP_pipe.waterIn) annotation(
    Line(points = {{30, 50}, {30, 54}, {38, 54}, {38, 23}}, color = {0, 127, 255}));
  connect(IP_SH_1.gasIn, HP_ECO_2.gasOut) annotation(
    Line(points = {{-18, -1}, {-18, -1}, {-18, -1}, {-18, -1}, {-18, -1}, {-18, -1}, {-18, -13}, {-18, -13}, {-18, -13}, {-18, -13}}, color = {0, 127, 255}));
  connect(IP_SH_1.gasOut, IP_EVO.gasIn) annotation(
    Line(points = {{-18, 9}, {-18, 22}}, color = {0, 127, 255}));
  connect(IP_ECO_HP_ECO_1.flowOut_2, HP_ECO_2.flowIn) annotation(
    Line(points = {{-8, 62}, {-4, 62}, {-4, -14}, {-8, -14}}, color = {0, 127, 255}));
  connect(LP_SH_1.flowOut, LP_SH_2.flowIn) annotation(
    Line(points = {{-8, 80}, {-2, 80}, {-2, 50}, {-8, 50}, {-8, 50}}, color = {0, 127, 255}));
  connect(LP_pipe.waterOut, LP_SH_1.flowIn) annotation(
    Line(points = {{36, 98}, {36, 98}, {36, 88}, {-8, 88}, {-8, 88}}, color = {0, 127, 255}));
  connect(LP_drum.steam, LP_pipe.waterIn) annotation(
    Line(points = {{27, 129}, {27, 120}, {36, 120}, {36, 107}}, color = {0, 127, 255}));
  connect(LP_SH_1.gasOut, LP_EVO.gasIn) annotation(
    Line(points = {{-18, 90}, {-18, 90}, {-18, 98}, {-18, 98}}, color = {0, 127, 255}));
  connect(IP_ECO_HP_ECO_1.gasOut, LP_SH_1.gasIn) annotation(
    Line(points = {{-18, 72}, {-18, 72}, {-18, 80}, {-18, 80}}, color = {0, 127, 255}));
  connect(IP_EVO.gasOut, LP_SH_2.gasIn) annotation(
    Line(points = {{-18, 32}, {-18, 41}}, color = {0, 127, 255}));
  connect(LP_SH_2.gasOut, IP_ECO_HP_ECO_1.gasIn) annotation(
    Line(points = {{-18, 51}, {-18, 60}}, color = {0, 127, 255}));
  connect(LP_drum.HPFW, HP_FW_pump.port_a) annotation(
    Line(points = {{10, 116}, {-32, 116}, {-32, 110}, {-86, 110}, {-86, 4}, {-80, 4}, {-80, 6}}, color = {0, 127, 255}));
  connect(LP_drum.HPFW, IP_FW_pump.port_a) annotation(
    Line(points = {{10, 116}, {-32, 116}, {-32, 110}, {-86, 110}, {-86, 68}, {-82, 68}, {-82, 70}}, color = {0, 127, 255}));
  connect(LP_drum.waterLevel, LP_LC.u) annotation(
    Line(points = {{31, 126}, {46, 126}}, color = {0, 0, 127}));
  connect(LP_LC.y, LP_FWCV.opening) annotation(
    Line(points = {{69, 126}, {78, 126}, {78, 140}, {-20, 140}, {-20, 106}, {-48, 106}, {-48, 112}, {-47, 112}, {-47, 111}}, color = {0, 0, 127}));
  connect(LP_circPump.port_b, LP_EVO.flowIn) annotation(
    Line(points = {{-2, 107}, {-8, 107}, {-8, 106}}, color = {0, 127, 255}));
  connect(LP_drum.downStr, LP_circPump.port_a) annotation(
    Line(points = {{13, 111}, {10.5, 111}, {10.5, 107}, {8, 107}}, color = {0, 127, 255}));
  connect(LP_set_flow.y, LP_circPump.D_flow_in) annotation(
    Line(points = {{10, 142}, {3, 142}, {3, 112}}, color = {0, 0, 127}));
  connect(LP_EVO.gasOut, cond_HE.gasIn) annotation(
    Line(points = {{-18, 107}, {-18, 150}}, color = {0, 127, 255}));
  connect(LP_EVO.flowOut, LP_drum.upStr) annotation(
    Line(points = {{-8, 98}, {28, 98}, {28, 111}, {27, 111}}, color = {0, 127, 255}));
  connect(cond_HE.flowOut, LP_drum.fedWater) annotation(
    Line(points = {{-8, 150}, {12, 150}, {12, 129}, {13, 129}}, color = {0, 127, 255}));
  connect(LP_FWCV.port_b, cond_HE.flowIn) annotation(
    Line(points = {{-40, 118}, {0, 118}, {0, 158}, {-8, 158}, {-8, 158}}, color = {0, 127, 255}));
  connect(cond_In, cond_pump.port_a) annotation(
    Line(points = {{-100, 118}, {-82, 118}, {-82, 118}, {-82, 118}}));
  connect(cond_HE.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-18, 160}, {-18, 160}, {-18, 180}, {-18, 180}}, color = {0, 127, 255}));
  connect(LPFW_CV_dp.y, LPFW_add.u1) annotation(
    Line(points = {{-46.5, 149}, {-44, 149}, {-44, 146}, {-54, 146}}, color = {0, 0, 127}));
  connect(LPFW_p.p, LPFW_add.u2) annotation(
    Line(points = {{-36.5, 129}, {-41.5, 129}, {-41.5, 131}, {-46.5, 131}, {-46.5, 141}, {-54.5, 141}, {-54.5, 139}}, color = {0, 0, 127}));
  connect(LPFW_add.y, cond_pump.p_in) annotation(
    Line(points = {{-66.5, 143}, {-70.5, 143}, {-70.5, 145}, {-74.5, 145}, {-74.5, 125}, {-74.5, 125}, {-74.5, 123}, {-74.5, 123}}, color = {0, 0, 127}));
  connect(LP_FWCV.port_b, LPFW_p.port) annotation(
    Line(points = {{-40, 117}, {-35, 117}, {-35, 119}, {-30, 119}, {-30, 125}, {-30, 125}, {-30, 123}, {-30, 123}}, color = {0, 127, 255}));
  connect(cond_pump.port_b, LP_FWCV.port_a) annotation(
    Line(points = {{-68, 117}, {-61, 117}, {-61, 119}, {-54, 119}, {-54, 119}, {-54, 119}, {-54, 117}, {-54, 117}}, color = {0, 127, 255}));
  connect(IP_set_flow.y, IP_circPump.D_flow_in) annotation(
    Line(points = {{14, 68}, {3, 68}, {3, 38.5}}, color = {0, 0, 127}));
  connect(IP_drum.downStr, IP_circPump.port_a) annotation(
    Line(points = {{16, 32}, {8, 32}, {8, 33}}, color = {0, 127, 255}));
  connect(IP_circPump.port_b, IP_EVO.flowIn) annotation(
    Line(points = {{-2, 33}, {-8, 33}, {-8, 30}}, color = {0, 127, 255}));
  connect(IP_ECO_HP_ECO_1.flowOut_1, IP_drum.fedWater) annotation(
    Line(points = {{-28, 62}, {-32, 62}, {-32, 56}, {14, 56}, {14, 50}, {16, 50}}, color = {0, 127, 255}));
  connect(IP_drum.waterLevel, IP_LC.u) annotation(
    Line(points = {{34, 46}, {44, 46}, {44, 50}, {54, 50}, {54, 50}}, color = {0, 0, 127}));
  connect(IP_EVO.flowOut, IP_drum.upStr) annotation(
    Line(points = {{-8, 22}, {28, 22}, {28, 32}, {30, 32}}, color = {0, 127, 255}));
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
  connect(HP_FWCV.port_b, IP_ECO_HP_ECO_1.flowIn_2) annotation(
    Line(points = {{-44, 6}, {-30, 6}, {-30, 54}, {-38, 54}, {-38, 66}, {-34, 66}, {-34, 76}, {-8, 76}, {-8, 70}, {-8, 70}}, color = {0, 127, 255}));
  connect(HP_FW_pump.port_b, HP_FWCV.port_a) annotation(
    Line(points = {{-66, 6}, {-58, 6}, {-58, 6}, {-58, 6}}, color = {0, 127, 255}));
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
    Icon(graphics = {Text(origin = {-153, 157}, lineColor = {0, 170, 255}, extent = {{-27, 23}, {33, -17}}, textString = "LP"), Text(origin = {61, 157}, lineColor = {0, 170, 255}, extent = {{-27, 23}, {33, -17}}, textString = "IP"), Text(origin = {127, 157}, lineColor = {0, 170, 255}, extent = {{-27, 23}, {33, -17}}, textString = "HP")}, coordinateSystem(extent = {{-200, -300}, {200, 300}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-100, -300}, {100, 200}})),
    __OpenModelica_commandLineOptions = "");
end ThreePVerticalHRSG;
