within TPPSim.Boilers;

model OnePVerticalOTHRSG_2
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
  TPPSim.HRSG_HeatExch.GFHE HP_EVO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE HP_EVO_1(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 30e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.04, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 13, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Сепаратор ВД
  TPPSim.Drums.Separator HP_separator(redeclare package Medium = Medium_F, Din_down_pipe = 0.2, Din_sep = 0.5, H_down_pipe = 10, H_sep = 3, L_start = 7) annotation(
    Placement(visible = true, transformation(origin = {12, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Пароперегреватель ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 6.4e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 3.6e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы ВД
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {28, -14}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
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
  TPPSim.Controls.TC HP_TC(T_sprh = 60, yMax = 1, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {45, 27}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  TPPSim.Pumps.simplePump HP_sink_valve(redeclare package Medium = Medium_F, setD_flow = 0, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {50, -52}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater HPTC_gr annotation(
    Placement(visible = true, transformation(origin = {-59, 11}, extent = {{-6, 6}, {6, -6}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant HPTC_const(k = 100 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-94, -10}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure HPTC_p(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {20,20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.SpecificEnthalpy HPTC_enth(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {4, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  TPPSim.Sensors.Temperature HP_overheat(TemperatureType_set = TPPSim.Sensors.TemperatureType.overheating) annotation(
    Placement(visible = true, transformation(origin = {4, -14}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  //Датчики температуры газов
  Modelica.Fluid.Sensors.Temperature Tg_out_RH1(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-43, -3}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-18, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -224}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b HP_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a HP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Атмосфера
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-18, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

 Modelica.Blocks.Math.Max max2 annotation(
    Placement(visible = true, transformation(origin = {72, 16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 20)  annotation(
    Placement(visible = true, transformation(origin = {113, -103}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {68, -74}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation(
    Placement(visible = true, transformation(origin = {35, -77}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 0)  annotation(
    Placement(visible = true, transformation(origin = {67, -99}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {85, -31}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 60, height = 20, offset = 0, startTime = 5)  annotation(
    Placement(visible = true, transformation(origin = {14, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.LC LC(DFmax = 1, DFmin = 0)  annotation(
    Placement(visible = true, transformation(origin = {45, 1}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-3, 35}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));
  Modelica.Blocks.Continuous.LimPID PID(Ti = 120, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = 100, yMax = 1, yMin = 0)  annotation(
    Placement(visible = true, transformation(origin = {34, 50}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
equation
  connect(product1.y, HP_sink_valve.D_flow_in) annotation(
    Line(points = {{86, -38}, {84, -38}, {84, -42}, {50, -42}, {50, -46}, {50, -46}}, color = {0, 0, 127}));
  connect(ramp1.y, product1.u1) annotation(
    Line(points = {{26, 94}, {90, 94}, {90, -22}, {90, -22}}, color = {0, 0, 127}));
  connect(PID.y, product1.u2) annotation(
    Line(points = {{40, 50}, {80, 50}, {80, -22}, {80, -22}}, color = {0, 0, 127}));
  connect(const.y, add1.u1) annotation(
    Line(points = {{106, -102}, {92, -102}, {92, -68}, {78, -68}, {78, -70}}, color = {0, 0, 127}));
  connect(const.y, add1.u2) annotation(
    Line(points = {{106, -102}, {88, -102}, {88, -78}, {78, -78}, {78, -78}}, color = {0, 0, 127}));
  connect(ramp1.y, PID.u_s) annotation(
    Line(points = {{26, 94}, {28, 94}, {28, 68}, {20, 68}, {20, 50}, {26, 50}, {26, 50}}, color = {0, 0, 127}));
  connect(massFlowRate1.m_flow, PID.u_m) annotation(
    Line(points = {{2, 36}, {34, 36}, {34, 42}, {34, 42}}, color = {0, 0, 127}));
  connect(massFlowRate1.port_b, HP_EVO_1.flowIn) annotation(
    Line(points = {{-3, 30}, {-6, 30}, {-6, 22}, {-8, 22}}, color = {0, 127, 255}));
  connect(HP_ECO_3.flowOut, massFlowRate1.port_a) annotation(
    Line(points = {{-8, 42}, {-6, 42}, {-6, 40}, {-3, 40}}, color = {0, 127, 255}));
  connect(LC.y, max2.u2) annotation(
    Line(points = {{52, 0}, {58, 0}, {58, 12}, {64, 12}, {64, 12}}, color = {0, 0, 127}));
  connect(HP_separator.level, LC.u) annotation(
    Line(points = {{18, 2}, {37, 2}, {37, 1}}, color = {0, 0, 127}));
  connect(const1.y, max1.u2) annotation(
    Line(points = {{59, -99}, {50, -99}, {50, -80}, {43, -80}, {43, -81}}, color = {0, 0, 127}));
  connect(HP_sink_valve.port_b, HP_ECO_3.flowIn) annotation(
    Line(points = {{56, -52}, {96, -52}, {96, 74}, {-4, 74}, {-4, 62}, {-6, 62}, {-6, 50}, {-8, 50}, {-8, 50}}, color = {0, 127, 255}));
  connect(add1.y, max1.u1) annotation(
    Line(points = {{60, -74}, {44, -74}, {44, -72}, {44, -72}}, color = {0, 0, 127}));
  connect(HP_SH_2.flowOut, HP_Out) annotation(
    Line(points = {{-8, -52}, {0, -52}, {0, -120}, {100, -120}}, color = {0, 127, 255}));
  connect(max2.y, FWCV.opening) annotation(
    Line(points = {{78, 16}, {84, 16}, {84, 58}, {-50, 58}, {-50, 68}, {-50, 68}}, color = {0, 0, 127}));
  connect(HP_TC.y, max2.u1) annotation(
    Line(points = {{52, 28}, {58, 28}, {58, 20}, {64, 20}, {64, 20}}, color = {0, 0, 127}));
  connect(HP_separator.downWater, HP_sink_valve.port_a) annotation(
    Line(points = {{12, -14}, {12, -52}, {44, -52}}, color = {0, 127, 255}));
  connect(Tg_out_RH1.T, HPTC_gr.u1) annotation(
    Line(points = {{-46.5, -3}, {-48, -3}, {-48, -3}, {-49.5, -3}, {-49.5, -1}, {-52.5, -1}, {-52.5, 5}, {-56, 5}, {-56, 3}, {-57.75, 3}, {-57.75, 3}, {-59.5, 3}}, color = {0, 0, 127}));
  connect(HP_SH_1.gasOut, Tg_out_RH1.port) annotation(
    Line(points = {{-18, -23}, {-18, -23}, {-18, -21}, {-18, -21}, {-18, -15}, {-42, -15}, {-42, -7}, {-42, -7}, {-42, -9}, {-42, -9}}, color = {0, 127, 255}));
  connect(HP_overheat.port, HP_separator.fedWater) annotation(
    Line(points = {{4, -18}, {2, -18}, {2, -18}, {0, -18}, {0, -4}, {4, -4}, {4, 4}, {5, 4}, {5, 4}, {6, 4}}, color = {0, 127, 255}));
  connect(HPTC_enth.h_out, HP_TC.h) annotation(
    Line(points = {{10.6, 20}, {10.6, 20}, {10.6, 20}, {12.6, 20}, {12.6, 27}, {25.1, 27}, {25.1, 27}, {37.6, 27}}, color = {0, 0, 127}));
  connect(HP_separator.fedWater, HPTC_enth.port) annotation(
    Line(points = {{5, 3}, {4, 3}, {4, 5}, {5, 5}, {5, 15}, {3, 15}, {3, 13}, {3, 13}, {3, 13}, {3, 13}}, color = {0, 127, 255}));
  connect(HPTC_p.p, HP_TC.p) annotation(
    Line(points = {{26.6, 20}, {27.1, 20}, {27.1, 20}, {27.6, 20}, {27.6, 23}, {32.1, 23}, {32.1, 23}, {34.35, 23}, {34.35, 23}, {36.6, 23}}, color = {0, 0, 127}));
  connect(HP_separator.steam, HPTC_p.port) annotation(
    Line(points = {{12, 7}, {15, 7}, {15, 9}, {20, 9}, {20, 15}, {20, 15}, {20, 13}, {20, 13}, {20, 13}, {20, 13}}, color = {0, 127, 255}));
  connect(HPTC_const.y, HPTC_gr.u2) annotation(
    Line(points = {{-87.4, -10}, {-63.4, -10}, {-63.4, -3}, {-63.4, -3}, {-63.4, 4}}, color = {0, 0, 127}));
  connect(HPTC_gr.y, HP_TC.on) annotation(
    Line(points = {{-59, 17.6}, {-59, 23.6}, {-59, 23.6}, {-59, 29.6}, {-4, 29.6}, {-4, 32.6}, {16.5, 32.6}, {16.5, 30.6}, {37, 30.6}}, color = {255, 0, 255}));
  connect(HP_pipe.waterOut, HP_SH_1.flowIn) annotation(
    Line(points = {{28, -18.84}, {28, -18.84}, {28, -18.84}, {28, -22.84}, {10, -22.84}, {10, -24.84}, {1, -24.84}, {1, -24.84}, {-8, -24.84}}, color = {0, 127, 255}));
  connect(HP_separator.steam, HP_pipe.waterIn) annotation(
    Line(points = {{12, 7}, {16, 7}, {16, 7}, {20, 7}, {20, 9}, {28, 9}, {28, -10}}, color = {0, 127, 255}));
  connect(HP_SH_1.flowOut, HP_SH_2.flowIn) annotation(
    Line(points = {{-8, -32}, {-6, -32}, {-6, -32}, {-4, -32}, {-4, -44}, {-6, -44}, {-6, -44}, {-8, -44}}, color = {0, 127, 255}));
  connect(HP_SH_2.gasIn, gasIn) annotation(
    Line(points = {{-18, -53}, {-18, -62}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasIn, HP_SH_2.gasOut) annotation(
    Line(points = {{-18, -33}, {-18, -33}, {-18, -31}, {-18, -31}, {-18, -41}, {-18, -41}, {-18, -43}, {-18, -43}}, color = {0, 127, 255}));
  connect(HP_EVO_2.gasIn, HP_SH_1.gasOut) annotation(
    Line(points = {{-18, -9}, {-18, -22}}, color = {0, 127, 255}));
  connect(HP_EVO_2.flowOut, HP_separator.fedWater) annotation(
    Line(points = {{-8, -8}, {-5, -8}, {-5, -8}, {-2, -8}, {-2, 2}, {6, 2}, {6, 3}, {6, 3}, {6, 4}}, color = {0, 127, 255}));
  connect(HP_EVO_1.flowOut, HP_EVO_2.flowIn) annotation(
    Line(points = {{-8, 14}, {-6, 14}, {-6, 14}, {-4, 14}, {-4, 0}, {-6, 0}, {-6, 0}, {-8, 0}}, color = {0, 127, 255}));
  connect(HP_EVO_1.gasIn, HP_EVO_2.gasOut) annotation(
    Line(points = {{-18, 13}, {-18, 1}}, color = {0, 127, 255}));
  connect(HP_EVO_1.gasOut, HP_ECO_3.gasIn) annotation(
    Line(points = {{-18, 23}, {-18, 14}}, color = {0, 127, 255}));
  connect(FWCV.port_b, HP_ECO_2.flowIn) annotation(
    Line(points = {{-44, 74}, {-30, 74}, {-30, 88}, {-8, 88}, {-8, 78}, {-8, 78}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-18, 79}, {-18, 100}}, color = {0, 127, 255}));
  connect(HP_ECO_2.flowOut, HP_ECO_3.flowIn) annotation(
    Line(points = {{-8, 70}, {-6, 70}, {-6, 50}, {-8, 50}}, color = {0, 127, 255}));
  connect(HP_ECO_3.gasOut, HP_ECO_2.gasIn) annotation(
    Line(points = {{-18, 52}, {-18, 69}}, color = {0, 127, 255}));
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
end OnePVerticalOTHRSG_2;
