within TPPSim.Boilers;

model ThreePVerticalHRSG
  extends TPPSim.Boilers.BaseClases.Icons.Icon3pVerticalHRSG;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  outer Modelica.Fluid.System system;
  TPPSim.HRSG_HeatExch.GFHE_simple condHE(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.215e-3, z1 = 58, z2 = 8, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.012, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Drums.Drum LP_drum(Din = 1.718, Hw_start = 0.5, L = 9, delta = 0.02) annotation(
    Placement(visible = true, transformation(origin = {22, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.SteamPipe LP_pipe(Din = 0.3, delta = 0.01, Lpipe = 10, DynamicMomentum = true) annotation(
    Placement(visible = true, transformation(origin = {40, 76}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Pumps.simplePump LP_circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {5, 73}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.3, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {40, -52}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.012, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -72}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.215e-3, z1 = 58, z2 = 8, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -32}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Drums.Drum HP_drum(Din = 1.718, Hw_start = 0.5, L = 9, delta = 0.02) annotation(
    Placement(visible = true, transformation(origin = {22, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE HP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, z1 = 58, z2 = 6, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -52}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Pumps.simplePump HP_circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {7, -47}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.012, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Pipes.SteamPipe IP_pipe(Din = 0.3, delta = 0.01, Lpipe = 10, DynamicMomentum = true) annotation(
    Placement(visible = true, transformation(origin = {38, 16}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Drums.Drum IP_drum(Din = 1.718, Hw_start = 0.5, L = 9, delta = 0.02) annotation(
    Placement(visible = true, transformation(origin = {22, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE IP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, z1 = 58, z2 = 6, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Pumps.simplePump IP_circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {7, 13}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple IP_ECO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.215e-3, z1 = 58, z2 = 8, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE LP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, z1 = 58, z2 = 6, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple RH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.012, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -98}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-18, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Обратный клапан
  Modelica.Fluid.Valves.ValveCompressible checkValve(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, checkValve = true, dp_nominal = 100000, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {-40, -44}, extent = {{4, -4}, {-4, 4}}, rotation = 90)));
  //Регуляторы
  TPPSim.Controls.LC LP_LC(DFmax = 57, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {70, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.LC HP_LC(DFmax = 46, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {70, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.LC IP_LC(DFmax = 11, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {70, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-18, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -224}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a condIn(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-202, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b LP_steamOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b HP_steamOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a IP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a HP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b FW_out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-154, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.simpleValve HP_FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {1, -25}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Valves.simpleValve IP_FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {3, 37}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Valves.simpleValve LP_FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {5, 99}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b RH_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a RH_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant checkValve_const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-53, -43}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Pipes.SteamPipe IP_pipe2(Din = 0.3, delta = 0.01, Lpipe = 10, DynamicMomentum = false) annotation(
    Placement(visible = true, transformation(origin = {-40, -30}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Fluid.Valves.ValveCompressible valve_vent(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, checkValve = true, dp_nominal = 100000, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {-48, 18}, extent = {{-4, -4}, {4, 4}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const_vent(k = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-65, 17}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary vent(redeclare package Medium = Medium_F, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-48, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(HP_SH.gasIn, RH.gasOut) annotation(
    Line(points = {{-18, -76}, {-18, -76}, {-18, -92}, {-18, -92}}, color = {0, 127, 255}));
  connect(HP_SH.gasOut, HP_EVO.gasIn) annotation(
    Line(points = {{-18, -67}, {-18, -47}, {-19, -47}, {-19, -55}, {-18.5, -55}, {-18.5, -57}, {-18, -57}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, HP_SH.flowIn) annotation(
    Line(points = {{40, -56.84}, {40, -64.84}, {-8, -64.84}, {-8, -68}}, color = {0, 127, 255}));
  connect(HP_SH.flowOut, HP_steamOut) annotation(
    Line(points = {{-8, -76}, {100, -76}}, color = {0, 127, 255}));
  connect(RH.gasIn, gasIn) annotation(
    Line(points = {{-18, -102}, {-18, -102}, {-18, -120}, {-18, -120}}, color = {0, 127, 255}));
  connect(RH.flowOut, RH_Out) annotation(
    Line(points = {{-8, -102}, {100, -102}}, color = {0, 127, 255}));
  connect(checkValve.port_b, RH.flowIn) annotation(
    Line(points = {{-40, -48}, {-40, -48}, {-40, -88}, {-8, -88}, {-8, -94}, {-8, -94}}, color = {0, 127, 255}));
  connect(RH.flowIn, RH_In) annotation(
    Line(points = {{-8, -94}, {-8, -88}, {-100, -88}}, color = {0, 127, 255}));
  connect(valve_vent.port_b, vent.ports[1]) annotation(
    Line(points = {{-48, 22}, {-48, 100}}, color = {0, 127, 255}));
  connect(const_vent.y, valve_vent.opening) annotation(
    Line(points = {{-59.5, 17}, {-55.5, 17}, {-55.5, 17}, {-51.5, 17}, {-51.5, 17}, {-51.5, 17}, {-51.5, 17}, {-51.5, 17}}, color = {0, 0, 127}));
  connect(IP_pipe2.waterOut, valve_vent.port_a) annotation(
    Line(points = {{-40, -34.84}, {-44, -34.84}, {-44, -32.84}, {-48, -32.84}, {-48, 13.16}, {-48, 13.16}, {-48, 13.16}, {-48, 13.16}}, color = {0, 127, 255}));
  connect(IP_SH.flowOut, IP_pipe2.waterIn) annotation(
    Line(points = {{-8, -16}, {-8, -16}, {-8, -14}, {-8, -14}, {-8, -18}, {-40, -18}, {-40, -24}, {-40, -24}, {-40, -26}, {-40, -26}}, color = {0, 127, 255}));
  connect(IP_pipe2.waterOut, checkValve.port_a) annotation(
    Line(points = {{-40, -34.84}, {-40, -34.84}, {-40, -34.84}, {-40, -34.84}, {-40, -38.84}, {-40, -38.84}, {-40, -40.84}, {-40, -40.84}}, color = {0, 127, 255}));
  connect(checkValve_const.y, checkValve.opening) annotation(
    Line(points = {{-47.5, -43}, {-45.5, -43}, {-45.5, -43}, {-43.5, -43}, {-43.5, -43}, {-43.5, -43}, {-43.5, -45}, {-43.5, -45}}, color = {0, 0, 127}));
  connect(condHE.flowOut, LP_FWCV.flowIn) annotation(
    Line(points = {{-8, 84}, {-6, 84}, {-6, 86}, {-4, 86}, {-4, 100}, {0, 100}, {0, 100}}, color = {0, 127, 255}));
  connect(LP_FWCV.flowOut, LP_drum.fedWater) annotation(
    Line(points = {{10, 99}, {13, 99}, {13, 99}, {16, 99}, {16, 97}, {16, 97}, {16, 97}, {16, 97}}, color = {0, 127, 255}));
  connect(LP_LC.y, LP_FWCV.D_flow_in) annotation(
    Line(points = {{81, 88}, {83, 88}, {83, 90}, {87, 90}, {87, 106}, {5, 106}, {5, 102}, {4, 102}, {4, 100}, {5, 100}}, color = {0, 0, 127}));
  connect(IP_ECO.flowOut, IP_FWCV.flowIn) annotation(
    Line(points = {{-8, 24}, {-6, 24}, {-6, 36}, {-2, 36}, {-2, 38}}, color = {0, 127, 255}));
  connect(IP_FWCV.flowOut, IP_drum.fedWater) annotation(
    Line(points = {{8, 37}, {12, 37}, {12, 39}, {16, 39}, {16, 37}, {16, 37}, {16, 37}, {16, 37}}, color = {0, 127, 255}));
  connect(IP_LC.y, IP_FWCV.D_flow_in) annotation(
    Line(points = {{81, 28}, {89, 28}, {89, 42}, {3, 42}, {3, 40}, {2, 40}, {2, 38}, {3, 38}}, color = {0, 0, 127}));
  connect(HP_LC.y, HP_FWCV.D_flow_in) annotation(
    Line(points = {{81, -32}, {89, -32}, {89, -18}, {3, -18}, {3, -24}, {0, -24}}, color = {0, 0, 127}));
  connect(HP_FWCV.flowOut, HP_drum.fedWater) annotation(
    Line(points = {{6, -25}, {8, -25}, {8, -23}, {10, -23}, {10, -20}, {14, -20}, {14, -22}, {16, -22}}, color = {0, 127, 255}));
  connect(HP_FWCV.flowIn, HP_ECO.flowOut) annotation(
    Line(points = {{-4, -25}, {-4, -34}, {-6, -34}, {-6, -36}, {-8, -36}}, color = {0, 127, 255}));
  connect(IP_drum.waterLevel, IP_LC.u) annotation(
    Line(points = {{33, 35}, {42, 35}, {42, 35}, {51, 35}, {51, 27}, {59, 27}, {59, 27}, {57, 27}, {57, 27}}, color = {0, 0, 127}));
  connect(HP_drum.waterLevel, HP_LC.u) annotation(
    Line(points = {{33, -25}, {41, -25}, {41, -23}, {51, -23}, {51, -33}, {59, -33}, {59, -33}, {57, -33}, {57, -33}}, color = {0, 0, 127}));
  connect(LP_drum.waterLevel, LP_LC.u) annotation(
    Line(points = {{33, 95}, {41, 95}, {41, 97}, {51, 97}, {51, 89}, {53, 89}, {53, 87}, {57, 87}}, color = {0, 0, 127}));
  connect(condHE.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-18, 93}, {-18, 93}, {-18, 93}, {-18, 93}, {-18, 101}, {-18, 101}, {-18, 99}, {-18, 99}}, color = {0, 127, 255}));
  connect(LP_drum.upStr, LP_EVO.flowOut) annotation(
    Line(points = {{29, 79}, {28.5, 79}, {28.5, 81}, {28, 81}, {28, 64}, {-8, 64}}, color = {0, 127, 255}));
  connect(LP_circPump.port_b, LP_EVO.flowIn) annotation(
    Line(points = {{0, 73}, {-1, 73}, {-1, 75}, {-2, 75}, {-2, 72}, {-8, 72}}, color = {0, 127, 255}));
  connect(LP_SH.gasOut, LP_EVO.gasIn) annotation(
    Line(points = {{-18, 53}, {-18, 53}, {-18, 53}, {-18, 53}, {-18, 63}, {-18, 63}, {-18, 63}, {-18, 63}}, color = {0, 127, 255}));
  connect(LP_EVO.gasOut, condHE.gasIn) annotation(
    Line(points = {{-18, 73}, {-18, 73}, {-18, 75}, {-18, 75}, {-18, 85}, {-18, 85}, {-18, 83}, {-18, 83}}, color = {0, 127, 255}));
  connect(IP_EVO.gasOut, IP_ECO.gasIn) annotation(
    Line(points = {{-18, 13}, {-18, 13}, {-18, 13}, {-18, 13}, {-18, 23}, {-18, 23}, {-18, 23}, {-18, 23}}, color = {0, 127, 255}));
  connect(IP_ECO.gasOut, LP_SH.gasIn) annotation(
    Line(points = {{-18, 33}, {-18, 33}, {-18, 35}, {-18, 35}, {-18, 43}, {-18, 43}, {-18, 43}, {-18, 43}}, color = {0, 127, 255}));
  connect(IP_ECO.flowIn, IP_FW_In) annotation(
    Line(points = {{-8, 32}, {-8, 32}, {-8, 38}, {-100, 38}, {-100, 38}}, color = {0, 127, 255}));
  connect(IP_drum.downStr, IP_circPump.port_a) annotation(
    Line(points = {{15, 19}, {14, 19}, {14, 13}, {12, 13}}, color = {0, 127, 255}));
  connect(IP_circPump.port_b, IP_EVO.flowIn) annotation(
    Line(points = {{2, 13}, {1, 13}, {1, 15}, {0, 15}, {0, 14}, {-4, 14}, {-4, 12}, {-8, 12}}, color = {0, 127, 255}));
  connect(IP_EVO.flowOut, IP_drum.upStr) annotation(
    Line(points = {{-8, 4}, {-4, 4}, {-4, 2}, {28, 2}, {28, 17}, {28.5, 17}, {28.5, 19}, {29, 19}}, color = {0, 127, 255}));
  connect(IP_SH.gasOut, IP_EVO.gasIn) annotation(
    Line(points = {{-18, -7}, {-18, 3}}, color = {0, 127, 255}));
  connect(IP_drum.steam, IP_pipe.waterIn) annotation(
    Line(points = {{29, 37}, {34, 37}, {34, 37}, {39, 37}, {39, 21}, {37, 21}, {37, 19}, {37, 19}}, color = {0, 127, 255}));
  connect(IP_pipe.waterOut, IP_SH.flowIn) annotation(
    Line(points = {{38, 11.16}, {38, 11.16}, {38, 11.16}, {38, 11.16}, {38, -6.84}, {-8, -6.84}, {-8, -8.84}}, color = {0, 127, 255}));
  connect(HP_ECO.gasOut, IP_SH.gasIn) annotation(
    Line(points = {{-18, -27}, {-18, -17}}, color = {0, 127, 255}));
  connect(HP_drum.downStr, HP_circPump.port_a) annotation(
    Line(points = {{15, -41}, {14.5, -41}, {14.5, -45}, {13.25, -45}, {13.25, -47}, {12, -47}}, color = {0, 127, 255}));
  connect(HP_circPump.port_b, HP_EVO.flowIn) annotation(
    Line(points = {{2, -47}, {0, -47}, {0, -46}, {-4, -46}, {-4, -48}, {-8, -48}}, color = {0, 127, 255}));
  connect(HP_EVO.gasOut, HP_ECO.gasIn) annotation(
    Line(points = {{-18, -47}, {-18, -37}}, color = {0, 127, 255}));
  connect(HP_EVO.flowOut, HP_drum.upStr) annotation(
    Line(points = {{-8, -56}, {-4, -56}, {-4, -64}, {28, -64}, {28, -41}, {29, -41}}, color = {0, 127, 255}));
  connect(HP_drum.steam, HP_pipe.waterIn) annotation(
    Line(points = {{29, -23}, {34.5, -23}, {34.5, -21}, {40, -21}, {40, -48}}, color = {0, 127, 255}));
  connect(HP_ECO.flowIn, HP_FW_In) annotation(
    Line(points = {{-8, -28}, {-8, -28}, {-8, -20}, {-100, -20}, {-100, -22}}, color = {0, 127, 255}));
  connect(LP_drum.downStr, LP_circPump.port_a) annotation(
    Line(points = {{15, 79}, {14.5, 79}, {14.5, 81}, {14, 81}, {14, 75}, {12, 75}, {12, 73}, {10, 73}}, color = {0, 127, 255}));
  connect(LP_pipe.waterOut, LP_SH.flowIn) annotation(
    Line(points = {{40, 71.16}, {40, 54.16}, {16, 54.16}, {16, 52.16}, {-8, 52.16}}, color = {0, 127, 255}));
  connect(LP_drum.steam, LP_pipe.waterIn) annotation(
    Line(points = {{29, 97}, {34.5, 97}, {34.5, 99}, {40, 99}, {40, 81}}, color = {0, 127, 255}));
  connect(LP_drum.HPFW, FW_out) annotation(
    Line(points = {{11.6, 83}, {6.6, 83}, {6.6, 85}, {1.6, 85}, {1.6, 79}, {-100.4, 79}, {-100.4, 77}}, color = {0, 127, 255}));
  connect(LP_SH.flowOut, LP_steamOut) annotation(
    Line(points = {{-8, 44}, {100, 44}}, color = {0, 127, 255}));
  connect(condHE.flowIn, condIn) annotation(
    Line(points = {{-8, 92}, {-8, 92}, {-8, 94}, {-8, 94}, {-8, 98}, {-100, 98}, {-100, 96}}, color = {0, 127, 255}));
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
    Diagram(coordinateSystem(extent = {{-100, -120}, {100, 120}})),
    __OpenModelica_commandLineOptions = "");
end ThreePVerticalHRSG;
