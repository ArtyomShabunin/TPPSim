within TPPSim.Tests;
model startUpControlTest_2
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  parameter Real temperature_exh[:, 2] = {{0.0, 2.57}, {11.94, 3.46}, {17.9104, 4.23}, {17.9105, 7.32}, {20.8955, 15.79}, {20.8956, 40.82}, {23.8806, 45.44}, {23.8807, 52.75}, {26.8657, 52.75}, {26.8658, 57.89}, {29.8507, 60.97}, {32.84, 62.25}, {35.82, 64.3}, {38.81, 66.2}, {44.78, 67.51}, {50.75, 68.79}, {53.73, 70.08}, {59.7, 71.23}, {68.66, 72.39}, {74.63, 73.16}, {80.6, 73.67}, {92.54, 74.57}, {107.46, 75.47}, {122.39, 76.23}, {143.28, 76.88}, {155.22, 77.0}, {170.15, 76.87}, {191.05, 76.36}, {205.97, 75.46}, {217.91, 74.69}, {229.85, 73.66}, {238.81, 72.76}, {244.78, 71.86}, {253.73, 70.71}, {259.7, 69.42}, {265.67, 68.65}, {274.63, 67.75}, {280.6, 66.6}, {286.57, 65.19}, {295.52, 63.77}, {301.49, 62.49}, {310.45, 60.56}, {316.42, 59.41}, {334.33, 57.74}, {382.09, 57.74}, {382.0901, 60.3}, {841.79, 100.58}, {1671.64, 100.58}, {2361.19, 100.74}, {2492.54, 100.74}, {2782.09, 100.0}, {2933.39, 100.0}};
  parameter Real flow_exh[:, 2] = {{0.0, 0.0}, {11.94, 2.31}, {32.84, 7.83}, {50.75, 10.27}, {74.63, 13.09}, {107.46, 16.29}, {140.3, 18.99}, {176.12, 22.58}, {197.02, 25.53}, {217.91, 29.12}, {235.82, 31.82}, {244.78, 34.51}, {256.72, 38.1}, {274.63, 42.21}, {292.54, 46.19}, {307.46, 51.06}, {319.4, 55.69}, {328.36, 60.18}, {334.33, 58.38}, {382.09, 58.38}, {385.08, 58.51}, {838.81, 58.73}, {1677.61, 99.88}, {2922.39, 100.0}};
  parameter Real Tnom = 517.2 + 273.15;
  parameter Real Gnom = 1292.6 / 3.6;
  parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
  parameter Modelica.SIunits.MassFlowRate wsteam = 0.01 "Расход пара на выходе из сепаратора";
  package Medium_G = TPPSim.Media.ExhaustGas;
  parameter Modelica.SIunits.MassFlowRate wgas = 100 / 3.6 "Номинальный (и начальный) массовый расход газов ";
  parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
  parameter Medium_F.SaturationProperties sat_start = Medium_F.setSat_p(pflow_ote2);
  //Исходные данные для сепаратора
  parameter Modelica.SIunits.Length Dsep = 0.348 "Внутренний диаметр сепаратор";
  parameter Modelica.SIunits.Length Lsep = 5 "Длина (высота) сепаратора";
  parameter Modelica.SIunits.Length deltaSep = 0.04 "Толщина стенки сепаратора";
  parameter Integer n_sep_set = 2 "Количество сепараторов";
  //Начальные значения для сепаратора
  parameter Modelica.SIunits.Length Hw_start_set = 2 "Начальное значение уровня воды в сепараторе";
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
  parameter Integer numberOfVolumes_sh = 1 "Число участков разбиения пароперегревателя" annotation(
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
  inner Modelica.Fluid.System system(allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = Tinflow_eco, m_flow = wflow, nPorts = 1, use_T_in = false, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE ECO(redeclare TPPSim.HRSG_HeatExch.FlowSideECO flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco, numberOfVolumes = numberOfVolumes_eco, flow_DynamicMomentum = false, flow_DynamicMassBalance = false, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
    Placement(visible = true, transformation(origin = {-52, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_glob OTE1(redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, setTm = setTm_ote1, numberOfTubeSections = numberOfTubeSections_ote1, flow_DynamicMomentum = false, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
    Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_new OTE2(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE3 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2, numberOfTubeSections = numberOfTubeSections_ote2, flow_DynamicMomentum = false, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
    Placement(visible = true, transformation(origin = {2, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 600, height = 1000, offset = wgas, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 40, height = 200, offset = Tingas_sh, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH2 flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2, numberOfVolumes = numberOfVolumes_sh, flow_DynamicMomentum = true, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {38, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Drums.Separator2 separator(m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {14, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {35, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV1(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {46, 56}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable tempTable(table = temperature_exh) annotation(
    Placement(visible = true, transformation(origin = {-78, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable flowTable(table = flow_exh) annotation(
    Placement(visible = true, transformation(origin = {-78, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain temp_gain(k = Tnom / 100) annotation(
    Placement(visible = true, transformation(origin = {-52, -58}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain flow_gain(k = Gnom / 100) annotation(
    Placement(visible = true, transformation(origin = {-52, -86}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation(
    Placement(visible = true, transformation(origin = {-15, -61}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Max max2 annotation(
    Placement(visible = true, transformation(origin = {-15, -89}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant minT(k = Tingas_sh) annotation(
    Placement(visible = true, transformation(origin = {-37, -71}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant minG(k = 10) annotation(
    Placement(visible = true, transformation(origin = {-37, -93}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Continuous.Filter filter1(f_cut = 1) annotation(
    Placement(visible = true, transformation(origin = {7, -61}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Continuous.Filter filter2(f_cut = 1) annotation(
    Placement(visible = true, transformation(origin = {7, -77}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.flowLimiter flowLimiter1(redeclare package Medium = Medium_F, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {43, 39}, extent = {{-3, 3}, {3, -3}}, rotation = 0)));
  TPPSim.Pipes.SteamPipe steamPipe1(setD_flow = wsteam, setp_flow_in = pflow_sh, setp_flow_out = pflow_sh, setT_inFlow = Tinflow_sh, setT_outFlow = Tinflow_sh, Din = 0.3, delta = 0.01, Lpipe = 10, seth_in = hflow_sh_in, seth_out = hflow_sh_in, setTm = setTm_ote2, DynamicMomentum = true) annotation(
    Placement(visible = true, transformation(origin = {34, 36}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Sensors.Temperature deltaTs(TemperatureType_set = TPPSim.Sensors.TemperatureType.subcooling) annotation(
    Placement(visible = true, transformation(origin = {-38, 35}, extent = {{-6, -5}, {6, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Set(k = 10) annotation(
    Placement(visible = true, transformation(origin = {37, 85}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI(T = 120, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 10, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {-34, 86}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 50, uMin = 58 / 3.6) annotation(
    Placement(visible = true, transformation(origin = {-62, 86}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {12, 86}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  TPPSim.Sensors.Temperature deltaTs_OTE2(TemperatureType_set = TPPSim.Sensors.TemperatureType.overheating) annotation(
    Placement(visible = true, transformation(origin = {-3, 41}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  TPPSim.Controls.onAuto onAuto1(trigger = 10) annotation(
    Placement(visible = true, transformation(origin = {-10, 86}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
equation
  connect(onAuto1.y, PI.u) annotation(
    Line(points = {{-16, 86}, {-26, 86}, {-26, 86}, {-26, 86}, {-26, 86}}, color = {0, 0, 127}));
  connect(feedback.y, onAuto1.u) annotation(
    Line(points = {{4, 86}, {-2, 86}, {-2, 86}, {-2, 86}}, color = {0, 0, 127}));
  connect(PI.y, limiter.u) annotation(
    Line(points = {{-40.6, 86}, {-54.6, 86}, {-54.6, 86}, {-54.6, 86}}, color = {0, 0, 127}));
  connect(limiter.y, flowSource.m_flow_in) annotation(
    Line(points = {{-69, 86}, {-98, 86}, {-98, 60}, {-94, 60}, {-94, 58}}, color = {0, 0, 127}));
  connect(deltaTs_OTE2.deltaTs, feedback.u1) annotation(
    Line(points = {{-6, 42}, {-14, 42}, {-14, 68}, {22, 68}, {22, 86}, {18, 86}, {18, 86}}, color = {0, 0, 127}));
  connect(Set.y, feedback.u2) annotation(
    Line(points = {{32, 86}, {26, 86}, {26, 72}, {12, 72}, {12, 80}, {12, 80}}, color = {0, 0, 127}));
  connect(OTE2.flowOut, deltaTs_OTE2.port) annotation(
    Line(points = {{6, 24}, {6, 30}, {-3, 30}, {-3, 36}}, color = {0, 127, 255}));
  connect(ECO.flowOut, deltaTs.port) annotation(
    Line(points = {{-48, 24}, {-38, 24}, {-38, 30}, {-38, 30}}, color = {0, 127, 255}));
  connect(ECO.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-58, 12}, {-70, 12}, {-70, -6}, {-80, -6}, {-80, -6}}, color = {0, 127, 255}));
  connect(OTE1.gasOut, ECO.gasIn) annotation(
    Line(points = {{-28, 12}, {-46, 12}, {-46, 12}, {-46, 12}}, color = {0, 127, 255}));
  connect(steamPipe1.waterOut, SH.flowIn) annotation(
    Line(points = {{34, 32}, {34, 32}, {34, 24}, {34, 24}}, color = {0, 127, 255}));
  connect(steamPipe1.waterIn, separator.steam) annotation(
    Line(points = {{34, 40}, {34, 40}, {34, 52}, {14, 52}, {14, 52}}, color = {0, 127, 255}));
  connect(flowLimiter1.waterIn, SH.flowOut) annotation(
    Line(points = {{43, 35}, {43, 28}, {42, 28}, {42, 24}}, color = {0, 127, 255}));
  connect(flowLimiter1.waterOut, CV1.port_a) annotation(
    Line(points = {{43, 43}, {42, 43}, {42, 56}}, color = {0, 127, 255}));
  connect(filter2.y, gasSource.m_flow_in) annotation(
    Line(points = {{12, -76}, {52, -76}, {52, -52}, {92, -52}, {92, 2}, {80, 2}, {80, 2}}, color = {0, 0, 127}));
  connect(max2.y, filter2.u) annotation(
    Line(points = {{-10, -88}, {-8, -88}, {-8, -76}, {0, -76}, {0, -76}}, color = {0, 0, 127}));
  connect(filter1.y, gasSource.T_in) annotation(
    Line(points = {{12, -60}, {48, -60}, {48, -50}, {88, -50}, {88, -2}, {82, -2}, {82, -2}}, color = {0, 0, 127}));
  connect(max1.y, filter1.u) annotation(
    Line(points = {{-10, -60}, {0, -60}, {0, -60}, {0, -60}}, color = {0, 0, 127}));
  connect(minG.y, max2.u2) annotation(
    Line(points = {{-32, -92}, {-22, -92}, {-22, -92}, {-22, -92}}, color = {0, 0, 127}));
  connect(flow_gain.y, max2.u1) annotation(
    Line(points = {{-46, -86}, {-22, -86}, {-22, -86}, {-22, -86}}, color = {0, 0, 127}));
  connect(minT.y, max1.u2) annotation(
    Line(points = {{-32, -70}, {-28, -70}, {-28, -64}, {-22, -64}, {-22, -64}}, color = {0, 0, 127}));
  connect(temp_gain.y, max1.u1) annotation(
    Line(points = {{-46, -58}, {-22, -58}, {-22, -58}, {-22, -58}}, color = {0, 0, 127}));
  connect(flowTable.y, flow_gain.u) annotation(
    Line(points = {{-67, -86}, {-59, -86}}, color = {0, 0, 127}));
  connect(tempTable.y, temp_gain.u) annotation(
    Line(points = {{-67, -58}, {-63, -58}, {-63, -58}, {-59, -58}, {-59, -58}, {-61, -58}}, color = {0, 0, 127}));
  connect(SH.gasOut, OTE2.gasIn) annotation(
    Line(points = {{32, 12}, {8, 12}, {8, 12}, {8, 12}}, color = {0, 127, 255}));
  connect(OTE2.flowOut, separator.fedWater) annotation(
    Line(points = {{6, 24}, {6, 24}, {6, 48}, {8, 48}, {8, 48}}, color = {0, 127, 255}));
  connect(OTE1.flowOut, OTE2.flowIn) annotation(
    Line(points = {{-18, 24}, {-2, 24}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
  connect(ECO.flowOut, OTE1.flowIn) annotation(
    Line(points = {{-48, 24}, {-26, 24}, {-26, 24}, {-26, 24}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], ECO.flowIn) annotation(
    Line(points = {{-74, 50}, {-56, 50}, {-56, 23}}, color = {0, 127, 255}));
  connect(gasSource.ports[1], SH.gasIn) annotation(
    Line(points = {{60, -6}, {48, -6}, {48, 12}, {44, 12}}, color = {0, 127, 255}));
  connect(OTE1.gasIn, OTE2.gasOut) annotation(
    Line(points = {{-16, 12}, {-3.8, 12}}, color = {0, 127, 255}));
  connect(CV1.port_b, flowSink.ports[1]) annotation(
    Line(points = {{50, 56}, {60, 56}, {60, 56}, {60, 56}}, color = {0, 127, 255}));
  connect(constCV1.y, CV1.opening) annotation(
    Line(points = {{40, 70}, {46, 70}, {46, 60}, {46, 60}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.1")),
    Documentation(info = "<html>
<p>
Одноконтурный прямоточный КУ с регулированием расхода через PI-регулятор.
Модель со сложным разбиением OTE и упрощенным сепаратором.
Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
</p>
</html>", revisions = "Модель работает, но PI регулятор требует дополнительной настройки."),
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 0.005));
end startUpControlTest_2;