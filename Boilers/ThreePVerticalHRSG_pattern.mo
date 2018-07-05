within TPPSim.Boilers;

model ThreePVerticalHRSG_pattern
  extends TPPSim.Boilers.BaseClases.Icons.Icon3pVerticalHRSG_pattern;
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
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 2.162e-3, z1 = 174, z2 = 5, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO_3(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 2.162e-3, z1 = 174, z2 = 5, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -58}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Параллельный экономайзер ВД/СД
  TPPSim.HRSG_HeatExch.ParallelGFHE_simple IP_ECO_HP_ECO_1(redeclare package Medium_F = Medium_F, redeclare package Medium_G = Medium_G, Din_1 = 24e-3, Din_2 = 24e-3, HRSG_type_set_1 = TPPSim.Choices.HRSG_type.verticalTop, HRSG_type_set_2 = TPPSim.Choices.HRSG_type.verticalTop, Lpipe_1 = 20.04, Lpipe_2 = 20.4, delta_1 = 3e-3, delta_2 = 4e-3, delta_fin_1 = 0.8e-3, delta_fin_2 = 0.8e-3, flowEnergyDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowEnergyDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMassDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin_1 = 17e-3, hfin_2 = 17e-3, metalDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, metalDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes_1 = 2, numberOfVolumes_2 = 2, s1_1 = 75.02e-3, s1_2 = 82.7e-3, s2_1 = 79e-3, s2_2 = 79e-3, sfin_1 = 2.93e-3, sfin_2 = 3.133e-3, z1_1 = 20, z1_2 = 154, z2_1 = 6, z2_2 = 10, zahod_1 = 1, zahod_2 = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 66}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  //Испаритель ВД
  //Барабан и цирк. насос ВД
  Modelica.Blocks.Interfaces.RealOutput HP_p_drum annotation(
    Placement(visible = true, transformation(origin = {104, -116}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, 234}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //Пароперегреватель ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 6.4e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -188}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 3.6e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -242}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы ВД
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
  //Контур СД
  //Испаритель СД
  //Барабан СД
  Modelica.Blocks.Interfaces.RealOutput IP_p_drum annotation(
    Placement(visible = true, transformation(origin = {88, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {86, 300}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  //Пароперегреватель СД
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 30e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 59.03e-3, s2 = 63.75e-3, sfin = 5.102e-3, z1 = 242, z2 = 2, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -78}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Промежуточный пароперегреватель
  TPPSim.HRSG_HeatExch.GFHE_simple RH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, Lpipe = 20.4, delta = 3.2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.42e-3, s2 = 110e-3, sfin = 7.5e-3, z1 = 174, z2 = 4, zahod = 4) annotation(
    Placement(visible = true, transformation(origin = {-18, -162}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple RH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, Lpipe = 20.4, delta = 3.2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.42e-3, s2 = 137e-3, sfin = 7.5e-3, z1 = 174, z2 = 4, zahod = 4) annotation(
    Placement(visible = true, transformation(origin = {-18, -214}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple RH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, Lpipe = 20.4, delta = 3.2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.42e-3, s2 = 110e-3, sfin = 7.5e-3, z1 = 174, z2 = 4, zahod = 4) annotation(
    Placement(visible = true, transformation(origin = {-18, -266}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы СД
  TPPSim.Pipes.ComplexPipe IP_pipe_2(Din = 0.25, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {26, -64}, extent = {{4, -4}, {-4, 4}}, rotation = 180)));
  Modelica.Fluid.Valves.ValveCompressible checkValve(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 0.5e5, filteredOpening = false, m_flow_nominal = 17.83, p_nominal = 71e5, rho_nominal = 11.44, riseTime = 300) annotation(
    Placement(visible = true, transformation(origin = {90, -98}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Fluid.Sensors.RelativePressure IP_relativePressure(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {74, -102}, extent = {{4, -4}, {-4, 4}}, rotation = 90)));
  TPPSim.Controls.dp_control checkValve_control annotation(
    Placement(visible = true, transformation(origin = {98, -52}, extent = {{6, -6}, {-6, 6}}, rotation = 180)));
  Modelica.Fluid.Valves.ValveCompressible IP_vent(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 2.98e+06, filteredOpening = true, m_flow_nominal = 17.83, p_nominal = 29.8e+05, rho_nominal = 11.44, riseTime = 600) annotation(
    Placement(visible = true, transformation(origin = {-66, -76}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput check_valve_pos annotation(
    Placement(visible = true, transformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater cv_greater annotation(
    Placement(visible = true, transformation(origin = {74, 0}, extent = {{6, 6}, {-6, -6}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant check_valve_pos_const(k = 0.1) annotation(
    Placement(visible = true, transformation(origin = {92, -14}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate IP_massFlowRate(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {5, -63}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));  
  TPPSim.Controls.vent_control vent_control1(event_value = 10, finish_out = 0, start_out = 0.05) annotation(
    Placement(visible = true, transformation(origin = {-66, -58}, extent = {{6, -6}, {-6, 6}}, rotation = 90)));
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
  //Контур НД
  //ГПК
  TPPSim.HRSG_HeatExch.GFHE_simple cond_HE(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 2.958e-3, z1 = 174, z2 = 16, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 154}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Регулирование температуры перед ГПК
  Modelica.Fluid.Sensors.Temperature Tw_condin(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {15, 179}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Pumps.simplePump rec_pump(redeclare package Medium = Medium_F, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {67, 159}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
  Modelica.Blocks.Continuous.LimPID T_cond_control(controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialOutput, yMax = 50, yMin = 0, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {46, 180}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant set_T_cond(k = 60 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {87, 187}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  //Испаритель НД
  TPPSim.HRSG_HeatExch.GFHE LP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.032, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 3e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 110e-3, sfin = 2.868e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, 102}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Барабан НД
  TPPSim.Drums.Drum LP_drum(Din = 1.718, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.5, L = 13.1, delta = 16e-3, ps_start = HP_p_flow_start, t_m_steam_start = HP_t_m_steam_start, t_m_water_start = HP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {20, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump LP_circPump(redeclare package Medium = Medium_F, setD_flow = 0.001, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {3, 107}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp LP_set_flow(duration = 20, height = 25, offset = 0.01, startTime = 3) annotation(
    Placement(visible = true, transformation(origin = {14, 142}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  //Трубопровод НД
  TPPSim.Pipes.ComplexPipe LP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {36, 102}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //Пароперегреватель НД
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 3e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 9e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.04e-3, s2 = 110e-3, sfin = 19.29e-3, z1 = 174, z2 = 2, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 84}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 3e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 9e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.04e-3, s2 = 110e-3, sfin = 19.29e-3, z1 = 174, z2 = 2, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 3e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 9e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.27e-3, s2 = 110e-3, sfin = 18.56e-3, z1 = 174, z2 = 1, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
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
  //Атмосфера
  Modelica.Fluid.Sources.FixedBoundary vent(redeclare package Medium = Medium_F, T = system.T_ambient, nPorts = 3, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-90, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Паровые продувки
  Modelica.Fluid.Valves.ValveCompressible HP_vent(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1000, dp_nominal = 1.2431e+07, filteredOpening = true, riseTime = 960) annotation(
    Placement(visible = true, transformation(origin = {-60, -144}, extent = {{4, -4}, {-4, 4}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput HP_vent_pos annotation(
    Placement(visible = true, transformation(origin = {-100, -176}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-128, 298}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Valves.ValveCompressible RH_vent(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1000, dp_nominal = 2.861e+06, filteredOpening = true, riseTime = 2300) annotation(
    Placement(visible = true, transformation(origin = {-80, -144}, extent = {{4, -4}, {-4, 4}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput RH_vent_pos annotation(
    Placement(visible = true, transformation(origin = {-100, -156}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-190, 298}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-18, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -224}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b HP_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -176}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b RH_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -220}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -126}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b LP_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a cond_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a RH_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {202, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(IP_massFlowRate.m_flow, vent_control1.u) annotation(
    Line(points = {{5, -57.5}, {8, -57.5}, {8, -48}, {-66, -48}, {-66, -50}}, color = {0, 0, 127}));
  connect(IP_SH_2.flowOut, IP_massFlowRate.port_a) annotation(
    Line(points = {{-8, -82}, {-2, -82}, {-2, -64}, {0, -64}, {0, -63}}, color = {0, 127, 255}));
  connect(IP_massFlowRate.port_b, IP_pipe_2.waterIn) annotation(
    Line(points = {{10, -63}, {20, -63}, {20, -64}, {22, -64}}, color = {0, 127, 255}));
  connect(vent_control1.y, IP_vent.opening) annotation(
    Line(points = {{-66, -64}, {-66, -64}, {-66, -72}, {-66, -72}, {-66, -72}}, color = {0, 0, 127}));
  connect(cond_HE.flowIn, Tw_condin.port) annotation(
    Line(points = {{-8, 158}, {-8, 158}, {-8, 170}, {14, 170}, {14, 174}, {16, 174}}, color = {0, 127, 255}));
  connect(rec_pump.port_b, cond_HE.flowIn) annotation(
    Line(points = {{68, 166}, {-8, 166}, {-8, 158}, {-8, 158}}, color = {0, 127, 255}));
  connect(cond_HE.flowOut, rec_pump.port_a) annotation(
    Line(points = {{-8, 150}, {66, 150}, {66, 152}, {68, 152}}, color = {0, 127, 255}));
  connect(Tw_condin.T, T_cond_control.u_m) annotation(
    Line(points = {{18, 180}, {38, 180}, {38, 180}, {38, 180}}, color = {0, 0, 127}));
  connect(set_T_cond.y, T_cond_control.u_s) annotation(
    Line(points = {{80, 188}, {66, 188}, {66, 194}, {50, 194}, {50, 194}, {46, 194}, {46, 188}, {46, 188}}, color = {0, 0, 127}));
  connect(T_cond_control.y, rec_pump.D_flow_in) annotation(
    Line(points = {{46, 174}, {46, 174}, {46, 170}, {80, 170}, {80, 160}, {74, 160}, {74, 160}}, color = {0, 0, 127}));
  connect(gasIn, RH_3.gasIn) annotation(
    Line(points = {{-18, -300}, {-18, -270}}));
  connect(RH_vent.port_b, vent.ports[3]) annotation(
    Line(points = {{-80, -140}, {-80, -140}, {-80, -110}, {-80, -110}}, color = {0, 127, 255}));
  connect(RH_vent_pos, RH_vent.opening) annotation(
    Line(points = {{-100, -156}, {-72, -156}, {-72, -144}, {-76, -144}, {-76, -144}}, color = {0, 0, 127}));
  connect(RH_3.flowOut, RH_vent.port_a) annotation(
    Line(points = {{-8, -270}, {-8, -270}, {-8, -276}, {-80, -276}, {-80, -148}, {-80, -148}}, color = {0, 127, 255}));
  connect(HP_vent.port_b, vent.ports[2]) annotation(
    Line(points = {{-60, -140}, {-60, -140}, {-60, -112}, {-80, -112}, {-80, -110}}, color = {0, 127, 255}));
  connect(HP_vent_pos, HP_vent.opening) annotation(
    Line(points = {{-100, -176}, {-50, -176}, {-50, -144}, {-56, -144}, {-56, -144}}, color = {0, 0, 127}));
  connect(HP_SH_3.flowOut, HP_vent.port_a) annotation(
    Line(points = {{-8, -246}, {-8, -246}, {-8, -254}, {-60, -254}, {-60, -148}, {-60, -148}}, color = {0, 127, 255}));
  connect(cv_greater.y, check_valve_pos) annotation(
    Line(points = {{74, 6}, {74, 6}, {74, 30}, {90, 30}, {90, 30}}, color = {255, 0, 255}));
  connect(checkValve.opening_actual, cv_greater.u1) annotation(
    Line(points = {{90, -100}, {98, -100}, {98, -68}, {74, -68}, {74, -8}, {74, -8}}, color = {0, 0, 127}));
  connect(check_valve_pos_const.y, cv_greater.u2) annotation(
    Line(points = {{86, -14}, {80, -14}, {80, -8}, {78, -8}}, color = {0, 0, 127}));
  connect(IP_vent.port_b, vent.ports[1]) annotation(
    Line(points = {{-70, -76}, {-74, -76}, {-74, -110}, {-80, -110}, {-80, -110}}, color = {0, 127, 255}));
  connect(IP_pipe_2.waterOut, IP_vent.port_a) annotation(
    Line(points = {{30, -64}, {30, -64}, {30, -72}, {10, -72}, {10, -86}, {-48, -86}, {-48, -76}, {-62, -76}, {-62, -76}}, color = {0, 127, 255}));
  connect(checkValve_control.y, checkValve.opening) annotation(
    Line(points = {{104, -52}, {108, -52}, {108, -98}, {94, -98}, {94, -98}}, color = {0, 0, 127}));
  connect(IP_relativePressure.p_rel, checkValve_control.u) annotation(
    Line(points = {{78, -102}, {82, -102}, {82, -52}, {90, -52}, {90, -52}}, color = {0, 0, 127}));
  connect(IP_relativePressure.port_b, RH_1.flowIn) annotation(
    Line(points = {{74, -106}, {88, -106}, {88, -140}, {40, -140}, {40, -158}, {-8, -158}, {-8, -158}}, color = {0, 127, 255}));
  connect(checkValve.port_b, RH_1.flowIn) annotation(
    Line(points = {{90, -102}, {88, -102}, {88, -140}, {40, -140}, {40, -158}, {-8, -158}, {-8, -158}}, color = {0, 127, 255}));
  connect(IP_pipe_2.waterOut, IP_relativePressure.port_a) annotation(
    Line(points = {{30, -64}, {46, -64}, {46, -98}, {74, -98}, {74, -98}}, color = {0, 127, 255}));
  connect(IP_pipe_2.waterOut, checkValve.port_a) annotation(
    Line(points = {{30, -64}, {90, -64}, {90, -94}, {90, -94}}, color = {0, 127, 255}));
  connect(RH_In, RH_1.flowIn) annotation(
    Line(points = {{100, -140}, {40, -140}, {40, -158}, {-8, -158}, {-8, -158}}));
  connect(HP_SH_3.flowOut, HP_Out) annotation(
    Line(points = {{-8, -246}, {60, -246}, {60, -176}, {100, -176}}, color = {0, 127, 255}));
  connect(HP_SH_2.gasOut, RH_1.gasIn) annotation(
    Line(points = {{-18, -182}, {-18, -182}, {-18, -166}, {-18, -166}}, color = {0, 127, 255}));
  connect(RH_2.gasOut, HP_SH_2.gasIn) annotation(
    Line(points = {{-18, -208}, {-18, -208}, {-18, -192}, {-18, -192}}, color = {0, 127, 255}));
  connect(HP_SH_3.gasOut, RH_2.gasIn) annotation(
    Line(points = {{-18, -236}, {-18, -236}, {-18, -218}, {-18, -218}}, color = {0, 127, 255}));
  connect(RH_3.gasOut, HP_SH_3.gasIn) annotation(
    Line(points = {{-18, -260}, {-18, -260}, {-18, -246}, {-18, -246}}, color = {0, 127, 255}));
  connect(RH_3.flowOut, RH_Out) annotation(
    Line(points = {{-8, -270}, {72, -270}, {72, -220}, {100, -220}, {100, -220}}, color = {0, 127, 255}));
  connect(RH_2.flowOut, RH_3.flowIn) annotation(
    Line(points = {{-8, -218}, {6, -218}, {6, -262}, {-8, -262}, {-8, -262}}, color = {0, 127, 255}));
  connect(RH_1.flowOut, RH_2.flowIn) annotation(
    Line(points = {{-8, -166}, {6, -166}, {6, -210}, {-8, -210}, {-8, -210}}, color = {0, 127, 255}));
  connect(HP_SH_2.flowOut, HP_SH_3.flowIn) annotation(
    Line(points = {{-8, -192}, {-2, -192}, {-2, -238}, {-8, -238}, {-8, -238}}, color = {0, 127, 255}));
  connect(HP_ECO_2.flowOut, HP_ECO_3.flowIn) annotation(
    Line(points = {{-8, -22}, {-4, -22}, {-4, -52}, {-4, -52}, {-4, -54}, {-8, -54}, {-8, -54}}, color = {0, 127, 255}));
  connect(LP_SH_3.flowOut, LP_Out) annotation(
    Line(points = {{-8, -42}, {66, -42}, {66, 20}, {100, 20}, {100, 20}}, color = {0, 127, 255}));
  connect(LP_SH_2.flowOut, LP_SH_3.flowIn) annotation(
    Line(points = {{-8, 42}, {-6, 42}, {-6, -28}, {-6, -28}, {-6, -34}, {-8, -34}, {-8, -34}}, color = {0, 127, 255}));
  connect(HP_ECO_3.gasIn, IP_SH_2.gasOut) annotation(
    Line(points = {{-18, -62}, {-18, -62}, {-18, -72}, {-18, -72}}, color = {0, 127, 255}));
  connect(LP_SH_3.gasIn, HP_ECO_3.gasOut) annotation(
    Line(points = {{-18, -42}, {-18, -42}, {-18, -52}, {-18, -52}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasIn, LP_SH_3.gasOut) annotation(
    Line(points = {{-18, -22}, {-18, -22}, {-18, -32}, {-18, -32}}, color = {0, 127, 255}));
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
  connect(HPFW_add.y, HP_FW_pump.p_in) annotation(
    Line(points = {{-66, 28}, {-72, 28}, {-72, 12}, {-72, 12}}, color = {0, 0, 127}));
  connect(HPFW_CV_dp.y, HPFW_add.u1) annotation(
    Line(points = {{-42, 38}, {-48, 38}, {-48, 30}, {-54, 30}, {-54, 30}}, color = {0, 0, 127}));
  connect(HPFW_p.p, HPFW_add.u2) annotation(
    Line(points = {{-42, 20}, {-48, 20}, {-48, 24}, {-54, 24}, {-54, 24}}, color = {0, 0, 127}));
  connect(HP_FWCV.port_b, HPFW_p.port) annotation(
    Line(points = {{-44, 6}, {-36, 6}, {-36, 14}, {-36, 14}}, color = {0, 127, 255}));
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
    Icon(graphics = {Polygon(origin = {16, 104}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-115, 188}, {-115, -170}, {123, -170}, {123, -190}, {119, -190}, {119, -174}, {-119, -174}, {-119, 188}, {-115, 188}}), Polygon(origin = {-17, 103}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-142, 189}, {-142, 87}, {-100, 87}, {-100, -209}, {152, -209}, {152, -225}, {148, -225}, {148, -213}, {-104, -213}, {-104, 83}, {-146, 83}, {-146, 189}, {-142, 189}}), Polygon(origin = {155, -35}, rotation = -90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{13, 45}, {13, 11}, {-13, 11}, {-13, -35}, {-21, -35}, {-21, 19}, {5, 19}, {5, 45}, {13, 45}}), Polygon(origin = {131, -70}, rotation = -90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-30, 43}, {-22, 43}, {-22, -11}, {-30, -11}, {-30, 15}, {-30, 35}, {-30, 43}}), Polygon(origin = {143, -18}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, points = {{-15, 10}, {15, -10}, {15, 10}, {-15, -10}, {-15, 10}}), Line(origin = {159.639, -3.048}, points = {{-7, -8.5172}, {-7, 3.48283}, {9, 3.48283}, {39, 3.4828}}), Rectangle(origin = {-101, 281}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-7, 7}, {7, -7}}), Line(origin = {-104.769, 284.899}, points = {{-3, 0}, {3, 0}}), Line(origin = {-97.1063, 281.373}, points = {{-3, 0}, {3, 0}}), Line(origin = {-104.743, 277.46}, points = {{-3, 0}, {3, 0}}), Rectangle(extent = {{-234, 186}, {-234, 186}}), Ellipse(extent = {{-226, 192}, {-226, 192}}, endAngle = 360), Polygon(origin = {-101, 295}, points = {{-10, -3}, {0, 3}, {10, -3}, {-10, -3}}), Rectangle(extent = {{-238, 158}, {-238, 158}}), Rectangle(origin = {-161, 281}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-7, 7}, {7, -7}}), Line(origin = {-164.748, 284.006}, points = {{-3, 0}, {3, 0}}), Line(origin = {-156.766, 280.018}, points = {{-3, 0}, {3, 0}}), Line(origin = {-164.79, 276.366}, points = {{-3, 0}, {3, 0}}), Polygon(origin = {-161, 295}, points = {{-10, -3}, {0, 3}, {10, -3}, {-10, -3}}), Polygon(origin = {-101, 252}, rotation = -90, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, points = {{-15, 10}, {15, -10}, {15, 10}, {-15, -10}, {-15, 10}}), Polygon(origin = {-161, 252}, rotation = -90, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, points = {{-15, 10}, {15, -10}, {15, 10}, {-15, -10}, {-15, 10}}), Rectangle(origin = {-246, 89}, rotation = -90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-5, 66}, {5, 46}}), Polygon(origin = {-19, 63}, rotation = -90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-11, 179}, {15, 179}, {15, -171}, {-21, -171}, {-21, -163}, {7, -163}, {7, 171}, {-11, 171}, {-11, 179}}), Polygon(origin = {63, 61}, fillColor = {0, 85, 255}, fillPattern = FillPattern.Solid, points = {{-1, 9}, {17, -9}, {-17, -9}, {-1, 9}}), Ellipse(origin = {64, 53}, lineColor = {156, 156, 156}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Sphere, extent = {{-18, 17}, {16, -17}}, endAngle = 360), Polygon(origin = {55, 53}, rotation = 90, fillColor = {0, 85, 255}, fillPattern = FillPattern.Solid, points = {{-1, 9}, {17, -9}, {-17, -9}, {-1, 9}}), Ellipse(origin = {-200, 210}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{4, -2}, {26, -24}}, endAngle = 360), Line(origin = {-177.008, 178.749}, points = {{-7.20888, 6.20888}, {-7.20888, -5.79112}, {4.79112, -5.79112}}), Text(origin = {-184, 198}, extent = {{-8, 8}, {8, -8}}, textString = "P"), Ellipse(origin = {78, 214}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{4, -2}, {26, -24}}, endAngle = 360), Text(origin = {94, 202}, extent = {{-8, 8}, {8, -8}}, textString = "P"), Line(origin = {100.44, 183.3}, points = {{-7.20888, 6.20888}, {-7.20888, -5.79112}, {-21.2089, -5.79112}}), Line(origin = {-190.87, 238.563}, points = {{8.89567, -31.2087}, {8.89567, -3.20866}, {8.8957, -3.20866}, {0.8957, -3.2087}}), Line(origin = {86.8675, 238.695}, points = {{0, -29}, {0, 61}}), Line(origin = {-110.446, 275.825}, points = {{-15, 23}, {-15, -19}, {11, -19}}), Line(origin = {-173.986, 274.747}, points = {{-15, 23}, {-15, -19}, {11, -19}}), Rectangle(origin = {185, 29}, rotation = 90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-5, 65}, {5, -15}}), Rectangle(origin = {185, -91}, rotation = 90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-5, 65}, {5, -15}}), Rectangle(origin = {185, -127}, rotation = 90, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-5, 65}, {5, -15}}), Polygon(origin = {160, 147}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-40, -73}, {40, -73}, {40, 73}, {-20, 73}, {-20, 41}, {-10, 33}, {-10, 65}, {32, 65}, {32, -65}, {-40, -65}, {-40, -73}}), Polygon(origin = {171, 216}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, points = {{-15, 10}, {15, -10}, {15, 10}, {-15, -10}, {-15, 10}})}, coordinateSystem(extent = {{-200, -300}, {200, 300}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-100, -300}, {100, 200}})),
    __OpenModelica_commandLineOptions = "");
end ThreePVerticalHRSG_pattern;
