within TPPSim.Boilers;

model ThreePVerticalHRSG
  extends TPPSim.Boilers.BaseClases.Icons.Icon3pVerticalHRSG;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  outer Modelica.Fluid.System system;
  TPPSim.HRSG_HeatExch.GFHE_simple condHE(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flow_DynamicEnergyBalance = true, flow_DynamicMassBalance = false, flow_DynamicMomentum = false, flow_DynamicTm = true, gas_DynamicEnergyBalance = true, gas_DynamicMassBalance = true, hfin = 0.015, k_gamma_gas = 1, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.215e-3, z1 = 58, z2 = 8, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple LP_SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flow_DynamicEnergyBalance = true, flow_DynamicMassBalance = true, flow_DynamicMomentum = true, flow_DynamicTm = true, gas_DynamicEnergyBalance = true, gas_DynamicMassBalance = true, hfin = 0.012, k_gamma_gas = 1, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Drums.Drum LP_drum(Din = 1.718, Hw_start = 0.5, L = 9, delta = 0.02) annotation(
    Placement(visible = true, transformation(origin = {22, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.SteamPipe LP_pipe(Din = 0.3, delta = 0.01, Lpipe = 10, DynamicMomentum = true) annotation(
    Placement(visible = true, transformation(origin = {40, 58}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Pumps.simplePump LP_circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {5, 55}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Pipes.SteamPipe HP_pipe(Din = 0.3, delta = 0.01, Lpipe = 10, DynamicMomentum = true) annotation(
    Placement(visible = true, transformation(origin = {40, -70}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flow_DynamicEnergyBalance = true, flow_DynamicMassBalance = true, flow_DynamicMomentum = true, flow_DynamicTm = true, gas_DynamicEnergyBalance = true, gas_DynamicMassBalance = true, hfin = 0.012, k_gamma_gas = 1, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flow_DynamicEnergyBalance = true, flow_DynamicMassBalance = false, flow_DynamicMomentum = false, flow_DynamicTm = true, gas_DynamicEnergyBalance = true, gas_DynamicMassBalance = true, hfin = 0.015, k_gamma_gas = 1, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.215e-3, z1 = 58, z2 = 8, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Drums.Drum HP_drum(Din = 1.718, Hw_start = 0.5, L = 9, delta = 0.02) annotation(
    Placement(visible = true, transformation(origin = {22, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE HP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flow_DynamicEnergyBalance = true, flow_DynamicMassBalance = true, flow_DynamicMomentum = false, flow_DynamicTm = true, gas_DynamicEnergyBalance = true, gas_DynamicMassBalance = true, hfin = 0.015, k_gamma_gas = 1, numberOfTubeSections = 1, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, z1 = 58, z2 = 6, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Pumps.simplePump HP_circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {7, -65}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flow_DynamicEnergyBalance = true, flow_DynamicMassBalance = true, flow_DynamicMomentum = true, flow_DynamicTm = true, gas_DynamicEnergyBalance = true, gas_DynamicMassBalance = true, hfin = 0.012, k_gamma_gas = 1, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
//  TPPSim.Pipes.SteamPipe IP_pipe(Din = 0.3, delta = 0.01, Lpipe = 10, DynamicMomentum = true) annotation(
//    Placement(visible = true, transformation(origin = {40, 0}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Drums.Drum IP_drum(Din = 1.718, Hw_start = 0.5, L = 9, delta = 0.02) annotation(
    Placement(visible = true, transformation(origin = {22, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE IP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flow_DynamicEnergyBalance = true, flow_DynamicMassBalance = true, flow_DynamicMomentum = false, flow_DynamicTm = true, gas_DynamicEnergyBalance = true, gas_DynamicMassBalance = true, hfin = 0.015, k_gamma_gas = 1, numberOfTubeSections = 1, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, z1 = 58, z2 = 6, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Pumps.simplePump IP_circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {7, -5}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple IP_ECO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flow_DynamicEnergyBalance = true, flow_DynamicMassBalance = false, flow_DynamicMomentum = false, flow_DynamicTm = true, gas_DynamicEnergyBalance = true, gas_DynamicMassBalance = true, hfin = 0.015, k_gamma_gas = 1, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.215e-3, z1 = 58, z2 = 8, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE LP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flow_DynamicEnergyBalance = true, flow_DynamicMassBalance = true, flow_DynamicMomentum = false, flow_DynamicTm = true, gas_DynamicEnergyBalance = true, gas_DynamicMassBalance = true, hfin = 0.015, k_gamma_gas = 1, numberOfTubeSections = 1, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, z1 = 58, z2 = 6, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-18, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Обратный клапан
  Modelica.Blocks.Sources.Constant checkValve_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-53, -61}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible checkValve(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, checkValve = true, dp_nominal = 100000, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {-40, -62}, extent = {{4, -4}, {-4, 4}}, rotation = 90)));
  //Регуляторы
  TPPSim.Controls.LC LP_LC(DFmax = 57, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.LC HP_LC(DFmax = 46, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {70, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.LC IP_LC(DFmax = 11, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
//Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -224}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a condIn(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-202, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b LP_steamOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b HP_steamOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -94}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a IP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a HP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b FW_out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-154, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.simpleValve HP_FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true)  annotation(
    Placement(visible = true, transformation(origin = {1, -43}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Valves.simpleValve IP_FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true)  annotation(
    Placement(visible = true, transformation(origin = {3, 19}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Valves.simpleValve LP_FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {5, 81}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple RH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flow_DynamicEnergyBalance = true, flow_DynamicMassBalance = true, flow_DynamicMomentum = true, flow_DynamicTm = true, gas_DynamicEnergyBalance = true, gas_DynamicMassBalance = true, hfin = 0.012, k_gamma_gas = 1, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-70, -90}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Fluid.Interfaces.FluidPort_b RH_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a RH_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(IP_drum.steam, IP_SH.flowIn) annotation(
    Line(points = {{30, 20}, {38, 20}, {38, -26}, {-8, -26}, {-8, -26}}, color = {0, 127, 255}));
  connect(checkValve_const.y, checkValve.opening) annotation(
    Line(points = {{-48, -60}, {-44, -60}, {-44, -62}, {-44, -62}}, color = {0, 0, 127}));
  connect(checkValve.port_b, RH.flowIn) annotation(
    Line(points = {{-40, -66}, {-40, -66}, {-40, -94}, {-60, -94}, {-60, -94}}, color = {0, 127, 255}));
  connect(IP_SH.flowOut, checkValve.port_a) annotation(
    Line(points = {{-8, -34}, {-8, -34}, {-8, -38}, {-40, -38}, {-40, -58}, {-40, -58}}, color = {0, 127, 255}));
  connect(RH.flowOut, RH_Out) annotation(
    Line(points = {{-60, -86}, {-60, -86}, {-60, -20}, {100, -20}, {100, -20}}, color = {0, 127, 255}));
  connect(RH.flowIn, RH_In) annotation(
    Line(points = {{-60, -94}, {-60, -94}, {-60, -98}, {-86, -98}, {-86, -80}, {-100, -80}, {-100, -80}}, color = {0, 127, 255}));
  connect(RH.gasIn, gasIn) annotation(
    Line(points = {{-70, -84}, {-70, -84}, {-70, -70}, {-70, -70}}, color = {0, 127, 255}));
  connect(RH.gasOut, HP_SH.gasIn) annotation(
    Line(points = {{-70, -94}, {-70, -94}, {-70, -100}, {-18, -100}, {-18, -94}, {-18, -94}}, color = {0, 127, 255}));
  connect(LP_LC.y, LP_FWCV.D_flow_in) annotation(
    Line(points = {{82, 70}, {86, 70}, {86, 88}, {4, 88}, {4, 82}, {6, 82}}, color = {0, 0, 127}));
  connect(LP_FWCV.flowOut, LP_drum.fedWater) annotation(
    Line(points = {{10, 82}, {16, 82}, {16, 80}, {16, 80}}, color = {0, 127, 255}));
  connect(condHE.flowOut, LP_FWCV.flowIn) annotation(
    Line(points = {{-8, 66}, {-4, 66}, {-4, 80}, {0, 80}, {0, 82}}, color = {0, 127, 255}));
  connect(IP_LC.y, IP_FWCV.D_flow_in) annotation(
    Line(points = {{82, 10}, {88, 10}, {88, 24}, {2, 24}, {2, 20}, {4, 20}}, color = {0, 0, 127}));
  connect(IP_FWCV.flowOut, IP_drum.fedWater) annotation(
    Line(points = {{8, 20}, {16, 20}, {16, 20}, {16, 20}}, color = {0, 127, 255}));
  connect(IP_ECO.flowOut, IP_FWCV.flowIn) annotation(
    Line(points = {{-8, 6}, {-6, 6}, {-6, 18}, {-2, 18}, {-2, 20}}, color = {0, 127, 255}));
  connect(HP_FWCV.flowIn, HP_ECO.flowOut) annotation(
    Line(points = {{-4, -43}, {-4, -54}, {-8, -54}}, color = {0, 127, 255}));
  connect(HP_FWCV.flowOut, HP_drum.fedWater) annotation(
    Line(points = {{6, -43}, {10, -43}, {10, -38}, {14, -38}, {14, -40}, {16, -40}}, color = {0, 127, 255}));
  connect(HP_LC.y, HP_FWCV.D_flow_in) annotation(
    Line(points = {{82, -50}, {88, -50}, {88, -36}, {2, -36}, {2, -42}, {1, -42}}, color = {0, 0, 127}));
  connect(LP_drum.HPFW, FW_out) annotation(
    Line(points = {{12, 66}, {2, 66}, {2, 60}, {-100, 60}, {-100, 60}}, color = {0, 127, 255}));
  connect(HP_ECO.flowIn, HP_FW_In) annotation(
    Line(points = {{-8, -46}, {-8, -46}, {-8, -40}, {-100, -40}, {-100, -40}}, color = {0, 127, 255}));
  connect(IP_ECO.flowIn, IP_FW_In) annotation(
    Line(points = {{-8, 14}, {-8, 14}, {-8, 20}, {-100, 20}, {-100, 20}}, color = {0, 127, 255}));
  connect(condHE.flowIn, condIn) annotation(
    Line(points = {{-8, 74}, {-8, 74}, {-8, 78}, {-100, 78}, {-100, 78}}, color = {0, 127, 255}));
  connect(HP_drum.waterLevel, HP_LC.u) annotation(
    Line(points = {{34, -42}, {50, -42}, {50, -50}, {58, -50}, {58, -50}}, color = {0, 0, 127}));
  connect(IP_drum.waterLevel, IP_LC.u) annotation(
    Line(points = {{34, 18}, {50, 18}, {50, 10}, {58, 10}, {58, 10}}, color = {0, 0, 127}));
  connect(LP_drum.waterLevel, LP_LC.u) annotation(
    Line(points = {{34, 78}, {50, 78}, {50, 70}, {58, 70}}, color = {0, 0, 127}));
  connect(HP_SH.flowOut, HP_steamOut) annotation(
    Line(points = {{-8, -94}, {100, -94}}, color = {0, 127, 255}));
  connect(LP_SH.flowOut, LP_steamOut) annotation(
    Line(points = {{-8, 26}, {100, 26}}, color = {0, 127, 255}));
  connect(condHE.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-18, 76}, {-18, 76}, {-18, 82}, {-18, 82}}, color = {0, 127, 255}));
  connect(LP_EVO.gasOut, condHE.gasIn) annotation(
    Line(points = {{-18, 56}, {-18, 56}, {-18, 66}, {-18, 66}}, color = {0, 127, 255}));
  connect(LP_SH.gasOut, LP_EVO.gasIn) annotation(
    Line(points = {{-18, 36}, {-18, 36}, {-18, 46}, {-18, 46}}, color = {0, 127, 255}));
  connect(IP_ECO.gasOut, LP_SH.gasIn) annotation(
    Line(points = {{-18, 16}, {-18, 16}, {-18, 26}, {-18, 26}}, color = {0, 127, 255}));
  connect(IP_EVO.gasOut, IP_ECO.gasIn) annotation(
    Line(points = {{-18, -4}, {-18, -4}, {-18, 6}, {-18, 6}}, color = {0, 127, 255}));
  connect(IP_circPump.port_b, IP_EVO.flowIn) annotation(
    Line(points = {{2, -5}, {0, -5}, {0, -6}, {-8, -6}}, color = {0, 127, 255}));
  connect(IP_drum.downStr, IP_circPump.port_a) annotation(
    Line(points = {{15, 1}, {14, 1}, {14, -5}, {12, -5}}, color = {0, 127, 255}));
  connect(LP_drum.downStr, LP_circPump.port_a) annotation(
    Line(points = {{15, 61}, {14, 61}, {14, 55}, {10, 55}}, color = {0, 127, 255}));
  connect(LP_circPump.port_b, LP_EVO.flowIn) annotation(
    Line(points = {{0, 55}, {-2, 55}, {-2, 54}, {-8, 54}}, color = {0, 127, 255}));
  connect(HP_circPump.port_b, HP_EVO.flowIn) annotation(
    Line(points = {{2, -65}, {0, -65}, {0, -66}, {-8, -66}}, color = {0, 127, 255}));
  connect(HP_drum.downStr, HP_circPump.port_a) annotation(
    Line(points = {{15, -59}, {14.5, -59}, {14.5, -65}, {12, -65}}, color = {0, 127, 255}));
  connect(HP_drum.steam, HP_pipe.waterIn) annotation(
    Line(points = {{29, -41}, {40, -41}, {40, -66}}, color = {0, 127, 255}));
  connect(HP_EVO.flowOut, HP_drum.upStr) annotation(
    Line(points = {{-8, -74}, {-4, -74}, {-4, -82}, {28, -82}, {28, -59}, {29, -59}}, color = {0, 127, 255}));
  connect(LP_drum.upStr, LP_EVO.flowOut) annotation(
    Line(points = {{29, 61}, {28, 61}, {28, 46}, {-8, 46}}, color = {0, 127, 255}));
  connect(LP_drum.steam, LP_pipe.waterIn) annotation(
    Line(points = {{29, 79}, {40, 79}, {40, 63}}, color = {0, 127, 255}));
  connect(LP_pipe.waterOut, LP_SH.flowIn) annotation(
    Line(points = {{40, 53}, {40, 34}, {-8, 34}}, color = {0, 127, 255}));
  connect(IP_SH.gasOut, IP_EVO.gasIn) annotation(
    Line(points = {{-18, -25}, {-18, -15}}, color = {0, 127, 255}));
  connect(IP_EVO.flowOut, IP_drum.upStr) annotation(
    Line(points = {{-8, -14}, {-4, -14}, {-4, -16}, {28, -16}, {28, -1}, {28.5, -1}, {28.5, 1}, {29, 1}}, color = {0, 127, 255}));
  connect(HP_ECO.gasOut, IP_SH.gasIn) annotation(
    Line(points = {{-18, -45}, {-18, -35}}, color = {0, 127, 255}));
  connect(HP_EVO.gasOut, HP_ECO.gasIn) annotation(
    Line(points = {{-18, -65}, {-18, -55}}, color = {0, 127, 255}));
  connect(HP_SH.gasOut, HP_EVO.gasIn) annotation(
    Line(points = {{-18, -85}, {-18, -67}, {-19, -67}, {-19, -75}, {-18, -75}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, HP_SH.flowIn) annotation(
    Line(points = {{40, -74.84}, {40, -82.84}, {-8, -82.84}, {-8, -86}}, color = {0, 127, 255}));
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
    Icon(coordinateSystem(extent = {{-200, -300}, {200, 300}}, initialScale = 0.1), graphics = {Text(origin = {-153, 157}, lineColor = {0, 170, 255}, extent = {{-27, 23}, {33, -17}}, textString = "LP"), Text(origin = {61, 157}, lineColor = {0, 170, 255}, extent = {{-27, 23}, {33, -17}}, textString = "IP"), Text(origin = {127, 157}, lineColor = {0, 170, 255}, extent = {{-27, 23}, {33, -17}}, textString = "HP")}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    __OpenModelica_commandLineOptions = "");
end ThreePVerticalHRSG;
