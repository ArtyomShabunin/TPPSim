within TPPSim.Boilers;

model ThreePVerticalOTHRSG
  extends TPPSim.Boilers.BaseClases.Icons.Icon3pVerticalOTHRSG;
  package Medium_G = TPPSim.Media.ExhaustGas;
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  outer Modelica.Fluid.System system;
  inner parameter Boolean SH_cold_start = true "Исходное состояние - холодное" annotation(
    Dialog(group = "Исходное состояние"));
  parameter Modelica.SIunits.AbsolutePressure HP_p_flow_start = system.p_ambient "Начальное давление пара в контуре ВД" annotation(
    Dialog(group = "Контур ВД"));
  parameter Modelica.SIunits.AbsolutePressure IP_p_flow_start = system.p_ambient "Начальное давление пара в БСД" annotation(
    Dialog(group = "Контур СД"));
  parameter Modelica.SIunits.Temperature IP_t_m_steam_start = 100 + 273.15 "Начальная температура металла верха БСД" annotation(
    Dialog(group = "Контур СД"));
  parameter Modelica.SIunits.Temperature IP_t_m_water_start = 100 + 273.15 "Начальная температура металла низа БСД" annotation(
    Dialog(group = "Контур СД"));
  parameter Modelica.SIunits.SpecificEnthalpy IP_pipe2_h_start = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(IP_p_flow_start) + 100 "Начальная энтальпия пара в парапроводе за ПеСД" annotation(
    Dialog(group = "Контур СД"));
  parameter Modelica.SIunits.SpecificEnthalpy IP_SH_h_start = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(IP_p_flow_start) + 100 "Начальная энтальпия пара ПеСД" annotation(
    Dialog(group = "Контур СД"));
  parameter Modelica.SIunits.AbsolutePressure LP_p_flow_start = system.p_ambient "Начальное давление пара в БНД" annotation(
    Dialog(group = "Контур НД"));
  parameter Modelica.SIunits.Temperature LP_t_m_steam_start = 100 + 273.15 "Начальная температура металла верха БНД" annotation(
    Dialog(group = "Контур НД"));
  parameter Modelica.SIunits.Temperature LP_t_m_water_start = 100 + 273.15 "Начальная температура металла низа БНД" annotation(
    Dialog(group = "Контур НД"));
  parameter Modelica.SIunits.SpecificEnthalpy LP_SH_h_start = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(LP_p_flow_start) + 100 "Начальная энтальпия пара ПеНД" annotation(
    Dialog(group = "Контур НД"));  
  //Контур ВД
  //Экономайзер ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 7.702e-3, z1 = 174, z2 = 10, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO_3(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 2.162e-3, z1 = 174, z2 = 5, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Параллельный экономайзер ВД/СД
  TPPSim.HRSG_HeatExch.ParallelGFHE_simple IP_ECO_HP_ECO_1(redeclare package Medium_F = Medium_F, redeclare package Medium_G = Medium_G, Din_1 = 24e-3, Din_2 = 24e-3, HRSG_type_set_1 = TPPSim.Choices.HRSG_type.verticalTop, HRSG_type_set_2 = TPPSim.Choices.HRSG_type.verticalTop, Lpipe_1 = 20.04, Lpipe_2 = 20.4, delta_1 = 3e-3, delta_2 = 4e-3, delta_fin_1 = 0.8e-3, delta_fin_2 = 0.8e-3, flowEnergyDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowEnergyDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMassDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin_1 = 17e-3, hfin_2 = 17e-3, metalDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, metalDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes_1 = 2, numberOfVolumes_2 = 2, s1_1 = 75.02e-3, s1_2 = 82.7e-3, s2_1 = 79e-3, s2_2 = 79e-3, sfin_1 = 2.93e-3, sfin_2 = 3.133e-3, z1_1 = 20, z1_2 = 154, z2_1 = 6, z2_2 = 10, zahod_1 = 1, zahod_2 = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 102}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  //Испаритель ВД
  TPPSim.HRSG_HeatExch.GFHE HP_EVO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -78}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE HP_EVO_1(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 30e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.04, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 13, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -58}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Сепаратор ВД
  TPPSim.Drums.Separator HP_separator(redeclare package Medium = Medium_F, Din_down_pipe = 0.2, Din_sep = 0.5, H_down_pipe = 10, H_sep = 3, L_start = 7) annotation(
    Placement(visible = true, transformation(origin = {12, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Пароперегреватель ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.03e-3, s2 = 110e-3, sfin = 6.4e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -118}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.03e-3, s2 = 110e-3, sfin = 3.6e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -158}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы ВД
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {28, -90}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //ПЭН и РПК ВД
  TPPSim.Pumps.pressurePump FW_pump(redeclare package Medium = Medium_F, set_p = 6e+06, use_p_in = true) annotation(
    Placement(visible = true, transformation(origin = {-73, 115}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveIncompressible FWCV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 200, dp_nominal = 100000, filteredOpening = true, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-51, 115}, extent = {{-7, 7}, {7, -7}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure HPFW_p(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-37, 129}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add HPFW_add annotation(
    Placement(visible = true, transformation(origin = {-61, 137}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant HPFW_CV_dp(k = 1e5) annotation(
    Placement(visible = true, transformation(origin = {-37, 147}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  //Регуляторы ВД
  TPPSim.Controls.LC_sink HP_LC(DFmax = 30, DFmin = 0, L = 7) annotation(
    Placement(visible = true, transformation(origin = {45, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  TPPSim.Controls.TC HP_TC(T_sprh = 60, yMax = 1, y_start = 0.3) annotation(
    Placement(visible = true, transformation(origin = {45, -49}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  TPPSim.Pumps.simplePump HP_sink_valve(redeclare package Medium = Medium_F, setD_flow = 0, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {60, -130}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flash_tank(redeclare package Medium = Medium_F, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {90, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Logical.Greater HPTC_gr annotation(
    Placement(visible = true, transformation(origin = {-59, -71}, extent = {{-6, 6}, {6, -6}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant HPTC_const(k = 100 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-94, -86}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure HPTC_p(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {20, -56}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.SpecificEnthalpy HPTC_enth(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {4, -56}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  TPPSim.Sensors.Temperature HP_overheat(TemperatureType_set = TPPSim.Sensors.TemperatureType.overheating) annotation(
    Placement(visible = true, transformation(origin = {4, -90}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  //Контур СД
  //Испаритель СД
  TPPSim.HRSG_HeatExch.GFHE IP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 34e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 2e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, s1 = 91.64e-3, s2 = 79e-3, sfin = 4.287e-3, z1 = 118, z2 = 6, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Барабан СД
  TPPSim.Drums.Drum IP_drum(Din = 1.4, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.4, L = 13.1, delta = 30e-3, ps_start = IP_p_flow_start, t_m_steam_start = IP_t_m_steam_start, t_m_water_start = IP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {22, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Пароперегреватель СД
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 34e-3, Lpipe = 20.4, delta = 2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 9e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 64.64e-3, s2 = 70e-3, sfin = 5.102e-3, z1 = 168, z2 = 1, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 42}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 30e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 9e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 59.03e-3, s2 = 63.75e-3, sfin = 5.102e-3, z1 = 242, z2 = 2, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Промежуточный пароперегреватель
  TPPSim.HRSG_HeatExch.GFHE_simple RH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, Lpipe = 20.4, delta = 3.2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.42e-3, s2 = 110e-3, sfin = 7.5e-3, z1 = 174, z2 = 4, zahod = 4) annotation(
    Placement(visible = true, transformation(origin = {-18, -98}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple RH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, Lpipe = 20.4, delta = 3.2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.42e-3, s2 = 137e-3, sfin = 7.5e-3, z1 = 174, z2 = 4, zahod = 4) annotation(
    Placement(visible = true, transformation(origin = {-18, -138}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple RH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, Lpipe = 20.4, delta = 3.2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.42e-3, s2 = 110e-3, sfin = 7.5e-3, z1 = 174, z2 = 4, zahod = 4) annotation(
    Placement(visible = true, transformation(origin = {-18, -178}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Паропровод СД
  TPPSim.Pipes.ComplexPipe IP_pipe_1(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 4, numberOfVolumes = 2, p_flow_start = IP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {22, 46}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  TPPSim.Pipes.ComplexPipe IP_pipe_2(Din = 0.25, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2, p_flow_start = IP_p_flow_start, h_start = IP_pipe2_h_start) annotation(
    Placement(visible = true, transformation(origin = {36, -18}, extent = {{4, -4}, {-4, 4}}, rotation = 180)));
  Modelica.Fluid.Valves.ValveCompressible checkValve(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 0.5e5, filteredOpening = false, m_flow_nominal = 17.83, p_nominal = 71e5, rho_nominal = 11.44, riseTime = 300) annotation(
    Placement(visible = true, transformation(origin = {68, -30}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Fluid.Sensors.MassFlowRate IP_massFlowRate(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {13, -17}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible IP_vent(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 2.98e+06, filteredOpening = true, m_flow_nominal = 17.83, p_nominal = 29.8e+05, rho_nominal = 11.44, riseTime = 600) annotation(
    Placement(visible = true, transformation(origin = {-68, -10}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  TPPSim.Controls.vent_control IP_vent_control(event_value = 10, finish_out = 0, start_out = 0.05) annotation(
    Placement(visible = true, transformation(origin = {-40, 10}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Ts_IP(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {43, 7}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sensors.RelativePressure IP_relativePressure(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {76, -48}, extent = {{4, -4}, {-4, 4}}, rotation = 90)));
  TPPSim.Controls.dp_control checkValve_control annotation(
    Placement(visible = true, transformation(origin = {86, -30}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Blocks.Logical.Greater cv_greater annotation(
    Placement(visible = true, transformation(origin = {74, 0}, extent = {{6, 6}, {-6, -6}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant check_valve_pos_const(k = 0.1) annotation(
    Placement(visible = true, transformation(origin = {92, -14}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  //Контур НД
  //ГПК
  TPPSim.HRSG_HeatExch.GFHE_simple condHE(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.026, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.04, delta = 0.003, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.017, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 2.958e-3, z1 = 174, z2 = 16, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 162}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  //Испаритель НД
  TPPSim.HRSG_HeatExch.GFHE LP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.032, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 0.003, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.017, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, s1 = 82.04e-3, s2 = 110e-3, sfin = 2.868e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, 142}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Барабан НД
  TPPSim.Drums.Drum LP_drum(Din = 1.4, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.48, L = 13.1, delta = 16e-3, m_flow_small = 2 * system.m_flow_small, ps_start = LP_p_flow_start, t_m_steam_start = LP_t_m_steam_start, t_m_water_start = LP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {22, 162}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Пароперегреватель НД
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.032, Lpipe = 20.4, delta = 0.003, delta_fin = 0.001, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.09, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.27e-3, s2 = 110e-3, sfin = 45.03e-3, z1 = 174, z2 = 1, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 122}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 3e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 9e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 110e-3, sfin = 19.29e-3, z1 = 174, z2 = 2, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 82}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 3e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 9e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.27e-3, s2 = 110e-3, sfin = 18.56e-3, z1 = 174, z2 = 1, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Паропровод НД
  TPPSim.Pipes.ComplexPipe LP_pipe(Din = 0.2, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 4, numberOfVolumes = 2, p_flow_start = LP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {14, 126}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  //Клапаны
  //Паровые продувки
  Modelica.Fluid.Valves.ValveCompressible RH_vent(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1000, dp_nominal = 2.861e+06, filteredOpening = true, riseTime = 2300) annotation(
    Placement(visible = true, transformation(origin = {-80, -144}, extent = {{4, -4}, {-4, 4}}, rotation = -90)));
  Modelica.Fluid.Valves.ValveCompressible HP_vent(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1000, dp_nominal = 1.2431e+07, filteredOpening = true, riseTime = 960) annotation(
    Placement(visible = true, transformation(origin = {-60, -144}, extent = {{4, -4}, {-4, 4}}, rotation = -90)));
  TPPSim.Pumps.simplePump LP_circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {5, 147}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Pumps.simplePump IP_circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {7, 67}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //Обратный клапан
  //Регуляторы
  TPPSim.Controls.LC LP_LC(DFmax = 140, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {70, 162}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.LC IP_LC(DFmax = 20, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {70, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Датчики температуры газов
  Modelica.Fluid.Sensors.Temperature Tg_out_RH2(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-39, -121}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Tg_out_RH1(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-43, -79}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Tg_out_IPSH2(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-47, -23}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Tg_out_HPECO2(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {5, 35}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Tg_out_LPSH2(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-45, 77}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Tg_out_LPEVO(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-61, 185}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature Tg_out_CHE(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-45, 185}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-18, -200}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -224}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a condIn(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 174}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-202, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b LP_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b HP_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -162}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a IP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a HP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 114}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b condOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 156}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.simpleValve IP_FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {5, 93}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Valves.simpleValve LP_FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {5, 175}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b RH_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -182}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -126}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a RH_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput HP_vent_pos annotation(
    Placement(visible = true, transformation(origin = {-100, -176}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-128, 298}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput RH_vent_pos annotation(
    Placement(visible = true, transformation(origin = {-100, -156}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-190, 298}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanOutput check_valve_pos annotation(
    Placement(visible = true, transformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput HP_p_sep annotation(
    Placement(visible = true, transformation(origin = {90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, 234}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealOutput IP_p_drum annotation(
    Placement(visible = true, transformation(origin = {90, 138}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {86, 300}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Fluid.Interfaces.FluidPort_a LP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, 190}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Атмосфера
  Modelica.Fluid.Sources.FixedBoundary vent(redeclare package Medium = Medium_F, T = system.T_ambient, nPorts = 3, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-76, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-18, 190}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(HP_ECO_3.flowOut, HP_EVO_1.flowIn) annotation(
    Line(points = {{-8, -22}, {-4, -22}, {-4, -54}, {-8, -54}, {-8, -54}}, color = {0, 127, 255}));
  connect(HP_ECO_2.flowOut, HP_ECO_3.flowIn) annotation(
    Line(points = {{-8, 18}, {-6, 18}, {-6, -14}, {-8, -14}, {-8, -14}}, color = {0, 127, 255}));
  connect(LP_SH_3.flowOut, LP_Out) annotation(
    Line(points = {{-8, -2}, {32, -2}, {32, 40}, {64, 40}, {64, 50}, {100, 50}, {100, 50}}, color = {0, 127, 255}));
  connect(LP_SH_2.flowOut, LP_SH_3.flowIn) annotation(
    Line(points = {{-8, 78}, {0, 78}, {0, 6}, {-8, 6}, {-8, 6}}, color = {0, 127, 255}));
  connect(IP_ECO_HP_ECO_1.flowOut_2, HP_ECO_2.flowIn) annotation(
    Line(points = {{-8, 98}, {-6, 98}, {-6, 26}, {-8, 26}, {-8, 26}}, color = {0, 127, 255}));
  connect(HPTC_p.p, HP_p_sep) annotation(
    Line(points = {{26, -56}, {28, -56}, {28, -60}, {60, -60}, {60, -70}, {90, -70}, {90, -70}}, color = {0, 0, 127}));
  connect(LP_drum.steam, LP_pipe.waterIn) annotation(
    Line(points = {{30, 172}, {30, 172}, {30, 178}, {40, 178}, {40, 126}, {18, 126}, {18, 126}}, color = {0, 127, 255}));
  connect(LP_SH_1.flowIn, LP_pipe.waterOut) annotation(
    Line(points = {{-8, 126}, {8, 126}, {8, 126}, {10, 126}}, color = {0, 127, 255}));
  connect(cv_greater.y, check_valve_pos) annotation(
    Line(points = {{74, 6}, {74, 6}, {74, 30}, {90, 30}, {90, 30}}, color = {255, 0, 255}));
  connect(IP_drum.p_drum, IP_p_drum) annotation(
    Line(points = {{34, 92}, {40, 92}, {40, 120}, {60, 120}, {60, 138}, {90, 138}}, color = {0, 0, 127}));
  connect(check_valve_pos_const.y, cv_greater.u2) annotation(
    Line(points = {{86, -14}, {80, -14}, {80, -8}, {78, -8}}, color = {0, 0, 127}));
  connect(checkValve.opening_actual, cv_greater.u1) annotation(
    Line(points = {{68, -32}, {68, -32}, {68, -36}, {74, -36}, {74, -8}, {74, -8}}, color = {0, 0, 127}));
  connect(IP_relativePressure.p_rel, checkValve_control.u) annotation(
    Line(points = {{80, -48}, {96, -48}, {96, -30}, {94, -30}, {94, -30}}, color = {0, 0, 127}));
  connect(checkValve_control.y, checkValve.opening) annotation(
    Line(points = {{80, -30}, {72, -30}, {72, -30}, {72, -30}}, color = {0, 0, 127}));
  connect(IP_relativePressure.port_b, RH_1.flowIn) annotation(
    Line(points = {{76, -52}, {76, -52}, {76, -58}, {68, -58}, {68, -98}, {-4, -98}, {-4, -94}, {-8, -94}, {-8, -94}}, color = {0, 127, 255}));
  connect(checkValve.port_b, IP_relativePressure.port_a) annotation(
    Line(points = {{68, -34}, {68, -34}, {68, -40}, {76, -40}, {76, -44}, {76, -44}}, color = {0, 127, 255}));
  connect(IP_pipe_2.waterOut, Ts_IP.port) annotation(
    Line(points = {{41, -18}, {41, 2}, {43, 2}}, color = {0, 127, 255}));
  connect(IP_pipe_2.waterOut, checkValve.port_a) annotation(
    Line(points = {{41, -18}, {68, -18}, {68, -26}}, color = {0, 127, 255}));
  connect(IP_pipe_2.waterOut, IP_vent.port_a) annotation(
    Line(points = {{41, -18}, {50, -18}, {50, -10}, {-64, -10}}, color = {0, 127, 255}));
  connect(IP_massFlowRate.port_b, IP_pipe_2.waterIn) annotation(
    Line(points = {{18, -17}, {26, -17}, {26, -18}, {31, -18}}, color = {0, 127, 255}));
  connect(LP_FW_In, LP_FWCV.flowIn) annotation(
    Line(points = {{100, 190}, {-2, 190}, {-2, 172}, {0, 172}, {0, 175}}));
  connect(LP_LC.y, LP_FWCV.D_flow_in) annotation(
    Line(points = {{81, 162}, {82, 162}, {82, 164}, {87, 164}, {87, 182}, {5, 182}, {5, 176}, {5, 176}}, color = {0, 0, 127}));
  connect(LP_FWCV.flowOut, LP_drum.fedWater) annotation(
    Line(points = {{10, 175}, {16, 175}, {16, 171}}, color = {0, 127, 255}));
  connect(LP_SH_1.flowOut, LP_SH_2.flowIn) annotation(
    Line(points = {{-8, 118}, {-4, 118}, {-4, 86}, {-8, 86}, {-8, 86}}, color = {0, 127, 255}));
  connect(IP_ECO_HP_ECO_1.flowOut_1, IP_FWCV.flowIn) annotation(
    Line(points = {{-28, 98}, {-32, 98}, {-32, 94}, {0, 94}, {0, 94}}, color = {0, 127, 255}));
  connect(RH_In, RH_1.flowIn) annotation(
    Line(points = {{100, -90}, {68, -90}, {68, -98}, {-4, -98}, {-4, -94}, {-8, -94}, {-8, -94}}));
  connect(IP_massFlowRate.m_flow, IP_vent_control.u) annotation(
    Line(points = {{13, -11.5}, {12, -11.5}, {12, 10}, {-32, 10}}, color = {0, 0, 127}));
  connect(IP_SH_2.flowOut, IP_massFlowRate.port_a) annotation(
    Line(points = {{-8, -42}, {2, -42}, {2, -17}, {8, -17}}, color = {0, 127, 255}));
  connect(IP_vent_control.y, IP_vent.opening) annotation(
    Line(points = {{-46, 10}, {-68, 10}, {-68, -6}, {-68, -6}}, color = {0, 0, 127}));
  connect(IP_vent.port_b, vent.ports[3]) annotation(
    Line(points = {{-72, -10}, {-92, -10}, {-92, -124}, {-78, -124}, {-78, -120}, {-76, -120}}, color = {0, 127, 255}));
  connect(checkValve.port_b, RH_1.flowIn) annotation(
    Line(points = {{68, -34}, {68, -34}, {68, -98}, {-4, -98}, {-4, -94}, {-8, -94}, {-8, -94}}, color = {0, 127, 255}));
  connect(IP_SH_1.flowOut, IP_SH_2.flowIn) annotation(
    Line(points = {{-8, 38}, {-2, 38}, {-2, -34}, {-8, -34}, {-8, -34}}, color = {0, 127, 255}));
  connect(IP_drum.steam, IP_pipe_1.waterIn) annotation(
    Line(points = {{30, 92}, {30, 92}, {30, 100}, {44, 100}, {44, 46}, {26, 46}, {26, 46}}, color = {0, 127, 255}));
  connect(IP_pipe_1.waterOut, IP_SH_1.flowIn) annotation(
    Line(points = {{18, 46}, {-8, 46}, {-8, 46}, {-8, 46}}, color = {0, 127, 255}));
  connect(HP_overheat.port, HP_separator.fedWater) annotation(
    Line(points = {{4, -94}, {0, -94}, {0, -80}, {4, -80}, {4, -72}, {6, -72}}, color = {0, 127, 255}));
  connect(HP_TC.y, FWCV.opening) annotation(
    Line(points = {{53, -49}, {60, -49}, {60, -8}, {-50, -8}, {-50, 110}}, color = {0, 0, 127}));
  connect(HPTC_gr.y, HP_TC.on) annotation(
    Line(points = {{-59, -64}, {-59, -48}, {-4, -48}, {-4, -45}, {37, -45}}, color = {255, 0, 255}));
  connect(HPTC_p.p, HP_TC.p) annotation(
    Line(points = {{27, -56}, {28, -56}, {28, -53}, {37, -53}}, color = {0, 0, 127}));
  connect(HPTC_enth.h_out, HP_TC.h) annotation(
    Line(points = {{10, -56}, {12, -56}, {12, -49}, {37, -49}}, color = {0, 0, 127}));
  connect(FW_pump.port_b, FWCV.port_a) annotation(
    Line(points = {{-66, 116}, {-58, 116}, {-58, 116}, {-58, 116}}, color = {0, 127, 255}));
  connect(FWCV.port_b, IP_ECO_HP_ECO_1.flowIn_2) annotation(
    Line(points = {{-44, 116}, {-40, 116}, {-40, 112}, {-8, 112}, {-8, 106}, {-8, 106}, {-8, 106}}, color = {0, 127, 255}));
  connect(FWCV.port_b, HPFW_p.port) annotation(
    Line(points = {{-44, 116}, {-36, 116}, {-36, 124}, {-36, 124}}, color = {0, 127, 255}));
  connect(HP_separator.steam, HPTC_p.port) annotation(
    Line(points = {{12, -68}, {20, -68}, {20, -62}, {20, -62}}, color = {0, 127, 255}));
  connect(HP_separator.fedWater, HPTC_enth.port) annotation(
    Line(points = {{6, -72}, {4, -72}, {4, -62}, {4, -62}}, color = {0, 127, 255}));
  connect(HPTC_const.y, HPTC_gr.u2) annotation(
    Line(points = {{-88, -86}, {-64, -86}, {-64, -78}, {-64, -78}}, color = {0, 0, 127}));
  connect(Tg_out_RH2.T, HPTC_gr.u1) annotation(
    Line(points = {{-42, -120}, {-54, -120}, {-54, -94}, {-59, -94}, {-59, -78}}, color = {0, 0, 127}));
  connect(RH_2.gasOut, Tg_out_RH2.port) annotation(
    Line(points = {{-18, -132}, {-18, -130}, {-32, -130}, {-32, -138}, {-38, -138}, {-38, -126}, {-39, -126}}, color = {0, 127, 255}));
  connect(HP_vent.port_b, vent.ports[1]) annotation(
    Line(points = {{-60, -140}, {-60, -131}, {-76, -131}, {-76, -120}}, color = {0, 127, 255}));
  connect(RH_vent.port_b, vent.ports[2]) annotation(
    Line(points = {{-80, -140}, {-80, -132}, {-76, -132}, {-76, -120}}, color = {0, 127, 255}));
  connect(LP_EVO.gasOut, Tg_out_LPEVO.port) annotation(
    Line(points = {{-18, 148}, {-18, 148}, {-18, 154}, {-60, 154}, {-60, 180}, {-60, 180}}, color = {0, 127, 255}));
  connect(condHE.gasOut, Tg_out_CHE.port) annotation(
    Line(points = {{-18, 168}, {-18, 168}, {-18, 172}, {-46, 172}, {-46, 180}, {-44, 180}}, color = {0, 127, 255}));
  connect(IP_EVO.gasOut, Tg_out_LPSH2.port) annotation(
    Line(points = {{-18, 68}, {-18, 68}, {-18, 72}, {-44, 72}, {-44, 72}}, color = {0, 127, 255}));
  connect(IP_SH_2.gasOut, Tg_out_IPSH2.port) annotation(
    Line(points = {{-18, -32}, {-18, -32}, {-18, -28}, {-46, -28}, {-46, -28}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasOut, Tg_out_HPECO2.port) annotation(
    Line(points = {{-18, 28}, {-18, 28}, {-18, 30}, {6, 30}, {6, 30}}, color = {0, 127, 255}));
  connect(HP_SH_2.flowOut, HP_vent.port_a) annotation(
    Line(points = {{-8, -162}, {-4, -162}, {-4, -168}, {-60, -168}, {-60, -148}}, color = {0, 127, 255}));
  connect(HP_vent_pos, HP_vent.opening) annotation(
    Line(points = {{-100, -176}, {-44, -176}, {-44, -144}, {-57, -144}}, color = {0, 0, 127}));
  connect(RH_3.flowOut, RH_vent.port_a) annotation(
    Line(points = {{-8, -182}, {-4, -182}, {-4, -188}, {-80, -188}, {-80, -148}}, color = {0, 127, 255}));
  connect(RH_vent_pos, RH_vent.opening) annotation(
    Line(points = {{-100, -156}, {-74, -156}, {-74, -144}, {-77, -144}}, color = {0, 0, 127}));
  connect(RH_1.gasOut, Tg_out_RH1.port) annotation(
    Line(points = {{-18, -92}, {-18, -92}, {-18, -88}, {-44, -88}, {-44, -84}, {-42, -84}}, color = {0, 127, 255}));
  connect(HP_LC.y, HP_sink_valve.D_flow_in) annotation(
    Line(points = {{53, -73}, {60, -73}, {60, -124}}, color = {0, 0, 127}));
  connect(HP_separator.level, HP_LC.u) annotation(
    Line(points = {{17, -74}, {27, -74}, {27, -73}, {37, -73}}, color = {0, 0, 127}));
  connect(HP_separator.downWater, HP_sink_valve.port_a) annotation(
    Line(points = {{12, -90}, {12, -130}, {54, -130}}, color = {0, 127, 255}));
  connect(HP_sink_valve.port_b, flash_tank.ports[1]) annotation(
    Line(points = {{66, -130}, {80, -130}}, color = {0, 127, 255}));
  connect(HPFW_add.y, FW_pump.p_in) annotation(
    Line(points = {{-66, 138}, {-72, 138}, {-72, 122}, {-72, 122}}, color = {0, 0, 127}));
  connect(HPFW_CV_dp.y, HPFW_add.u1) annotation(
    Line(points = {{-42.5, 147}, {-50, 147}, {-50, 140}, {-54, 140}}, color = {0, 0, 127}));
  connect(HPFW_p.p, HPFW_add.u2) annotation(
    Line(points = {{-42, 130}, {-48, 130}, {-48, 134}, {-55, 134}}, color = {0, 0, 127}));
  connect(HP_FW_In, FW_pump.port_a) annotation(
    Line(points = {{-100, 114}, {-91, 114}, {-91, 115}, {-80, 115}}));
  connect(RH_1.flowOut, RH_2.flowIn) annotation(
    Line(points = {{-8, -102}, {2, -102}, {2, -134}, {-8, -134}, {-8, -134}}, color = {0, 127, 255}));
  connect(RH_2.flowOut, RH_3.flowIn) annotation(
    Line(points = {{-8, -142}, {2, -142}, {2, -174}, {-8, -174}, {-8, -174}}, color = {0, 127, 255}));
  connect(HP_SH_2.flowOut, HP_Out) annotation(
    Line(points = {{-8, -162}, {98, -162}, {98, -162}, {100, -162}}, color = {0, 127, 255}));
  connect(RH_3.flowOut, RH_Out) annotation(
    Line(points = {{-8, -182}, {100, -182}, {100, -182}, {100, -182}}, color = {0, 127, 255}));
  connect(HP_SH_1.flowOut, HP_SH_2.flowIn) annotation(
    Line(points = {{-8, -122}, {-4, -122}, {-4, -154}, {-8, -154}, {-8, -154}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, HP_SH_1.flowIn) annotation(
    Line(points = {{28, -94}, {28, -94}, {28, -114}, {-8, -114}, {-8, -114}}, color = {0, 127, 255}));
  connect(HP_separator.steam, HP_pipe.waterIn) annotation(
    Line(points = {{12, -68}, {28, -68}, {28, -85}}, color = {0, 127, 255}));
  connect(HP_EVO_2.flowOut, HP_separator.fedWater) annotation(
    Line(points = {{-8, -82}, {-2, -82}, {-2, -74}, {6, -74}, {6, -72}}, color = {0, 127, 255}));
  connect(HP_EVO_1.flowOut, HP_EVO_2.flowIn) annotation(
    Line(points = {{-8, -62}, {-4, -62}, {-4, -74}, {-8, -74}, {-8, -74}}, color = {0, 127, 255}));
  connect(condOut, condHE.flowOut) annotation(
    Line(points = {{-100, 156}, {-70, 156}, {-70, 158}, {-28, 158}, {-28, 158}}));
  connect(condIn, condHE.flowIn) annotation(
    Line(points = {{-100, 174}, {-70, 174}, {-70, 166}, {-28, 166}, {-28, 166}}));
  connect(LP_drum.upStr, LP_EVO.flowOut) annotation(
    Line(points = {{29, 153}, {28.5, 153}, {28.5, 155}, {28, 155}, {28, 140}, {10, 140}, {10, 138}, {-8, 138}}, color = {0, 127, 255}));
  connect(LP_circPump.port_b, LP_EVO.flowIn) annotation(
    Line(points = {{0, 147}, {-1, 147}, {-1, 149}, {-2, 149}, {-2, 146}, {-5, 146}, {-5, 146}, {-8, 146}}, color = {0, 127, 255}));
  connect(LP_SH_1.gasOut, LP_EVO.gasIn) annotation(
    Line(points = {{-18, 127}, {-18, 127}, {-18, 127}, {-18, 127}, {-18, 137}, {-18, 137}, {-18, 139}, {-18, 139}, {-18, 137}, {-18, 137}, {-18, 137}, {-18, 137}}, color = {0, 127, 255}));
  connect(LP_EVO.gasOut, condHE.gasIn) annotation(
    Line(points = {{-18, 147}, {-18, 157}}, color = {0, 127, 255}));
  connect(condHE.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-18, 167}, {-18, 180}}, color = {0, 127, 255}));
  connect(IP_FW_In, IP_ECO_HP_ECO_1.flowIn_1) annotation(
    Line(points = {{-100, 100}, {-66, 100}, {-66, 106}, {-28, 106}, {-28, 106}}));
  connect(RH_2.gasIn, HP_SH_2.gasOut) annotation(
    Line(points = {{-18, -142}, {-18, -142}, {-18, -152}, {-18, -152}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasIn, RH_2.gasOut) annotation(
    Line(points = {{-18, -122}, {-18, -122}, {-18, -132}, {-18, -132}}, color = {0, 127, 255}));
  connect(RH_1.gasIn, HP_SH_1.gasOut) annotation(
    Line(points = {{-18, -102}, {-18, -102}, {-18, -112}, {-18, -112}}, color = {0, 127, 255}));
  connect(HP_EVO_2.gasIn, RH_1.gasOut) annotation(
    Line(points = {{-18, -82}, {-18, -82}, {-18, -92}, {-18, -92}}, color = {0, 127, 255}));
  connect(HP_EVO_1.gasIn, HP_EVO_2.gasOut) annotation(
    Line(points = {{-18, -62}, {-18, -62}, {-18, -72}, {-18, -72}}, color = {0, 127, 255}));
  connect(IP_SH_2.gasIn, HP_EVO_1.gasOut) annotation(
    Line(points = {{-18, -42}, {-18, -42}, {-18, -52}, {-18, -52}}, color = {0, 127, 255}));
  connect(HP_ECO_3.gasIn, IP_SH_2.gasOut) annotation(
    Line(points = {{-18, -22}, {-18, -22}, {-18, -32}, {-18, -32}}, color = {0, 127, 255}));
  connect(LP_SH_3.gasIn, HP_ECO_3.gasOut) annotation(
    Line(points = {{-18, -2}, {-18, -2}, {-18, -12}, {-18, -12}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasIn, LP_SH_3.gasOut) annotation(
    Line(points = {{-18, 18}, {-18, 18}, {-18, 8}, {-18, 8}}, color = {0, 127, 255}));
  connect(LP_SH_2.gasIn, IP_EVO.gasOut) annotation(
    Line(points = {{-18, 78}, {-18, 78}, {-18, 68}, {-18, 68}}, color = {0, 127, 255}));
  connect(IP_ECO_HP_ECO_1.gasIn, LP_SH_2.gasOut) annotation(
    Line(points = {{-18, 96}, {-18, 96}, {-18, 88}, {-18, 88}}, color = {0, 127, 255}));
  connect(LP_SH_1.gasIn, IP_ECO_HP_ECO_1.gasOut) annotation(
    Line(points = {{-18, 118}, {-18, 118}, {-18, 108}, {-18, 108}}, color = {0, 127, 255}));
  connect(RH_3.gasOut, HP_SH_2.gasIn) annotation(
    Line(points = {{-18, -172}, {-18, -172}, {-18, -162}, {-18, -162}}, color = {0, 127, 255}));
  connect(RH_3.gasIn, gasIn) annotation(
    Line(points = {{-18, -182}, {-18, -182}, {-18, -200}, {-18, -200}}, color = {0, 127, 255}));
  connect(IP_FWCV.flowOut, IP_drum.fedWater) annotation(
    Line(points = {{10, 93}, {16, 93}, {16, 91}}, color = {0, 127, 255}));
  connect(IP_LC.y, IP_FWCV.D_flow_in) annotation(
    Line(points = {{81, 82}, {85, 82}, {85, 82}, {89, 82}, {89, 96}, {5, 96}, {5, 94}}, color = {0, 0, 127}));
  connect(IP_drum.waterLevel, IP_LC.u) annotation(
    Line(points = {{33, 88}, {35.25, 88}, {35.25, 88}, {37.5, 88}, {37.5, 90}, {40, 90}, {40, 90}, {49, 90}, {49, 82}, {57, 82}, {57, 82}, {55, 82}, {55, 82}, {57, 82}, {57, 80}}, color = {0, 0, 127}));
  connect(LP_drum.waterLevel, LP_LC.u) annotation(
    Line(points = {{33, 168}, {37, 168}, {37, 170}, {41, 170}, {41, 170}, {51, 170}, {51, 162}, {53, 162}, {53, 162}, {55, 162}, {55, 160}, {56, 160}, {56, 160}, {57, 160}}, color = {0, 0, 127}));
  connect(IP_drum.downStr, IP_circPump.port_a) annotation(
    Line(points = {{15, 73}, {14.75, 73}, {14.75, 73}, {14.5, 73}, {14.5, 73}, {14, 73}, {14, 67}, {13, 67}, {13, 67}, {12.5, 67}, {12.5, 67}, {12, 67}}, color = {0, 127, 255}));
  connect(IP_circPump.port_b, IP_EVO.flowIn) annotation(
    Line(points = {{2, 67}, {1.5, 67}, {1.5, 67}, {1, 67}, {1, 69}, {0, 69}, {0, 68}, {-4, 68}, {-4, 66}, {-8, 66}}, color = {0, 127, 255}));
  connect(IP_EVO.flowOut, IP_drum.upStr) annotation(
    Line(points = {{-8, 58}, {-6, 58}, {-6, 58}, {-4, 58}, {-4, 56}, {28, 56}, {28, 71}, {28.5, 71}, {28.5, 73}, {28.75, 73}, {28.75, 73}, {28.875, 73}, {28.875, 73}, {29, 73}}, color = {0, 127, 255}));
  connect(IP_SH_1.gasOut, IP_EVO.gasIn) annotation(
    Line(points = {{-18, 47}, {-18, 57}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasOut, IP_SH_1.gasIn) annotation(
    Line(points = {{-18, 27}, {-18, 37}}, color = {0, 127, 255}));
  connect(LP_drum.downStr, LP_circPump.port_a) annotation(
    Line(points = {{15, 153}, {14.75, 153}, {14.75, 153}, {14.5, 153}, {14.5, 155}, {14, 155}, {14, 149}, {12, 149}, {12, 147}, {10, 147}}, color = {0, 127, 255}));
protected
  annotation(
    Documentation(info = "<html>
  <p>
  Модель трехконтурного котла-утилизатора с прямоточным контуром ВД и барабанными контурами СД и НД.
  </p>
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>May 24, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(coordinateSystem(extent = {{-200, -300}, {200, 300}}, initialScale = 0.1), graphics = {Polygon(origin = {16, 104}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-115, 188}, {-115, -170}, {123, -170}, {123, -190}, {119, -190}, {119, -174}, {-119, -174}, {-119, 188}, {-115, 188}}), Polygon(origin = {-17, 103}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-142, 189}, {-142, 87}, {-100, 87}, {-100, -209}, {152, -209}, {152, -225}, {148, -225}, {148, -213}, {-104, -213}, {-104, 83}, {-146, 83}, {-146, 189}, {-142, 189}}), Polygon(origin = {155, -35}, rotation = -90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{13, 45}, {13, 11}, {-13, 11}, {-13, -35}, {-21, -35}, {-21, 19}, {5, 19}, {5, 45}, {13, 45}}), Polygon(origin = {131, -70}, rotation = -90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-30, 43}, {-22, 43}, {-22, -11}, {-30, -11}, {-30, 15}, {-30, 35}, {-30, 43}}), Polygon(origin = {143, -18}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, points = {{-15, 10}, {15, -10}, {15, 10}, {-15, -10}, {-15, 10}}), Line(origin = {159.639, -3.048}, points = {{-7, -8.5172}, {-7, 3.48283}, {9, 3.48283}, {39, 3.4828}}), Rectangle(origin = {-101, 281}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-7, 7}, {7, -7}}), Line(origin = {-104.769, 284.899}, points = {{-3, 0}, {3, 0}}), Line(origin = {-97.1063, 281.373}, points = {{-3, 0}, {3, 0}}), Line(origin = {-104.743, 277.46}, points = {{-3, 0}, {3, 0}}), Rectangle(extent = {{-234, 186}, {-234, 186}}), Ellipse(extent = {{-226, 192}, {-226, 192}}, endAngle = 360), Polygon(origin = {-101, 295}, points = {{-10, -3}, {0, 3}, {10, -3}, {-10, -3}}), Rectangle(extent = {{-238, 158}, {-238, 158}}), Rectangle(origin = {-161, 281}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-7, 7}, {7, -7}}), Line(origin = {-164.748, 284.006}, points = {{-3, 0}, {3, 0}}), Line(origin = {-156.766, 280.018}, points = {{-3, 0}, {3, 0}}), Line(origin = {-164.79, 276.366}, points = {{-3, 0}, {3, 0}}), Polygon(origin = {-161, 295}, points = {{-10, -3}, {0, 3}, {10, -3}, {-10, -3}}), Polygon(origin = {-101, 252}, rotation = -90, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, points = {{-15, 10}, {15, -10}, {15, 10}, {-15, -10}, {-15, 10}}), Polygon(origin = {-161, 252}, rotation = -90, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, points = {{-15, 10}, {15, -10}, {15, 10}, {-15, -10}, {-15, 10}}), Rectangle(origin = {-246, 89}, rotation = -90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-5, 66}, {5, 46}}), Polygon(origin = {-19, 63}, rotation = -90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-11, 179}, {15, 179}, {15, -171}, {-21, -171}, {-21, -163}, {7, -163}, {7, 171}, {-11, 171}, {-11, 179}}), Polygon(origin = {63, 61}, fillColor = {0, 85, 255}, fillPattern = FillPattern.Solid, points = {{-1, 9}, {17, -9}, {-17, -9}, {-1, 9}}), Ellipse(origin = {64, 53}, lineColor = {156, 156, 156}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Sphere, extent = {{-18, 17}, {16, -17}}, endAngle = 360), Polygon(origin = {55, 53}, rotation = 90, fillColor = {0, 85, 255}, fillPattern = FillPattern.Solid, points = {{-1, 9}, {17, -9}, {-17, -9}, {-1, 9}}), Rectangle(origin = {185, 79}, rotation = 90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-5, 65}, {5, -15}}), Ellipse(origin = {-200, 210}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{4, -2}, {26, -24}}, endAngle = 360), Line(origin = {-177.008, 178.749}, points = {{-7.20888, 6.20888}, {-7.20888, -5.79112}, {4.79112, -5.79112}}), Text(origin = {-184, 198}, extent = {{-8, 8}, {8, -8}}, textString = "P"), Ellipse(origin = {78, 214}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{4, -2}, {26, -24}}, endAngle = 360), Text(origin = {94, 202}, extent = {{-8, 8}, {8, -8}}, textString = "P"), Line(origin = {100.44, 183.3}, points = {{-7.20888, 6.20888}, {-7.20888, -5.79112}, {-21.2089, -5.79112}}), Line(origin = {-190.87, 238.563}, points = {{8.89567, -31.2087}, {8.89567, -3.20866}, {8.8957, -3.20866}, {0.8957, -3.2087}}), Line(origin = {86.8675, 238.695}, points = {{0, -29}, {0, 61}}), Line(origin = {-110.446, 275.825}, points = {{-15, 23}, {-15, -19}, {11, -19}}), Line(origin = {-173.986, 274.747}, points = {{-15, 23}, {-15, -19}, {11, -19}}), Rectangle(origin = {185, 29}, rotation = 90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-5, 65}, {5, -15}}), Rectangle(origin = {185, -91}, rotation = 90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-5, 65}, {5, -15}}), Rectangle(origin = {185, -127}, rotation = 90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-5, 65}, {5, -15}}), Rectangle(origin = {-195, 17}, rotation = 90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-3, 5}, {5, -15}}), Rectangle(origin = {-195, -33}, rotation = 90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-3, 5}, {5, -15}}), Rectangle(origin = {-195, -61}, rotation = 90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-3, 5}, {5, -15}})}),
    Diagram(coordinateSystem(extent = {{-100, -200}, {100, 200}})),
    __OpenModelica_commandLineOptions = "");
end ThreePVerticalOTHRSG;
