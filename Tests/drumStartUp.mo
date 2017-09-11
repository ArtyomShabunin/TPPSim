within TPPSim.Tests;
model drumStartUp
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  parameter Real temperature_exh[:, 2] = {{0.0, 2.57}, {11.94, 3.46}, {17.9104, 4.23}, {17.9105, 7.32}, {20.8955, 15.79}, {20.8956, 40.82}, {23.8806, 45.44}, {23.8807, 52.75}, {26.8657, 52.75}, {26.8658, 57.89}, {29.8507, 60.97}, {32.84, 62.25}, {35.82, 64.3}, {38.81, 66.2}, {44.78, 67.51}, {50.75, 68.79}, {53.73, 70.08}, {59.7, 71.23}, {68.66, 72.39}, {74.63, 73.16}, {80.6, 73.67}, {92.54, 74.57}, {107.46, 75.47}, {122.39, 76.23}, {143.28, 76.88}, {155.22, 77.0}, {170.15, 76.87}, {191.05, 76.36}, {205.97, 75.46}, {217.91, 74.69}, {229.85, 73.66}, {238.81, 72.76}, {244.78, 71.86}, {253.73, 70.71}, {259.7, 69.42}, {265.67, 68.65}, {274.63, 67.75}, {280.6, 66.6}, {286.57, 65.19}, {295.52, 63.77}, {301.49, 62.49}, {310.45, 60.56}, {316.42, 59.41}, {334.33, 57.74}, {382.09, 57.74}, {382.0901, 60.3}, {841.79, 100.58}, {1671.64, 100.58}, {2361.19, 100.74}, {2492.54, 100.74}, {2782.09, 100.0}, {2933.39, 100.0}};
  parameter Real flow_exh[:, 2] = {{0.0, 0.0}, {11.94, 2.31}, {32.84, 7.83}, {50.75, 10.27}, {74.63, 13.09}, {107.46, 16.29}, {140.3, 18.99}, {176.12, 22.58}, {197.02, 25.53}, {217.91, 29.12}, {235.82, 31.82}, {244.78, 34.51}, {256.72, 38.1}, {274.63, 42.21}, {292.54, 46.19}, {307.46, 51.06}, {319.4, 55.69}, {328.36, 60.18}, {334.33, 58.38}, {382.09, 58.38}, {385.08, 58.51}, {838.81, 58.73}, {1677.61, 99.88}, {2922.39, 100.0}};
  parameter Real Tnom = 517.2 + 273.15;
  parameter Real Gnom = 1292.6 / 3.6;
  parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
  parameter Modelica.SIunits.MassFlowRate wsteam = 0.01 "Расход пара на выходе из сепаратора";
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Modelica.SIunits.MassFlowRate wgas = 100 / 3.6 "Номинальный (и начальный) массовый расход газов ";
  parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
  parameter Medium_F.SaturationProperties sat_start = Medium_F.setSat_p(pflow_ote2);
  //Исходные данные для сепаратора
  parameter Modelica.SIunits.Length Dsep = 0.348 "Внутренний диаметр сепаратор";
  parameter Modelica.SIunits.Length Lsep = 5 "Длина (высота) сепаратора";
  parameter Modelica.SIunits.Length deltaSep = 0.04 "Толщина стенки сепаратора";
  parameter Integer n_sep_set = 2 "Количество сепараторов";
  //Констуктивные характеристики поверхностей нагрева
  parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
  //Исходные данные для экономайзера
  parameter Modelica.SIunits.Diameter Din_eco = 0.038 "Внутренний диаметр трубок теплообменника";
  parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
  parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
  parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
  parameter Integer zahod_eco = 1 "заходность труб теплообменника";
  parameter Integer z1_eco = 58 "Число труб по ширине газохода";
  parameter Integer z2_eco = 8 "Число труб по ходу газов в теплообменнике";
  ///Оребрение труб экономайзера
  parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
  parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
  parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
  //Исходные данные по разбиению экономайзера
  parameter Integer numberOfVolumes_eco = 1 "Число участков разбиения пароперегревателя" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Pressure pflow_eco = 1.013e5 "Начальное давление потока вода/пар перед ECO";
  parameter Modelica.SIunits.Temperature Tinflow_eco = 60 + 273.15 "Начальная входная температура потока воды/пар";
  parameter Modelica.SIunits.Temperature Toutflow_eco = 60 + 273.15 "Начальная выходная температура потока воды/пар";
  parameter Modelica.SIunits.Temperature setTm_eco = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
  parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
  parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия выходного потока вода/пар";
  //Исходные данные для газовой стороны экономайзера
  parameter Modelica.SIunits.Temperature Tingas_eco = 60 + 273.15 "Начальная входная температура газов";
  parameter Modelica.SIunits.Temperature Toutgas_eco = 60 + 273.15 "Начальная выходная температура газов";
  parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
  //Исходные данные для прямоточного испарителя №1 (OTE1)
  parameter Modelica.SIunits.Diameter Din_ote1 = 0.038 "Внутренний диаметр трубок теплообменника";
  parameter Modelica.SIunits.Length delta_ote1 = 0.002 "Толщина стенки трубки теплообменника";
  parameter Modelica.SIunits.Length s1_ote1 = 91.09e-3 "Поперечный шаг";
  parameter Modelica.SIunits.Length s2_ote1 = 79e-3 "Продольный шаг";
  parameter Integer zahod_ote1 = 1 "заходность труб теплообменника";
  parameter Integer z1_ote1 = 58 "Число труб по ширине газохода";
  parameter Integer z2_ote1 = 10 "Число труб по ходу газов в теплообменнике";
  ///Оребрение труб прямоточного испарителя №1 (OTE1)
  parameter Modelica.SIunits.Length delta_fin_ote1 = 0.0008 "Средняя толщина ребра, м";
  parameter Modelica.SIunits.Length hfin_ote1 = 0.015 "Высота ребра, м";
  parameter Modelica.SIunits.Length sfin_ote1 = 2.002e-3 "Шаг ребер, м";
  //Исходные данные по разбиению испарителя №1 (OTE1)
  parameter Integer numberOfTubeSections_ote1 = 1 "Число участков разбиения трубы" annotation(
    Dialog(group = "Конструктивные характеристики"));
  //Исходные данные вода/пар для экономайзера
  parameter Modelica.SIunits.Pressure pflow_ote1 = 1.013e5 "Начальное давление потока вода/пар перед ECO";
  parameter Modelica.SIunits.Temperature Tinflow_ote1 = 60 + 273.15 "Начальная входная температура потока воды/пар";
  parameter Modelica.SIunits.Temperature Toutflow_ote1 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
  parameter Modelica.SIunits.Temperature setTm_ote1 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
  parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_in = hflow_eco_out "Начальная энтальпия входного потока вода/пар";
  parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_out = hflow_ote1_in "Начальная энтальпия выходного потока вода/пар";
  //Исходные данные для газовой стороны экономайзера
  parameter Modelica.SIunits.Temperature Tingas_ote1 = 60 + 273.15 "Начальная входная температура газов";
  parameter Modelica.SIunits.Temperature Toutgas_ote1 = 60 + 273.15 "Начальная выходная температура газов";
  parameter Real k_gamma_gas_ote1 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
  //Исходные данные для прямоточного испарителя №2 (OTE2)
  parameter Modelica.SIunits.Diameter Din_ote2 = 0.038 "Внутренний диаметр трубок теплообменника";
  parameter Modelica.SIunits.Length delta_ote2 = 0.002 "Толщина стенки трубки теплообменника";
  parameter Modelica.SIunits.Length s1_ote2 = 91.09e-3 "Поперечный шаг";
  parameter Modelica.SIunits.Length s2_ote2 = 79e-3 "Продольный шаг";
  parameter Integer zahod_ote2 = 2 "заходность труб теплообменника";
  parameter Integer z1_ote2 = 58 "Число труб по ширине газохода";
  parameter Integer z2_ote2 = 6 "Число труб по ходу газов в теплообменнике";
  ///Оребрение труб прямоточного испарителя №2 (OTE2)
  parameter Modelica.SIunits.Length delta_fin_ote2 = 0.0008 "Средняя толщина ребра, м";
  parameter Modelica.SIunits.Length hfin_ote2 = 0.015 "Высота ребра, м";
  parameter Modelica.SIunits.Length sfin_ote2 = 2.735e-3 "Шаг ребер, м";
  //Исходные данные по разбиению испарителя №2 (OTE2)
  parameter Integer numberOfTubeSections_ote2 = 1 "Число участков разбиения трубы" annotation(
    Dialog(group = "Конструктивные характеристики"));
  //Исходные данные вода/пар для испарителя №2
  parameter Modelica.SIunits.Pressure pflow_ote2 = 1.013e5 "Начальное давление потока вода/пар перед OTE2";
  parameter Modelica.SIunits.Temperature Tinflow_ote2 = 60 + 273.15 "Начальная входная температура потока воды/пар";
  parameter Modelica.SIunits.Temperature Toutflow_ote2 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
  parameter Modelica.SIunits.Temperature setTm_ote2 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
  parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_in = hflow_ote1_out "Начальная энтальпия входного потока вода/пар";
  parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_out = hflow_ote2_in "Начальная энтальпия выходного потока вода/пар";
  //Исходные данные для газовой стороны испарителя №2
  parameter Modelica.SIunits.Temperature Tingas_ote2 = 60 + 273.15 "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
  parameter Modelica.SIunits.Temperature Toutgas_ote2 = 60 + 273.15 "Начальная выходная температура газов";
  parameter Real k_gamma_gas_ote2 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
  //Исходные данные для пароперегревателя (SH)
  parameter Modelica.SIunits.Diameter Dout_sh = 0.038 "Наружный диаметр трубок теплообменника";
  parameter Modelica.SIunits.Length delta_sh = 0.002 "Толщина стенки трубки теплообменника";
  parameter Modelica.SIunits.Length s1_sh = 91.09e-3 "Поперечный шаг";
  parameter Modelica.SIunits.Length s2_sh = 79e-3 "Продольный шаг";
  parameter Integer zahod_sh = 2 "заходность труб теплообменника";
  parameter Integer z1_sh = 58 "Число труб по ширине газохода";
  parameter Integer z2_sh = 8 "Число труб по ходу газов в теплообменнике";
  ///Оребрение труб пароперегревателя (SH)
  parameter Modelica.SIunits.Length delta_fin_sh = 0.001 "Средняя толщина ребра, м";
  parameter Modelica.SIunits.Length hfin_sh = 0.012 "Высота ребра, м";
  parameter Modelica.SIunits.Length sfin_sh = 5.102e-3 "Шаг ребер, м";
  //Исходные данные по разбиению пароперегревателя (SH)
  parameter Integer numberOfVolumes_sh = 2 "Число участков разбиения пароперегревателя" annotation(
    Dialog(group = "Конструктивные характеристики"));
  //Исходные данные вода/пар для пароперегревателя
  parameter Modelica.SIunits.Pressure pflow_sh = 1.013e5 "Начальное давление потока вода/пар перед SH";
  parameter Modelica.SIunits.Temperature Tinflow_sh = 60 + 273.15 "Начальная входная температура потока воды/пар";
  parameter Modelica.SIunits.Temperature Toutflow_sh = 60 + 273.15 "Начальная выходная температура потока воды/пар";
  parameter Modelica.SIunits.Temperature setTm_sh = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
  parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_in = 2.676e6 "Начальная энтальпия входного потока вода/пар";
  parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_out = hflow_sh_in "Начальная энтальпия входного потока вода/пар";
  //Исходные данные для газовой стороны пароперегревателя
  parameter Modelica.SIunits.Temperature Tingas_sh = 60 + 273.15 "Начальная входная температура газов";
  parameter Modelica.SIunits.Temperature Toutgas_sh = 60 + 273.15 "Начальная выходная температура газов";
  parameter Real k_gamma_gas_sh = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
  //Исходные данные для барабана
  parameter Modelica.SIunits.Length Din_drum = 1.718 "Внутренний диаметр барабана";
  parameter Modelica.SIunits.Length L_drum = 9 "Длина барабана";
  parameter Modelica.SIunits.Length Hw_start_set = 0.5 "Начальное значение уровня воды в барабане";
  inner Modelica.Fluid.System system(allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = Tinflow_eco, m_flow = wflow, nPorts = 1, use_T_in = false, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-76, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE ECO(redeclare TPPSim.HRSG_HeatExch.FlowSideECO flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco, numberOfVolumes = numberOfVolumes_eco, flow_DynamicMomentum = false, flow_DynamicMassBalance = false, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
    Placement(visible = true, transformation(origin = {-44, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-82, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_new OTE2(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE3 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2, numberOfTubeSections = numberOfTubeSections_ote2, flow_DynamicMomentum = false, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
    Placement(visible = true, transformation(origin = {8, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH2 flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2, numberOfVolumes = numberOfVolumes_sh, flow_DynamicMomentum = true, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {46, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {53, 37}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV1(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {64, 22}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {86, 22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  /*TPPSim.flowLimiter flowLimiter1(redeclare package Medium = Medium_F, m_flow_small = 0.01) annotation(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Placement(visible = true, transformation(origin = {43, 41}, extent = {{-3, 3}, {3, -3}}, rotation = 0)));*/
  TPPSim.Drums.Drum Drum(Din = Din_drum, L = L_drum, delta = 0.02, Hw_start = Hw_start_set) annotation(
    Placement(visible = true, transformation(origin = {8, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.SteamPipe steamPipe1(setD_flow = wsteam, setp_flow_in = pflow_sh, setp_flow_out = pflow_sh, setT_inFlow = Tinflow_sh, setT_outFlow = Tinflow_sh, Din = 0.3, delta = 0.01, Lpipe = 10, seth_in = hflow_sh_in, seth_out = hflow_sh_in, setTm = setTm_ote2, DynamicMomentum = true) annotation(
    Placement(visible = true, transformation(origin = {42, 2}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Pumps.simplePump circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {-12, -48}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  TPPSim.Gas_turbine.simple_startupGT GT_startup(redeclare package Medium = Medium_G, Tnom = Tnom, Gnom = Gnom, Tstart = Tinflow_sh) annotation(
    Placement(visible = true, transformation(origin = {84, -22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Controls.LC lc1(DFmax = 50, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-26, 48}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pipes.SteamPipe steamPipe2(setD_flow = wsteam, setp_flow_in = pflow_sh, setp_flow_out = pflow_sh, setT_inFlow = Tinflow_sh, setT_outFlow = Tinflow_sh, Din = 0.3, delta = 0.01, Lpipe = 10, seth_in = hflow_sh_in, seth_out = hflow_sh_in, setTm = setTm_ote2, DynamicMomentum = true) annotation(
    Placement(visible = true, transformation(origin = {50, 2}, extent = {{-4, -4}, {4, 4}}, rotation = 90)));
equation
  connect(steamPipe2.waterOut, CV1.port_a) annotation(
    Line(points = {{50, 6}, {50, 6}, {50, 22}, {60, 22}, {60, 22}}, color = {0, 127, 255}));
  connect(SH.flowOut, steamPipe2.waterIn) annotation(
    Line(points = {{50, -10}, {50, -10}, {50, -2}, {50, -2}}, color = {0, 127, 255}));
  connect(constCV1.y, CV1.opening) annotation(
    Line(points = {{58.5, 37}, {64, 37}, {64, 25}}, color = {0, 0, 127}));
  connect(CV1.port_b, flowSink.ports[1]) annotation(
    Line(points = {{68, 22}, {76, 22}}, color = {0, 127, 255}));
  connect(Drum.waterLevel, lc1.u) annotation(
    Line(points = {{19, 19}, {20, 19}, {20, 21}, {23, 21}, {23, 51}, {1, 51}, {1, 48}, {-14, 48}}, color = {0, 0, 127}));
  connect(lc1.y, flowSource.m_flow_in) annotation(
    Line(points = {{-37, 48}, {-87, 48}, {-87, 24}}, color = {0, 0, 127}));
  connect(GT_startup.flowOut, SH.gasIn) annotation(
    Line(points = {{74, -22}, {52, -22}, {52, -22}, {52, -22}, {52, -22}, {52, -22}}, color = {0, 127, 255}));
  connect(circPump.port_b, OTE2.flowIn) annotation(
    Line(points = {{-6, -48}, {-4, -48}, {-4, -48}, {-2, -48}, {-2, -12}, {6, -12}, {6, -11}, {4, -11}, {4, -10}}, color = {0, 127, 255}));
  connect(Drum.downStr, circPump.port_a) annotation(
    Line(points = {{1, 3}, {2, 3}, {2, 5}, {3, 5}, {3, -3}, {-7, -3}, {-7, -35}, {-17, -35}, {-17, -47}, {-18, -47}, {-18, -49}, {-19, -49}}, color = {0, 127, 255}));
  connect(SH.flowIn, steamPipe1.waterOut) annotation(
    Line(points = {{41.8, -11}, {41.8, -11}, {41.8, -9}, {41.8, -9}, {41.8, -1}, {41.8, -1}, {41.8, -3}, {41.8, -3}}, color = {0, 127, 255}));
  connect(steamPipe1.waterIn, Drum.steam) annotation(
    Line(points = {{42, 6.8}, {42, 6.8}, {42, 6.8}, {44, 6.8}, {44, 22.8}, {16, 22.8}, {16, 22.8}}, color = {0, 127, 255}));
  connect(ECO.flowOut, Drum.fedWater) annotation(
    Line(points = {{-39.8, -11}, {-25.8, -11}, {-25.8, -9}, {-9.8, -9}, {-9.8, 22}, {-5.3, 22}, {-5.3, 20}, {1.2, 20}}, color = {0, 127, 255}));
  connect(Drum.upStr, OTE2.flowOut) annotation(
    Line(points = {{15, 3}, {13.5, 3}, {13.5, 3}, {14, 3}, {14, -7.5}, {12, -7.5}, {12, -10}}, color = {0, 127, 255}));
  connect(SH.gasOut, OTE2.gasIn) annotation(
    Line(points = {{39.8, -22}, {13.8, -22}}, color = {0, 127, 255}));
  connect(ECO.gasIn, OTE2.gasOut) annotation(
    Line(points = {{-37.8, -22}, {2.2, -22}, {2.2, -22}, {2.2, -22}}, color = {0, 127, 255}));
  connect(ECO.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-50.2, -22}, {-72.2, -22}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], ECO.flowIn) annotation(
    Line(points = {{-66, 16}, {-57, 16}, {-57, 16}, {-46, 16}, {-46, -1.5}, {-48, -1.5}, {-48, -11}}, color = {0, 127, 255}));
  annotation(
    uses(Modelica(version = "3.2.1")),
    Documentation(info = "<html>
  <p>
  Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
  Первая попытка реалиизовать регулирование расхода при пуске прямоточного КУ.
  </p>
  </html>", revisions = "Модель со сложным разбиением и упрощенным сепаратором"),
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 0.005));
end drumStartUp;