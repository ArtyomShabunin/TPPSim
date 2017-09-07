within TPPSim.Tests;
model threePDrumStartUp "Пуск трехконтурного барабанного КУ"
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
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
    Placement(visible = true, transformation(origin = {290, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = Tinflow_eco, m_flow = wflow, nPorts = 1, use_T_in = false, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_glob_simple ECO(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE_glob flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco, numberOfVolumes = numberOfVolumes_eco, flow_DynamicMomentum = false, flow_DynamicMassBalance = false, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
    Placement(visible = true, transformation(origin = {-52, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_glob OTE2(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE_glob flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2, numberOfTubeSections = numberOfTubeSections_ote2, flow_DynamicMomentum = false, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
    Placement(visible = true, transformation(origin = {0, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_glob_simple SH(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE_glob flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, wgas = wgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2, numberOfVolumes = numberOfVolumes_sh, flow_DynamicMomentum = true, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {38, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {35, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV1(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 4.1e+06, m_flow_nominal = 10, p_nominal = 41e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {46, 56}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 3, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {54, -44}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  TPPSim.Drums.Drum Drum(Din = Din_drum, L = L_drum, delta = 0.02, Hw_start = Hw_start_set) annotation(
    Placement(visible = true, transformation(origin = {0, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.SteamPipe LP_pipe(setD_flow = wsteam, setp_flow_in = pflow_sh, setp_flow_out = pflow_sh, setT_inFlow = Tinflow_sh, setT_outFlow = Tinflow_sh, Din = 0.3, delta = 0.01, Lpipe = 10, seth_in = hflow_sh_in, seth_out = hflow_sh_in, setTm = setTm_ote2, DynamicMomentum = true) annotation(
    Placement(visible = true, transformation(origin = {34, 36}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Pumps.simplePump circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {-17, -5}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  TPPSim.Pumps.simplePump FWPump(redeclare package Medium = Medium_F, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-1, -17}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Tnom = Tnom, Gnom = Gnom, Tstart = Tinflow_sh) annotation(
    Placement(visible = true, transformation(origin = {288, 12}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Controls.LC lc1(DFmax = 57, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-30, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constCV2(k = 1) annotation(
    Placement(visible = true, transformation(origin = {245, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Pipes.SteamPipe HP_pipe(setD_flow = wsteam, setp_flow_in = pflow_sh, setp_flow_out = pflow_sh, setT_inFlow = Tinflow_sh, setT_outFlow = Tinflow_sh, Din = 0.3, delta = 0.01, Lpipe = 10, seth_in = hflow_sh_in, seth_out = hflow_sh_in, setTm = setTm_ote2, DynamicMomentum = true) annotation(
    Placement(visible = true, transformation(origin = {244, 36}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Fluid.Valves.ValveCompressible CV2(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {256, 56}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_glob_simple HP_SH(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE_glob flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, wgas = wgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2, numberOfVolumes = numberOfVolumes_sh, flow_DynamicMomentum = true, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {248, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Controls.LC lc2(DFmax = 46, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {190, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_glob_simple HP_ECO(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE_glob flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco, numberOfVolumes = numberOfVolumes_eco, flow_DynamicMomentum = false, flow_DynamicMassBalance = false, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
    Placement(visible = true, transformation(origin = {176, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Drums.Drum HP_drum(Din = Din_drum, L = L_drum, delta = 0.02, Hw_start = Hw_start_set) annotation(
    Placement(visible = true, transformation(origin = {220, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_glob HP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE_glob flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas,  Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2, numberOfTubeSections = numberOfTubeSections_ote2, flow_DynamicMomentum = false, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
    Placement(visible = true, transformation(origin = {220, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump HP_circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {203, -5}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV3(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {156, 56}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constCV3(k = 1) annotation(
    Placement(visible = true, transformation(origin = {139, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_glob_simple IP_SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH_glob flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, wgas = wgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2, numberOfVolumes = numberOfVolumes_sh, flow_DynamicMomentum = true, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {142, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pipes.SteamPipe IP_pipe(setD_flow = wsteam, setp_flow_in = pflow_sh, setp_flow_out = pflow_sh, setT_inFlow = Tinflow_sh, setT_outFlow = Tinflow_sh, Din = 0.3, delta = 0.01, Lpipe = 10, seth_in = hflow_sh_in, seth_out = hflow_sh_in, setTm = setTm_ote2, DynamicMomentum = true) annotation(
    Placement(visible = true, transformation(origin = {138, 36}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Drums.Drum IP_drum(Din = Din_drum, L = L_drum, delta = 0.02, Hw_start = Hw_start_set) annotation(
    Placement(visible = true, transformation(origin = {112, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_glob IP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE_glob flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2, numberOfTubeSections = numberOfTubeSections_ote2, flow_DynamicMomentum = false, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
    Placement(visible = true, transformation(origin = {112, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump IP_circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {95, -5}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_glob_simple IP_ECO(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE_glob flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco, numberOfVolumes = numberOfVolumes_eco, flow_DynamicMomentum = false, flow_DynamicMassBalance = false, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
    Placement(visible = true, transformation(origin = {78, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump simplePump1(redeclare package Medium = Medium_F, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {19, -33}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  TPPSim.Controls.LC lc3(DFmax = 11, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {88, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(CV3.port_b, flowSink.ports[3]) annotation(
    Line(points = {{160, 56}, {162, 56}, {162, -30}, {58, -30}, {58, -34}, {54, -34}}, color = {0, 127, 255}));
  connect(lc3.y, simplePump1.D_flow_in) annotation(
    Line(points = {{78, 80}, {62, 80}, {62, -22}, {20, -22}, {20, -28}, {20, -28}}, color = {0, 0, 127}));
  connect(IP_drum.waterLevel, lc3.u) annotation(
    Line(points = {{124, 54}, {124, 54}, {124, 80}, {100, 80}, {100, 80}}, color = {0, 0, 127}));
  connect(lc2.y, FWPump.D_flow_in) annotation(
    Line(points = {{180, 80}, {140, 80}, {140, 96}, {60, 96}, {60, -8}, {0, -8}, {0, -12}, {0, -12}}, color = {0, 0, 127}));
  connect(simplePump1.port_b, IP_ECO.flowIn) annotation(
    Line(points = {{24, -32}, {40, -32}, {40, -10}, {68, -10}, {68, 22}, {74, 22}, {74, 24}}, color = {0, 127, 255}));
  connect(Drum.HPFW, simplePump1.port_a) annotation(
    Line(points = {{-10, 42}, {-10, 42}, {-10, -34}, {14, -34}, {14, -32}}, color = {0, 127, 255}));
  connect(IP_drum.fedWater, IP_ECO.flowOut) annotation(
    Line(points = {{106, 56}, {82, 56}, {82, 24}, {82, 24}}, color = {0, 127, 255}));
  connect(IP_ECO.gasOut, SH.gasIn) annotation(
    Line(points = {{72, 12}, {44, 12}, {44, 12}, {44, 12}}, color = {0, 127, 255}));
  connect(IP_EVO.gasOut, IP_ECO.gasIn) annotation(
    Line(points = {{106, 12}, {84, 12}, {84, 12}, {84, 12}}, color = {0, 127, 255}));
  connect(IP_circPump.port_b, IP_EVO.flowIn) annotation(
    Line(points = {{100, -4}, {102, -4}, {102, 24}, {108, 24}, {108, 24}}, color = {0, 127, 255}));
  connect(IP_drum.downStr, IP_circPump.port_a) annotation(
    Line(points = {{106, 38}, {90, 38}, {90, -5}}, color = {0, 127, 255}));
  connect(IP_SH.gasIn, HP_ECO.gasOut) annotation(
    Line(points = {{148, 12}, {170, 12}, {170, 12}, {170, 12}}, color = {0, 127, 255}));
  connect(IP_EVO.gasIn, IP_SH.gasOut) annotation(
    Line(points = {{118, 12}, {136, 12}, {136, 12}, {136, 12}}, color = {0, 127, 255}));
  connect(IP_EVO.flowOut, IP_drum.upStr) annotation(
    Line(points = {{116, 24}, {116, 24}, {116, 30}, {120, 30}, {120, 38}, {120, 38}}, color = {0, 127, 255}));
  connect(IP_SH.flowIn, IP_pipe.waterOut) annotation(
    Line(points = {{138, 24}, {138, 24}, {138, 32}, {138, 32}}, color = {0, 127, 255}));
  connect(IP_pipe.waterIn, IP_drum.steam) annotation(
    Line(points = {{138, 40}, {138, 40}, {138, 56}, {120, 56}, {120, 56}}, color = {0, 127, 255}));
  connect(CV3.port_a, IP_SH.flowOut) annotation(
    Line(points = {{152, 56}, {146, 56}, {146, 24}, {146, 24}}, color = {0, 127, 255}));
  connect(constCV3.y, CV3.opening) annotation(
    Line(points = {{144, 70}, {156, 70}, {156, 60}, {156, 60}}, color = {0, 0, 127}));
  connect(CV2.port_a, HP_SH.flowOut) annotation(
    Line(points = {{252, 56}, {250, 56}, {250, 36}, {252, 36}, {252, 24}, {252, 24}}, color = {0, 127, 255}));
  connect(FWPump.port_b, HP_ECO.flowIn) annotation(
    Line(points = {{4, -16}, {166, -16}, {166, 24}, {172, 24}, {172, 24}}, color = {0, 127, 255}));
  connect(HP_circPump.port_a, HP_drum.downStr) annotation(
    Line(points = {{198, -4}, {198, -4}, {198, 36}, {214, 36}, {214, 38}}, color = {0, 127, 255}));
  connect(HP_ECO.flowOut, HP_drum.fedWater) annotation(
    Line(points = {{180, 24}, {180, 24}, {180, 56}, {214, 56}, {214, 56}}, color = {0, 127, 255}));
  connect(HP_circPump.port_b, HP_EVO.flowIn) annotation(
    Line(points = {{208, -4}, {210, -4}, {210, 24}, {216, 24}, {216, 24}}, color = {0, 127, 255}));
  connect(HP_EVO.flowOut, HP_drum.upStr) annotation(
    Line(points = {{224, 24}, {224, 24}, {224, 32}, {226, 32}, {226, 38}, {228, 38}}, color = {0, 127, 255}));
  connect(HP_EVO.gasIn, HP_SH.gasOut) annotation(
    Line(points = {{226.2, 12}, {236.2, 12}, {236.2, 12}, {242.2, 12}, {242.2, 12}, {249.2, 12}, {249.2, 12}, {242.2, 12}}, color = {0, 127, 255}));
  connect(HP_ECO.gasIn, HP_EVO.gasOut) annotation(
    Line(points = {{182.2, 12}, {200.2, 12}, {200.2, 12}, {214.2, 12}, {214.2, 12}, {221.2, 12}, {221.2, 12}, {214.2, 12}}, color = {0, 127, 255}));
  connect(HP_drum.steam, HP_pipe.waterIn) annotation(
    Line(points = {{227, 55}, {235, 55}, {235, 57}, {243, 57}, {243, 41}, {243, 41}, {243, 39}, {243, 39}}, color = {0, 127, 255}));
  connect(HP_drum.waterLevel, lc2.u) annotation(
    Line(points = {{231, 53}, {231, 53}, {231, 55}, {231, 55}, {231, 81}, {201, 81}, {201, 80}, {201, 80}, {201, 79}}, color = {0, 0, 127}));
  connect(HP_SH.gasIn, GT.flowOut) annotation(
    Line(points = {{254.2, 12}, {276.2, 12}, {276.2, 12}, {278.2, 12}, {278.2, 12}, {278.2, 12}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, HP_SH.flowIn) annotation(
    Line(points = {{244, 31.16}, {244, 31.16}, {244, 33.16}, {244, 33.16}, {244, 25.16}, {244, 25.16}, {244, 23.16}, {244, 23.16}}, color = {0, 127, 255}));
  connect(constCV2.y, CV2.opening) annotation(
    Line(points = {{250.5, 69}, {252.5, 69}, {252.5, 71}, {254.5, 71}, {254.5, 61}, {256.5, 61}, {256.5, 59}, {256.5, 59}}, color = {0, 0, 127}));
  connect(CV2.port_b, flowSink.ports[2]) annotation(
    Line(points = {{260, 56}, {260, 15}, {264, 15}, {264, -26}, {56, -26}, {56, -34}, {54, -34}}, color = {0, 127, 255}));
  connect(SH.flowOut, CV1.port_a) annotation(
    Line(points = {{42, 24}, {42, 24}, {42, 46}, {38, 46}, {38, 56}, {42, 56}, {42, 56}}, color = {0, 127, 255}));
  connect(LP_pipe.waterOut, SH.flowIn) annotation(
    Line(points = {{34, 32}, {34, 32}, {34, 24}, {34, 24}}, color = {0, 127, 255}));
  connect(Drum.steam, LP_pipe.waterIn) annotation(
    Line(points = {{8, 56}, {34, 56}, {34, 40}, {34, 40}}, color = {0, 127, 255}));
  connect(constCV1.y, CV1.opening) annotation(
    Line(points = {{40, 70}, {46, 70}, {46, 60}, {46, 60}}, color = {0, 0, 127}));
  connect(CV1.port_b, flowSink.ports[1]) annotation(
    Line(points = {{50, 56}, {55, 56}, {55, -34}, {54, -34}}, color = {0, 127, 255}));
  connect(ECO.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-58, 12}, {-80, 12}, {-80, 10}, {-80, 10}}, color = {0, 127, 255}));
  connect(OTE2.gasOut, ECO.gasIn) annotation(
    Line(points = {{-6, 12}, {-46, 12}, {-46, 12}, {-46, 12}}, color = {0, 127, 255}));
  connect(lc1.y, flowSource.m_flow_in) annotation(
    Line(points = {{-40, 80}, {-94, 80}, {-94, 58}, {-94, 58}}, color = {0, 0, 127}));
  connect(Drum.waterLevel, lc1.u) annotation(
    Line(points = {{12, 54}, {14, 54}, {14, 80}, {-18, 80}, {-18, 80}}, color = {0, 0, 127}));
  connect(Drum.HPFW, FWPump.port_a) annotation(
    Line(points = {{-10, 42}, {-10, 42}, {-10, -18}, {-6, -18}, {-6, -16}}, color = {0, 127, 255}));
  connect(circPump.port_b, OTE2.flowIn) annotation(
    Line(points = {{-12, -4}, {-12, -4}, {-12, 24}, {-4, 24}, {-4, 24}}, color = {0, 127, 255}));
  connect(Drum.downStr, circPump.port_a) annotation(
    Line(points = {{-6, 38}, {-8, 38}, {-8, 28}, {-16, 28}, {-16, 10}, {-22, 10}, {-22, -4}, {-22, -4}}, color = {0, 127, 255}));
  connect(Drum.upStr, OTE2.flowOut) annotation(
    Line(points = {{7, 37}, {4, 37}, {4, 24}}, color = {0, 127, 255}));
  connect(ECO.flowOut, Drum.fedWater) annotation(
    Line(points = {{-48, 24}, {-20, 24}, {-20, 55}, {-7, 55}}, color = {0, 127, 255}));
  connect(SH.gasOut, OTE2.gasIn) annotation(
    Line(points = {{32, 12}, {6, 12}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], ECO.flowIn) annotation(
    Line(points = {{-74, 50}, {-56, 50}, {-56, 23}}, color = {0, 127, 255}));
  annotation(
    uses(Modelica(version = "3.2.1")),
    Documentation(info = "<html>
  <p>
  Модель пуска трехконтурного барабанного котла-утилизатора с ГТУ SGT5-4000F.
  </p>
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>July 25, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 0.005),
    Diagram(coordinateSystem(extent = {{-100, -100}, {300, 100}})),
    Icon(coordinateSystem(extent = {{-100, -100}, {300, 100}})),
    __OpenModelica_commandLineOptions = "");
end threePDrumStartUp;
