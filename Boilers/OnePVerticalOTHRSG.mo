﻿within TPPSim.Boilers;

model OnePVerticalOTHRSG
  //  extends TPPSim.Boilers.BaseClases.Icons.Icon1pVerticalOTHRSG;
  //  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  //  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  //  outer Modelica.Fluid.System system;
  //  inner parameter Boolean SH_cold_start = true "Исходное состояние - холодное" annotation(
  //    Dialog(group = "Исходное состояние"));
  //  parameter Modelica.SIunits.AbsolutePressure HP_p_flow_start = system.p_ambient "Начальное давление пара в БВД" annotation(
  //    Dialog(group = "Контур ВД"));
  //  TPPSim.Pipes.ComplexPipe pipe(Din = 0.3, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, t_m_start = 373.15) annotation(
  //    Placement(visible = true, transformation(origin = {30, -4}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //  TPPSim.HRSG_HeatExch.GFHE_simple SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.012, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
  //    Placement(visible = true, transformation(origin = {-18, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //  TPPSim.HRSG_HeatExch.GFHE_simple ECO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.215e-3, z1 = 58, z2 = 8, zahod = 1) annotation(
  //    Placement(visible = true, transformation(origin = {-18, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //  TPPSim.HRSG_HeatExch.GFHE EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, z1 = 58, z2 = 6, zahod = 2) annotation(
  //    Placement(visible = true, transformation(origin = {-18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
  //    Placement(visible = true, transformation(origin = {-18, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //  //Обратный клапан
  //  //Регуляторы
  //  //Интерфейс
  //  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
  //    Placement(visible = true, transformation(origin = {-18, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -224}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  Modelica.Fluid.Interfaces.FluidPort_b steam(redeclare package Medium = Medium_F) annotation(
  //    Placement(visible = true, transformation(origin = {100, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {128, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  Modelica.Fluid.Interfaces.FluidPort_a FW_In(redeclare package Medium = Medium_F) annotation(
  //    Placement(visible = true, transformation(origin = {-100, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ////  TPPSim.Valves.simpleValve FWCV(redeclare package Medium = Medium_F, dp = 100000, m_flow_small = 0.0001, setD_flow = 30, use_D_flow_in = true) annotation(
  ////    Placement(visible = true, transformation(origin = {-37, 49}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //  TPPSim.Sensors.Temperature overheat_T(TemperatureType_set = TPPSim.Sensors.TemperatureType.overheating)  annotation(
  //    Placement(visible = true, transformation(origin = {44, 6}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  //  TPPSim.Controls.TC tc1(T_sprh = 60,yMax = 1, y_start = 0.3)  annotation(
  //    Placement(visible = true, transformation(origin = {26, 42}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  //  Modelica.Fluid.Sensors.Pressure pressure1(redeclare package Medium = Medium_F) annotation(
  //    Placement(visible = true, transformation(origin = {67, 7}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy(redeclare package Medium = Medium_F) annotation(
  //    Placement(visible = true, transformation(origin = {92, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  TPPSim.Drums.Separator separator1(redeclare package Medium = Medium_F, Din_down_pipe = 0.2, Din_sep = 0.5, H_down_pipe = 10, H_sep = 3, L_start = 7) annotation(
  //    Placement(visible = true, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  TPPSim.Pumps.simplePump sink_valve(redeclare package Medium = Medium_F, setD_flow = 0, use_D_flow_in = true) annotation(
  //    Placement(visible = true, transformation(origin = {34, -50}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  //  Modelica.Fluid.Sources.FixedBoundary sink(redeclare package Medium = Medium_F, nPorts = 1)  annotation(
  //    Placement(visible = true, transformation(origin = {90, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //  Modelica.Fluid.Sensors.Temperature t_g(redeclare package Medium = Medium_G) annotation(
  //    Placement(visible = true, transformation(origin = {4, -12}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  //  TPPSim.Controls.LC_sink lC_sink1(DFmax = 30, DFmin = 0, L = 7)  annotation(
  //    Placement(visible = true, transformation(origin = {45, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  //  TPPSim.Pumps.pressurePump FW_pump(redeclare package Medium = Medium_F, set_p = 6e+06, use_p_in = true)  annotation(
  //    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //  Modelica.Fluid.Valves.ValveIncompressible FWCV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 200, dp_nominal = 100000, filteredOpening = true, riseTime = 10)  annotation(
  //    Placement(visible = true, transformation(origin = {-31, 51}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  //  Modelica.Fluid.Sensors.Pressure pressure2(redeclare package Medium = Medium_F) annotation(
  //    Placement(visible = true, transformation(origin = {-7,77}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  //  Modelica.Blocks.Math.Add add1 annotation(
  //    Placement(visible = true, transformation(origin = {-49, 83}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  //  Modelica.Blocks.Sources.Constant const(k = 1e5)  annotation(
  //    Placement(visible = true, transformation(origin = {-90, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  Modelica.Blocks.Logical.Greater greater1 annotation(
  //    Placement(visible = true, transformation(origin = {58, 63}, extent = {{-8, -9}, {8, 9}}, rotation = 180)));
  //  Modelica.Blocks.Sources.Constant const2(k = 100 + 273.15)  annotation(
  //    Placement(visible = true, transformation(origin = {48, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //equation
  //  connect(tc1.y, FWCV.opening) annotation(
  //    Line(points = {{17, 42}, {10, 42}, {10, 68}, {-31, 68}, {-31, 57}}, color = {0, 0, 127}));
  //  connect(FW_pump.port_b, FWCV.port_a) annotation(
  //    Line(points = {{-60, 50}, {-53, 50}, {-53, 51}, {-38, 51}}, color = {0, 127, 255}));
  //  connect(FWCV.port_b, ECO.flowIn) annotation(
  //    Line(points = {{-24, 51}, {-2, 51}, {-2, 26}, {-8, 26}}, color = {0, 127, 255}));
  //  connect(FWCV.port_b, pressure2.port) annotation(
  //    Line(points = {{-24, 51}, {-7, 51}, {-7, 72}}, color = {0, 127, 255}));
  //  connect(greater1.y, tc1.on) annotation(
  //    Line(points = {{49, 63}, {44, 63}, {44, 47}, {36, 47}}, color = {255, 0, 255}));
  //  connect(t_g.T, greater1.u1) annotation(
  //    Line(points = {{6, -12}, {10, -12}, {10, 0}, {6, 0}, {6, 28}, {72, 28}, {72, 63}, {68, 63}}, color = {0, 0, 127}));
  //  connect(const2.y, greater1.u2) annotation(
  //    Line(points = {{60, 96}, {78, 96}, {78, 70}, {68, 70}}, color = {0, 0, 127}));
  //  connect(specificEnthalpy.h_out, tc1.h) annotation(
  //    Line(points = {{104, 14}, {102, 14}, {102, 42}, {36, 42}}, color = {0, 0, 127}));
  //  connect(pressure1.p, tc1.p) annotation(
  //    Line(points = {{72, 8}, {76, 8}, {76, 37}, {36, 37}}, color = {0, 0, 127}));
  //  connect(separator1.fedWater, overheat_T.port) annotation(
  //    Line(points = {{10, 8}, {10, 8}, {10, 18}, {38, 18}, {38, 6}, {44, 6}, {44, 6}}, color = {0, 127, 255}));
  //  connect(add1.y, FW_pump.p_in) annotation(
  //    Line(points = {{-56, 84}, {-70, 84}, {-70, 60}, {-70, 60}}, color = {0, 0, 127}));
  //  connect(const.y, add1.u1) annotation(
  //    Line(points = {{-78, 110}, {-36, 110}, {-36, 88}, {-40, 88}, {-40, 88}}, color = {0, 0, 127}));
  //  connect(pressure2.p, add1.u2) annotation(
  //    Line(points = {{-12, 78}, {-38, 78}, {-38, 79}, {-41, 79}}, color = {0, 0, 127}));
  //  connect(FW_In, FW_pump.port_a) annotation(
  //    Line(points = {{-100, 68}, {-92, 68}, {-92, 50}, {-80, 50}, {-80, 50}}));
  //  connect(lC_sink1.y, sink_valve.D_flow_in) annotation(
  //    Line(points = {{52, -14}, {58, -14}, {58, -38}, {34, -38}, {34, -44}, {34, -44}}, color = {0, 0, 127}));
  //  connect(separator1.level, lC_sink1.u) annotation(
  //    Line(points = {{22, 6}, {24, 6}, {24, -14}, {36, -14}, {36, -14}}, color = {0, 0, 127}));
  //  connect(separator1.steam, pipe.waterIn) annotation(
  //    Line(points = {{16, 12}, {30, 12}, {30, 0}, {30, 0}}, color = {0, 127, 255}));
  //  connect(specificEnthalpy.port, separator1.fedWater) annotation(
  //    Line(points = {{92, 4}, {80, 4}, {80, 18}, {10, 18}, {10, 8}, {10, 8}}, color = {0, 127, 255}));
  //  connect(EVO.flowOut, separator1.fedWater) annotation(
  //    Line(points = {{-8, -4}, {2, -4}, {2, 8}, {10, 8}, {10, 8}}, color = {0, 127, 255}));
  //  connect(separator1.downWater, sink_valve.port_a) annotation(
  //    Line(points = {{16, -10}, {16, -10}, {16, -50}, {28, -50}, {28, -50}}, color = {0, 127, 255}));
  //  connect(SH.gasOut, t_g.port) annotation(
  //    Line(points = {{-18, -20}, {-18, -20}, {-18, -16}, {4, -16}, {4, -16}}, color = {0, 127, 255}));
  //  connect(sink_valve.port_b, sink.ports[1]) annotation(
  //    Line(points = {{40, -50}, {80, -50}, {80, -50}, {80, -50}}, color = {0, 127, 255}));
  //  connect(pipe.waterIn, pressure1.port) annotation(
  //    Line(points = {{30, 0}, {68, 0}, {68, 2}, {68, 2}}, color = {0, 127, 255}));
  //  connect(pipe.waterOut, SH.flowIn) annotation(
  //    Line(points = {{30, -9}, {30, -22}, {-8, -22}}, color = {0, 127, 255}));
  //  connect(ECO.flowOut, EVO.flowIn) annotation(
  //    Line(points = {{-8, 18}, {-4, 18}, {-4, 4}, {-8, 4}, {-8, 4}}, color = {0, 127, 255}));
  //  connect(ECO.gasOut, gasSink.ports[1]) annotation(
  //    Line(points = {{-18, 28}, {-18, 28}, {-18, 100}, {-18, 100}}, color = {0, 127, 255}));
  //  connect(EVO.gasOut, ECO.gasIn) annotation(
  //    Line(points = {{-18, 6}, {-18, 6}, {-18, 18}, {-18, 18}}, color = {0, 127, 255}));
  //  connect(SH.gasOut, EVO.gasIn) annotation(
  //    Line(points = {{-18, -20}, {-18, -20}, {-18, -4}, {-18, -4}}, color = {0, 127, 255}));
  //  connect(gasIn, SH.gasIn) annotation(
  //    Line(points = {{-18, -120}, {-18, -120}, {-18, -30}, {-18, -30}}));
  //  connect(SH.flowOut, steam) annotation(
  //    Line(points = {{-8, -30}, {80, -30}, {80, -24}, {100, -24}, {100, -24}}, color = {0, 127, 255}));
  //protected
  extends TPPSim.Boilers.BaseClases.Icons.Icon1pVerticalOTHRSG;
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
    Placement(visible = true, transformation(origin = {-18, 74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO_3(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 2.162e-3, z1 = 174, z2 = 5, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Параллельный экономайзер ВД/СД
  //Испаритель ВД
  TPPSim.HRSG_HeatExch.GFHE HP_EVO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE HP_EVO_1(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 30e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.04, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 13, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Сепаратор ВД
  TPPSim.Drums.Separator HP_separator(redeclare package Medium = Medium_F, Din_down_pipe = 0.2, Din_sep = 0.5, H_down_pipe = 10, H_sep = 3, L_start = 7) annotation(
    Placement(visible = true, transformation(origin = {12, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Пароперегреватель ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 6.4e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 3.6e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы ВД
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {28, -26}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //ПЭН и РПК ВД
  TPPSim.Pumps.pressurePump FW_pump(redeclare package Medium = Medium_F, set_p = 6e+06, use_p_in = true) annotation(
    Placement(visible = true, transformation(origin = {-73, 73}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveIncompressible FWCV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 200, dp_nominal = 100000, filteredOpening = true, leakageOpening = 1e-4, m_flow_small = system.m_flow_small, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-51, 73}, extent = {{-7, 7}, {7, -7}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure HPFW_p(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-37, 87}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add HPFW_add annotation(
    Placement(visible = true, transformation(origin = {-61, 95}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant HPFW_CV_dp(k = 1e5) annotation(
    Placement(visible = true, transformation(origin = {-37, 105}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  //Регуляторы ВД
  TPPSim.Controls.LC_sink HP_LC(DFmax = 30, DFmin = 0, L = 7) annotation(
    Placement(visible = true, transformation(origin = {45, -9}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  TPPSim.Controls.TC HP_TC(T_sprh = 60, yMax = 1, y_start = 0.3) annotation(
    Placement(visible = true, transformation(origin = {45, 15}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  TPPSim.Pumps.simplePump HP_sink_valve(redeclare package Medium = Medium_F, setD_flow = 0, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {60, -66}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flash_tank(redeclare package Medium = Medium_F, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {90, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Logical.Greater HPTC_gr annotation(
    Placement(visible = true, transformation(origin = {-59, -1}, extent = {{-6, 6}, {6, -6}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant HPTC_const(k = 100 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-94, -22}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure HPTC_p(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {20, 8}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.SpecificEnthalpy HPTC_enth(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {4, 8}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  TPPSim.Sensors.Temperature HP_overheat(TemperatureType_set = TPPSim.Sensors.TemperatureType.overheating) annotation(
    Placement(visible = true, transformation(origin = {4, -26}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  //Контур СД
  //Испаритель СД
  //Барабан СД
  //Пароперегреватель СД
  //Промежуточный пароперегреватель
  //Паропровод СД
  //Контур НД
  //ГПК
  //Испаритель НД
  //Барабан НД
  //Пароперегреватель НД
  //Паропровод НД
  //Клапаны
  //Паровые продувки
  //Обратный клапан
  //Регуляторы
  //Датчики температуры газов
  Modelica.Fluid.Sensors.Temperature Tg_out_RH1(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-43, -15}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-18, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -224}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b HP_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a HP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Атмосфера
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-18, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(FWCV.port_b, HP_ECO_2.flowIn) annotation(
    Line(points = {{-44, 74}, {-30, 74}, {-30, 88}, {-8, 88}, {-8, 78}, {-8, 78}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-18, 79}, {-18, 100}}, color = {0, 127, 255}));
  connect(HP_ECO_2.flowOut, HP_ECO_3.flowIn) annotation(
    Line(points = {{-8, 70}, {-6, 70}, {-6, 50}, {-8, 50}}, color = {0, 127, 255}));
  connect(HP_ECO_3.gasOut, HP_ECO_2.gasIn) annotation(
    Line(points = {{-18, 52}, {-18, 69}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasOut, Tg_out_RH1.port) annotation(
    Line(points = {{-18, -34}, {-18, -34}, {-18, -28}, {-42, -28}, {-42, -20}, {-42, -20}}, color = {0, 127, 255}));
  connect(HP_EVO_1.gasOut, HP_ECO_3.gasIn) annotation(
    Line(points = {{-18, 12}, {-18, 12}, {-18, 42}, {-18, 42}}, color = {0, 127, 255}));
  connect(HP_EVO_2.gasIn, HP_SH_1.gasOut) annotation(
    Line(points = {{-18, -21}, {-18, -34}}, color = {0, 127, 255}));
  connect(HP_EVO_1.gasIn, HP_EVO_2.gasOut) annotation(
    Line(points = {{-18, 1}, {-18, -11}}, color = {0, 127, 255}));
  connect(HP_EVO_1.flowOut, HP_EVO_2.flowIn) annotation(
    Line(points = {{-8, 2}, {-4, 2}, {-4, -12}, {-8, -12}}, color = {0, 127, 255}));
  connect(HP_EVO_2.flowOut, HP_separator.fedWater) annotation(
    Line(points = {{-8, -20}, {-2, -20}, {-2, -10}, {6, -10}, {6, -8}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasIn, HP_SH_2.gasOut) annotation(
    Line(points = {{-18, -44}, {-18, -44}, {-18, -54}, {-18, -54}}, color = {0, 127, 255}));
  connect(HP_SH_2.flowOut, HP_Out) annotation(
    Line(points = {{-8, -64}, {0, -64}, {0, -98}, {100, -98}, {100, -98}}, color = {0, 127, 255}));
  connect(HP_SH_2.gasIn, gasIn) annotation(
    Line(points = {{-18, -64}, {-18, -64}, {-18, -120}, {-18, -120}}, color = {0, 127, 255}));
  connect(Tg_out_RH1.T, HPTC_gr.u1) annotation(
    Line(points = {{-46.5, -15}, {-49.5, -15}, {-49.5, -13}, {-52.5, -13}, {-52.5, -7}, {-56, -7}, {-56, -9}, {-59.5, -9}}, color = {0, 0, 127}));
  connect(HP_overheat.port, HP_separator.fedWater) annotation(
    Line(points = {{4, -30}, {0, -30}, {0, -16}, {4, -16}, {4, -8}, {6, -8}}, color = {0, 127, 255}));
  connect(HP_separator.fedWater, HPTC_enth.port) annotation(
    Line(points = {{5, -9}, {4, -9}, {4, -7}, {5, -7}, {5, 3}, {3, 3}, {3, 1}, {3, 1}}, color = {0, 127, 255}));
  connect(HPTC_enth.h_out, HP_TC.h) annotation(
    Line(points = {{10.6, 8}, {10.6, 8}, {10.6, 8}, {12.6, 8}, {12.6, 15}, {25.1, 15}, {25.1, 15}, {37.6, 15}}, color = {0, 0, 127}));
  connect(HP_separator.steam, HPTC_p.port) annotation(
    Line(points = {{12, -5}, {15, -5}, {15, -3}, {20, -3}, {20, 3}, {20, 3}, {20, 1}, {20, 1}}, color = {0, 127, 255}));
  connect(HPTC_p.p, HP_TC.p) annotation(
    Line(points = {{26.6, 8}, {27.1, 8}, {27.1, 8}, {27.6, 8}, {27.6, 11}, {32.1, 11}, {32.1, 11}, {36.6, 11}}, color = {0, 0, 127}));
  connect(HPTC_const.y, HPTC_gr.u2) annotation(
    Line(points = {{-87.4, -22}, {-63.4, -22}, {-63.4, -15}, {-63.4, -15}, {-63.4, -8}}, color = {0, 0, 127}));
  connect(HPTC_gr.y, HP_TC.on) annotation(
    Line(points = {{-59, 5.6}, {-59, 17.6}, {-4, 17.6}, {-4, 20.6}, {16.5, 20.6}, {16.5, 18.6}, {37, 18.6}}, color = {255, 0, 255}));
  connect(HP_sink_valve.port_b, flash_tank.ports[1]) annotation(
    Line(points = {{66, -66}, {80, -66}}, color = {0, 127, 255}));
  connect(HP_separator.downWater, HP_sink_valve.port_a) annotation(
    Line(points = {{12, -26}, {12, -66}, {54, -66}}, color = {0, 127, 255}));
  connect(HP_LC.y, HP_sink_valve.D_flow_in) annotation(
    Line(points = {{52.7, -9}, {59.7, -9}, {59.7, -34.5}, {59.7, -34.5}, {59.7, -60}}, color = {0, 0, 127}));
  connect(HP_TC.y, FWCV.opening) annotation(
    Line(points = {{52.7, 15}, {59.7, 15}, {59.7, 56}, {-51.3, 56}, {-51.3, 61.5}, {-51.3, 61.5}, {-51.3, 67}}, color = {0, 0, 127}));
  connect(HP_separator.level, HP_LC.u) annotation(
    Line(points = {{17, -10.2}, {22, -10.2}, {22, -10.2}, {27, -10.2}, {27, -9.2}, {32, -9.2}, {32, -9.2}, {37, -9.2}}, color = {0, 0, 127}));
  connect(HPFW_CV_dp.y, HPFW_add.u1) annotation(
    Line(points = {{-42.5, 105}, {-50, 105}, {-50, 98}, {-54, 98}}, color = {0, 0, 127}));
  connect(HPFW_p.p, HPFW_add.u2) annotation(
    Line(points = {{-42.5, 87}, {-45.5, 87}, {-45.5, 89}, {-46.5, 89}, {-46.5, 93}, {-52, 93}, {-52, 91}, {-53.75, 91}, {-53.75, 91}, {-55.5, 91}}, color = {0, 0, 127}));
  connect(HPFW_add.y, FW_pump.p_in) annotation(
    Line(points = {{-66.5, 95}, {-69.5, 95}, {-69.5, 95}, {-70.5, 95}, {-70.5, 81}, {-72.5, 81}, {-72.5, 79}, {-72.5, 79}}, color = {0, 0, 127}));
  connect(FWCV.port_b, HPFW_p.port) annotation(
    Line(points = {{-44, 73}, {-40, 73}, {-40, 73}, {-36, 73}, {-36, 83}, {-36, 83}, {-36, 81}, {-36, 81}}, color = {0, 127, 255}));
  connect(FW_pump.port_b, FWCV.port_a) annotation(
    Line(points = {{-66, 73}, {-64, 73}, {-64, 73}, {-62, 73}, {-62, 75}, {-58, 75}, {-58, 75}, {-58, 75}, {-58, 73}, {-58, 73}, {-58, 73}, {-58, 73}}, color = {0, 127, 255}));
  connect(HP_FW_In, FW_pump.port_a) annotation(
    Line(points = {{-100, 72}, {-97.75, 72}, {-97.75, 72}, {-95.5, 72}, {-95.5, 74}, {-91, 74}, {-91, 73}, {-85.5, 73}, {-85.5, 73}, {-80, 73}}));
  connect(HP_separator.steam, HP_pipe.waterIn) annotation(
    Line(points = {{12, -5}, {20, -5}, {20, -3}, {28, -3}, {28, -22}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, HP_SH_1.flowIn) annotation(
    Line(points = {{28, -30.84}, {28, -30.84}, {28, -30.84}, {28, -34.84}, {10, -34.84}, {10, -36.84}, {-8, -36.84}}, color = {0, 127, 255}));
  connect(HP_SH_1.flowOut, HP_SH_2.flowIn) annotation(
    Line(points = {{-8, -44}, {-6, -44}, {-6, -44}, {-4, -44}, {-4, -56}, {-6, -56}, {-6, -56}, {-8, -56}}, color = {0, 127, 255}));
  connect(HP_ECO_3.flowOut, HP_EVO_1.flowIn) annotation(
    Line(points = {{-8, 42}, {-4, 42}, {-4, 10}, {-8, 10}, {-8, 10}}, color = {0, 127, 255}));
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
    Diagram(coordinateSystem(extent = {{-100, -120}, {100, 120}})),
    __OpenModelica_commandLineOptions = "");
end OnePVerticalOTHRSG;
