within TPPSim.Boilers;

model EMA_028_HRSG "Котел-утилизатор ЭМА-028-КУ энергоблока ПГУ-410 Ново-Салаватской ТЭЦ"
  extends TPPSim.Boilers.BaseClases.Icons.Icon3pHorizontalHRSG;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  outer Modelica.Fluid.System system;
  //Контур ВД
  //Экономайзеры ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.29, delta = 3.404e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15.88e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 2.421e-3, z1 = 120, z2 = 10, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-4, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.ParallelGFHE_simple parallel_ECO(redeclare package Medium_F = Medium_F, redeclare package Medium_G = Medium_G, Din_1 = 38.1e-3, Din_2 = 38.1e-3, HRSG_type_set_1 = TPPSim.Choices.HRSG_type.horizontalBottom, HRSG_type_set_2 = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe_1 = 18.29, Lpipe_2 = 18.29, delta_1 = 3.404e-3, delta_2 = 2.108e-3, delta_fin_1 = 0.9906e-3, delta_fin_2 = 0.9906e-3, flowEnergyDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowEnergyDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMassDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin_1 = 15.88e-3, hfin_2 = 15.88e-3, metalDynamics_1 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, metalDynamics_2 = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes_1 = 2, numberOfVolumes_2 = 2, s1_1 = 89.93e-3, s1_2 = 85.05e-3, s2_1 = 111.1e-3, s2_2 = 111.1e-3, sfin_1 = 2.67e-3, sfin_2 = 3.156e-3, z1_1 = 98, z1_2 = 22, z2_1 = 10, z2_2 = 8, zahod_1 = 1, zahod_2 = 1) annotation(
    Placement(visible = true, transformation(origin = {90, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //Испаритель ВД
  TPPSim.HRSG_HeatExch.GFHE_EVO HP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.29, circ_type_set = TPPSim.Choices.circ_type.forced, delta = 3.404e-3, delta_fin = 0.9906e-3, dp_circ(displayUnit = "bar") = fill(1e5, 16), flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flow_circ = fill(15, 16), gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15.88e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, s1 = 85.15e-3, s2 = 111.1e-3, sfin = 2.921e-3, start_flow_circ = 1, z1 = 126, z2 = 16, zahod = 16) annotation(
    Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //Пароперегреватели ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 2.667e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12.7e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 4.526e-3, z1 = 120, z2 = 3, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-70, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 3.048e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12.7e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 5.412e-3, z1 = 120, z2 = 6, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-110, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 4.775e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12.7e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 4.48e-3, z1 = 120, z2 = 6, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-150, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //Контур СД
  //Промежуточный пароперегреватель
  TPPSim.HRSG_HeatExch.GFHE_simple RH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 50.8e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 2.667e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12.7e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 3.235e-3, z1 = 120, z2 = 2, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-170, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple RH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 50.8e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 2.667e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12.7e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 4.677e-3, z1 = 120, z2 = 3, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-130, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple RH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 50.8e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 2.667e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12.7e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 3.123e-3, z1 = 120, z2 = 1, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-90, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //Пароперегреватель СД
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 2.108e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12.7e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 3.195e-3, z1 = 120, z2 = 2, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {18, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 2.108e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12.7e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 9.017e-3, z1 = 120, z2 = 2, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-24, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //Испаритель СД
  TPPSim.HRSG_HeatExch.GFHE_EVO IP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.29, circ_type_set = TPPSim.Choices.circ_type.forced, delta = 2.108e-3, delta_fin = 0.9906e-3, dp_circ(displayUnit = "bar") = fill(1e5, 10), flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flow_circ = fill(15, 10), gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15.88e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 3.156e-3, start_flow_circ = 1, z1 = 120, z2 = 10, zahod = 10) annotation(
    Placement(visible = true, transformation(origin = {44, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //  TPPSim.HRSG_HeatExch.GFHE_simple IP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.29, delta = 2.108e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15.88e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 3.156e-3, z1 = 120, z2 = 10, zahod = 10) annotation(
  //    Placement(visible = true, transformation(origin = {44, -30}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  //Барабаны
  TPPSim.Drums.Drum HP_drum(Din = 1.6, Hw_start = 0.34, L = 14.05, delta = 0.0105) annotation(
    Placement(visible = true, transformation(origin = {-50, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Drums.Drum IP_drum(Din = 1.4, Hw_start = 0.4, L = 13.1, delta = 30e-3) annotation(
    Placement(visible = true, transformation(origin = {44, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Drums.Drum LP_drum(Din = 1.4, Hw_start = 0.48, L = 13.1, delta = 16e-3, m_flow_small = 2 * system.m_flow_small) annotation(
    Placement(visible = true, transformation(origin = {134, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //Контур НД
  //Пароперегреватель НД
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 50.8e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 2.667e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12.7e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 88.29e-3, s2 = 111.1e-3, sfin = 2.424e-3, z1 = 122, z2 = 1, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {110, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 50.8e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 2.667e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12.7e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 88.29e-3, s2 = 111.1e-3, sfin = 10.25e-3, z1 = 122, z2 = 1, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {70, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //Испаритель НД
  TPPSim.HRSG_HeatExch.GFHE_EVO LP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.29, circ_type_set = TPPSim.Choices.circ_type.forced, delta = 2.108e-3, delta_fin = 0.9906e-3, dp_circ(displayUnit = "bar") = fill(1e5, 10), flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flow_circ = fill(15, 10), gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15.88e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 2.815e-3, start_flow_circ = 1, z1 = 120, z2 = 10, zahod = 10) annotation(
    Placement(visible = true, transformation(origin = {134, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //  TPPSim.HRSG_HeatExch.GFHE_simple LP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.29, delta = 2.108e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15.88e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 2.815e-3, z1 = 120, z2 = 10, zahod = 10) annotation(
  //    Placement(visible = true, transformation(origin = {134, -30}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  //ГПК
  TPPSim.HRSG_HeatExch.GFHE_simple cond_HE(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.29, delta = 2.108e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15.88e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 2.728e-3, z1 = 120, z2 = 12, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {164, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //Трубопроводы (вода)
  TPPSim.Pipes.ComplexPipe HP_downPipe(redeclare TPPSim.Pipes.ElementaryPipe Pipe, Din = 0.3, Lpiezo = -18.29, Lpipe = 18.29, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-36, -30}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Pipes.ComplexPipe IP_downPipe(redeclare TPPSim.Pipes.ElementaryPipe Pipe, Din = 0.3, Lpiezo = -18.29, Lpipe = 18.29, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {58, -30}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Pipes.ComplexPipe LP_downPipe(redeclare TPPSim.Pipes.ElementaryPipe Pipe, Din = 0.3, Lpiezo = -18.29, Lpipe = 18.29, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {148, -30}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //Паропроводы
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-66, -10}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Pipes.ComplexPipe IP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 4, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {22, -10}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Pipes.ComplexPipe IP_pipe_2(Din = 0.25, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-38, 42}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  TPPSim.Pipes.ComplexPipe LP_pipe(Din = 0.2, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 4, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {114, -10}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //Регуляторы уровня
  TPPSim.Controls.LC HP_LC(DFmax = 95, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {-15, 9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Controls.LC IP_LC(DFmax = 20, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {59, 11}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Controls.LC LP_LC(DFmax = 140, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {157, 9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //РПК
  TPPSim.Valves.simpleValve HP_FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-15, -5}, extent = {{5, -5}, {-5, 5}}, rotation = -90)));
  TPPSim.Valves.simpleValve IP_FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {63, -9}, extent = {{5, -5}, {-5, 5}}, rotation = -90)));
  TPPSim.Valves.simpleValve LP_FWCV(redeclare package Medium = Medium_F, dp = 100000, m_flow_small = 2 * system.m_flow_small, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {161, -7}, extent = {{5, -5}, {-5, 5}}, rotation = -90)));
  //Клапан на продувке СД
  Modelica.Fluid.Valves.ValveCompressible vent_CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 2.98e+06, filteredOpening = true, m_flow_nominal = 17.83, p_nominal = 29.8e+05, rho_nominal = 11.44, riseTime = 600) annotation(
    Placement(visible = true, transformation(origin = {-28, 56}, extent = {{4, -4}, {-4, 4}}, rotation = -90)));
  //Обратный клапан на паропроводе СД
  Modelica.Fluid.Valves.ValveCompressible checkValve(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, checkValve = true, dp_nominal = 0.5e5, filteredOpening = true, m_flow_nominal = 17.83, p_nominal = 71e5, rho_nominal = 11.44, riseTime = 300) annotation(
    Placement(visible = true, transformation(origin = {-66, 42}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  //Атмосфера
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {190, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Fluid.Sources.FixedBoundary vent(redeclare package Medium = Medium_F, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-28, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-200, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-300, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a cond_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {200, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {150, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b HP_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-200, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-164, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a RH_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-200, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-136, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b RH_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-200, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-190, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b LP_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-200, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a HP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {200, -94}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b FW_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {200, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a IP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {200, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {72, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate IP_massFlowRate(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-31, 25}, extent = {{-5, 5}, {5, -5}}, rotation = 90)));
  TPPSim.Controls.vent_control vent_control1(event_value = 0.1, finish_out = 0, start_out = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-12, 56}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  //  TPPSim.Pumps.simplePump circulation_IP(redeclare package Medium = Medium_F, setD_flow = 150)  annotation(
  //    Placement(visible = true, transformation(origin = {52, -48}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  //  TPPSim.Pumps.simplePump circulation_LP(redeclare package Medium = Medium_F, setD_flow = 150)  annotation(
  //    Placement(visible = true, transformation(origin = {142, -48}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.RelativePressure relativePressure1(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-64, 30}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  TPPSim.Controls.vent_control checkValve_control(event_value = 1e5, finish_out = 1, start_out = 0)  annotation(
    Placement(visible = true, transformation(origin = {-74, 56}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
equation
  connect(checkValve_control.y, checkValve.opening) annotation(
    Line(points = {{-68, 56}, {-66, 56}, {-66, 46}, {-66, 46}}, color = {0, 0, 127}));
  connect(relativePressure1.p_rel, checkValve_control.u) annotation(
    Line(points = {{-64, 26}, {-82, 26}, {-82, 56}, {-82, 56}}, color = {0, 0, 127}));
  connect(relativePressure1.port_a, IP_pipe_2.waterOut) annotation(
    Line(points = {{-60, 30}, {-43, 30}, {-43, 42}}, color = {0, 127, 255}));
  connect(IP_pipe_2.waterOut, checkValve.port_a) annotation(
    Line(points = {{-43, 42}, {-62, 42}}, color = {0, 127, 255}));
  connect(IP_pipe_2.waterOut, vent_CV.port_a) annotation(
    Line(points = {{-43, 42}, {-46, 42}, {-46, 48}, {-28, 48}, {-28, 52}}, color = {0, 127, 255}));
  connect(IP_massFlowRate.port_b, IP_pipe_2.waterIn) annotation(
    Line(points = {{-31, 30}, {-31, 42}, {-33, 42}}, color = {0, 127, 255}));
  connect(relativePressure1.port_b, RH_1.flowIn) annotation(
    Line(points = {{-68, 30}, {-86, 30}, {-86, -20}}, color = {0, 127, 255}));
//  connect(circulation_LP.port_b, LP_EVO.flowIn) annotation(
//    Line(points = {{138, -48}, {136, -48}, {136, -42}, {142, -42}, {142, -20}, {138, -20}, {138, -20}}, color = {0, 127, 255}));
//  connect(LP_downPipe.waterOut, circulation_LP.port_a) annotation(
//    Line(points = {{148, -34}, {148, -34}, {148, -48}, {146, -48}, {146, -48}}, color = {0, 127, 255}));
//  connect(circulation_IP.port_b, IP_EVO.flowIn) annotation(
//    Line(points = {{48, -48}, {46, -48}, {46, -42}, {52, -42}, {52, -20}, {48, -20}, {48, -20}}, color = {0, 127, 255}));
//  connect(IP_downPipe.waterOut, circulation_IP.port_a) annotation(
//    Line(points = {{58, -34}, {58, -34}, {58, -48}, {56, -48}, {56, -48}}, color = {0, 127, 255}));
  connect(vent_control1.y, vent_CV.opening) annotation(
    Line(points = {{-19, 56}, {-24, 56}}, color = {0, 0, 127}));
  connect(IP_massFlowRate.m_flow, vent_control1.u) annotation(
    Line(points = {{-25.5, 25}, {-12, 25}, {-12, 42}, {0, 42}, {0, 56}, {-5, 56}}, color = {0, 0, 127}));
  connect(IP_SH_2.flowOut, IP_massFlowRate.port_a) annotation(
    Line(points = {{-28, -20}, {-28, 1}, {-31, 1}, {-31, 20}}, color = {0, 127, 255}));
  connect(vent_CV.port_b, vent.ports[1]) annotation(
    Line(points = {{-28, 60}, {-28, 60}, {-28, 80}, {-28, 80}}, color = {0, 127, 255}));
  connect(LP_drum.waterLevel, LP_LC.u) annotation(
    Line(points = {{124, -2}, {116, -2}, {116, 9}, {151, 9}}, color = {0, 0, 127}));
  connect(LP_LC.y, LP_FWCV.D_flow_in) annotation(
    Line(points = {{162.5, 9}, {166, 9}, {166, -6}, {162, -6}, {162, -7}}, color = {0, 0, 127}));
  connect(IP_drum.waterLevel, IP_LC.u) annotation(
    Line(points = {{33, -3}, {29, -3}, {29, -1}, {23, -1}, {23, 11}, {53, 11}}, color = {0, 0, 127}));
  connect(IP_LC.y, IP_FWCV.D_flow_in) annotation(
    Line(points = {{64.5, 11}, {69, 11}, {69, -8}, {63, -8}}, color = {0, 0, 127}));
  connect(HP_drum.waterLevel, HP_LC.u) annotation(
    Line(points = {{-61, -3}, {-75, -3}, {-75, 9}, {-21, 9}}, color = {0, 0, 127}));
  connect(HP_FWCV.D_flow_in, HP_LC.y) annotation(
    Line(points = {{-14, -5}, {-8, -5}, {-8, -3}, {-2, -3}, {-2, 9}, {-9.5, 9}}, color = {0, 0, 127}));
//  connect(IP_EVO.flowOut, IP_drum.upStr) annotation(
//    Line(points = {{44, -20}, {38, -20}, {38, -18}}, color = {0, 127, 255}));
  connect(IP_EVO.gasIn, IP_SH_1.gasOut) annotation(
    Line(points = {{39, -30}, {25, -30}}, color = {0, 127, 255}));
  connect(LP_SH_2.gasIn, IP_EVO.gasOut) annotation(
    Line(points = {{66, -30}, {49, -30}}, color = {0, 127, 255}));
//  connect(LP_EVO.flowOut, LP_drum.upStr) annotation(
//    Line(points = {{134, -20}, {128, -20}, {128, -18}}, color = {0, 127, 255}));
  connect(cond_HE.gasIn, LP_EVO.gasOut) annotation(
    Line(points = {{160, -30}, {139, -30}}, color = {0, 127, 255}));
  connect(LP_EVO.gasIn, LP_SH_1.gasOut) annotation(
    Line(points = {{129, -30}, {116, -30}}, color = {0, 127, 255}));
  connect(LP_SH_2.flowOut, LP_Out) annotation(
    Line(points = {{66, -20}, {66, -20}, {66, -16}, {72, -16}, {72, 66}, {-200, 66}, {-200, 66}}, color = {0, 127, 255}));
  connect(LP_SH_1.flowOut, LP_SH_2.flowIn) annotation(
    Line(points = {{106, -20}, {106, -20}, {106, -12}, {74, -12}, {74, -20}, {74, -20}}, color = {0, 127, 255}));
  connect(parallel_ECO.gasIn, LP_SH_2.gasOut) annotation(
    Line(points = {{84, -30}, {76, -30}, {76, -30}, {76, -30}}, color = {0, 127, 255}));
  connect(IP_FWCV.flowOut, IP_drum.fedWater) annotation(
    Line(points = {{63, -4}, {61, -4}, {61, 4}, {49, 4}, {49, 0}, {51, 0}}, color = {0, 127, 255}));
  connect(parallel_ECO.flowOut_2, IP_FWCV.flowIn) annotation(
    Line(points = {{86, -40}, {86, -44}, {62, -44}, {62, -14}, {63, -14}}, color = {0, 127, 255}));
  connect(IP_pipe.waterOut, IP_SH_1.flowIn) annotation(
    Line(points = {{22, -14.84}, {22, -14.84}, {22, -12.84}, {22, -12.84}, {22, -18.84}, {22, -18.84}, {22, -20.84}, {22, -20.84}}, color = {0, 127, 255}));
  connect(IP_drum.steam, IP_pipe.waterIn) annotation(
    Line(points = {{37, -1}, {38, -1}, {38, 1}, {37, 1}, {37, 5}, {21, 5}, {21, -5}, {20, -5}, {20, -7}, {21, -7}}, color = {0, 127, 255}));
  connect(IP_drum.downStr, IP_downPipe.waterIn) annotation(
    Line(points = {{51, -19}, {54, -19}, {54, -17}, {57, -17}, {57, -25}, {58, -25}, {58, -27}, {57, -27}}, color = {0, 127, 255}));
  connect(IP_SH_1.flowOut, IP_SH_2.flowIn) annotation(
    Line(points = {{14, -20}, {14, -14}, {-20, -14}, {-20, -20}}, color = {0, 127, 255}));
  connect(IP_SH_1.gasIn, HP_ECO_2.gasOut) annotation(
    Line(points = {{13, -30}, {1, -30}}, color = {0, 127, 255}));
  connect(checkValve.port_b, RH_1.flowIn) annotation(
    Line(points = {{-70, 42}, {-86, 42}, {-86, -20}}, color = {0, 127, 255}));
  connect(IP_SH_2.gasIn, HP_EVO.gasOut) annotation(
    Line(points = {{-28, -30}, {-46, -30}, {-46, -30}, {-44, -30}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasIn, IP_SH_2.gasOut) annotation(
    Line(points = {{-8, -30}, {-20, -30}, {-20, -30}, {-18, -30}}, color = {0, 127, 255}));
  connect(HP_ECO_2.flowOut, HP_FWCV.flowIn) annotation(
    Line(points = {{-8, -20}, {-8, -16}, {-13, -16}, {-13, -13}, {-15, -13}, {-15, -10}}, color = {0, 127, 255}));
  connect(parallel_ECO.flowOut_1, HP_ECO_2.flowIn) annotation(
    Line(points = {{86, -20}, {86, 34}, {0, 34}, {0, -20}}, color = {0, 127, 255}));
  connect(HP_FW_In, parallel_ECO.flowIn_1) annotation(
    Line(points = {{200, -94}, {100, -94}, {100, -16}, {94, -16}, {94, -20}, {94, -20}}));
  connect(IP_FW_In, parallel_ECO.flowIn_2) annotation(
    Line(points = {{200, -76}, {94, -76}, {94, -40}, {94, -40}}));
  connect(LP_SH_1.gasIn, parallel_ECO.gasOut) annotation(
    Line(points = {{106, -30}, {94, -30}, {94, -30}, {96, -30}}, color = {0, 127, 255}));
  connect(HP_FWCV.flowOut, HP_drum.fedWater) annotation(
    Line(points = {{-15, 0}, {-23, 0}, {-23, 0}, {-29, 0}, {-29, 0}, {-43, 0}, {-43, 0}, {-42, 0}, {-42, 0}, {-41.5, 0}, {-41.5, 0}, {-43.25, 0}, {-43.25, 0}, {-43, 0}}, color = {0, 127, 255}));
  connect(HP_drum.steam, HP_pipe.waterIn) annotation(
    Line(points = {{-57, -1}, {-63, -1}, {-63, -1}, {-67, -1}, {-67, -7}, {-67, -7}, {-67, -7}, {-67, -7}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, HP_SH_1.flowIn) annotation(
    Line(points = {{-66, -14.84}, {-66, -20.84}}, color = {0, 127, 255}));
  connect(HP_drum.downStr, HP_downPipe.waterIn) annotation(
    Line(points = {{-43, -19}, {-43.625, -19}, {-43.625, -19}, {-42.25, -19}, {-42.25, -19}, {-41.5, -19}, {-41.5, -19}, {-40, -19}, {-40, -17}, {-37, -17}, {-37, -25}, {-36, -25}, {-36, -27}, {-36.5, -27}, {-36.5, -27}, {-36.75, -27}, {-36.75, -27}, {-37, -27}}, color = {0, 127, 255}));
  connect(RH_1.flowOut, RH_2.flowIn) annotation(
    Line(points = {{-94, -20}, {-95, -20}, {-95, -20}, {-94, -20}, {-94, -6}, {-126, -6}, {-126, -20}, {-127, -20}, {-127, -20}, {-126, -20}}, color = {0, 127, 255}));
  connect(RH_In, RH_1.flowIn) annotation(
    Line(points = {{-200, 38}, {-144, 38}, {-144, 38}, {-86, 38}, {-86, -20}, {-87, -20}, {-87, -20}, {-86, -20}}));
  connect(RH_1.gasIn, HP_SH_2.gasOut) annotation(
    Line(points = {{-95, -30}, {-107, -30}, {-107, -30}, {-106, -30}, {-106, -30}, {-105, -30}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasIn, RH_1.gasOut) annotation(
    Line(points = {{-75, -30}, {-87, -30}, {-87, -30}, {-85, -30}}, color = {0, 127, 255}));
  connect(RH_2.flowOut, RH_3.flowIn) annotation(
    Line(points = {{-134, -20}, {-135, -20}, {-135, -20}, {-134, -20}, {-134, -6}, {-166, -6}, {-166, -20}, {-167, -20}, {-167, -20}, {-166, -20}}, color = {0, 127, 255}));
  connect(RH_2.gasIn, HP_SH_3.gasOut) annotation(
    Line(points = {{-135, -30}, {-141, -30}, {-141, -30}, {-147, -30}, {-147, -30}, {-145, -30}}, color = {0, 127, 255}));
  connect(HP_SH_2.gasIn, RH_2.gasOut) annotation(
    Line(points = {{-115, -30}, {-125, -30}, {-125, -30}, {-125, -30}, {-125, -30}, {-125, -30}}, color = {0, 127, 255}));
  connect(RH_3.flowOut, RH_Out) annotation(
    Line(points = {{-174, -20}, {-174, -20}, {-174, -20}, {-174, -20}, {-174, -8}, {-200, -8}, {-200, -8}, {-200, -8}, {-200, -8}, {-200, -8}, {-200, -8}}, color = {0, 127, 255}));
  connect(RH_3.gasIn, gasIn) annotation(
    Line(points = {{-175, -30}, {-188, -30}, {-188, -30}, {-199, -30}, {-199, -30}, {-201, -30}, {-201, -30}, {-201, -30}}, color = {0, 127, 255}));
  connect(HP_SH_3.gasIn, RH_3.gasOut) annotation(
    Line(points = {{-155, -30}, {-161, -30}, {-161, -30}, {-165, -30}, {-165, -30}, {-166, -30}, {-166, -30}, {-165, -30}}, color = {0, 127, 255}));
  connect(HP_SH_3.flowOut, HP_Out) annotation(
    Line(points = {{-154, -20}, {-154, -11.5}, {-154, -11.5}, {-154, -3}, {-154, -3}, {-154, 14}, {-178, 14}, {-178, 14}, {-200, 14}}, color = {0, 127, 255}));
  connect(HP_SH_2.flowOut, HP_SH_3.flowIn) annotation(
    Line(points = {{-114, -20}, {-114, -18}, {-114, -18}, {-114, -16}, {-114, -16}, {-114, -12}, {-146, -12}, {-146, -16}, {-146, -16}, {-146, -18}, {-146, -18}, {-146, -20}}, color = {0, 127, 255}));
  connect(HP_SH_1.flowOut, HP_SH_2.flowIn) annotation(
    Line(points = {{-74, -20}, {-75, -20}, {-75, -20}, {-74, -20}, {-74, -12}, {-106, -12}, {-106, -20}, {-106, -20}, {-106, -20}, {-106, -20}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasOut, HP_EVO.gasIn) annotation(
    Line(points = {{-65, -30}, {-54, -30}}, color = {0, 127, 255}));
  connect(LP_drum.HPFW, FW_Out) annotation(
    Line(points = {{144, -14}, {154, -14}, {154, -58}, {200, -58}}, color = {0, 127, 255}));
  connect(LP_pipe.waterOut, LP_SH_1.flowIn) annotation(
    Line(points = {{114, -14}, {114, -14}, {114, -20}, {114, -20}}, color = {0, 127, 255}));
  connect(cond_HE.flowOut, LP_FWCV.flowIn) annotation(
    Line(points = {{160, -20}, {154.5, -20}, {154.5, -12}, {161, -12}}, color = {0, 127, 255}));
  connect(LP_FWCV.flowOut, LP_drum.fedWater) annotation(
    Line(points = {{161, -2}, {151.5, -2}, {151.5, 0}, {142, 0}}, color = {0, 127, 255}));
  connect(LP_drum.downStr, LP_downPipe.waterIn) annotation(
    Line(points = {{142, -18}, {148, -18}, {148, -26}, {148, -26}}, color = {0, 127, 255}));
  connect(LP_drum.steam, LP_pipe.waterIn) annotation(
    Line(points = {{128, 0}, {114, 0}, {114, -6}, {114, -6}}, color = {0, 127, 255}));
  connect(cond_In, cond_HE.flowIn) annotation(
    Line(points = {{200, 0}, {168, 0}, {168, -20}}));
  connect(cond_HE.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{169, -30}, {180, -30}}, color = {0, 127, 255}));
  for i in 1:16 loop
    connect(HP_downPipe.waterOut, HP_EVO.flowIn[i]);
    connect(HP_EVO.flowOut[i], HP_drum.upStr);
  end for;
  for i in 1:10 loop
    connect(IP_downPipe.waterOut, IP_EVO.flowIn[i]);
    connect(IP_EVO.flowOut[i], IP_drum.upStr);
  end for;
  for i in 1:10 loop
    connect(LP_downPipe.waterOut, LP_EVO.flowIn[i]);
    connect(LP_EVO.flowOut[i], LP_drum.upStr);
  end for;
  annotation(
    Documentation(info = "<html>
  <p>
  Модель КУ ЭМА-028-КУ, тип Еп-264/297/43-13.0/3.0/0.47-558/558/237-11.6вв.<br>
  Индексы в обозначении КУ означают следующее:<br><br>
  Еп - тип котла-утилизатора с естественной циркуляцией и промежуточным перегревом;<br>
  264 - паропроизводительность контура высокого давления (ВД), т/ч;<br>
  297 - паропроизводительность контура горячего промперегрева (ГПП), т/ч;<br>
  43 - паропроизводительность контура низкого давления (НД), т/ч;<br>
  13.0 - давление пара на выходе из контура высокого давления (абс.), МПа;<br>
  3.0 - давление пара на выходе из контура горячего промперегрева (абс.), МПа;<br>
  0.47 - давление пара на выходе из контура низкого давления (абс.), МПа;<br>
  558 - температура пара на выходе из контура высокого давления, С;<br>
  558 - температура пара на выходе из контура горячего промперегрева, С;<br>
  273 - температура пара на выходе из контура низкого давления, С;<br>
  11.6вв - максимальная тепловая мощность ВВТО, МВт;<br><br>
  Параметры указаны для номинальной нагрузки ГТУ при температуре наружного воздуха +15С, относитльеной влажности 60% и атмосферном давлении 1.013бар.
  </p>
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>October 11, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    __OpenModelica_commandLineOptions = "");
end EMA_028_HRSG;
