within TPPSim.Tests;
model startUpTest_2
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
  parameter Modelica.SIunits.MassFlowRate wsteam = 0.01 "Расход пара на выходе из сепаратора";
  replaceable package Medium_G = TPPSim.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
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
  parameter Integer numberOfTubeSections_eco = 1 "Число участков разбиения трубы" annotation(
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
  parameter Integer numberOfTubeSections_ote1 = 2 "Число участков разбиения трубы" annotation(
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
  parameter Integer numberOfTubeSections_ote2 = 4 "Число участков разбиения трубы" annotation(
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
  parameter Integer numberOfVolumes_sh = 10 "Число участков разбиения пароперегревателя" annotation(
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
  inner Modelica.Fluid.System system(allowFlowReversal = false) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wflow, T = Tinflow_eco) annotation(
    Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE ECO(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE3 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco, numberOfVolumes = 4, DynamicMomentum = false) annotation(
    Placement(visible = true, transformation(origin = {-46, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_new OTE1(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE3 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, setTm = setTm_ote1, numberOfTubeSections = numberOfTubeSections_ote1, DynamicMomentum = false) annotation(
    Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_new OTE2(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE3 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2, numberOfTubeSections = numberOfTubeSections_ote2, DynamicMomentum = false) annotation(
    Placement(visible = true, transformation(origin = {2, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 600, height = 1000, offset = wgas, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 40, height = 200, offset = Tingas_sh, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH2 flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2, numberOfVolumes = numberOfVolumes_sh, DynamicMomentum = true, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {35, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV1(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {46, 56}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Separator separator(redeclare package Medium = Medium_F, Din = Dsep, L = Lsep, n_sep = n_sep_set, ps_start = pflow_ote2, delta = deltaSep, Hw_start = Hw_start_set, sat_start = sat_start, t_start = Medium_F.saturationTemperature_sat(sat_start)) annotation(
    Placement(visible = true, transformation(origin = {18, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T drainSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {26, -18}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
equation
  connect(OTE1.flowOut, OTE2.flowIn) annotation(
    Line(points = {{-18, 24}, {-2, 24}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
  connect(ECO.flowOut, OTE1.flowIn) annotation(
    Line(points = {{-42, 24}, {-26, 24}, {-26, 24}, {-26, 24}}, color = {0, 127, 255}));
  connect(separator.drainFeedback, drainSink.m_flow_in) annotation(
    Line(points = {{24, 44}, {24, 44}, {24, -4}, {32, -4}, {32, -14}, {32, -14}}, color = {0, 0, 127}));
  connect(separator.downStr, drainSink.ports[1]) annotation(
    Line(points = {{18, 30}, {18, 30}, {18, -18}, {20, -18}, {20, -18}}, color = {0, 127, 255}));
  connect(separator.steam, SH.flowIn) annotation(
    Line(points = {{18, 52}, {30, 52}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
  connect(OTE2.flowOut, separator.fedWater) annotation(
    Line(points = {{6, 24}, {6, 24}, {6, 48}, {12, 48}, {12, 48}}, color = {0, 127, 255}));
  connect(CV1.port_b, flowSink.ports[1]) annotation(
    Line(points = {{50, 56}, {60, 56}, {60, 56}, {60, 56}}, color = {0, 127, 255}));
  connect(constCV1.y, CV1.opening) annotation(
    Line(points = {{40, 70}, {46, 70}, {46, 60}, {46, 60}}, color = {0, 0, 127}));
  connect(CV1.port_a, SH.flowOut) annotation(
    Line(points = {{42, 56}, {38, 56}, {38, 24}, {38, 24}}, color = {0, 127, 255}));
  connect(SH.gasOut, OTE2.gasIn) annotation(
    Line(points = {{28, 12}, {8, 12}, {8, 12}, {8, 12}}, color = {0, 127, 255}));
  connect(gasSource.ports[1], SH.gasIn) annotation(
    Line(points = {{60, -6}, {48, -6}, {48, 12}, {40, 12}, {40, 12}}, color = {0, 127, 255}));
  connect(gasSource.T_in, rampGasTemp.y) annotation(
    Line(points = {{82, -2}, {87, -2}, {87, -2}, {92, -2}, {92, -34}, {82, -34}, {82, -34}}, color = {0, 0, 127}));
  connect(rampGasFlow.y, gasSource.m_flow_in) annotation(
    Line(points = {{81, -66}, {89, -66}, {89, -66}, {97, -66}, {97, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}}, color = {0, 0, 127}));
  connect(OTE1.gasIn, OTE2.gasOut) annotation(
    Line(points = {{-15.8, 12}, {-3.8, 12}}, color = {0, 127, 255}));
  connect(ECO.gasIn, OTE1.gasOut) annotation(
    Line(points = {{-39.8, 12}, {-27.8, 12}}, color = {0, 127, 255}));
  connect(gasSink.ports[1], ECO.gasOut) annotation(
    Line(points = {{-80, -6}, {-60, -6}, {-60, 12}, {-52, 12}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], ECO.flowIn) annotation(
    Line(points = {{-74, 50}, {-50, 50}, {-50, 23}}, color = {0, 127, 255}));
  annotation(
    uses(Modelica(version = "3.2.1")),
    Documentation(info = "<html>
  <p>
  Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
  </p>
  </html>"),
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 0.005));
end startUpTest_2;