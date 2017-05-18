package TPPSim
  package Choices
    type HRSG_type = enumeration(verticalBottom "Вертикальный КУ входной коллектор внизу", verticalTop "Вертикальный КУ входной коллектор наверху", horizontalBottom "Гоизонтальный КУ входной коллектор внизу", horizontalTop "Гоизонтальный КУ входной коллектор наверху") "Тип котла-утилизатора (вертикальный/горизонтальный)";
  end Choices;

  package Tests
    model startUpTest_1
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
      parameter Integer numberOfVolumes_eco = 4 "Число участков разбиения теплообменника" annotation(
        Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
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
      parameter Integer numberOfVolumes_ote1 = 10 "Число участков разбиения теплообменника" annotation(
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
      parameter Integer numberOfVolumes_ote2 = 10 "Число участков разбиения теплообменника" annotation(
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
      parameter Integer numberOfVolumes_sh = 10 "Число участков разбиения теплообменника" annotation(
        Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для пароперегревателя
      parameter Modelica.SIunits.Pressure pflow_sh = 1.013e5 "Начальное давление потока вода/пар перед SH";
      parameter Modelica.SIunits.Temperature Tinflow_sh = 60 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_sh = 60 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm_sh = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_in = 2.676e6 "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_out = hflow_sh_in "Начальная энтальпия входного потока вода/пар";
      //Исходные данные для газовой стороны испарителя №2
      parameter Modelica.SIunits.Temperature Tingas_sh = 60 + 273.15 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_sh = 60 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_sh = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      inner Modelica.Fluid.System system(allowFlowReversal = false) annotation(
        Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wflow, T = Tinflow_eco) annotation(
        Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
        Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      TPPSim.HRSG_HeatExch.GFHE ECO(redeclare TPPSim.HRSG_HeatExch.FlowSideECO flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco, numberOfVolumes = numberOfVolumes_eco) annotation(
        Placement(visible = true, transformation(origin = {-46, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
        Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(
        Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TPPSim.HRSG_HeatExch.GFHE OTE1(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE3 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, setTm = setTm_ote1, numberOfVolumes = numberOfVolumes_ote1) annotation(
        Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TPPSim.HRSG_HeatExch.GFHE OTE2(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE3 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2, numberOfVolumes = numberOfVolumes_ote2) annotation(
        Placement(visible = true, transformation(origin = {2, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TPPSim.Pipes.Pipe flowPipe1(setD_flow = wflow, setp_flow_in = pflow_ote2, setp_flow_out = pflow_ote2, setT_inFlow = Tinflow_ote2, setT_outFlow = Tinflow_ote2, Din = 0.3, delta = 0.01, Lpipe = 10, seth_in = hflow_ote2_in, seth_out = hflow_ote2_in, setTm = setTm_ote2, DynamicMomentum = false) annotation(
        Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 600, height = 1000, offset = wgas, startTime = 10) annotation(
        Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 40, height = 200, offset = Tingas_sh, startTime = 10) annotation(
        Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TPPSim.HRSG_HeatExch.GFHE SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH2 flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2, numberOfVolumes = numberOfVolumes_sh, m_flow_small = 0.001, DynamicMomentum = true) annotation(
        Placement(visible = true, transformation(origin = {34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(
        Placement(visible = true, transformation(origin = {35, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      TPPSim.Separator2 separator21(m_flow_small = 0.001) annotation(
        Placement(visible = true, transformation(origin = {20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveCompressible CV1(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
        Placement(visible = true, transformation(origin = {46, 56}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
    equation
      connect(OTE2.flowOut, separator21.fedWater) annotation(
        Line(points = {{6, 24}, {6, 24}, {6, 48}, {14, 48}, {14, 48}}, color = {0, 127, 255}));
      connect(ECO.flowOut, OTE1.flowIn) annotation(
        Line(points = {{-42, 24}, {-26, 24}, {-26, 24}, {-26, 24}}, color = {0, 127, 255}));
      connect(separator21.steam, SH.flowIn) annotation(
        Line(points = {{20, 51}, {20, 54}, {30, 54}, {30, 24}}, color = {0, 127, 255}));
      connect(flowPipe1.waterOut, OTE2.flowIn) annotation(
        Line(points = {{-6, 30}, {-2, 30}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
      connect(OTE1.flowOut, flowPipe1.waterIn) annotation(
        Line(points = {{-18, 24}, {-18, 30}, {-15, 30}}, color = {0, 127, 255}));
      connect(constCV1.y, CV1.opening) annotation(
        Line(points = {{40, 70}, {46, 70}, {46, 60}, {46, 60}}, color = {0, 0, 127}));
      connect(CV1.port_a, SH.flowOut) annotation(
        Line(points = {{42, 56}, {38, 56}, {38, 24}, {38, 24}}, color = {0, 127, 255}));
      connect(CV1.port_b, flowSink.ports[1]) annotation(
        Line(points = {{50, 56}, {60, 56}, {60, 56}, {60, 56}}, color = {0, 127, 255}));
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
    end startUpTest_1;

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

    model startUpTest_11 "Модель прямоточной части КУ со сложной разбивкой OTE и упрощенной моделью сепаратора"
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
      TPPSim.HRSG_HeatExch.GFHE ECO(redeclare TPPSim.HRSG_HeatExch.FlowSideECO flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco, numberOfVolumes = 4, DynamicMomentum = false) annotation(
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
      TPPSim.HRSG_HeatExch.GFHE SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH2 flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2, numberOfVolumes = numberOfVolumes_sh, DynamicMomentum = true, m_flow_small = 0.001) annotation(
        Placement(visible = true, transformation(origin = {34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TPPSim.Separator2 separator(m_flow_small = 0.001) annotation(
        Placement(visible = true, transformation(origin = {14, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(
        Placement(visible = true, transformation(origin = {35, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveCompressible CV1(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
        Placement(visible = true, transformation(origin = {46, 56}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
        Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    equation
      connect(separator.steam, SH.flowIn) annotation(
        Line(points = {{14, 52}, {30, 52}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
      connect(OTE2.flowOut, separator.fedWater) annotation(
        Line(points = {{6, 24}, {6, 24}, {6, 48}, {8, 48}}, color = {0, 127, 255}));
      connect(OTE1.flowOut, OTE2.flowIn) annotation(
        Line(points = {{-18, 24}, {-2, 24}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
      connect(ECO.flowOut, OTE1.flowIn) annotation(
        Line(points = {{-42, 24}, {-26, 24}, {-26, 24}, {-26, 24}}, color = {0, 127, 255}));
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
      </html>", revisions = "Модель со сложным разбиением и упрощенным сепаратором"),
        experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 0.005));
    end startUpTest_11;

    model startUpControlTest_1
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
      TPPSim.HRSG_HeatExch.GFHE_new OTE1(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE3 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, setTm = setTm_ote1, numberOfTubeSections = numberOfTubeSections_ote1, flow_DynamicMomentum = false, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
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
      Modelica.Fluid.Sensors.Pressure ECO_out_press(redeclare package Medium = Medium_F) annotation(
        Placement(visible = true, transformation(origin = {-37, 37}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Fluid.Sensors.SpecificEnthalpy ECO_in_ent(redeclare package Medium = Medium_F) annotation(
        Placement(visible = true, transformation(origin = {-7, 37}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Fluid.Sensors.SpecificEnthalpy ECO_gasout_ent(redeclare package Medium = Medium_G) annotation(
        Placement(visible = true, transformation(origin = {-65, -9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Fluid.Sensors.MassFlowRate ECO_gasout_flow(redeclare package Medium = Medium_G) annotation(
        Placement(visible = true, transformation(origin = {-67, 11}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
      Modelica.Fluid.Sensors.MassFlowRate ECO_gasin_flow(redeclare package Medium = Medium_G) annotation(
        Placement(visible = true, transformation(origin = {-39, 13}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
      Modelica.Fluid.Sensors.SpecificEnthalpy ECO_gasin_ent(redeclare package Medium = Medium_G) annotation(
        Placement(visible = true, transformation(origin = {-47, -9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
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
      FWControl fWControl annotation(
        Placement(visible = true, transformation(origin = {-24, -38}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    equation
      connect(ECO_gasout_flow.m_flow, fWControl.gasFlow_out) annotation(
        Line(points = {{-66, 16}, {-60, 16}, {-60, -18}, {-6, -18}, {-6, -32}, {-12, -32}, {-12, -32}}, color = {0, 0, 127}));
      connect(ECO_gasout_ent.h_out, fWControl.gasEnt_out) annotation(
        Line(points = {{-60, -8}, {-56, -8}, {-56, -50}, {-6, -50}, {-6, -40}, {-12, -40}, {-12, -40}}, color = {0, 0, 127}));
      connect(ECO_gasin_flow.m_flow, fWControl.gasFlow_in) annotation(
        Line(points = {{-38, 18}, {-36, 18}, {-36, -4}, {-8, -4}, {-8, -28}, {-12, -28}, {-12, -28}}, color = {0, 0, 127}));
      connect(ECO_gasin_ent.h_out, fWControl.gasEnt_in) annotation(
        Line(points = {{-42, -8}, {-2, -8}, {-2, -36}, {-12, -36}, {-12, -36}}, color = {0, 0, 127}));
      connect(ECO_in_ent.h_out, fWControl.flowEnt_in) annotation(
        Line(points = {{-1.5, 37}, {2, 37}, {2, -48}, {-12, -48}}, color = {0, 0, 127}));
      connect(flowSource.m_flow_in, fWControl.FWflow) annotation(
        Line(points = {{-94, 58}, {-100, 58}, {-100, -38}, {-36, -38}, {-36, -38}}, color = {0, 0, 127}));
      connect(ECO_out_press.p, fWControl.flowPress_out) annotation(
        Line(points = {{-32, 38}, {-32, 38}, {-32, -22}, {0, -22}, {0, -44}, {-12, -44}, {-12, -44}}, color = {0, 0, 127}));
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
      connect(ECO_gasout_ent.port, ECO.gasOut) annotation(
        Line(points = {{-64, -14}, {-72, -14}, {-72, 0}, {-58, 0}, {-58, 12}, {-58, 12}}, color = {0, 127, 255}));
      connect(SH.gasOut, OTE2.gasIn) annotation(
        Line(points = {{32, 12}, {8, 12}, {8, 12}, {8, 12}}, color = {0, 127, 255}));
      connect(ECO_gasout_flow.port_b, gasSink.ports[1]) annotation(
        Line(points = {{-72, 12}, {-74, 12}, {-74, -6}, {-80, -6}, {-80, -6}}, color = {0, 127, 255}));
      connect(ECO.gasOut, ECO_gasout_flow.port_a) annotation(
        Line(points = {{-58, 12}, {-62, 12}, {-62, 12}, {-62, 12}}, color = {0, 127, 255}));
      connect(ECO_in_ent.port, ECO.flowIn) annotation(
        Line(points = {{-6, 32}, {-22, 32}, {-22, 44}, {-52, 44}, {-52, 24}, {-56, 24}, {-56, 24}}, color = {0, 127, 255}));
      connect(ECO.gasIn, ECO_gasin_ent.port) annotation(
        Line(points = {{-46, 12}, {-46, 12}, {-46, -2}, {-54, -2}, {-54, -14}, {-46, -14}, {-46, -14}}, color = {0, 127, 255}));
      connect(OTE1.gasOut, ECO_gasin_flow.port_a) annotation(
        Line(points = {{-28, 12}, {-34, 12}, {-34, 14}, {-34, 14}}, color = {0, 127, 255}));
      connect(OTE1.flowIn, ECO_out_press.port) annotation(
        Line(points = {{-26, 24}, {-38, 24}, {-38, 32}, {-36, 32}}, color = {0, 127, 255}));
      connect(OTE2.flowOut, separator.fedWater) annotation(
        Line(points = {{6, 24}, {6, 24}, {6, 48}, {8, 48}, {8, 48}}, color = {0, 127, 255}));
      connect(OTE1.flowOut, OTE2.flowIn) annotation(
        Line(points = {{-18, 24}, {-2, 24}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
      connect(ECO.flowOut, OTE1.flowIn) annotation(
        Line(points = {{-48, 24}, {-26, 24}, {-26, 24}, {-26, 24}}, color = {0, 127, 255}));
      connect(ECO.gasIn, ECO_gasin_flow.port_b) annotation(
        Line(points = {{-46, 12}, {-44, 12}, {-44, 13}}, color = {0, 127, 255}));
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
      Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
      Первая попытка реалиизовать регулирование расхода при пуске прямоточного КУ.
      </p>
      </html>", revisions = "Модель со сложным разбиением и упрощенным сепаратором"),
        experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 0.005));
    end startUpControlTest_1;

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
        Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TPPSim.HRSG_HeatExch.GFHE ECO(redeclare TPPSim.HRSG_HeatExch.FlowSideECO flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco, numberOfVolumes = numberOfVolumes_eco, flow_DynamicMomentum = false, flow_DynamicMassBalance = false, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
        Placement(visible = true, transformation(origin = {-52, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
        Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(
        Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TPPSim.HRSG_HeatExch.GFHE_new OTE2(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE3 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2, numberOfTubeSections = numberOfTubeSections_ote2, flow_DynamicMomentum = false, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
        Placement(visible = true, transformation(origin = {0, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 600, height = 1000, offset = wgas, startTime = 10) annotation(
        Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 40, height = 200, offset = Tingas_sh, startTime = 10) annotation(
        Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TPPSim.HRSG_HeatExch.GFHE SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH2 flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2, numberOfVolumes = numberOfVolumes_sh, flow_DynamicMomentum = true, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true, m_flow_small = 0.01) annotation(
        Placement(visible = true, transformation(origin = {38, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(
        Placement(visible = true, transformation(origin = {35, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveCompressible CV1(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
        Placement(visible = true, transformation(origin = {46, 56}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
        Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Fluid.Sensors.Pressure ECO_out_press(redeclare package Medium = Medium_F) annotation(
        Placement(visible = true, transformation(origin = {-37, 37}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Fluid.Sensors.SpecificEnthalpy ECO_in_ent(redeclare package Medium = Medium_F) annotation(
        Placement(visible = true, transformation(origin = {-51, 59}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Fluid.Sensors.SpecificEnthalpy ECO_gasout_ent(redeclare package Medium = Medium_G) annotation(
        Placement(visible = true, transformation(origin = {-65, -9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Fluid.Sensors.MassFlowRate ECO_gasout_flow(redeclare package Medium = Medium_G) annotation(
        Placement(visible = true, transformation(origin = {-67, 11}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
      Modelica.Fluid.Sensors.MassFlowRate ECO_gasin_flow(redeclare package Medium = Medium_G) annotation(
        Placement(visible = true, transformation(origin = {-39, 13}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
      Modelica.Fluid.Sensors.SpecificEnthalpy ECO_gasin_ent(redeclare package Medium = Medium_G) annotation(
        Placement(visible = true, transformation(origin = {-47, -9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
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
        Placement(visible = true, transformation(origin = {43, 45}, extent = {{-3, 3}, {3, -3}}, rotation = 0)));
      TPPSim.Drums.Drum Drum(Din = Din_drum, L = L_drum, delta = 0.02, Hw_start = Hw_start_set) annotation(
        Placement(visible = true, transformation(origin = {0, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Feedback feedback annotation(
        Placement(visible = true, transformation(origin = {12, 86}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant levelSet(k = 0.5) annotation(
        Placement(visible = true, transformation(origin = {37, 85}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
      Modelica.Blocks.Continuous.PI PI(T = 120, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 100, y_start = 0) annotation(
        Placement(visible = true, transformation(origin = {-16, 86}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 50, uMin = 0) annotation(
        Placement(visible = true, transformation(origin = {-44, 86}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
      TPPSim.Pipes.SteamPipe steamPipe1(setD_flow = wsteam, setp_flow_in = pflow_sh, setp_flow_out = pflow_sh, setT_inFlow = Tinflow_sh, setT_outFlow = Tinflow_sh, Din = 0.3, delta = 0.01, Lpipe = 10, seth_in = hflow_sh_in, seth_out = hflow_sh_in, setTm = setTm_ote2, DynamicMomentum = true) annotation(
        Placement(visible = true, transformation(origin = {34, 36}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
    equation
      connect(steamPipe1.waterIn, Drum.steam) annotation(
        Line(points = {{34, 40}, {34, 40}, {34, 56}, {8, 56}, {8, 56}}, color = {0, 127, 255}));
      connect(SH.flowIn, steamPipe1.waterOut) annotation(
        Line(points = {{34, 24}, {34, 24}, {34, 32}, {34, 32}}, color = {0, 127, 255}));
      connect(SH.flowOut, flowLimiter1.waterIn) annotation(
        Line(points = {{42, 24}, {44, 24}, {44, 42}, {44, 42}}, color = {0, 127, 255}));
      connect(flowLimiter1.waterOut, CV1.port_a) annotation(
        Line(points = {{43, 49}, {42, 49}, {42, 56}}, color = {0, 127, 255}));
      connect(Drum.waterLevel, feedback.u2) annotation(
        Line(points = {{12, 54}, {12, 54}, {12, 80}, {12, 80}}, color = {0, 0, 127}));
      connect(limiter.y, flowSource.m_flow_in) annotation(
        Line(points = {{-50, 86}, {-96, 86}, {-96, 58}, {-94, 58}}, color = {0, 0, 127}));
      connect(PI.y, limiter.u) annotation(
        Line(points = {{-22, 86}, {-36, 86}, {-36, 86}, {-36, 86}}, color = {0, 0, 127}));
      connect(feedback.y, PI.u) annotation(
        Line(points = {{4, 86}, {-8, 86}, {-8, 86}, {-8, 86}}, color = {0, 0, 127}));
      connect(levelSet.y, feedback.u1) annotation(
        Line(points = {{31, 85}, {23, 85}, {23, 86}, {18, 86}}, color = {0, 0, 127}));
      connect(Drum.downStr, OTE2.flowIn) annotation(
        Line(points = {{-7, 37}, {-4, 37}, {-4, 24}}, color = {0, 127, 255}));
      connect(Drum.upStr, OTE2.flowOut) annotation(
        Line(points = {{7, 37}, {4, 37}, {4, 24}}, color = {0, 127, 255}));
      connect(ECO.flowOut, Drum.fedWater) annotation(
        Line(points = {{-48, 24}, {-20, 24}, {-20, 55}, {-7, 55}}, color = {0, 127, 255}));
      connect(Drum.fedWater, ECO_out_press.port) annotation(
        Line(points = {{-7, 55}, {-26, 55}, {-26, 30}, {-36, 30}, {-36, 32}}, color = {0, 127, 255}));
      connect(ECO_gasin_flow.port_a, OTE2.gasOut) annotation(
        Line(points = {{-34, 14}, {-6, 14}, {-6, 12}, {-6, 12}}, color = {0, 127, 255}));
      connect(ECO_in_ent.port, ECO.flowIn) annotation(
        Line(points = {{-51, 54}, {-52, 54}, {-52, 24}, {-56, 24}}, color = {0, 127, 255}));
      connect(SH.gasOut, OTE2.gasIn) annotation(
        Line(points = {{32, 12}, {6, 12}}, color = {0, 127, 255}));
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
      connect(ECO_gasout_ent.port, ECO.gasOut) annotation(
        Line(points = {{-64, -14}, {-72, -14}, {-72, 0}, {-58, 0}, {-58, 12}, {-58, 12}}, color = {0, 127, 255}));
      connect(ECO_gasout_flow.port_b, gasSink.ports[1]) annotation(
        Line(points = {{-72, 12}, {-74, 12}, {-74, -6}, {-80, -6}, {-80, -6}}, color = {0, 127, 255}));
      connect(ECO.gasOut, ECO_gasout_flow.port_a) annotation(
        Line(points = {{-58, 12}, {-62, 12}, {-62, 12}, {-62, 12}}, color = {0, 127, 255}));
      connect(ECO.gasIn, ECO_gasin_ent.port) annotation(
        Line(points = {{-46, 12}, {-46, 12}, {-46, -2}, {-54, -2}, {-54, -14}, {-46, -14}, {-46, -14}}, color = {0, 127, 255}));
      connect(ECO.gasIn, ECO_gasin_flow.port_b) annotation(
        Line(points = {{-46, 12}, {-44, 12}, {-44, 13}}, color = {0, 127, 255}));
      connect(flowSource.ports[1], ECO.flowIn) annotation(
        Line(points = {{-74, 50}, {-56, 50}, {-56, 23}}, color = {0, 127, 255}));
      connect(gasSource.ports[1], SH.gasIn) annotation(
        Line(points = {{60, -6}, {48, -6}, {48, 12}, {44, 12}}, color = {0, 127, 255}));
      connect(CV1.port_b, flowSink.ports[1]) annotation(
        Line(points = {{50, 56}, {60, 56}, {60, 56}, {60, 56}}, color = {0, 127, 255}));
      connect(constCV1.y, CV1.opening) annotation(
        Line(points = {{40, 70}, {46, 70}, {46, 60}, {46, 60}}, color = {0, 0, 127}));
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


    model drumOnly
      package Medium = Modelica.Media.Water.WaterIF97_ph;
      TPPSim.Drums.Drum Drum(Din = 1, L = 9, delta = 0.02, ps_start = system.p_ambient) annotation(
        Placement(visible = true, transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T FW(redeclare package Medium = Medium, T = 60 + 273.15, nPorts = 1, use_m_flow_in = true) annotation(
        Placement(visible = true, transformation(origin = {-48, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary Sink(redeclare package Medium = Medium, T = 60 + 273.15, nPorts = 1, p = system.p_ambient) annotation(
        Placement(visible = true, transformation(origin = {72, 32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(
        Placement(visible = true, transformation(origin = {35, 45}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveCompressible CV1(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
        Placement(visible = true, transformation(origin = {46, 32}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      inner Modelica.Fluid.System system annotation(
        Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(CV1.port_b, Sink.ports[1]) annotation(
        Line(points = {{50, 32}, {62, 32}, {62, 32}, {62, 32}}, color = {0, 127, 255}));
      connect(Drum.steam, CV1.port_a) annotation(
        Line(points = {{18, 20}, {18, 20}, {18, 32}, {42, 32}, {42, 32}}, color = {0, 127, 255}));
      connect(constCV1.y, CV1.opening) annotation(
        Line(points = {{40, 46}, {46, 46}, {46, 36}, {46, 36}}, color = {0, 0, 127}));
      connect(Drum.FW_feedback, FW.m_flow_in) annotation(
        Line(points = {{22, 14}, {26, 14}, {26, -18}, {-72, -18}, {-72, 38}, {-58, 38}, {-58, 38}}, color = {0, 0, 127}));
      connect(FW.ports[1], Drum.fedWater) annotation(
        Line(points = {{-38, 30}, {2, 30}, {2, 20}, {4, 20}}, color = {0, 127, 255}));
      connect(Drum.upStr, Drum.downStr) annotation(
        Line(points = {{17, 1}, {15, 1}, {15, -15}, {1, -15}, {1, 1}, {3, 1}}, color = {0, 127, 255}));
    initial equation
      der(Drum.ps) = 0;
    end drumOnly;

    model startUpControlTest_2
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
      TPPSim.HRSG_HeatExch.GFHE_new OTE1(redeclare TPPSim.HRSG_HeatExch.FlowSideOTE3 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, setTm = setTm_ote1, numberOfTubeSections = numberOfTubeSections_ote1, flow_DynamicMomentum = false, flow_DynamicMassBalance = true, flow_DynamicEnergyBalance = true, flow_DynamicTm = true, gas_DynamicMassBalance = true, gas_DynamicEnergyBalance = true) annotation(
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
      TPPSim.Sensors.Temperature deltaTs annotation(
        Placement(visible = true, transformation(origin = {-38, 35}, extent = {{-6, -5}, {6, 5}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant Set(k = 5) annotation(
        Placement(visible = true, transformation(origin = {37, 85}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
      Modelica.Blocks.Continuous.PI PI(T = 120, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 100, y_start = 0) annotation(
        Placement(visible = true, transformation(origin = {-16, 86}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 50, uMin = 58 / 3.6) annotation(
        Placement(visible = true, transformation(origin = {-44, 86}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
      Modelica.Blocks.Math.Feedback feedback annotation(
        Placement(visible = true, transformation(origin = {12, 86}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
    equation
      connect(Set.y, feedback.u1) annotation(
        Line(points = {{32, 86}, {20, 86}, {20, 86}, {18, 86}}, color = {0, 0, 127}));
      connect(deltaTs.deltaTs, feedback.u2) annotation(
        Line(points = {{-34, 36}, {-12, 36}, {-12, 64}, {12, 64}, {12, 80}, {12, 80}}, color = {0, 0, 127}));
      connect(limiter.y, flowSource.m_flow_in) annotation(
        Line(points = {{-50, 86}, {-98, 86}, {-98, 60}, {-94, 60}, {-94, 58}}, color = {0, 0, 127}));
      connect(PI.y, limiter.u) annotation(
        Line(points = {{-22, 86}, {-36, 86}, {-36, 86}, {-36, 86}}, color = {0, 0, 127}));
      connect(feedback.y, PI.u) annotation(
        Line(points = {{4, 86}, {-8, 86}, {-8, 86}, {-8, 86}}, color = {0, 0, 127}));
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
  Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
  Первая попытка реалиизовать регулирование расхода при пуске прямоточного КУ.
  </p>
  </html>", revisions = "Модель со сложным разбиением и упрощенным сепаратором"),
        experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 0.005));
    end startUpControlTest_2;


    model test_when
      Real trigger(start = 1.0, fixed = true);
    equation
      der(trigger) = 0;
      when trigger > 0.5 and time > 5 then
        reinit(trigger, 0);
      end when;
      annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
    end test_when;
  end Tests;

  package functions
    function alfaFor2ph
      input Medium.SpecificEnthalpy h_n[2];
      input Medium.MassFlowRate D_flow_v;
      input Medium.AbsolutePressure p_v;
      input Modelica.SIunits.Diameter Din;
      input Modelica.SIunits.Area f_flow;
      output Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
    protected
      package Medium = Modelica.Media.Water.WaterIF97_ph;
      Medium.AbsolutePressure pc = 22.06e6;
      Modelica.SIunits.SpecificEnthalpy hzero = 1e-3;
      Modelica.SIunits.Pressure pzero = 10;
      Medium.SpecificEnthalpy h_v;
      Medium.Density rho_n[2];
      Medium.Density rho_v;
      Medium.Density rhov;
      Medium.Density rhol;
      Medium.SpecificEnthalpy hl;
      Medium.SpecificEnthalpy hv;
      Real Re_flow_eco;
      Real Re_flow_sh;
      Medium.ThermalConductivity k_flow_eco;
      Medium.ThermalConductivity k_flow_sh;
      Real Pr_flow_eco;
      Real Pr_flow_sh;
      Medium.DynamicViscosity mu_flow_eco;
      Medium.DynamicViscosity mu_flow_sh;
      Modelica.SIunits.Velocity w_flow_v_eco;
      Modelica.SIunits.Velocity w_flow_v_sh;
      Real A_alfa;
      Real C_alfa;
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_eco "Коэффициент теплопередачи со стороны потока вода/пар";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_sh "Коэффициент теплопередачи со стороны потока вода/пар";
    algorithm
      h_v := 0.5 * (h_n[1] + h_n[2]);
      for i in 1:2 loop
        rho_n[i] := Medium.density(Medium.setState_ph(p_v, h_n[i]));
      end for;
      rho_v := 0.5 * (rho_n[2] + rho_n[1]);
      hl := Medium.bubbleEnthalpy(Medium.setSat_p(p_v));
      hv := Medium.dewEnthalpy(Medium.setSat_p(p_v));
      rhol := Medium.bubbleDensity(Medium.setSat_p(p_v));
      rhov := Medium.dewDensity(Medium.setSat_p(p_v));
      if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
        k_flow_sh := k_flow_eco;
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
        Pr_flow_sh := Pr_flow_eco;
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
        mu_flow_sh := mu_flow_eco;
        w_flow_v_eco := D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
        Re_flow_sh := Re_flow_eco;
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
        k_flow_sh := k_flow_eco;
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
        Pr_flow_sh := Pr_flow_eco;
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
        mu_flow_sh := mu_flow_eco;
        w_flow_v_eco := D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
        Re_flow_sh := Re_flow_eco;
      elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco := D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco := D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco := D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco := D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco := D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      else
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco := D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      end if;
// 1-phase or almost uniform properties
// 2-phase
// liquid/2-phase
// 2-phase/vapour
// liquid/2-phase/vapour
// 2-phase/liquid
// vapour/2-phase/liquid
// vapour/2-phase
      A_alfa := min(max((hl - h_n[1]) / max(h_n[2] - h_n[1], 0.01), 0), 1);
      C_alfa := min(max((h_n[2] - hv) / max(h_n[2] - h_n[1], 0.01), 0), 1);
      alfa_flow_eco := 0.023 * k_flow_eco / Din * Re_flow_eco ^ 0.8 * Pr_flow_eco ^ 0.4;
      alfa_flow_sh := 0.023 * k_flow_sh / Din * Re_flow_sh ^ 0.8 * Pr_flow_sh ^ 0.4;
      alfa_flow := ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) * alfa_flow_eco + ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2) * alfa_flow_sh + (1 - ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) - ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2)) * 20000;
    end alfaFor2ph;

    function deltaPg
      import Modelica.SIunits.Conversions.to_degF;
      input Medium.MassFlowRate deltaDGas "Расход дымовых газов";
      input Integer z1 "Число труб по ширине газохода";
      input Integer z2 "Число труб по ходу газов в данной поверхности нагрева";
      input Modelica.SIunits.Diameter Dout "Диаметр теплообменной трубки";
      input Modelica.SIunits.Length Lpipe "Длина теплообменной трубки";
      input Modelica.SIunits.Length s1 "Поперечный шаг";
      input Modelica.SIunits.Length s2 "Продольный шаг";
      input Medium.ThermodynamicState state;
      output Medium.AbsolutePressure deltaPg;
    protected
      package Medium = TPPSim.ExhaustGas;
      Medium.MolarMass MM;
      Medium.DynamicViscosity mu "Динамическая вязкость газов";
      Medium.MassFlowRate Gg "Gas mass velocity";
    algorithm
      mu := Medium.dynamicViscosity(state);
      MM := Medium.molarMass(state);
      Gg := deltaDGas / z1 / Lpipe / (s1 - Dout);
      deltaPg := Gg ^ 1.684 * Dout ^ 0.611 * mu ^ 0.216 * (460 + to_degF(state.T)) * z2 / s1 ^ 0.412 / s2 ^ 0.515 / (MM * 10 ^ 3);
    end deltaPg;

    function alfaForSH
      input Medium.SpecificEnthalpy h_v;
      input Medium.MassFlowRate D_flow_n1;
      input Medium.AbsolutePressure p_v;
      input Modelica.SIunits.Diameter Din;
      input Modelica.SIunits.Area f_flow;
      input Medium.MassFlowRate m_flow_small = 0;
      output Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
    protected
      package Medium = Modelica.Media.Water.WaterIF97_ph;
      Medium.Density rho_v;
      Medium.DynamicViscosity mu_flow;
      Modelica.SIunits.Velocity w_flow;
      Real Re_flow;
      Medium.ThermalConductivity k_flow;
      Real Pr_flow;
    algorithm
      rho_v := Medium.density(Medium.setState_ph(p_v, h_v));
      k_flow := Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
      mu_flow := Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v));
      Pr_flow := Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
      w_flow := max(D_flow_n1 - m_flow_small, 0) / rho_v / f_flow;
      Re_flow := w_flow * Din * rho_v / mu_flow;
      alfa_flow := 0.023 * k_flow / Din * Re_flow ^ 0.8 * Pr_flow ^ 0.4;
    end alfaForSH;

    function calc_rho_v
      input Medium.SpecificEnthalpy h_n[2];
      input Medium.AbsolutePressure p_v;
      output Medium.Density rho_v;
    protected
      package Medium = Modelica.Media.Water.WaterIF97_ph;
      constant Medium.AbsolutePressure pc = 22.06e6;
      constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3;
      constant Modelica.SIunits.Pressure pzero = 10;
      Medium.SaturationProperties sat;
      Medium.SpecificEnthalpy hl;
      Medium.SpecificEnthalpy hv;
      Medium.Density rhov;
      Medium.Density rhol;
      Medium.Density rho_n[2];
      Real AA;
    algorithm
      sat := Medium.setSat_p(p_v);
      hl := Medium.bubbleEnthalpy(sat);
      hv := Medium.dewEnthalpy(sat);
      rhol := Medium.bubbleDensity(sat);
      rhov := Medium.dewDensity(sat);
      AA := (hv - hl) / (1 / rhov - 1 / rhol);
      for i in 1:2 loop
        rho_n[i] := Medium.density(Medium.setState_ph(p_v, h_n[i]));
      end for;
      if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
        rho_v := (rho_n[1] + rho_n[2]) / 2;
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
        rho_v := AA * log(rho_n[1] / rho_n[2]) / (h_n[2] - h_n[1]);
      elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
        rho_v := ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rho_n[2])) / (h_n[2] - h_n[1]);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
        rho_v := (AA * log(rho_n[1] / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
      elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
        rho_v := ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
        rho_v := (AA * log(rho_n[1] / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
      elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
        rho_v := ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
      else
        rho_v := ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rho_n[2])) / (h_n[2] - h_n[1]);
      end if;
    end calc_rho_v;

    function deltaPg_lite
      import Modelica.SIunits.Conversions.to_degF;
      input Medium.MassFlowRate deltaDGas "Расход дымовых газов";
      input Real Kaer "Коэффициент для расчета аэродинамического сопротивления";
      input Modelica.SIunits.Area f_gas "Площадь для прохода газов на одном участке разбиения";
      input Medium.ThermodynamicState state;
      output Medium.AbsolutePressure deltaPg;
    protected
      package Medium = TPPSim.Media.ExhaustGas;
      Medium.MolarMass MM;
      Medium.DynamicViscosity mu "Динамическая вязкость газов";
    algorithm
      mu := Medium.dynamicViscosity(state);
      MM := Medium.molarMass(state);
      deltaPg := Kaer * (deltaDGas / f_gas) ^ 1.684 * mu ^ 0.216 * (460 + to_degF(state.T)) / (MM * 10 ^ 3);
    end deltaPg_lite;

    function calc_rho_drdh_drdp
      input Medium.SpecificEnthalpy h_n[2];
      input Medium.AbsolutePressure p_v;
      output Medium.Density rho_v;
      output Modelica.SIunits.DerDensityByPressure drdp_v;
      output Modelica.SIunits.DerDensityByEnthalpy drdh_v1, drdh_v2;
    protected
      package Medium = Modelica.Media.Water.WaterIF97_ph;
      constant Medium.AbsolutePressure pc = 22.06e6;
      constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3;
      constant Modelica.SIunits.Pressure pzero = 10;
      Medium.ThermodynamicState stateFlow[2];
      Medium.SaturationProperties sat;
      Medium.SpecificEnthalpy hl;
      Medium.SpecificEnthalpy hv;
      Medium.Density rhov;
      Medium.Density rhol;
      Medium.Density rho_n[2];
      Modelica.SIunits.DerDensityByPressure drdp_n[2];
      Modelica.SIunits.DerDensityByPressure drdh_n[2];
      Modelica.SIunits.DerDensityByPressure drldp;
      Modelica.SIunits.DerDensityByPressure drvdp;
      Modelica.SIunits.DerEnthalpyByPressure dhldp;
      Modelica.SIunits.DerEnthalpyByPressure dhvdp;
      Real AA;
      Real AA1;
    algorithm
      sat := Medium.setSat_p(p_v);
      hl := Medium.bubbleEnthalpy(sat);
      hv := Medium.dewEnthalpy(sat);
      rhol := Medium.bubbleDensity(sat);
      rhov := Medium.dewDensity(sat);
      drldp := Medium.dBubbleDensity_dPressure(sat);
      drvdp := Medium.dDewDensity_dPressure(sat);
      dhldp := Medium.dBubbleEnthalpy_dPressure(sat);
      dhvdp := Medium.dDewEnthalpy_dPressure(sat);
      AA := (hv - hl) / (1 / rhov - 1 / rhol);
      AA1 := ((dhvdp - dhldp) * (rhol - rhov) * rhol * rhov - (hv - hl) * (rhov ^ 2 * drldp - rhol ^ 2 * drvdp)) / (rhol - rhov) ^ 2;
      for i in 1:2 loop
        stateFlow[i] := Medium.setState_ph(p_v, h_n[i]);
        rho_n[i] := Medium.density(stateFlow[i]);
        drdp_n[i] := Medium.density_derp_h(stateFlow[i]);
        drdh_n[i] := Medium.density_derh_p(stateFlow[i]);
      end for;
      if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
        rho_v := (rho_n[1] + rho_n[2]) / 2;
        drdp_v := (drdp_n[1] + drdp_n[2]) / 2;
        drdh_v1 := drdh_n[1] / 2;
        drdh_v2 := drdh_n[2] / 2;
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
        rho_v := AA * log(rho_n[1] / rho_n[2]) / (h_n[2] - h_n[1]);
        drdp_v := (AA1 * log(rho_n[1] / rho_n[2]) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
        drdh_v1 := (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
        drdh_v2 := (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
      elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
        rho_v := ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rho_n[2])) / (h_n[2] - h_n[1]);
        drdp_v := ((drdp_n[1] + drldp) * (hl - h_n[1]) / 2 + (rho_n[1] + rhol) / 2 * dhldp + AA1 * log(rhol / rho_n[2]) + AA * (1 / rhol * drldp - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
        drdh_v1 := (rho_v - (rho_n[1] + rhol) / 2 + drdh_n[1] * (hl - h_n[1]) / 2) / (h_n[2] - h_n[1]);
        drdh_v2 := (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
        rho_v := (AA * log(rho_n[1] / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
        drdp_v := (AA1 * log(rho_n[1] / rhov) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rhov * drvdp) + (drvdp + drdp_n[2]) * (h_n[2] - hv) / 2 - (rhov + rho_n[2]) / 2 * dhvdp) / (h_n[2] - h_n[1]);
        drdh_v1 := (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
        drdh_v2 := ((rhov + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
      elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
        rho_v := ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
        drdp_v := ((drdp_n[1] + drldp) * (hl - h_n[1]) / 2 + (rho_n[1] + rhol) / 2 * dhldp + AA1 * log(rhol / rhov) + AA * (1 / rhol * drldp - 1 / rhov * drvdp) + (drvdp + drdp_n[2]) * (h_n[2] - hv) / 2 - (rhov + rho_n[2]) / 2 * dhvdp) / (h_n[2] - h_n[1]);
        drdh_v1 := (rho_v - (rho_n[1] + rhol) / 2 + drdh_n[1] * (hl - h_n[1]) / 2) / (h_n[2] - h_n[1]);
        drdh_v2 := ((rhov + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
        rho_v := (AA * log(rho_n[1] / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
        drdp_v := (AA1 * log(rho_n[1] / rhol) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rhol * drldp) + (drldp + drdp_n[2]) * (h_n[2] - hl) / 2 - (rhol + rho_n[2]) / 2 * dhldp) / (h_n[2] - h_n[1]);
        drdh_v1 := (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
        drdh_v2 := ((rhol + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
      elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
        rho_v := ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
        drdp_v := ((drdp_n[1] + drvdp) * (hv - h_n[1]) / 2 + (rho_n[1] + rhov) / 2 * dhvdp + AA1 * log(rhov / rhol) + AA * (1 / rhov * drvdp - 1 / rhol * drldp) + (drldp + drdp_n[2]) * (h_n[2] - hl) / 2 - (rhol + rho_n[2]) / 2 * dhldp) / (h_n[2] - h_n[1]);
        drdh_v1 := (rho_v - (rho_n[1] + rhov) / 2 + drdh_n[1] * (hv - h_n[1]) / 2) / (h_n[2] - h_n[1]);
        drdh_v2 := ((rhol + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
      else
        rho_v := ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rho_n[2])) / (h_n[2] - h_n[1]);
        drdp_v := ((drdp_n[1] + drvdp) * (hv - h_n[1]) / 2 + (rho_n[1] + rhov) / 2 * dhvdp + AA1 * log(rhov / rho_n[2]) + AA * (1 / rhov * drvdp - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
        drdh_v1 := (rho_v - (rho_n[1] + rhov) / 2 + drdh_n[1] * (hv - h_n[1]) / 2) / (drdp_n[1] - h_n[1]);
        drdh_v2 := (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
      end if;
    end calc_rho_drdh_drdp;

    function drdh_drdp
      input Medium.SpecificEnthalpy h_v;
      input Medium.SpecificEnthalpy h_n[2];
      input Medium.AbsolutePressure p_v;
      input Medium.AbsolutePressure p_n[2];
      //input Modelica.SIunits.DerDensityByEnthalpy drdh_last;
      //input Modelica.SIunits.DerDensityByPressure drdp_last;
      //input Real mytime;
      output Modelica.SIunits.DerDensityByEnthalpy drdh;
      output Modelica.SIunits.DerDensityByPressure drdp;
    protected
      package Medium = Modelica.Media.Water.WaterIF97_ph;
      Modelica.SIunits.DerDensityByEnthalpy drdh_temp;
      Modelica.SIunits.DerDensityByPressure drdp_temp;
      Modelica.SIunits.DerDensityByEnthalpy drdh_lim = -0.002 "Предельное значение производной плотности по энтальпии";
      Modelica.SIunits.DerDensityByPressure drdp_lim = 0.0005 "Предельное значение производной плотности по давлению";
    algorithm
      drdh_temp := if abs(h_n[2] - h_n[1]) > 0.01 then (Medium.density(Medium.setState_ph(p_v, h_n[2])) - Medium.density(Medium.setState_ph(p_v, h_n[1]))) / (h_n[2] - h_n[1]) else (Medium.density(Medium.setState_ph(p_v, h_n[2])) - Medium.density(Medium.setState_ph(p_v, h_n[2] - 0.01))) / 0.01;
      drdp_temp := if abs(p_n[2] - p_n[1]) > 0.01 then (Medium.density(Medium.setState_ph(p_n[2], h_v)) - Medium.density(Medium.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium.density(Medium.setState_ph(p_n[2], h_v)) - Medium.density(Medium.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
      if abs(drdh_temp) > abs(drdh_lim) then
        drdh := drdh_lim;
        if abs(drdp_temp) < abs(drdp_lim) then
          drdp := drdp_temp;
        else
          drdp := drdp_lim;
        end if;
      elseif abs(drdp_temp) > abs(drdp_lim) then
        drdp := drdp_lim;
        if abs(drdh_temp) < abs(drdh_lim) then
          drdh := drdh_temp;
        else
          drdh := drdh_lim;
        end if;
      else
        drdh := drdh_temp;
        drdp := drdp_temp;
      end if;
    end drdh_drdp;

    function drdh_drdp_NOGOOD "Вариант который мне не очень нравится, но кажется работает"
      input Medium.SpecificEnthalpy h_v;
      input Medium.SpecificEnthalpy h_n[2];
      input Medium.AbsolutePressure p_v;
      input Medium.AbsolutePressure p_n[2];
      output Modelica.SIunits.DerDensityByEnthalpy drdh;
      output Modelica.SIunits.DerDensityByPressure drdp;
    protected
      package Medium = Modelica.Media.Water.WaterIF97_ph;
      Modelica.SIunits.DerDensityByEnthalpy drdh_temp;
      Modelica.SIunits.DerDensityByPressure drdp_temp;
    algorithm
      drdh_temp := if abs(h_n[2] - h_n[1]) > 0.01 then (Medium.density(Medium.setState_ph(p_v, h_n[2])) - Medium.density(Medium.setState_ph(p_v, h_n[1]))) / (h_n[2] - h_n[1]) else (Medium.density(Medium.setState_ph(p_v, h_n[2])) - Medium.density(Medium.setState_ph(p_v, h_n[2] - 0.01))) / 0.01;
      drdp_temp := if abs(p_n[2] - p_n[1]) > 0.01 then (Medium.density(Medium.setState_ph(p_n[2], h_v)) - Medium.density(Medium.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium.density(Medium.setState_ph(p_n[2], h_v)) - Medium.density(Medium.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
      if abs(drdh_temp) > 0.005 then
        if abs(0.005 * drdp_temp / drdh_temp) < 0.000153 then
          drdh := -0.005;
          drdp := -0.005 * drdp_temp / drdh_temp;
        else
          drdh := 0.000153 * drdh_temp / drdp_temp;
          drdp := 0.000153;
        end if;
      elseif abs(drdp_temp) > 0.000153 then
        if abs(0.000153 * drdh_temp / drdp_temp) < 0.005 then
          drdh := 0.000153 * drdh_temp / drdp_temp;
          drdp := 0.000153;
        else
          drdh := -0.005;
          drdp := -0.005 * drdp_temp / drdh_temp;
        end if;
      else
        drdh := drdh_temp;
        drdp := drdp_temp;
      end if;
    end drdh_drdp_NOGOOD;
  end functions;

  package thermal
    model heatTransfer
      constant Medium.AbsolutePressure pc = Medium.fluidConstants[1].criticalPressure;
      constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
      constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
      replaceable package Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
      input Medium.SpecificEnthalpy h_n[2];
      input Medium.MassFlowRate D_flow_v;
      input Medium.Density rho_n[2];
      input Medium.Density rho_v;
      input Medium.Density rhov;
      input Medium.Density rhol;
      input Medium.SpecificEnthalpy hl;
      input Medium.SpecificEnthalpy hv;
      input Medium.AbsolutePressure p_v;
      input Medium.SpecificEnthalpy h_v;
      parameter Modelica.SIunits.Diameter Din;
      parameter Modelica.SIunits.Area f_flow;
      Real Re_flow_eco;
      Real Re_flow_sh;
      Medium.ThermalConductivity k_flow_eco;
      Medium.ThermalConductivity k_flow_sh;
      Real Pr_flow_eco;
      Real Pr_flow_sh;
      Medium.DynamicViscosity mu_flow_eco;
      Medium.DynamicViscosity mu_flow_sh;
      Modelica.SIunits.Velocity w_flow_v_eco;
      Modelica.SIunits.Velocity w_flow_v_sh;
      Real A_alfa;
      Real C_alfa;
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_eco "Коэффициент теплопередачи со стороны потока вода/пар";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_sh "Коэффициент теплопередачи со стороны потока вода/пар";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
    equation
      if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
// 1-phase or almost uniform properties
        k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
        k_flow_sh = k_flow_eco;
        Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
        Pr_flow_sh = Pr_flow_eco;
        mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
        mu_flow_sh = mu_flow_eco;
        w_flow_v_eco = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
        Re_flow_sh = Re_flow_eco;
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
// 2-phase
        k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
        k_flow_sh = k_flow_eco;
        Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
        Pr_flow_sh = Pr_flow_eco;
        mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
        mu_flow_sh = mu_flow_eco;
        w_flow_v_eco = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
        Re_flow_sh = Re_flow_eco;
      elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
// liquid/2-phase
        k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
// 2-phase/vapour
        k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
// liquid/2-phase/vapour
        k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
// 2-phase/liquid
        k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
// vapour/2-phase/liquid
        k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      else
// vapour/2-phase
        k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      end if;
      A_alfa = min(max((hl - h_n[1]) / max(h_n[2] - h_n[1], 0.01), 0), 1);
      C_alfa = min(max((h_n[2] - hv) / max(h_n[2] - h_n[1], 0.01), 0), 1);
      alfa_flow_eco = 0.023 * k_flow_eco / Din * Re_flow_eco ^ 0.8 * Pr_flow_eco ^ 0.4;
      alfa_flow_sh = 0.023 * k_flow_sh / Din * Re_flow_sh ^ 0.8 * Pr_flow_sh ^ 0.4;
      alfa_flow = ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) * alfa_flow_eco + ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2) * alfa_flow_sh + (1 - ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) - ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2)) * 20000;
    end heatTransfer;

    /* 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  replaceable model HeatTransfer = TPPSim.thermal.heatTransfer;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  HeatTransfer heatTransfer(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    redeclare package Medium = Medium_F,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    final h_n = h_n,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    final D_flow_v = D_flow_v,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    final rho_n = rho_n,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    final rho_v = rho_v,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    final rhov = rhov,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    final rhol = rhol,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    final hl = hl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    final hv = hv,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    final p_v = p_v,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    final h_v = h_v,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    final Din = Din,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    final f_flow = f_flow);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                */

    function alpha
      input Medium.SpecificEnthalpy h_n[2];
      input Medium.MassFlowRate D_flow_v;
      input Medium.AbsolutePressure p_v;
      input Modelica.SIunits.Diameter Din;
      input Modelica.SIunits.Area f_flow;
      output Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
    protected
      package Medium = Modelica.Media.Water.WaterIF97_ph;
      Medium.AbsolutePressure pc = 22.06e6;
      Modelica.SIunits.SpecificEnthalpy hzero = 1e-3;
      Modelica.SIunits.Pressure pzero = 10;
      Medium.SpecificEnthalpy h_v;
      Medium.Density rho_n[2];
      Medium.Density rho_v;
      Medium.Density rhov;
      Medium.Density rhol;
      Medium.SpecificEnthalpy hl;
      Medium.SpecificEnthalpy hv;
      Real Re_flow_eco;
      Real Re_flow_sh;
      Medium.ThermalConductivity k_flow_eco;
      Medium.ThermalConductivity k_flow_sh;
      Real Pr_flow_eco;
      Real Pr_flow_sh;
      Medium.DynamicViscosity mu_flow_eco;
      Medium.DynamicViscosity mu_flow_sh;
      Modelica.SIunits.Velocity w_flow_v_eco;
      Modelica.SIunits.Velocity w_flow_v_sh;
      Real A_alfa;
      Real C_alfa;
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_eco "Коэффициент теплопередачи со стороны потока вода/пар";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_sh "Коэффициент теплопередачи со стороны потока вода/пар";
    algorithm
      h_v := 0.5 * (h_n[1] + h_n[2]);
      for i in 1:2 loop
        rho_n[i] := Medium.density(Medium.setState_ph(p_v, h_n[i]));
      end for;
      rho_v := 0.5 * (rho_n[2] + rho_n[1]);
      hl := Medium.bubbleEnthalpy(Medium.setSat_p(p_v));
      hv := Medium.dewEnthalpy(Medium.setSat_p(p_v));
      rhol := Medium.bubbleDensity(Medium.setSat_p(p_v));
      rhov := Medium.dewDensity(Medium.setSat_p(p_v));
      if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
        k_flow_sh := k_flow_eco;
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
        Pr_flow_sh := Pr_flow_eco;
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
        mu_flow_sh := mu_flow_eco;
        w_flow_v_eco := D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
        Re_flow_sh := Re_flow_eco;
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
        k_flow_sh := k_flow_eco;
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
        Pr_flow_sh := Pr_flow_eco;
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
        mu_flow_sh := mu_flow_eco;
        w_flow_v_eco := D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
        Re_flow_sh := Re_flow_eco;
      elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco := D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco := D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco := D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco := D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco := D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      else
        k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco := D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      end if;
// 1-phase or almost uniform properties
// 2-phase
// liquid/2-phase
// 2-phase/vapour
// liquid/2-phase/vapour
// 2-phase/liquid
// vapour/2-phase/liquid
// vapour/2-phase
      A_alfa := min(max((hl - h_n[1]) / max(h_n[2] - h_n[1], 0.01), 0), 1);
      C_alfa := min(max((h_n[2] - hv) / max(h_n[2] - h_n[1], 0.01), 0), 1);
      alfa_flow_eco := 0.023 * k_flow_eco / Din * Re_flow_eco ^ 0.8 * Pr_flow_eco ^ 0.4;
      alfa_flow_sh := 0.023 * k_flow_sh / Din * Re_flow_sh ^ 0.8 * Pr_flow_sh ^ 0.4;
      alfa_flow := ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) * alfa_flow_eco + ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2) * alfa_flow_sh + (1 - ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) - ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2)) * 20000;
    end alpha;
  end thermal;

  block FWControl
    Modelica.Blocks.Interfaces.RealInput gasFlow_in annotation(
      Placement(visible = true, transformation(origin = {-122, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput gasFlow_out annotation(
      Placement(visible = true, transformation(origin = {-122, 58}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput gasEnt_in annotation(
      Placement(visible = true, transformation(origin = {-122, 18}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput gasEnt_out annotation(
      Placement(visible = true, transformation(origin = {-122, -26}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput flowPress_out annotation(
      Placement(visible = true, transformation(origin = {-122, -64}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput flowEnt_in annotation(
      Placement(visible = true, transformation(origin = {-122, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput FWflow annotation(
      Placement(visible = true, transformation(origin = {112, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {114, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  protected
    package Medium = Modelica.Media.Water.StandardWater;
    Medium.Temperature ts;
    Medium.SpecificEnthalpy flowEnt_out;
    Medium.MassFlowRate FWflow_temp;
  equation

  algorithm
    ts := Medium.saturationTemperature_sat(Medium.setSat_p(flowPress_out));
    flowEnt_out := Medium.specificEnthalpy_pT(flowPress_out, ts - 5);
    FWflow_temp := (gasFlow_in * gasEnt_in - gasFlow_out * gasEnt_out) / (flowEnt_out - flowEnt_in);
    FWflow := if FWflow_temp < 58 / 3.6 then 58 / 3.6 else FWflow_temp;
  end FWControl;

  model flowLimiter
    parameter Medium.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
    replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
    //Переменные
    Medium.AbsolutePressure p;
    Medium.SpecificEnthalpy h;
    Medium.MassFlowRate D;
    //Интерфейс
    Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium) annotation(
      Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
      Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
//Граничные условия
    D = max(waterIn.m_flow, m_flow_small);
    waterOut.m_flow = -D;
    waterOut.p = p;
    waterIn.p = p;
    h = inStream(waterIn.h_outflow);
    waterOut.h_outflow = h;
    waterIn.h_outflow = h;
    annotation(
      Documentation(info = "<HTML>Ограничитель расхода.</html>"),
      Diagram(graphics),
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
  end flowLimiter;

  package Drums
    model Drum "Модель барабана энергетического котла без встроенного деаэратора"
      extends TPPSim.Drums.BaseClases.BaseDrum;
      //Интерфейс
      Modelica.Blocks.Interfaces.RealOutput waterLevel annotation(
        Placement(visible = true, transformation(origin = {112, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput FW_feedback annotation(
        Placement(visible = true, transformation(origin = {112, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      fedWater.m_flow = D_fw;
      FW_feedback = (-Dsteam) + m_flow_small;
      waterLevel = Hw;
//Паровое пространство барабана
      state_eco = Medium.setState_ph(ps, inStream(fedWater.h_outflow));
      x_eco = Medium.vapourQuality(state_eco);
      state_upStr = Medium.setState_ph(ps, inStream(upStr.h_outflow));
      x_upStr = Medium.vapourQuality(state_upStr);
      sat = Medium.setSat_p(ps);
      ts = Medium.saturationTemperature_sat(sat);
      h_dew = Medium.dewEnthalpy(sat);
      h_bubble = Medium.bubbleEnthalpy(sat);
//t_m_steam = ts "Принимаем, что верхняя стенка барабанна в каждый момент времени равна температуре насыщения в паровом пространстве барабана. Такое равенство может работать только при конденсации, т.е. росте температуры стенки барабана!!!";
      20000 * (ts - t_m_steam) = D_cond_dr * (h_dew - h_bubble);
      D_st_circ = D_upStr * x_upStr;
      if inStream(fedWater.h_outflow) - h_bubble > 0 then
        D_st_eco = D_fw * (inStream(fedWater.h_outflow) - h_bubble) / (h_dew - h_bubble);
      elseif inStream(fedWater.h_outflow) - h_bubble <= 0 and D_st_circ <= D_fw * (h_bubble - inStream(fedWater.h_outflow)) / (h_dew - h_bubble) then
        D_st_eco = -D_st_circ;
      else
        D_st_eco = D_fw * (inStream(fedWater.h_outflow) - h_bubble) / (h_dew - h_bubble);
      end if;
      D_st_cond_fw_test = min(D_st_circ, max(D_fw * (h_bubble - inStream(fedWater.h_outflow)) / (h_dew - h_bubble), 0));
      D_st_cond_fw = -min(D_st_eco, 0);
      G_m_steam = rho_m * drumMetallVolume(Din / 2, delta, L, Hw, "top");
      D_cond_dr * (h_dew - h_bubble) = G_m_steam * C_m * der(t_m_steam) "Для моделирования снижения температуры стенки паровой части барабана в левую часть уравнения должно быть добавлено слагаемое равное произведению паропроизводительности на прирост энтальпии пара за счет охлаждения стенки!!! ВАЖНО!!!";
//Временная замена ур-я выше
      der(ps) = (D_st_circ + D_st_eco + Dvipar + Dsteam - D_cond_dr) / Vs / d_rhoDew_by_press "Уравнение определения давления в паровом пространстве";
      d_rhoDew_by_press = Medium.dDewDensity_dPressure(sat);
      Vs = 0.25 * Modelica.Constants.pi * Din ^ 2 * L - Vw;
//Водяное пространство барабана
      D_w_circ = D_upStr * (1 - x_upStr);
      D_w_eco = D_fw * min((h_dew - inStream(fedWater.h_outflow)) / (h_dew - h_bubble), 1);
      Dvipar = Gw * x_w * k;
      pw = ps + 0.5 * Hw * rhow * Modelica.Constants.g_n;
      sat_w = Medium.setSat_p(pw);
      rhow = Medium.density_ph(pw, hw);
      state_w = Medium.setState_ph(pw, hw);
      x_w = Medium.vapourQuality(state_w);
//t_m_water = Medium.saturationTemperature(pw) "Принимаем, что нижняя стенка барабанна в каждый момент времени равна температуре насыщения в водяном пространстве барабана";
      20000 * (Medium.saturationTemperature(pw) - t_m_water) = G_m_water * C_m * der(t_m_water) "ВОЗМОЖНО имеет смысл добавить площадь теплообмена";
      G_m_water = rho_m * drumMetallVolume(Din / 2, delta, L, Hw, "bottom");
      D_w_circ + D_w_eco + D_cond_dr + D_st_cond_fw + D_downStr - Dvipar - m_flow_small = der(Gw);
      D_w_circ * min(h_bubble, inStream(upStr.h_outflow)) + D_w_eco * min(h_bubble, inStream(fedWater.h_outflow)) + D_cond_dr * h_bubble + D_st_cond_fw * h_dew + D_downStr * hw - Dvipar * h_dew - m_flow_small * hw = der(Gw) * hw + Gw * der(hw) + G_m_water * C_m * der(t_m_water);
//Упрощенная формула, не учитывается масса металла
      rhow_dew = Medium.dewDensity(sat_w);
      rhow_bubble = Medium.bubbleDensity(sat_w);
      Vw = Gw * (1 - x_w) / rhow_bubble + Gw * x_w * (1 - k) / rhow_dew;
//Vw = drumWaterVolume(Din / 2, L, Hw);
      Hw = drumWaterLevel(Din / 2, L, Vw);
//Уравнение циркуляции
    algorithm
      D_downStr := -50;
    initial equation
      der(t_m_water) = 0;
      der(t_m_steam) = 0;
//der(hw) = 0;
//der(Gw) = 0;
//hw = inStream(upStr.h_outflow);
//der(ps) = 0;
      annotation(
        Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
        uses(Modelica(version = "3.2.1")),
        Documentation(info = "<html>
  <style>
  p {
      text-indent: 20px;
      text-align: 'justify';
     }
  </style>
  <p>Модель построенна на основе уравнений представленных в докторской диссертации Рубашкина А.С. С рядом дополнений которые позволяют использовать ее для моделирования пуска из состояния в котором парообразование в испарителе не происходит:</p>
  <ul>
    <li>принято что пасход пара на догрев питательной воды до состояния насыщения не может быть больше паропроизводительности испарителя;</li>
    <li>энтальпия питательной воды увеличивающей объем водяной части барабана равна до начала парообразования равна интальпии поступающей питательной воды.
  </ul>
  <p align = 'justify'>В модели допущен ряд упрощений:</p>
  <ul>
    <li>верхняя стенка барабанна в каждый момент времени равна температуре насыщения в паровом пространстве барабана. <b>Такое равенство может работать только при конденсации, т.е. росте температуры стенки барабана!!!</b>;</li>
    <li>необходимо задать расход циркуляции в испарителе</li>.
  </ul>  
  </html>", revisions = "<html>
  <ul>
  <li><i>4 Apr 2017</i>
    by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
       Создан.</li>
  </ul>
  </html>"));
    end Drum;

    package BaseClases
      model BaseDrum "Базовый класс 'барабан котла'"
        //Вспомогательные функции
        extends TPPSim.Drums.BaseClases.Icons.IconDrum;

        function drumWaterVolume "Формула для расчета объема воды в барабане"
          extends Modelica.Icons.Function;
          input Real R "внутренний радиус барабана";
          input Real L "длина барабана";
          input Real Hw "уровень воды в барабане";
          output Real V "объем занимаемый водой в барабане";
        protected
          Real alfa;
          Real Ssec;
          Real Str;
          Real p;
          Real H;
        algorithm
          H := if Hw < R then Hw else 2 * R - Hw;
          alfa := 2 * acos((R - H) / R);
          Ssec := alfa * R ^ 2 / 2;
          Str := (R - H) * R * sin(alfa / 2);
          V := if Hw < R then (Ssec - Str) * L else (Modelica.Constants.pi * R ^ 2 - (Ssec - Str)) * L;
        end drumWaterVolume;

        function drumWaterLevel
          extends Modelica.Icons.Function;
          input Real R "внутренний радиус барабана";
          input Real L "длина барабана";
          input Real V "объем занимаемый водой в барабане";
          output Real Hw "уровень воды в барабане";
        protected
          Real Sw;
          //Площадь сечения занятой водой
          Real Skr;
        algorithm
          Sw := max(V, 0) / L;
          Skr := Modelica.Constants.pi * R ^ 2;
          Hw := 2 * R * ((-5e-10 * (Sw / Skr) ^ 6) + 4.005 * (Sw / Skr) ^ 5 - 10.012 * (Sw / Skr) ^ 4 + 9.6531 * (Sw / Skr) ^ 3 - 4.4672 * (Sw / Skr) ^ 2 + 1.7942 * (Sw / Skr) + 0.0137);
//приближенная формула
        end drumWaterLevel;

        function drumMetallVolume "Объем металла над и под уровнем воды в барабане"
          extends Modelica.Icons.Function;
          input Real R "внутренний радиус барабана";
          input Real delta "толщина стенки барабана";
          input Real L "длина барабана";
          input Real Hw "уровень воды в барабане";
          input String area "верх или низ барабана";
          output Real V "масса металла";
        protected
          Real alfa;
          Real H;
          Real Ssec_ext;
          Real Ssec_int;
          Real Smetall_ring;
          Real Str;
          Real Vbottom;
          Real Vtop;
        algorithm
          H := if Hw < R then Hw else 2 * R - Hw;
          alfa := 2 * acos((R - H) / R);
          Ssec_ext := alfa * (R + delta) ^ 2 / 2;
          Ssec_int := alfa * R ^ 2 / 2;
          Smetall_ring := Modelica.Constants.pi * ((R + delta) ^ 2 - R ^ 2);
          Str := (R - H) * R * sin(alfa / 2);
          Vbottom := if Hw < R then (Ssec_ext - Ssec_int) * L + 2 * (Ssec_int - Str) * delta else (Smetall_ring - (Ssec_ext - Ssec_int)) * L + 2 * (Modelica.Constants.pi * R ^ 2 - (Ssec_int - Str)) * delta;
          Vtop := if Hw > R then (Ssec_ext - Ssec_int) * L + 2 * (Ssec_int - Str) * delta else (Smetall_ring - (Ssec_ext - Ssec_int)) * L + 2 * (Modelica.Constants.pi * R ^ 2 - (Ssec_int - Str)) * delta;
          V := if area == "top" then Vtop else Vbottom;
        end drumMetallVolume;

        //Исходные данные
        replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
        parameter Medium.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
        parameter Real k = 0.9 "Доля пара, которая практически сразу выделяется из водяного объема";
        //Геометрические характеристики барабана
        parameter Modelica.SIunits.Length Din "Внутренний диаметр барабана";
        parameter Modelica.SIunits.Length L "Длина барабана";
        parameter Modelica.SIunits.Length delta "Толщина стенки барабана";
        //Характеристики металла
        parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
          Dialog(group = "Металл"));
        parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
          Dialog(group = "Металл"));
        //Начальные значения
        parameter Modelica.SIunits.Length Hw_start = 0.5 "Начальное значение уровня воды в барабане";
        parameter Medium.AbsolutePressure ps_start = Medium.p_default "Начальное значение давления пара в барабане";
        parameter Medium.AbsolutePressure pw_start = ps_start + 0.5 * Hw_start * Medium.bubbleDensity(Medium.setSat_p(ps_start)) * Modelica.Constants.g_n "Начальное значение давления пара в барабане";
        parameter Medium.Temperature t_start = 100 + 273.15 "Стартовая температура";
        parameter Modelica.SIunits.Volume Vw_start = drumWaterVolume(Din / 2, L, Hw_start);
        parameter Modelica.SIunits.Mass Gw_start = Vw_start * Medium.bubbleDensity(Medium.setSat_p(ps_start));
        //Переменные
        Modelica.SIunits.Volume Vs "Объем парового пространства барабана";
        Medium.Temperature ts "Температура насыщения в барабане";
        Medium.ThermodynamicState state_eco "Термодинамическое состояние потока питательной воды";
        Real x_eco "Степень сухости питательной воды";
        Medium.ThermodynamicState state_upStr "Термодинамическое состояние потока в подъемных трубах испарительного контура";
        Real x_upStr "Степень сухости в подъемных трубах испарительного контура";
        Medium.SaturationProperties sat "State vector to compute saturation properties для парового объема";
        Medium.Temperature t_m_steam(start = t_start) "Температура металла паровой части барабана";
        Medium.Temperature t_m_water(start = t_start) "Температура металла водяной части барабана";
        Medium.MassFlowRate D_fw "Расход питательной воды";
        Medium.MassFlowRate D_st_circ "Пар поступающий в паровое пространство барабана из циркуляционных контуров ";
        Medium.MassFlowRate D_st_eco "Расход пара из питательной воды или необходимый для нагрева до h' недогретой питательной воды";
        Medium.MassFlowRate D_st_cond_fw "Расход пара конденсирующегося при нагреве питательной воды до энтальпии насыщения";
        Medium.MassFlowRate D_st_cond_fw_test;
        Medium.MassFlowRate Dsteam "Расход пара из барабана";
        Medium.MassFlowRate D_cond_dr "Пар конденсирующийся на стенках барабана";
        Modelica.SIunits.Mass G_m_steam(start = rho_m * drumMetallVolume(Din / 2, delta, L, Hw_start, "top")) "Масса металла паровой части барабана";
        Modelica.SIunits.Mass G_m_water(start = rho_m * drumMetallVolume(Din / 2, delta, L, Hw_start, "bottom")) "Масса металла водяной части барабана";
        Modelica.SIunits.DerDensityByPressure d_rhoDew_by_press "Производная плотности сухого пара от давления";
        Medium.MassFlowRate Dvipar "Выпар в паровой объем";
        Modelica.SIunits.Length Hw(start = Hw_start, fixed = false, max = Din, min = 0) "Уровень воды в барабане";
        Modelica.SIunits.Volume Vw(start = Vw_start, nominal = Vw_start, min = 0, max = drumWaterVolume(Din / 2, L, Din)) "Объем водяной части барабана";
        Medium.MassFlowRate D_downStr "Расход воды в опускные трубы циркуляционных контуров";
        Medium.MassFlowRate D_upStr(min = 10, max = 500) "Расход пароводяной среды в подъемных трубах циркуляционных контуров";
        Medium.AbsolutePressure ps(start = ps_start) "Давление насыщения в барабане";
        Medium.SpecificEnthalpy h_dew "Энтальпия пара на линии насыщения при давлении в барабане";
        Medium.SpecificEnthalpy h_bubble "Энтальпия воды на линии насыщения при давлении в барабане";
        Medium.AbsolutePressure pw(start = pw_start) "Давление воды в барабане";
        Medium.Density rhow "Плотность воды в барабане";
        Medium.SpecificEnthalpy hw "Энтальпия воды в водяном объеме";
        Medium.ThermodynamicState state_w "Термодинамическое состояние воды в водяном объеме";
        Real x_w "Степень сухости воды в водяном объеме";
        Modelica.SIunits.Mass Gw(start = Gw_start, fixed = true, nominal = drumWaterVolume(Din / 2, L, Hw_start) * Medium.bubbleDensity(Medium.setSat_p(ps_start)), min = 0) "Масса воды в барабане";
        Medium.SaturationProperties sat_w "State vector to compute saturation properties для водяного объема";
        Medium.MassFlowRate D_w_circ "Вода поступающая в водяное пространство барабана из циркуляционных контуров ";
        Medium.MassFlowRate D_w_eco "Расход воды из экономайзера, с учетом выделившегося или дополнительно конденсировавшегося пара";
        Medium.Density rhow_dew "Плотность воды на линии насыщения в водяном объеме барабана";
        Medium.Density rhow_bubble "Плотность пара на линии насыщения в водяном объеме барабана";
        //Интерфейс
        Modelica.Fluid.Interfaces.FluidPort_a fedWater(redeclare package Medium = Medium) annotation(
          Placement(visible = true, transformation(origin = {-104, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Interfaces.FluidPort_b steam(redeclare package Medium = Medium) annotation(
          Placement(visible = true, transformation(origin = {62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Interfaces.FluidPort_b downStr(redeclare package Medium = Medium) annotation(
          Placement(visible = true, transformation(origin = {-62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Interfaces.FluidPort_a upStr(redeclare package Medium = Medium) annotation(
          Placement(visible = true, transformation(origin = {104, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
//Питательная вода
        fedWater.h_outflow = hw;
        fedWater.p = ps;
        steam.p = ps;
//Выход насыщенного пара
        steam.h_outflow = h_dew;
        steam.m_flow = Dsteam;
//Опускной стояк
        downStr.h_outflow = hw;
        downStr.m_flow = D_downStr;
//Подъемные трубы
        upStr.h_outflow = hw;
        upStr.p = pw;
        upStr.m_flow = D_upStr;
        annotation(
          Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
          uses(Modelica(version = "3.2.1")),
          Documentation(info = "<html>
    <style>
    p {
        text-indent: 20px;
        text-align: 'justify';
       }
    </style>  
    </html>", revisions = "<html>
    <ul>
    <li><i>4 Apr 2017</i>
      by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
         Создан.</li>
    </ul>
    </html>"));
      end BaseDrum;

      package Icons
        model IconDrum
          annotation(
            Diagram(coordinateSystem(initialScale = 0.1)),
            Icon(graphics = {Ellipse(origin = {-92, 11}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8, 69}, {32, -91}}, endAngle = 360), Ellipse(origin = {68, 11}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8, 69}, {32, -91}}, endAngle = 360), Rectangle(fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Ellipse(origin = {-77, 0}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, extent = {{-17, 74}, {13, -74}}, endAngle = 360), Ellipse(origin = {81, 0}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, extent = {{-17, 74}, {13, -74}}, endAngle = 360), Rectangle(lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, extent = {{-80, 74}, {80, -74}}), Polygon(origin = {0, -33}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-80, -41}, {-84, -37}, {-88, -27}, {-90, -17}, {-92, -7}, {-94, 15}, {-94, 35}, {-88, 37}, {-78, 39}, {-70, 39}, {-62, 37}, {-54, 33}, {-44, 29}, {-34, 27}, {-22, 29}, {-14, 33}, {-4, 37}, {10, 37}, {20, 33}, {34, 29}, {42, 29}, {56, 31}, {64, 35}, {70, 39}, {76, 41}, {84, 41}, {92, 39}, {94, 37}, {94, 27}, {94, 13}, {92, -5}, {90, -17}, {88, -27}, {86, -33}, {84, -37}, {80, -41}, {-80, -41}}), Ellipse(origin = {-77, -27}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {5, -5}}, endAngle = 360), Ellipse(origin = {-67, -5}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {-67, -5}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {-3, -13}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {5, -5}}, endAngle = 360), Ellipse(origin = {19, -53}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {5, -5}}, endAngle = 360), Ellipse(origin = {-69, -61}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {-41, -23}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {45, -29}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {1, -43}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {-33, -55}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {5, -5}}, endAngle = 360), Ellipse(origin = {63, -45}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {5, -5}}, endAngle = 360), Ellipse(origin = {79, -13}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {45, -65}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
        end IconDrum;

        model Separator_Icon
          annotation(
            Icon(graphics = {Ellipse(origin = {0, 95}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-40, 5}, {40, -7}}, endAngle = 360), Rectangle(origin = {0, 31}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-40, 63}, {40, -61}}), Ellipse(origin = {0, -29}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-40, 5}, {40, -7}}, endAngle = 360), Rectangle(origin = {0, -64}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-10, 34}, {10, -34}}), Ellipse(origin = {1, -99}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-11, -1}, {9, 3}}, endAngle = 360), Ellipse(origin = {-3, 91}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-35, 7}, {41, -5}}, endAngle = 360), Ellipse(origin = {0, -28}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-38, 4}, {38, -4}}, endAngle = 360), Rectangle(origin = {0, 32}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-38, 60}, {38, -60}}), Rectangle(origin = {0, -64}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8, 34}, {8, -32}}), Ellipse(origin = {0, -97}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8, 3}, {8, -1}}, endAngle = 360), Ellipse(origin = {-60, 70}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-1, 6}, {1, -4}}, endAngle = 360), Rectangle(extent = {{-68, 74}, {-68, 74}}), Polygon(origin = {-49, 68}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{11, 2}, {-11, 8}, {-11, -2}, {11, -8}, {11, 2}}), Ellipse(extent = {{-60, 76}, {-60, 76}}, endAngle = 360), Ellipse(origin = {-59.2, 70.8}, lineColor = {255, 255, 255}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, extent = {{-1, 4.2}, {1, -4.2}}, endAngle = 360), Polygon(origin = {-48.2, 68}, lineColor = {255, 255, 255}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, points = {{-11, 7}, {-11, 7}, {11, 1}, {11, -7.4}, {-11, -1.4}, {-11, 7}}), Polygon(origin = {0, 57}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, points = {{-38, -35}, {-38, 35}, {-36, 37}, {-28, 39}, {-10, 41}, {10, 41}, {28, 39}, {36, 37}, {38, 35}, {38, -37}, {34, -35}, {26, -33}, {18, -33}, {12, -35}, {6, -39}, {-2, -41}, {-10, -41}, {-18, -39}, {-24, -37}, {-34, -35}, {-38, -35}, {-38, -35}}), Polygon(origin = {-11.28, 51.17}, lineColor = {255, 255, 255}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, points = {{-26.7236, 18}, {11.2764, 6.83018}, {27.2764, -1.16982}, {9.27639, 4.83018}, {23.2764, -7.16982}, {5.27639, 2.83018}, {19.2764, -9.16982}, {-0.723607, 2.83018}, {13.2764, -11.1698}, {-4.72361, 0.830179}, {5.27639, -13.1698}, {-2.72361, -5.16982}, {3.27639, -19.1698}, {-10.7236, -1.16982}, {-0.723607, -19.1698}, {-14.7236, -1.16982}, {-4.72361, -19.1698}, {-16.7236, -3.16982}, {-12.7236, -19.1698}, {-18.7236, -3.16982}, {-18.7236, -19.1698}, {-22.7236, -1.16982}, {-26.7236, 9.5}, {-26.7236, 18}}), Ellipse(origin = {-28, 8}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-4, 4}, {4, -4}}, endAngle = 360), Ellipse(origin = {24, 6}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-4, 4}, {4, -4}}, endAngle = 360), Ellipse(origin = {-25, -15}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {1, 5}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {10, -14}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-2, 2}, {2, -2}}, endAngle = 360), Ellipse(origin = {30, -24}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-4, 4}, {4, -4}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
        end Separator_Icon;
      end Icons;
    end BaseClases;

    model Separator
      //Вспомогательные функции
      extends TPPSim.Drums.BaseClases.Icons.Separator_Icon;

      function separatorWaterVolume "Формула для расчета объема воды в сепараторе"
        extends Modelica.Icons.Function;
        input Real R "внутренний радиус сепаратора";
        input Real Hw "уровень воды в сепараторе";
        output Real V "объем занимаемый водой в сепараторе";
      algorithm
        V := Hw * Modelica.Constants.pi * R ^ 2;
      end separatorWaterVolume;

      function separatorMetallVolume "Объем металла над и под уровнем воды в сепараторе"
        extends Modelica.Icons.Function;
        input Real R "внутренний радиус барабана";
        input Real delta "толщина стенки барабана";
        input Real L "длина сепаратора";
        input Real Hw "уровень воды в сепараторе";
        input String area "верх или низ сепаратора";
        output Real V "объем металла";
      protected
        Real Vbottom;
        Real Vtop;
      algorithm
        Vbottom := Hw * Modelica.Constants.pi * ((R + delta) ^ 2 - R ^ 2) + delta * Modelica.Constants.pi * R ^ 2;
        Vtop := (L - Hw) * Modelica.Constants.pi * ((R + delta) ^ 2 - R ^ 2) + delta * Modelica.Constants.pi * R ^ 2;
        V := if area == "top" then Vtop else Vbottom;
      end separatorMetallVolume;

      function separatoSteamSurface "Расчет площади внутренней поверхности парового объема сепаратора"
      end separatoSteamSurface;

      //***Исходные данные
      replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
      parameter Medium.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      parameter Real k = 0.9 "Доля пара, которая практически сразу выделяется из водяного объема";
      //***Геометрические характеристики сепаратора
      parameter Integer n_sep = 1 "Количество сепараторов";
      parameter Modelica.SIunits.Length Din "Внутренний диаметр сепаратора";
      parameter Modelica.SIunits.Length L "Длина (высота) сепаратора";
      parameter Modelica.SIunits.Length delta "Толщина стенки сепаратора";
      //**
      //***Характеристики металла
      parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
        Dialog(group = "Металл"));
      parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
        Dialog(group = "Металл"));
      //**
      //Начальные значения
      //**
      parameter Modelica.SIunits.Length Hw_start = 2 "Начальное значение уровня воды в сепараторе";
      parameter Medium.AbsolutePressure ps_start "Начальное значение давления пара в барабане";
      parameter Medium.Temperature t_start "Стартовая температура";
      parameter Medium.SaturationProperties sat_start "State vector to compute saturation properties для парового объема (стартовый)";
      parameter Modelica.SIunits.Volume Vw_start = separatorWaterVolume(Din / 2, Hw_start);
      parameter Modelica.SIunits.Mass Gw_start = Vw_start * Medium.bubbleDensity(Medium.setSat_p(ps_start));
      //**
      //Переменные
      //**
      Modelica.SIunits.Volume Vs "Объем парового пространства сепаратора";
      Medium.Temperature ts "Температура насыщения в сепараторе";
      Medium.ThermodynamicState state_eco "Термодинамическое состояние потока питательной воды";
      Real x_eco "Степень сухости питательной воды";
      Medium.SaturationProperties sat "State vector to compute saturation properties для парового объема";
      Medium.Temperature t_m_steam(start = t_start) "Температура металла паровой части барабана";
      Medium.Temperature t_m_water(start = t_start) "Температура металла водяной части барабана";
      Medium.MassFlowRate D_fw "Расход питательной воды";
      Medium.MassFlowRate D_st_eco "Расход пара из питательной воды или необходимый для нагрева до h' недогретой питательной воды";
      Medium.MassFlowRate Dsteam(start = -1.44504, nominal = -1.44504) "Расход пара из сепаратора";
      Medium.MassFlowRate D_cond_dr "Пар конденсирующийся на стенках барабана";
      Modelica.SIunits.Mass G_m_steam(start = rho_m * separatorMetallVolume(Din / 2, delta, L, Hw_start, "top")) "Масса металла паровой части сепаратора";
      Modelica.SIunits.Mass G_m_water(start = rho_m * separatorMetallVolume(Din / 2, delta, L, Hw_start, "bottom")) "Масса металла водяной части сепараратора";
      Modelica.SIunits.DerDensityByPressure d_rhoDew_by_press "Производная плотности сухого пара от давления";
      Medium.MassFlowRate Dvipar "Выпар в паровой объем";
      Modelica.SIunits.Length Hw(start = Hw_start) "Уровень воды в сепараторе";
      Modelica.SIunits.Volume Vw(start = Vw_start, nominal = Vw_start, min = 0, max = separatorWaterVolume(Din / 2, L)) "Объем водяной части барабана";
      Medium.MassFlowRate D_downStr "Расход воды в сливную трубу";
      Medium.AbsolutePressure ps(start = ps_start) "Давление насыщения в сепараторе";
      Medium.SpecificEnthalpy h_dew(start = Medium.bubbleEnthalpy(sat_start)) "Энтальпия пара на линии насыщения при давлении в сепараторе";
      Medium.SpecificEnthalpy h_bubble(start = Medium.bubbleEnthalpy(sat_start)) "Энтальпия воды на линии насыщения при давлении в сепараторе";
      Medium.AbsolutePressure pw(start = ps_start + 0.5 * Hw_start * Medium.bubbleDensity(Medium.setSat_p(ps_start)) * Modelica.Constants.g_n) "Давление воды в барабане";
      Medium.Density rhow "Плотность воды в сепараторе";
      Medium.SpecificEnthalpy hw(start = Medium.bubbleEnthalpy(sat_start)) "Энтальпия воды в водяном объеме";
      Medium.ThermodynamicState state_w "Термодинамическое состояние воды в водяном объеме";
      Real x_w "Степень сухости воды в водяном объеме";
      Modelica.SIunits.Mass Gw(start = Gw_start, nominal = separatorWaterVolume(Din / 2, Hw_start) * Medium.bubbleDensity(Medium.setSat_p(ps_start)), min = 0, fixed = true) "Масса воды в барабане";
      Medium.SaturationProperties sat_w "State vector to compute saturation properties для водяного объема";
      Medium.MassFlowRate D_w_eco "Расход воды из экономайзера, с учетом выделившегося или дополнительно конденсировавшегося пара";
      Medium.Density rhow_dew "Плотность воды на линии насыщения в водяном объеме сепаратора";
      Medium.Density rhow_bubble "Плотность пара на линии насыщения в водяном объеме сепаратора";
      Real alpha_cond;
      //***Интерфейс
      Modelica.Fluid.Interfaces.FluidPort_a fedWater(redeclare package Medium = Medium) annotation(
        Placement(visible = true, transformation(origin = {-104, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b steam(redeclare package Medium = Medium) annotation(
        Placement(visible = true, transformation(origin = {62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b downStr(redeclare package Medium = Medium) annotation(
        Placement(visible = true, transformation(origin = {-62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput waterLevel annotation(
        Placement(visible = true, transformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput steamFeedback annotation(
        Placement(visible = true, transformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput drainFeedback annotation(
        Placement(visible = true, transformation(origin = {110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
//Временные ур-я
      fedWater.m_flow = D_fw;
      steamFeedback = -Dsteam;
      drainFeedback = -(D_fw + Dsteam);
//С обратной связью надо что-то делать!!!
      waterLevel = Hw;
//Паровое пространство барабана
      state_eco = Medium.setState_ph(ps, inStream(fedWater.h_outflow));
      x_eco = Medium.vapourQuality(state_eco);
      sat = Medium.setSat_p(ps);
      ts = Medium.saturationTemperature_sat(sat);
      h_dew = Medium.dewEnthalpy(sat);
      h_bubble = Medium.bubbleEnthalpy(sat);
      alpha_cond = 20000;
      D_cond_dr * (h_dew - h_bubble) = alpha_cond * (ts - t_m_steam);
      D_st_eco = D_fw * (if inStream(fedWater.h_outflow) > h_dew then 1 elseif inStream(fedWater.h_outflow) < h_bubble then 0 else (inStream(fedWater.h_outflow) - h_bubble) / (h_dew - h_bubble));
      G_m_steam = rho_m * n_sep * separatorMetallVolume(Din / 2, delta, L, Hw, "top");
      D_cond_dr * (h_dew - h_bubble) = G_m_steam * C_m * der(t_m_steam);
      der(ps) = (D_st_eco + Dvipar + Dsteam - D_cond_dr) / Vs / d_rhoDew_by_press "Уравнение определения давления в паровом пространстве";
      ps = steam.p;
      d_rhoDew_by_press = Medium.dDewDensity_dPressure(sat);
      Vs = n_sep * 0.25 * Modelica.Constants.pi * Din ^ 2 * L - Vw;
//Водяное пространство барабана
      D_w_eco = D_fw * (if inStream(fedWater.h_outflow) > h_dew then 0 elseif inStream(fedWater.h_outflow) < h_bubble then 1 else (h_dew - inStream(fedWater.h_outflow)) / (h_dew - h_bubble));
      Dvipar = Gw * x_w * k;
      pw = ps + 0.5 * Hw * rhow * Modelica.Constants.g_n;
      sat_w = Medium.setSat_p(pw);
      rhow = Medium.density_ph(pw, hw);
      state_w = Medium.setState_ph(pw, hw);
      x_w = Medium.vapourQuality(state_w);
      t_m_water = Medium.saturationTemperature(pw) "Принимаем, что нижняя стенка барабанна в каждый момент времени равна температуре насыщения в водяном пространстве барабана";
      G_m_water = rho_m * separatorMetallVolume(Din / 2, delta, L, Hw, "bottom");
      D_w_eco + D_cond_dr + D_downStr - Dvipar = der(Gw);
//D_w_circ * h_dew + D_w_eco * h_dew - D_downStr * hw - Dvipar * h_bubble = der(Gw * hw + G_m_water * C_m * t_m_water);
      D_w_eco * h_bubble + D_downStr * hw - Dvipar * h_dew = Gw * der(hw) + G_m_water * C_m * der(t_m_water);
      rhow_dew = Medium.dewDensity(sat_w);
      rhow_bubble = Medium.bubbleDensity(sat_w);
      Vw = Gw * (1 - x_w) / rhow_bubble + Gw * x_w * (1 - k) / rhow_dew;
      Vw = n_sep * separatorWaterVolume(Din / 2, Hw);
//Питательная вода
      fedWater.h_outflow = hw;
      fedWater.p = ps;
//Выход насыщенного пара
      steam.h_outflow = if inStream(fedWater.h_outflow) > h_dew then inStream(fedWater.h_outflow) else h_dew;
      steam.m_flow = -(D_st_eco + Dvipar + Dsteam - D_cond_dr);
//Опускной стояк
      downStr.h_outflow = if inStream(fedWater.h_outflow) < h_bubble then inStream(fedWater.h_outflow) else hw;
      downStr.m_flow = D_downStr;
      downStr.p = pw;
    initial equation
//der(t_m_steam) = 0;
      der(ps) = 0;
//der(Gw) = 0;
      der(hw) = 0;
      annotation(
        uses(Modelica(version = "3.2.1")));
    end Separator;

    model Separator2
      //Вспомогательные функции
      extends TPPSim.Drums.BaseClases.Icons.Separator_Icon;
      //***Исходные данные
      replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
      parameter Medium.AbsolutePressure ps_start = 1.013e5 "Стартовое давление насыщения в сепараторе";
      parameter Medium.MassFlowRate Dsteam_start = m_flow_small "Стартовый расход пара из сепаратора";
      parameter Medium.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      //**
      //Переменные
      //**
      Medium.SaturationProperties sat "State vector to compute saturation properties для парового объема";
      Medium.MassFlowRate D_fw "Расход питательной воды";
      Medium.MassFlowRate Dsteam(start = Dsteam_start) "Расход пара из сепаратора";
      Medium.AbsolutePressure ps(start = ps_start) "Давление насыщения в сепараторе";
      Medium.SpecificEnthalpy h_dew "Энтальпия пара на линии насыщения при давлении в сепараторе";
      Medium.SpecificEnthalpy h_bubble "Энтальпия воды на линии насыщения при давлении в сепараторе";
      //***Интерфейс
      Modelica.Fluid.Interfaces.FluidPort_a fedWater(redeclare package Medium = Medium) annotation(
        Placement(visible = true, transformation(origin = {-104, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b steam(redeclare package Medium = Medium) annotation(
        Placement(visible = true, transformation(origin = {62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      sat = Medium.setSat_p(ps);
      h_dew = Medium.dewEnthalpy(sat);
      h_bubble = Medium.bubbleEnthalpy(sat);
      Dsteam = if noEvent(inStream(fedWater.h_outflow)) > h_dew then D_fw else D_fw * (inStream(fedWater.h_outflow) - h_bubble) / (h_dew - h_bubble);
//Питательная вода
      fedWater.h_outflow = h_bubble;
      fedWater.p = ps;
      fedWater.m_flow = D_fw;
//Выход насыщенного пара
      ps = steam.p;
      steam.h_outflow = if noEvent(inStream(fedWater.h_outflow)) > h_dew then inStream(fedWater.h_outflow) else h_dew;
      steam.m_flow = -Dsteam;
      annotation(
        uses(Modelica(version = "3.2.1")));
    end Separator2;
  end Drums;

  package Pipes
    package BaseClases
      package Icons
        model IconPipe
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {0, 186}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name", fontName = "MS Shell Dlg 2"), Rectangle(origin = {0, -4}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 44}, {100, -36}})}));
        end IconPipe;
      end Icons;

      partial model BasePipe
        extends TPPSim.Pipes.BaseClases.Icons.IconPipe;
        parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
        replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(
          Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(
          Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(
          Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(
          Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(
          Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
        parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
        parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
        //Характеристики металла
        parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
          Dialog(group = "Металл"));
        parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
          Dialog(group = "Металл"));
        //parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
        //Конструктивные характеристики
        parameter Modelica.SIunits.Diameter Din = 0.3 "Внутренний диаметр трубопровода" annotation(
          Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length delta = 0.01 "Толщина стенки трубопровода" annotation(
          Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length Lpipe = 25 "Длина теплообменной трубки" annotation(
          Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
        //Поток вода/пар
        parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din "Внутренняя площадь одного участка ряда труб";
        parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 / 4 "Внутренний объем одного участка ряда труб";
        parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) / 4 "Масса металла участка ряда труб";
        parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 / 4 "Площадь для прохода теплоносителя";
        //Начальные значения
        parameter Medium_F.SpecificEnthalpy h_startFlow_n[2] = fill(seth_in, 2) "Начальный вектор энальпии потока газов" annotation(
          Dialog(tab = "Инициализация"));
        parameter Medium_F.SpecificEnthalpy h_startFlow_v = seth_in "Начальный вектор энальпии потока газов" annotation(
          Dialog(tab = "Инициализация"));
        parameter Medium_F.AbsolutePressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(
          Dialog(tab = "Инициализация"));
        parameter Medium_F.AbsolutePressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(
          Dialog(tab = "Инициализация"));
        parameter Medium_F.MassFlowRate D_startFlow_v = setD_flow "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(
          Dialog(tab = "Инициализация"));
        parameter Medium_F.MassFlowRate D_startFlow_n[2] = fill(setD_flow, 2) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(
          Dialog(tab = "Инициализация"));
        //Металл
        parameter Modelica.SIunits.Temperature t_startM = setTm "Начальный вектор энальпии потока газов" annotation(
          Dialog(tab = "Инициализация"));
        parameter Boolean DynamicMomentum = false "Использовать или нет уравнение сохранения момента";
        //Переменные
        Medium_F.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
        Medium_F.Temperature t_flow "Температура потока вода/пар по участкам трубы";
        Medium_F.AbsolutePressure p_v(start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
        Medium_F.AbsolutePressure p_n[2](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
        Medium_F.SpecificEnthalpy h_v(start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
        Medium_F.SpecificEnthalpy h_n[2](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
        Medium_F.Density rho_v "Плотность потока по участкам трубы в конечных объемах";
        Medium_F.MassFlowRate D_flow_v(start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
        Medium_F.MassFlowRate D_flow_n[2](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
        Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
        Modelica.SIunits.Temperature t_m(start = t_startM) "Температура металла на участках трубопровода";
        Modelica.SIunits.Velocity w_flow_v "Скорость потока вода/пар в конечных объемах";
        Real dp_fric "Потеря давления из-за сил трения";
        Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
        Real lambda_tr "Коэффициент трения";
        //Интерфейс
        Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(
          Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {121, 0}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
        Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(
          Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
//Граничные условия
        D_flow_n[1] = max(waterIn.m_flow, m_flow_small);
        waterOut.m_flow = -D_flow_n[2];
        waterOut.p = p_n[2];
        waterIn.p = p_n[1];
        h_n[1] = inStream(waterIn.h_outflow);
        waterOut.h_outflow = h_n[2];
        waterIn.h_outflow = h_n[1];
        annotation(
          Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
          Diagram(graphics),
          experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
      end BasePipe;
    end BaseClases;

    model Pipe
      extends TPPSim.Pipes.BaseClases.BasePipe(redeclare replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
      import TPPSim.functions.alfaFor2ph;
      import TPPSim.functions.calc_rho_v;
      //Переменные
      Modelica.SIunits.DerDensityByPressure drdp_new;
      Medium_F.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
      Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
      Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
    equation
//0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
//0.5 * deltaVFlow * rho_v * der(h_n[2]) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя";
      0.5 * deltaVFlow * rho_v * der(h_v) = -D_flow_v * (h_v - h_n[1]);
      0.5 * deltaVFlow * rho_v * der(h_n[2]) = -D_flow_v * (h_n[2] - h_v);
//Уравнение теплового баланса металла
      deltaMMetal * C_m * der(t_m) = -alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения состояния
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      t_flow = Medium_F.temperature(stateFlow);
      rho_v = calc_rho_v(h_n, p_v);
//Уравнения для расчета процессов теплообмена
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
      alfa_flow = alfaFor2ph(h_n = h_n, D_flow_v = D_flow_v, p_v = p_v, Din = Din, f_flow = f_flow);
//Про две фазы
      D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
      D_flow_n[2] = D_flow_n[1] - deltaVFlow * drdp_new * der(p_v) "Уравнение сплошности";
      drdp_new = if abs(p_n[2] - p_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
      sat_v = Medium_F.setSat_p(p_v);
      hl = Medium_F.bubbleEnthalpy(sat_v);
      hv = Medium_F.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
      p_v = p_n[1];
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * Lpipe / Din;
      dp_fric = w_flow_v ^ 2 * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
//p_n[1] - p_n[2] = dp_fric;
      if DynamicMomentum then
        p_n[1] - p_n[2] = dp_fric + der(D_flow_n[2]) * Lpipe / f_flow;
      else
        p_n[1] - p_n[2] = dp_fric;
      end if;
      dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
    initial equation
      der(h_v) = 0;
      der(t_m) = 0;
      der(p_v) = 0;
      der(h_n[2]) = 0;
      if DynamicMomentum then
        der(D_flow_n[2]) = 0;
      end if;
      annotation(
        Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
        Diagram(graphics),
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
    end Pipe;

    model SteamPipe "Модель паропровода"
      extends TPPSim.Pipes.BaseClases.BasePipe(redeclare replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
      import TPPSim.functions.alfaForSH;
      import TPPSim.functions.calc_rho_v;
      import TPPSim.functions.drdh_drdp;
      //Переменные
      Modelica.SIunits.DerDensityByPressure drdp_v;
      Medium_F.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
      Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
      Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
    equation
//0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
//0.5 * deltaVFlow * rho_v * der(h_n[2]) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя";
//deltaVFlow * rho_v * der(h_v) = -D_flow_v * (h_n[2] - h_n[1]);
      deltaVFlow * rho_v * der(h_v) = alfa_flow * deltaSFlow * (t_m - t_flow) - (D_flow_n[2] * h_n[2] - D_flow_n[1] * h_n[1]);
//0.5 * deltaVFlow * rho_v * der(h_n[2]) = -D_flow_v * (h_n[2] - h_v);
      h_v = h_n[2];
//Уравнение теплового баланса металла
      deltaMMetal * C_m * der(t_m) = -alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения состояния
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      t_flow = Medium_F.temperature(stateFlow);
//drdp_v = Medium_F.density_derp_h(stateFlow);
      (, drdp_v) = drdh_drdp(h_v, h_n, p_v, p_n);
      rho_v = Medium_F.density(stateFlow);
//Уравнения для расчета процессов теплообмена
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
      alfa_flow = 20000;
//alfa_flow = alfaForSH(h_v = h_v, D_flow_n1 = D_flow_n[1], p_v = p_v, Din = Din, f_flow = f_flow) if t_m > t_flow else 4000;
//Про две фазы
      D_flow_v = D_flow_n[2];
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
      D_flow_n[2] = D_flow_n[1] - deltaVFlow * drdp_v * der(p_v) "Уравнение сплошности";
//drdp_new = if abs(p_n[2] - p_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
      sat_v = Medium_F.setSat_p(p_v);
      hl = Medium_F.bubbleEnthalpy(sat_v);
      hv = Medium_F.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
      p_v = p_n[1];
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * Lpipe / Din;
      dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
      if DynamicMomentum then
        p_n[1] - p_n[2] = dp_fric + der(D_flow_n[2]) * Lpipe / f_flow;
      else
        p_n[1] - p_n[2] = dp_fric;
      end if;
      dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
    initial equation
      der(h_v) = 0;
      der(t_m) = 0;
      der(p_v) = 0;
      if DynamicMomentum then
        der(D_flow_n[2]) = 0;
      end if;
      annotation(
        Documentation(info = "<html>
            <body>
              <p>Модель паропровода с коэффициентом теплоотдачи между стенкой и паром равным 20000. Имеется ввиду,  что теплообмен происходит при конденсации что справедливо для пароотводящих труб барабанов и сепараторов во время пуска.</p>
            </body>
          </html>"),
        Diagram(graphics),
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
    end SteamPipe;
  end Pipes;

  package HRSG_HeatExch
    package BaseClases
      package Icons
        model IconHE
          annotation(
            Icon(graphics = {Rectangle(lineColor = {255, 85, 0}, fillColor = {255, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, borderPattern = BorderPattern.Raised, extent = {{-52, 100}, {52, -100}}), Rectangle(origin = {-40, 0}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 84}, {5, -84}}), Rectangle(origin = {0, -89}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, extent = {{-52, -11}, {52, 5}}), Rectangle(lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 84}, {5, -84}}), Rectangle(origin = {-20, 0}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 84}, {5, -84}}), Rectangle(origin = {20, 0}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 84}, {5, -84}}), Rectangle(origin = {40, 0}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 84}, {5, -84}}), Rectangle(origin = {0, 95}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, extent = {{-52, -11}, {52, 5}}), Text(origin = {1, 3}, extent = {{-35, 21}, {35, -21}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
            Diagram(coordinateSystem(extent = {{-52, -130}, {52, 130}})),
            version = "",
            uses);
        end IconHE;
      end Icons;

      partial model BaseFlowSideHE
        parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
        replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
        constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
        constant Medium_F.AbsolutePressure pc = Medium_F.fluidConstants[1].criticalPressure;
        constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
        parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(
          Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(
          Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(
          Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(
          Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(
          Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
        parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
        parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
        //Характеристики металла
        parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
          Dialog(group = "Металл"));
        parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(
          Dialog(group = "Металл"));
        //Конструктивные характеристики
        parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(
          Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length deltaLpipe = 18.4 "Длина теплообменной трубки" annotation(
          Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
        //Поток вода/пар
        parameter Modelica.SIunits.Area deltaSFlow "Внутренняя площадь одного участка ряда труб";
        parameter Modelica.SIunits.Volume deltaVFlow "Внутренний объем одного участка ряда труб";
        parameter Modelica.SIunits.Mass deltaMMetal "Масса металла участка ряда труб";
        parameter Modelica.SIunits.Area f_flow "Площадь для прохода теплоносителя";
        //Начальные значения
        parameter Medium_F.SpecificEnthalpy h_startFlow_n[2] = fill(seth_in, 2) "Начальный вектор энальпии потока газов" annotation(
          Dialog(tab = "Инициализация"));
        parameter Medium_F.SpecificEnthalpy h_startFlow_v = seth_in "Начальный вектор энальпии потока газов" annotation(
          Dialog(tab = "Инициализация"));
        parameter Medium_F.AbsolutePressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(
          Dialog(tab = "Инициализация"));
        parameter Medium_F.AbsolutePressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(
          Dialog(tab = "Инициализация"));
        parameter Medium_F.MassFlowRate D_startFlow_v = setD_flow "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(
          Dialog(tab = "Инициализация"));
        parameter Medium_F.MassFlowRate D_startFlow_n[2] = fill(setD_flow, 2) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(
          Dialog(tab = "Инициализация"));
        //Металл
        parameter Modelica.SIunits.Temperature t_startM = setTm "Начальный вектор энальпии потока газов" annotation(
          Dialog(tab = "Инициализация"));
        parameter Boolean DynamicMomentum = false "Использовать или нет уравнение сохранения момента";
        parameter Boolean DynamicMassBalance = true "Использовать или нет уравнение сохранение массы с производными";
        parameter Boolean DynamicEnergyBalance = true "Использовать или нет уравнение сохранения энергии с производными";
        parameter Boolean DynamicTm = true "Использовать или нет производную по температуре металла";
        //Переменные
        Medium_F.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
        Medium_F.Temperature t_flow "Температура потока вода/пар по участкам трубы";
        Medium_F.AbsolutePressure p_v(start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
        Medium_F.AbsolutePressure p_n[2](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
        Medium_F.SpecificEnthalpy h_v(start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
        Medium_F.SpecificEnthalpy h_n[2](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
        Medium_F.Density rho_v "Плотность потока по участкам трубы в конечных объемах";
        Medium_F.MassFlowRate D_flow_v(start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
        Medium_F.MassFlowRate D_flow_n[2](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
        Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
        Modelica.SIunits.HeatFlowRate Q_flow "тепло переданное стенке трубы";
        Modelica.SIunits.Temperature t_m(start = t_startM) "Температура металла на участках трубопровода";
        Modelica.SIunits.Velocity w_flow_v "Скорость потока вода/пар в конечных объемах";
        Real dp_fric "Потеря давления из-за сил трения";
        Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
        Real lambda_tr "Коэффициент трения";
        //Интерфейс
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat annotation(
          Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(
          Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
        Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(
          Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
//Граничные условия
        D_flow_n[1] = max(waterIn.m_flow, m_flow_small);
        waterOut.m_flow = -D_flow_n[2];
        waterOut.p = p_n[2];
        waterIn.p = p_n[1];
        h_n[1] = inStream(waterIn.h_outflow);
        waterOut.h_outflow = h_n[2];
        waterIn.h_outflow = h_n[1];
        annotation(
          Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
          Diagram(graphics),
          experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
          Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
      end BaseFlowSideHE;

      partial model BaseGFHE
        extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconHE;
        parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
        //Исходные данные для газовой стороны
        replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate wgas "Номинальный (и начальный) массовый расход газов";
        parameter Modelica.SIunits.Pressure pgas "Начальное давление газов";
        parameter Modelica.SIunits.Temperature Tingas "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas "Начальная выходная температура газов";
        parameter Real k_gamma_gas "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для водяной стороны
        replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate wflow "Номинальный массовый расход воды/пар";
        parameter Modelica.SIunits.Pressure pflow_in "Начальное давление потока вода/пар на входе";
        parameter Modelica.SIunits.Pressure pflow_out "Начальное давление потока вода/пар на выходе";
        parameter Modelica.SIunits.Temperature Tinflow "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
        parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
        parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
        //Конструктивные характеристики
        parameter TPPSim.Choices.HRSG_type HRSG_type_set = Choices.HRSG_type.horizontalBottom "Выбор типа КУ (горизонтальный/вертикальный)";
        parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг";
        parameter Integer zahod = 1 "заходность труб теплообменника";
        parameter Integer z1 = 126 "Число труб по ширине газохода";
        parameter Integer z2 = 4 "Число труб по ходу газов в теплообменнике";
        parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки";
        //Характеристики металла
        parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
          Dialog(group = "Металл"));
        parameter Boolean flow_DynamicMomentum = false "Использовать или нет уравнение сохранения момента";
        parameter Boolean flow_DynamicMassBalance = true "Использовать или нет уравнение сохранение массы с производными";
        parameter Boolean flow_DynamicEnergyBalance = true "Использовать или нет уравнение сохранения энергии с производными";
        parameter Boolean flow_DynamicTm = true "Использовать или нет производную по температуре металла";
        parameter Boolean gas_DynamicMassBalance = true "Использовать или нет уравнение сохранение массы с производными";
        parameter Boolean gas_DynamicEnergyBalance = true "Использовать или нет уравнение сохранения энергии с производными";
        ///Оребрение
        parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м";
      protected
        parameter Modelica.SIunits.Diameter Dout = Din + 2 * delta "Наружный диаметр трубок теплообменника" annotation(
          Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length omega = Modelica.Constants.pi * Dout "Наружный периметр трубы";
        //Характеристики оребрения
        parameter Modelica.SIunits.Length Dfin = Dout + 2 * hfin "Диаметр ребер, м";
        parameter Real psi_fin = 1 / (2 * Dout * sfin) * (Dfin ^ 2 - Dout ^ 2 + 2 * Dfin * delta_fin) + 1 - delta_fin / sfin "Коэффициент оребрения, равный отношению полной поверхности пучка к поверхности несущих труб на оребренном участке";
        //формула 7.22а нормативного метода
        parameter Real sigma1 = s1 / Dout "Относительный поперечный шаг";
        parameter Real sigma2 = s2 / Dout "Относительный продольный шаг";
        parameter Real sigma3 = sqrt(0.25 * sigma1 ^ 2 + sigma2) "Средний относительный диагональный шаг труб";
        parameter Real xfin = sigma1 / sigma2 - 1.26 / psi_fin - 2 "Параметр 'x' для шахматного пучка";
        parameter Real phi_fin = Modelica.Math.tanh(xfin) "Некий параметр 'фи'";
        parameter Real n_fin = 0.7 + 0.08 * phi_fin + 0.005 * psi_fin "Показатель степени 'n' в формуле коэффициента теплоотдачи";
        parameter Real Cs = (1.36 - phi_fin) * (11 / (psi_fin + 8) - 0.14) "Коэффициент, определяемый в зависимости от от относительного поперечного и продольного шага труб в пучке, типа пучка и коэффициента оребрения";
        parameter Real Cz = if z2 < 8 and sigma1 / sigma2 < 2 then 3.15 * z2 ^ 0.05 - 2.5 elseif z2 < 8 and sigma1 / sigma2 >= 2 then 3.5 * z2 ^ 0.03 - 2.72 else 1 "Поправка на число рядов труб по ходу газов";
        parameter Real Kaer = Dout ^ 0.611 * z2 / s1 ^ 0.412 / s2 ^ 0.515 "Коэффициент для расчета аэродинамического сопротивления";
        Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(
          Placement(visible = true, transformation(origin = {90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
          Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium_F) annotation(
          Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium_F) annotation(
          Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        annotation(
          Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
          experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
          version = "",
          uses);
      end BaseGFHE;
    end BaseClases;

    model FlowSideOTE
      extends TPPSim.HRSG_HeatExch.BaseClases.BaseFlowSideHE(redeclare replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
      import TPPSim.functions.alfaFor2ph;
      import TPPSim.functions.calc_rho_v;
      //Переменные
      Modelica.SIunits.DerDensityByEnthalpy drdh_new;
      Modelica.SIunits.DerDensityByPressure drdp_new;
      Medium_F.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
      Real x_v "Степень сухости";
      Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
      Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
      Real C1 "Показатель в числителе уравнения сплошности";
      Real C2 "Показатель в знаменателе уравнения сплошности";
    equation
      0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
      0.5 * deltaVFlow * rho_v * der(h_n[2]) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
      deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
      heat.Q_flow = Q_flow;
      heat.T = t_m;
//Уравнения состояния
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      t_flow = Medium_F.temperature(stateFlow);
      rho_v = calc_rho_v(h_n, p_v);
//Уравнения для расчета процессов теплообмена
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
      alfa_flow = alfaFor2ph(h_n = h_n, D_flow_v = D_flow_v, p_v = p_v, Din = Din, f_flow = f_flow);
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium_F.setState_ph(p_v, h_v[i, j]);
      x_v = if h_v < hl then 0 elseif h_v > hv then 1 else (h_v - hl) / (hv - hl);
      D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
      D_flow_n[2] = D_flow_n[1] - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
      C1 = deltaVFlow * drdh_new * der(h_v);
      C2 = deltaVFlow * drdp_new * der(p_v);
      drdh_new = if abs(h_n[2] - h_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_v, h_n[2])) - Medium_F.density(Medium_F.setState_ph(p_v, h_n[1]))) / (h_n[2] - h_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_v, h_n[2])) - Medium_F.density(Medium_F.setState_ph(p_v, h_n[2] - 0.01))) / 0.01;
      drdp_new = if abs(p_n[2] - p_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
      sat_v = Medium_F.setSat_p(p_v);
      hl = Medium_F.bubbleEnthalpy(sat_v);
      hv = Medium_F.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
      p_v = p_n[1];
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * deltaLpipe / Din;
      dp_fric = w_flow_v ^ 2 * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
      if DynamicMomentum then
        p_n[1] - p_n[2] = dp_fric + der(D_flow_n[2]) * deltaLpipe / f_flow;
      else
        p_n[1] - p_n[2] = dp_fric;
      end if;
      dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
    initial equation
      der(h_v) = 0;
      der(t_m) = 0;
      der(p_v) = 0;
      der(h_n[2]) = 0;
      if DynamicMomentum then
        der(D_flow_n[2]) = 0;
      end if;
      annotation(
        Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
        Diagram(graphics),
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
        Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
    end FlowSideOTE;

    model GasSideHE
      import TPPSim.functions.deltaPg_lite;
      //**
      //***Исходные данные для газовой стороны
      //**
      replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate setD_gas = 509 "Номинальный (и начальный) массовый расход газов" annotation(
        Dialog(group = "Параметры стороны газов"));
      parameter Modelica.SIunits.Pressure setp_gas = 3e3 "Начальное давление газов" annotation(
        Dialog(group = "Параметры стороны газов"));
      parameter Modelica.SIunits.Temperature setT_inGas = 184 + 273.15 "Начальная входная температура газов" annotation(
        Dialog(group = "Параметры стороны газов"));
      parameter Modelica.SIunits.Temperature setT_outGas = 170 + 273.15 "Начальная выходная температура газов" annotation(
        Dialog(group = "Параметры стороны газов"));
      parameter Medium_G.MassFraction setX_gas[Medium_G.nXi] = Medium_G.reference_X;
      parameter Real k_alfaGas = 1 "Поправка к коэффициенту теплоотдачи со стороны газов" annotation(
        Dialog(group = "Параметры стороны газов"));
      //**
      //Конструктивные характеристики
      //**
      //Параметры
      parameter Integer numberOfVolumes = 10 "Число участков разбиения" annotation(
        Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Diameter Dout "Наружный диаметр трубок теплообменника" annotation(
        Dialog(group = "Конструктивные характеристики"));
      parameter Real Xi_flow = 0.3 "Коэффициент гидравлического сопротивления участка трубы" annotation(
        Dialog(group = "Конструктивные характеристики"));
      //Поток газов
      parameter Modelica.SIunits.Volume deltaVGas "Объем одного участка газового тракта";
      parameter Modelica.SIunits.Area f_gas "Площадь для прохода газов на одном участке разбиения";
      //Характеристики оребрения
      parameter Real n_fin "Показатель степени 'n' в формуле коэффициента теплоотдачи" annotation(
        Dialog(group = "Характеристики оребрения"));
      parameter Real Cs "Коэффициент, определяемый в зависимости от от относительного поперечного и продольного шага труб в пучке, типа пучка и коэффициента оребрения";
      parameter Real Cz "Поправка на число рядов труб по ходу газов";
      parameter Real H_fin "Площадь оребренной поверхности";
      parameter Real Kaer "Коэффициент для расчета аэродинамического сопротивления";
      //**
      //Начальные значения
      //**
      //Поток газов
      parameter Medium_G.SpecificEnthalpy h_startGas[2] = {Medium_G.specificEnthalpy_pTX(setp_gas, setT_inGas, setX_gas), Medium_G.specificEnthalpy_pTX(setp_gas, setT_outGas, setX_gas)} "Начальный вектор энальпии потока газов" annotation(
        Dialog(tab = "Инициализация"));
      parameter Medium_G.SpecificEnthalpy h_v_startGas = 0.5 * (Medium_G.specificEnthalpy_pTX(setp_gas, setT_inGas, setX_gas) + Medium_G.specificEnthalpy_pTX(setp_gas, setT_outGas, setX_gas));
      parameter Medium_G.AbsolutePressure p_startGas[2] = fill(setp_gas, 2) "Начальный вектор давлений потока вода/пар" annotation(
        Dialog(tab = "Инициализация"));
      parameter Boolean DynamicEnergyBalance = true "Использовать или нет уравнение сохранения энергии с производными";
      parameter Boolean DynamicMassBalance = true "Использовать или нет уравнение сохранение массы с производными";
      //**
      //Переменные
      //**
      //Поток газов
      Medium_G.BaseProperties gas;
      Medium_G.SpecificEnthalpy h_gas[2](start = h_startGas) "Энтальпия потока вода/пар по участкам трубы";
      Medium_G.Temperature t_gas(start = setT_inGas) "Температура потока газов по участкам трубы";
      Medium_G.MassFlowRate deltaDGas[2](start = fill(setD_gas, 2)) "Расход газов через участок газохода";
      Medium_G.DynamicViscosity mu "Динамическая вязкость газов";
      Medium_G.ThermalConductivity k "Коэффициент теплопроводности газов";
      Medium_G.SpecificHeatCapacity cp "Изобарная теплоемкость газов";
      Modelica.SIunits.PerUnit Re "Число Рейнольдса";
      Medium_G.PrandtlNumber Pr "Число Прандтля";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_gas "Коэффициент теплопередачи со стороны потока газов";
      Medium_G.AbsolutePressure deltaP "Аэродинамическое сопротивление";
      Medium_G.DerDensityByPressure drdp;
      Medium_G.DerDensityByTemperature drdT;
      //**
      //Интерфейс
      //**
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat annotation(
        Placement(visible = false, transformation(origin = {0, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
        Placement(visible = true, transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0), iconTransformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(
        Placement(visible = true, transformation(extent = {{80, -20}, {120, 20}}, rotation = 0), iconTransformation(extent = {{100, -20}, {140, 20}}, rotation = 0)));
    equation
//*****Уравнения для потока газов
      if DynamicEnergyBalance then
        deltaVGas * gas.d * der(t_gas) = deltaDGas[1] * (h_gas[1] - h_gas[2]) + heat.Q_flow;
      else
        0 = deltaDGas[1] * (h_gas[1] - h_gas[2]) + heat.Q_flow;
      end if;
      heat.Q_flow = -alfa_gas * H_fin * (t_gas - heat.T);
//Уравнения состояния
//gas.h = h_gas_v;
      gas.h = h_gas[2];
      gas.p = gasIn.p "Уравнение для давления";
      gas.X = setX_gas;
      gas.T = t_gas;
      drdp = Medium_G.density_derp_T(gas.state);
      drdT = Medium_G.density_derT_p(gas.state);
      if DynamicMassBalance then
        deltaDGas[2] = deltaDGas[1] - deltaVGas * (drdT * der(t_gas) + drdp * der(gas.p)) "Уравнение сплошности";
      else
        deltaDGas[2] = deltaDGas[1];
      end if;
//Коэффициент теплоотдачи
      mu = Medium_G.dynamicViscosity(gas.state);
      k = Medium_G.thermalConductivity(gas.state);
      cp = Medium_G.heatCapacity_cp(gas.state);
      Re = abs(deltaDGas[1] * Dout / (f_gas * mu));
      Pr = Medium_G.prandtlNumber(gas.state);
      alfa_gas = k_alfaGas * 0.113 * Cs * Cz * k / Dout * Re ^ n_fin * Pr ^ 0.33;
      deltaP = deltaPg_lite(deltaDGas = deltaDGas[2], Kaer = Kaer, f_gas = f_gas, state = gas.state) / numberOfVolumes;
//Граничные условия
      h_gas[1] = inStream(gasIn.h_outflow);
//Граничные условия
      gasIn.h_outflow = h_gas[1];
      gasOut.h_outflow = h_gas[2];
      gasIn.Xi_outflow = inStream(gasOut.Xi_outflow);
      inStream(gasIn.Xi_outflow) = gasOut.Xi_outflow;
      gasIn.m_flow - deltaDGas[1] = 0;
      gasOut.m_flow + deltaDGas[2] = 0;
      gasOut.p = gasIn.p - deltaP;
    initial equation
      if DynamicMassBalance then
        der(t_gas) = 0;
        der(gas.p) = 0;
      end if;
      if DynamicEnergyBalance == true and DynamicMassBalance == false then
        der(t_gas) = 0;
      end if;
      annotation(
        Diagram(graphics),
        Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-100, -115}, {100, -145}}, lineColor = {85, 170, 255}, textString = "%name")}));
    end GasSideHE;

    model GFHE
      extends TPPSim.HRSG_HeatExch.BaseClases.BaseGFHE;
      //Исходные данные по разбиению
      parameter Integer numberOfVolumes = 2 "Число участков разбиения";
      //Конструктивные характеристики
    protected
      parameter Modelica.SIunits.Area f_flow = zahod * Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
      parameter Modelica.SIunits.Length deltaLpipe = Lpipe * z2 / zahod / numberOfVolumes "Длина теплообменной трубки для элемента разбиения";
      parameter Modelica.SIunits.Area deltaSFlow = deltaLpipe * zahod * Modelica.Constants.pi * Din * z1 "Внутренняя площадь одного участка ряда труб";
      parameter Modelica.SIunits.Volume deltaVFlow = deltaLpipe * f_flow "Внутренний объем одного участка ряда труб";
      parameter Modelica.SIunits.Mass deltaMMetal = rho_m * deltaLpipe * zahod * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 "Масса металла участка ряда труб";
      parameter Modelica.SIunits.Volume deltaVGas = Lpipe * (s1 * s2 - Modelica.Constants.pi * Dout ^ 2 / 4) * z1 * z2 / numberOfVolumes "Объем одного участка газового тракта";
      parameter Modelica.SIunits.Area f_gas = (1 - Dout / s1 * (1 + 2 * hfin * delta_fin / sfin / Dout)) * Lpipe * s2 * z1 "Площадь для прохода газов";
      //Характеристики оребрения
      parameter Real H_fin = (omega * Lpipe * (1 - delta_fin / sfin) + (2 * Modelica.Constants.pi * (Dfin ^ 2 - Dout ^ 2) / 4 + Modelica.Constants.pi * Dfin * delta_fin) * (Lpipe / sfin)) * z1 * z2 / numberOfVolumes "Площадь оребренной поверхности";
      TPPSim.HRSG_HeatExch.GasSideHE gasHE[numberOfVolumes](redeclare package Medium_G = Medium_G, setD_gas = wgas, setp_gas = pgas, setT_inGas = Tingas, setT_outGas = Toutflow, k_alfaGas = k_gamma_gas, numberOfVolumes = numberOfVolumes, Dout = Dout, deltaVGas = deltaVGas, f_gas = f_gas, n_fin = n_fin, Cs = Cs, Cz = Cz, H_fin = H_fin, Kaer = Kaer, DynamicMassBalance = gas_DynamicMassBalance, DynamicEnergyBalance = gas_DynamicEnergyBalance) annotation(
        Placement(visible = true, transformation(origin = {0, 50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
      replaceable TPPSim.HRSG_HeatExch.FlowSideOTE flowHE[numberOfVolumes](setD_flow = wflow, setp_flow_in = pflow_in, setp_flow_out = pflow_out, setT_inFlow = Tinflow, setT_outFlow = Toutflow, Din = Din, deltaLpipe = deltaLpipe, seth_in = seth_in, seth_out = seth_out, setTm = setTm, m_flow_small = m_flow_small, deltaSFlow = deltaSFlow, deltaVFlow = deltaVFlow, deltaMMetal = deltaMMetal, f_flow = f_flow, DynamicMomentum = flow_DynamicMomentum, DynamicMassBalance = flow_DynamicMassBalance, DynamicEnergyBalance = flow_DynamicEnergyBalance, DynamicTm = flow_DynamicTm) annotation(
        Placement(visible = true, transformation(origin = {0, -50}, extent = {{-30, -30}, {30, 30}}, rotation = 90)));
    equation
      connect(flowIn, flowHE[1].waterIn) annotation(
        Line(points = {{-90, -50}, {-36, -50}}));
      connect(flowHE[numberOfVolumes].waterOut, flowOut) annotation(
        Line(points = {{36, -50}, {94, -50}}, color = {0, 127, 255}));
      for i in 1:numberOfVolumes - 1 loop
        connect(gasHE[i].gasOut, gasHE[i + 1].gasIn) annotation(
          Line(points = {{36, 50}, {92, 50}, {92, 48}, {92, 48}}, color = {0, 127, 255}));
        connect(flowHE[i].waterOut, flowHE[i + 1].waterIn) annotation(
          Line(points = {{36, -50}, {94, -50}, {94, -50}, {94, -50}}, color = {0, 127, 255}));
      end for;
      for i in 1:numberOfVolumes loop
        connect(flowHE[i].heat, gasHE[numberOfVolumes + 1 - i].heat);
      end for;
      connect(gasHE[numberOfVolumes].gasOut, gasOut) annotation(
        Line(points = {{36, 50}, {92, 50}, {92, 48}, {92, 48}}, color = {0, 127, 255}));
      connect(gasIn, gasHE[1].gasIn) annotation(
        Line(points = {{-90, 50}, {-34, 50}, {-34, 48}, {-34, 48}}));
      annotation(
        Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
        version = "",
        uses);
    end GFHE;

    model FlowSideSH
      import TPPSim.functions.alfaForSH;
      extends BaseClases.flowSideHE(redeclare replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model");
      Medium_F.ThermodynamicState stateFlow_n[2] "Термодинамическое состояние потока вода/пар на участках трубопровода";
      Real der_h_n[2] "Производняа энтальпии потока вода/пар";
      Medium_F.Density rho_n[2] "Плотность потока по участкам трубы в конечных объемах";
      Modelica.SIunits.DerDensityByEnthalpy drdh_v1 "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_v2 "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_n[2] "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_v "Производная плотности потока по давлению на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_n[2] "Производная плотности потока по давлению на участках ряда труб";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
      Medium_F.DynamicViscosity mu_flow "Динамическая вязкость для потока вода/пар";
      Modelica.SIunits.HeatFlowRate Q_flow "тепло переданное стенке трубы";
      Modelica.SIunits.Temperature t_m(start = t_startM) "Температура металла на участках трубопровода";
      Medium_F.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
      Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
      Real C1 "Показатель в числителе уравнения сплошности";
      Real C2 "Показатель в знаменателе уравнения сплошности";
      //Интерфейс
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat annotation(
        Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(
        Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(
        Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_n[1] * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
      0.5 * deltaVFlow * rho_v * der_h_n[2] = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
      deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
      heat.Q_flow = Q_flow;
      heat.T = t_m;
//Уравнения состояния
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      t_flow = Medium_F.temperature(stateFlow);
      mu_flow = if Medium_F.dynamicViscosity(stateFlow) < 1.503e-004 then 1.503e-004 else Medium_F.dynamicViscosity(stateFlow);
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
      alfa_flow = alfaForSH(h_v = h_v, D_flow_n1 = D_flow_n[1], p_v = p_v, Din = Din, f_flow = f_flow);
      D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
      D_flow_n[2] = D_flow_n[1] - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
      C1 = deltaVFlow * ((-1e-7) * der_h_n[1] + (-1e-7) * der_h_n[2]);
      C2 = deltaVFlow * 1e-8 * der(p_v);
      rho_v = (rho_n[1] + rho_n[2]) / 2;
      drdp_v = (drdp_n[1] + drdp_n[2]) / 2;
      drdh_v1 = drdh_n[1] / 2;
      drdh_v2 = drdh_n[2] / 2;
      for i in 1:2 loop
        stateFlow_n[i] = Medium_F.setState_ph(p_v, h_n[i]);
        drdp_n[i] = Medium_F.density_derp_h(stateFlow_n[i]);
        drdh_n[i] = Medium_F.density_derh_p(stateFlow_n[i]);
        rho_n[i] = Medium_F.density(stateFlow_n[i]);
      end for;
      der_h_n[1] = der(h_n[2]);
      der_h_n[2] = der(h_n[2]);
      sat_v = Medium_F.setSat_p(p_v);
      hl = Medium_F.bubbleEnthalpy(sat_v);
      hv = Medium_F.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
      p_v = p_n[1];
//Основное уравнение гидравлики
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * Lpipe * z2 / zahod / Din;
      dp_fric = w_flow_v ^ 2 * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
      p_n[1] - p_n[2] = dp_fric "Формула 2-1 из книги Рудомино, Ремжин";
    initial equation
      der(h_v) = 0;
      der(t_m) = 0;
      der(p_v) = 0;
      der(h_n[1]) = 0;
      der(h_n[2]) = 0;
      annotation(
        Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
        Diagram(graphics),
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
        Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
    end FlowSideSH;

    model GFHE_new
      extends TPPSim.HRSG_HeatExch.BaseClases.BaseGFHE;
      //Исходные данные по разбиению
      parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(
        Dialog(group = "Конструктивные характеристики"));
    protected
      parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(
        Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
      parameter Modelica.SIunits.Length deltaLpipe = Lpipe / numberOfTubeSections "Длина теплообменной трубки для элемента разбиения";
      parameter Modelica.SIunits.Area deltaSFlow = deltaLpipe * Modelica.Constants.pi * Din * z1 "Внутренняя площадь одного участка ряда труб";
      parameter Modelica.SIunits.Volume deltaVFlow = deltaLpipe * f_flow "Внутренний объем одного участка ряда труб";
      parameter Modelica.SIunits.Mass deltaMMetal = rho_m * deltaLpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 "Масса металла участка ряда труб";
      parameter Modelica.SIunits.Volume deltaVGas = deltaLpipe * (s1 * s2 - Modelica.Constants.pi * Dout ^ 2 / 4) * z1 "Объем одного участка газового тракта";
      parameter Modelica.SIunits.Area f_gas = (1 - Dout / s1 * (1 + 2 * hfin * delta_fin / sfin / Dout)) * deltaLpipe * s2 * z1 "Площадь для прохода газов";
      //Характеристики оребрения
      parameter Real H_fin = (omega * deltaLpipe * (1 - delta_fin / sfin) + (2 * Modelica.Constants.pi * (Dfin ^ 2 - Dout ^ 2) / 4 + Modelica.Constants.pi * Dfin * delta_fin) * (deltaLpipe / sfin)) * z1 * zahod "Площадь оребренной поверхности";
      //Переменные
      Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
      Modelica.SIunits.Length deltaHpipe[numberOfFlueSections, numberOfTubeSections] "Разность высот на участке ряда труб";
      Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(
        Placement(visible = true, transformation(origin = {90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
        Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium_F) annotation(
        Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium_F) annotation(
        Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TPPSim.HRSG_HeatExch.GasSideHE gasHE[numberOfFlueSections, numberOfTubeSections](redeclare package Medium_G = Medium_G, setD_gas = wgas, setp_gas = pgas, setT_inGas = Tingas, setT_outGas = Toutflow, k_alfaGas = k_gamma_gas, numberOfVolumes = numberOfFlueSections, Dout = Dout, deltaVGas = deltaVGas, f_gas = f_gas, n_fin = n_fin, Cs = Cs, Cz = Cz, H_fin = H_fin, Kaer = Kaer, DynamicMassBalance = gas_DynamicMassBalance, DynamicEnergyBalance = gas_DynamicEnergyBalance) annotation(
        Placement(visible = true, transformation(origin = {0, 50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
      replaceable TPPSim.HRSG_HeatExch.FlowSideOTE flowHE[numberOfFlueSections, numberOfTubeSections](setD_flow = wflow, setp_flow_in = pflow_in, setp_flow_out = pflow_out, setT_inFlow = Tinflow, setT_outFlow = Toutflow, Din = Din, deltaLpipe = deltaLpipe, seth_in = seth_in, seth_out = seth_out, setTm = setTm, m_flow_small = m_flow_small, deltaSFlow = deltaSFlow, deltaVFlow = deltaVFlow, deltaMMetal = deltaMMetal, f_flow = f_flow, DynamicMomentum = flow_DynamicMomentum, DynamicMassBalance = flow_DynamicMassBalance, DynamicEnergyBalance = flow_DynamicEnergyBalance, DynamicTm = flow_DynamicTm) annotation(
        Placement(visible = true, transformation(origin = {0, -50}, extent = {{-30, -30}, {30, 30}}, rotation = 90)));
      TPPSim.HRSG_HeatExch.Collector collFlow(redeclare package Medium = Medium_F, zahod = zahod);
      TPPSim.HRSG_HeatExch.Collector collGas(redeclare package Medium = Medium_G, zahod = numberOfTubeSections);
      TPPSim.HRSG_HeatExch.CollectorMix2 collFlowOut(redeclare package Medium = Medium_F, zahod = zahod, Din = Din, L = Lpipe, delta = delta);
    equation
      for i in 1:numberOfFlueSections loop
        hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева(минус 1 - нечетный, плюс 1 - четный)";
      end for;
      if HRSG_type_set == TPPSim.Choices.HRSG_type.verticalBottom or HRSG_type_set == TPPSim.Choices.HRSG_type.verticalTop then
        deltaHpipe = fill(0, numberOfFlueSections, numberOfTubeSections);
      else
        for i in 1:numberOfFlueSections loop
          for j in 1:numberOfTubeSections loop
            if HRSG_type_set == TPPSim.Choices.HRSG_type.horizontalBottom then
              deltaHpipe[i, j] = (-1) * hod[i * (j - 1) + j] * Lpipe / numberOfTubeSections "Разность высотных отметок труб для горизонтального КУ с нижним входным коллектором";
            elseif HRSG_type_set == TPPSim.Choices.HRSG_type.horizontalTop then
              deltaHpipe[i, j] = hod[i * (j - 1) + j] * Lpipe / numberOfTubeSections "Разность высотных отметок труб для горизонтального КУ с верхним входным коллектором";
            end if;
          end for;
        end for;
      end if;
      for i in 1:numberOfFlueSections - 1 loop
        for j in 1:numberOfTubeSections loop
          connect(gasHE[i, j].gasOut, gasHE[i + 1, j].gasIn);
        end for;
      end for;
      for i in 1:numberOfFlueSections loop
        for j in 1:numberOfTubeSections - 1 loop
          connect(flowHE[i, j].waterOut, flowHE[i, j + 1].waterIn);
        end for;
      end for;
//Гибы
      for i in 1:numberOfFlueSections - zahod loop
        connect(flowHE[i, numberOfTubeSections].waterOut, flowHE[i + zahod, 1].waterIn);
      end for;
//Тепловые потоки
      for i in 1:numberOfFlueSections loop
        for j in 1:numberOfTubeSections loop
          connect(flowHE[i, j].heat, gasHE[numberOfFlueSections - (i - 1), j].heat);
        end for;
      end for;
//Граничные условия
//Газы
      for j in 1:numberOfTubeSections loop
        connect(collGas.flowOut[j], gasHE[1, j].gasIn);
//connect(gasIn, gasHE[1, j].gasIn);
        connect(gasHE[numberOfFlueSections, j].gasOut, gasOut);
      end for;
      connect(gasIn, collGas.flowIn);
//Воды/Пар
      for i in 1:zahod loop
        connect(collFlow.flowOut[i], flowHE[i, 1].waterIn);
        connect(collFlowOut.flowIn[i], flowHE[numberOfFlueSections - (i - 1), numberOfTubeSections].waterOut);
// connect(flowIn, flowHE[i, 1].waterIn);
//connect(flowHE[numberOfFlueSections - (i - 1), numberOfTubeSections].waterOut, flowOut);
      end for;
      connect(flowIn, collFlow.flowIn);
      connect(flowOut, collFlowOut.flowOut);
      annotation(
        Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
        version = "",
        uses);
    end GFHE_new;

    model FlowSideSH2
      import TPPSim.functions.alfaForSH;
      extends TPPSim.HRSG_HeatExch.BaseClases.BaseFlowSideHE(redeclare replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model");
      Boolean SH_cold(start = true, fixed = true);
      Modelica.SIunits.DerDensityByEnthalpy drdh_v "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_v "Производная плотности потока по давлению на участках ряда труб";
    algorithm
      when t_m >= t_flow and SH_cold then
        SH_cold := false;
      end when;
    equation
      if DynamicEnergyBalance then
        if noEvent(SH_cold) then
          deltaVFlow * rho_v * der(h_v) = -D_flow_n[1] * (h_n[2] - h_n[1]);
        else
          deltaVFlow * rho_v * der(h_v) = alfa_flow * deltaSFlow * (t_m - t_flow) - (D_flow_n[2] * h_n[2] - D_flow_n[1] * h_n[1]);
        end if;
      else
        if noEvent(SH_cold) then
          h_n[1] = h_n[2];
        else
          D_flow_n[1] * (h_n[2] - h_n[1]) = alfa_flow * deltaSFlow * (t_m - t_flow);
        end if;
      end if;
      h_v = h_n[2];
//Уравнение теплового баланса металла
      if DynamicTm then
        if noEvent(SH_cold) then
          deltaMMetal * C_m * der(t_m) = Q_flow;
        else
          deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
        end if;
      else
        if noEvent(SH_cold) then
          Q_flow = 0;
        else
          Q_flow = alfa_flow * deltaSFlow * (t_m - t_flow);
        end if;
      end if;
//Уравнения для heat
      heat.Q_flow = Q_flow;
      heat.T = t_m;
//Уравнения состояния
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      t_flow = Medium_F.temperature(stateFlow);
      drdp_v = Medium_F.density_derp_h(stateFlow);
      drdh_v = Medium_F.density_derh_p(stateFlow);
      rho_v = Medium_F.density(stateFlow);
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
      alfa_flow = alfaForSH(h_v = h_v, D_flow_n1 = D_flow_n[1], p_v = p_v, Din = Din, f_flow = f_flow);
//D_flow_v = (D_flow_n[1] + D_flow_n[2]) / 2;
      D_flow_v = D_flow_n[2];
      if DynamicMassBalance == true then
        if noEvent(SH_cold) then
          D_flow_n[2] = D_flow_n[1] - deltaVFlow * drdp_v * der(p_v);
        else
          D_flow_n[2] = D_flow_n[1] - deltaVFlow * (drdh_v * der(h_v) + drdp_v * der(p_v)) "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
        end if;
      else
        D_flow_n[2] = D_flow_n[1];
      end if;
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
      p_v = p_n[1];
//Основное уравнение гидравлики
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * deltaLpipe / Din;
      dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
      if DynamicMomentum then
        p_n[1] - p_n[2] = dp_fric + der(D_flow_v) * deltaLpipe / f_flow;
//p_n[1] - p_n[2] = dp_fric + der(w_flow_v) * deltaLpipe * rho_v;
      else
        p_n[1] - p_n[2] = dp_fric;
      end if;
    initial equation
      if DynamicEnergyBalance and DynamicMassBalance then
        der(h_v) = 0;
        der(p_v) = 0;
      end if;
      if DynamicEnergyBalance == true and DynamicMassBalance == false then
        der(h_v) = 0;
      end if;
      if DynamicEnergyBalance == false and DynamicMassBalance == true then
        der(h_v) = 0;
        der(p_v) = 0;
      end if;
      if DynamicTm then
        der(t_m) = 0;
      end if;
      if DynamicMomentum then
        der(D_flow_v) = 0;
//der(w_flow_v) = 0;
      end if;
      annotation(
        Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
        Diagram(graphics),
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
        Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
    end FlowSideSH2;

    model FlowSideOTE2
      extends TPPSim.HRSG_HeatExch.BaseClases.BaseFlowSideHE(redeclare replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
      import TPPSim.functions.alfaFor2ph;
      import TPPSim.functions.calc_rho_v;
      import TPPSim.functions.calc_rho_drdh_drdp;
      //Переменные
      //Modelica.SIunits.DerDensityByEnthalpy drdh_new;
      //Modelica.SIunits.DerDensityByPressure drdp_new;
      Modelica.SIunits.DerDensityByEnthalpy drdh_v1, drdh_v2;
      Modelica.SIunits.DerDensityByPressure drdp_v;
      //Medium_F.Density rho_v_test;
      Medium_F.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
      Real x_v "Степень сухости";
      Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
      Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
      Real C1 "Показатель в числителе уравнения сплошности";
      Real C2 "Показатель в знаменателе уравнения сплошности";
    equation
      0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
      0.5 * deltaVFlow * rho_v * der(h_n[2]) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
      deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
      heat.Q_flow = Q_flow;
      heat.T = t_m;
//Уравнения состояния
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      t_flow = Medium_F.temperature(stateFlow);
//rho_v = calc_rho_v(h_n, p_v);
//Уравнения для расчета процессов теплообмена
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
      alfa_flow = alfaFor2ph(h_n = h_n, D_flow_v = D_flow_v, p_v = p_v, Din = Din, f_flow = f_flow);
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium_F.setState_ph(p_v, h_v[i, j]);
      x_v = if h_v < hl then 0 elseif h_v > hv then 1 else (h_v - hl) / (hv - hl);
      D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
      D_flow_n[2] = D_flow_n[1] - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
      C1 = deltaVFlow * (drdh_v1 * der(h_v) + drdh_v1 * der(h_n[2]));
      C2 = deltaVFlow * drdp_v * der(p_v);
      (rho_v, drdp_v, drdh_v1, drdh_v2) = calc_rho_drdh_drdp(h_n, p_v);
//drdh_new = if abs(h_n[2] - h_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_v, h_n[2])) - Medium_F.density(Medium_F.setState_ph(p_v, h_n[1]))) / (h_n[2] - h_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_v, h_n[2])) - Medium_F.density(Medium_F.setState_ph(p_v, h_n[2] - 0.01))) / 0.01;
//drdp_new = if abs(p_n[2] - p_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
      sat_v = Medium_F.setSat_p(p_v);
      hl = Medium_F.bubbleEnthalpy(sat_v);
      hv = Medium_F.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
      p_v = p_n[1];
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * deltaLpipe / Din;
      dp_fric = w_flow_v ^ 2 * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
//p_n[1] - p_n[2] = dp_fric;
      p_n[1] - p_n[2] = dp_fric + der(D_flow_n[2]) * deltaLpipe / f_flow;
      dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
    initial equation
      der(h_v) = 0;
      der(t_m) = 0;
      der(p_v) = 0;
      der(h_n[2]) = 0;
      der(D_flow_n[2]) = 0;
      annotation(
        Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
        Diagram(graphics),
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
        Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
    end FlowSideOTE2;

    model FlowSideOTE3
      extends TPPSim.HRSG_HeatExch.BaseClases.BaseFlowSideHE(redeclare replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
      //import TPPSim.functions.alfaFor2ph;
      import TPPSim.functions.calc_rho_v;
      import TPPSim.functions.drdh_drdp;
      //Переменные
      Modelica.SIunits.DerDensityByEnthalpy drdh;
      Modelica.SIunits.DerDensityByPressure drdp;
      Medium_F.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
      Real x_v "Степень сухости";
      Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
      Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
      Real C1 "Показатель в числителе уравнения сплошности";
      Real C2 "Показатель в знаменателе уравнения сплошности";
      //Modelica.Blocks.Continuous.Filter filter_drdh(order = 1, f_cut = 0.05) annotation(
        //Placement(visible = true, transformation(origin = {7, -61}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      //Modelica.Blocks.Continuous.Filter filter_drdp(order = 2, f_cut = 0.05) annotation(
        //Placement(visible = true, transformation(origin = {7, -61}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
    equation
      if DynamicEnergyBalance == true then
        0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
        0.5 * deltaVFlow * rho_v * der(h_n[2]) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
      else
        0 = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]);
        0 = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v);
      end if;
//Уравнение теплового баланса металла
      if DynamicTm == true then
        deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
      else
        0 = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow);
      end if;
//Уравнения для heat
      heat.Q_flow = Q_flow;
      heat.T = t_m;
//Уравнения состояния
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      t_flow = Medium_F.temperature(stateFlow);
      rho_v = calc_rho_v(h_n, p_v);
//Уравнения для расчета процессов теплообмена
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
      alfa_flow = 20000;
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium_F.setState_ph(p_v, h_v[i, j]);
      x_v = if noEvent(h_v < hl) then 0 elseif noEvent(h_v > hv) then 1 else (h_v - hl) / (hv - hl);
//D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
      D_flow_v = D_flow_n[2];
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
      D_flow_n[2] = D_flow_n[1] - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
      if DynamicMassBalance == true then
        C1 = deltaVFlow * drdh * der(h_v);
        C2 = deltaVFlow * drdp * der(p_v);
      else
        C1 = 0;
        C2 = 0;
      end if;
    //algorithm
      (drdh, drdp) = drdh_drdp(h_v, h_n, p_v, p_n);
      //filter_drdh.u := drdh;
      //filter_drdp.u := drdp;
      //drdh := filter_drdh.y;
      //drdp := filter_drdp.y;
    //equation
      sat_v = Medium_F.setSat_p(p_v);
      hl = Medium_F.bubbleEnthalpy(sat_v);
      hv = Medium_F.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
      p_v = p_n[1];
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * deltaLpipe / Din;
      dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
      if DynamicMomentum then
//p_n[1] - p_n[2] = dp_fric + der(D_flow_n[2]) * deltaLpipe / f_flow;
        p_n[1] - p_n[2] = dp_fric + der(D_flow_v) * deltaLpipe / f_flow;
//p_n[1] - p_n[2] = dp_fric + der(w_flow_v) * deltaLpipe * rho_v;
      else
        p_n[1] - p_n[2] = dp_fric;
      end if;
      dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
    initial equation
      if DynamicEnergyBalance == true and DynamicMassBalance == true then
        der(h_v) = 0;
        der(h_n[2]) = 0;
        der(p_v) = 0;
      end if;
      if DynamicEnergyBalance == true and DynamicMassBalance == false then
        der(h_v) = 0;
        der(h_n[2]) = 0;
      end if;
      if DynamicEnergyBalance == false and DynamicMassBalance == true then
        der(h_v) = 0;
        der(p_v) = 0;
      end if;
      if DynamicTm == true then
        der(t_m) = 0;
      end if;
      if DynamicMomentum then
//der(D_flow_n[2]) = 0;
        der(D_flow_v) = 0;
//der(w_flow_v) = 0;
      end if;
      annotation(
        Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
        Diagram(graphics),
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
        Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
    end FlowSideOTE3;




    model FlowSideECO
      extends TPPSim.HRSG_HeatExch.BaseClases.BaseFlowSideHE(redeclare replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
      import TPPSim.functions.alfaForSH;
      import TPPSim.functions.calc_rho_v;
      //Переменные
      Medium_F.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
      Real x_v "Степень сухости";
      Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
      Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
    equation
      if DynamicEnergyBalance == true then
        0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
        0.5 * deltaVFlow * rho_v * der(h_n[2]) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
      else
        0 = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]);
        0 = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v);
      end if;
//Уравнение теплового баланса металла
      if DynamicTm == true then
        deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
      else
        0 = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow);
      end if;
//Уравнения для heat
      heat.Q_flow = Q_flow;
      heat.T = t_m;
//Уравнения состояния
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      t_flow = Medium_F.temperature(stateFlow);
      rho_v = calc_rho_v(h_n, p_v);
//Уравнения для расчета процессов теплообмена
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
      alfa_flow = alfaForSH(h_v = h_v, D_flow_n1 = D_flow_n[1], p_v = p_v, Din = Din, f_flow = f_flow);
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium_F.setState_ph(p_v, h_v[i, j]);
      x_v = if h_v < hl then 0 elseif h_v > hv then 1 else (h_v - hl) / (hv - hl);
      D_flow_v = D_flow_n[2];
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
      D_flow_n[2] = D_flow_n[1] "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
      sat_v = Medium_F.setSat_p(p_v);
      hl = Medium_F.bubbleEnthalpy(sat_v);
      hv = Medium_F.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
      p_v = p_n[1];
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * deltaLpipe / Din;
      dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * 1000 / 2 / Modelica.Constants.g_n;
      if DynamicMomentum then
        p_n[1] - p_n[2] = dp_fric + der(D_flow_n[2]) * deltaLpipe / f_flow;
      else
        p_n[1] - p_n[2] = dp_fric;
      end if;
      dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
    initial equation
      if DynamicEnergyBalance == true then
        der(h_v) = 0;
        der(h_n[2]) = 0;
      end if;
      if DynamicTm == true then
        der(t_m) = 0;
      end if;
      if DynamicMomentum then
        der(D_flow_n[2]) = 0;
      end if;
      annotation(
        Documentation(info = "Модель экономайзер. Жидкость несжимаема. Коэффициент теплоотдачи к воде не учитывает ее кипение."),
        Diagram(graphics),
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
        Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
    end FlowSideECO;

    model Collector
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
        choicesAllMatching);
      parameter Integer zahod = 2;
      Modelica.Fluid.Interfaces.FluidPort_b flowOut[zahod](redeclare package Medium = Medium) annotation(
        Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium) annotation(
        Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      for i in 1:zahod loop
        flowOut[i].m_flow + flowIn.m_flow / zahod = 0;
        flowOut[i].h_outflow = inStream(flowIn.h_outflow);
        flowOut[i].Xi_outflow = inStream(flowIn.Xi_outflow);
      end for;
      flowIn.p = sum(flowOut[i].p for i in 1:zahod) / zahod;
//flowOut.p = fill(flowIn.p, zahod);
//sum(flowOut[i].m_flow for i in 1:zahod) + flowIn.m_flow = 0;
      flowIn.h_outflow = sum(inStream(flowOut[i].h_outflow) * flowOut[i].m_flow for i in 1:zahod) / sum(flowOut[i].m_flow for i in 1:zahod);
      flowIn.Xi_outflow = inStream(flowOut[1].Xi_outflow);
    end Collector;

    model CollectorMix
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
        choicesAllMatching);
      parameter Integer zahod = 2;
      Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
        Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a flowIn[zahod](redeclare package Medium = Medium) annotation(
        Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      flowOut.h_outflow = sum(inStream(flowIn[i].h_outflow) * flowIn[i].m_flow for i in 1:zahod) / sum(flowIn[i].m_flow for i in 1:zahod);
      flowIn.p = fill(flowOut.p, zahod);
      sum(flowIn[i].m_flow for i in 1:zahod) + flowOut.m_flow = 0;
      for i in 1:zahod loop
        flowIn[i].h_outflow = inStream(flowOut.h_outflow);
        flowIn[i].Xi_outflow = inStream(flowOut.Xi_outflow);
      end for;
      flowOut.Xi_outflow = inStream(flowIn[1].Xi_outflow);
    end CollectorMix;

    model CollectorMix2
      import TPPSim.functions.alfaFor2ph;
      import TPPSim.functions.drdh_drdp;
      replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Integer zahod = 2;
      parameter Modelica.SIunits.Diameter Din = 0.1 "Внутренний диаметр коллектора" annotation(
        Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length delta = 0.01 "Толщина стенки коллектора" annotation(
        Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length L = 5 "Длина коллектора" annotation(
        Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
        Dialog(group = "Металл"));
      parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
        Dialog(group = "Металл"));
      Modelica.SIunits.Temperature t_m "Температура металла на участках трубопровода";
    protected
      parameter Modelica.SIunits.Area SFlow = L * Modelica.Constants.pi * Din "Внутренняя площадь коллектора";
      parameter Modelica.SIunits.Volume VFlow = L * Modelica.Constants.pi * Din ^ 2 / 4 "Внутренний объем коллектора";
      parameter Modelica.SIunits.Mass MMetal = rho_m * L * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) / 4 "Масса металла коллектора";
      parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 / 4 "Площадь для прохода теплоносителя";
      Medium.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
      Medium.AbsolutePressure p_v;
      Medium.SpecificEnthalpy h_v;
      Medium.Temperature t_flow "Температура потока вода/пар";
      Medium.Density rho;
      Modelica.SIunits.DerDensityByEnthalpy drdh;
      Modelica.SIunits.DerDensityByPressure drdp;
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
      Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
        Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a flowIn[zahod](redeclare package Medium = Medium) annotation(
        Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      flowIn.p = fill(p_v, zahod);
      stateFlow = Medium.setState_ph(p_v, flowOut.h_outflow);
      rho = Medium.density(stateFlow);
      t_flow = Medium.temperature(stateFlow);
      (drdh, drdp) = drdh_drdp(h_v, {sum(inStream(flowIn[i].h_outflow) for i in 1:zahod) / zahod, h_v}, p_v, {sum(flowIn[i].p for i in 1:zahod) / zahod, p_v});
//drdp = Medium.density_derp_h(stateFlow);
//drdh = Medium.density_derh_p(stateFlow);
      alfa_flow = alfaFor2ph(h_n = {sum(inStream(flowIn[i].h_outflow) for i in 1:zahod) / zahod, h_v}, D_flow_v = -flowOut.m_flow, p_v = p_v, Din = Din, f_flow = f_flow);
      VFlow * rho * der(h_v) = sum(flowIn[i].m_flow * inStream(flowIn[i].h_outflow) for i in 1:zahod) + flowOut.m_flow * h_v "Уравнение баланса тепла";
      flowOut.m_flow + sum(flowIn[i].m_flow for i in 1:zahod) = VFlow * (drdh * der(h_v) + drdp * der(p_v));
      MMetal * C_m * der(t_m) = -alfa_flow * SFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
      flowOut.p = p_v;
      flowOut.h_outflow = h_v;
      for i in 1:zahod loop
        flowIn[i].h_outflow = inStream(flowOut.h_outflow);
        flowIn[i].Xi_outflow = inStream(flowOut.Xi_outflow);
      end for;
      flowOut.Xi_outflow = inStream(flowIn[1].Xi_outflow);
    initial equation
      der(t_m) = 0;
      der(p_v) = 0;
      der(h_v) = 0;
      annotation(
        Documentation(info = "<HTML>Аналогично collectorMix с добавлением производных по энтальпии и давлению.</html>"));
    end CollectorMix2;
  end HRSG_HeatExch;

  package Media
    model ExhaustGas
      import Modelica.Media.IdealGases.Common;
      extends Modelica.Media.IdealGases.Common.MixtureGasNasa(mediumName = "ExhaustGas", data = {Common.SingleGasesData.O2, Common.SingleGasesData.CO2, Common.SingleGasesData.H2O, Common.SingleGasesData.N2, Common.SingleGasesData.Ar, Common.SingleGasesData.SO2}, fluidConstants = {Common.FluidData.O2, Common.FluidData.CO2, Common.FluidData.H2O, Common.FluidData.N2, Common.FluidData.Ar, Common.FluidData.SO2}, substanceNames = {"Oxygen", "Carbondioxide", "Water", "Nitrogen", "Argon", "Sulfurdioxide"}, reference_X = {0.1383, 0.032, 0.0688, 1 - 0.1383 - 0.032 - 0.0688 - 0.0000000001 - 0.0000000001, 0.0000000001, 0.0000000001});
      annotation(
        Documentation(info = "<html>
      </html>"));
    end ExhaustGas;
  end Media;

  package Controls
  end Controls;

  package Sensors
    model Temperature "Ideal one port temperature sensor"
      Modelica.Fluid.Interfaces.FluidPort_a port(redeclare package Medium = Medium, m_flow(min = 0)) annotation(
        Placement(transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Interfaces.RealOutput deltaTs "Temperature in port medium" annotation(
        Placement(transformation(extent = {{60, -10}, {80, 10}})));
    protected
      package Medium = Modelica.Media.Water.StandardWater;
      Medium.Temperature ts;
      Medium.Temperature T;
    equation
      T = Medium.temperature(Medium.setState_phX(port.p, inStream(port.h_outflow), inStream(port.Xi_outflow)));
      ts = Medium.saturationTemperature_sat(Medium.setSat_p(port.p));
      deltaTs = ts - T;
      port.m_flow = 0;
      port.h_outflow = Medium.h_default;
      port.Xi_outflow = Medium.X_default[1:Medium.nXi];
      port.C_outflow = zeros(Medium.nC);
      annotation(
        defaultComponentName = "temperature",
        Documentation(info = "<html>
    <p>
    This component monitors the temperature of the fluid passing its port.
    The sensor is ideal, i.e., it does not influence the fluid.
    </p>
    </html>"),
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{0, -70}, {0, -100}}, color = {0, 0, 127}), Ellipse(extent = {{-20, -98}, {20, -60}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-12, 40}, {12, -68}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-12, 40}, {-12, 80}, {-10, 86}, {-6, 88}, {0, 90}, {6, 88}, {10, 86}, {12, 80}, {12, 40}, {-12, 40}}, lineColor = {0, 0, 0}, lineThickness = 0.5), Line(points = {{-12, 40}, {-12, -64}}, thickness = 0.5), Line(points = {{12, 40}, {12, -64}}, thickness = 0.5), Line(points = {{-40, -20}, {-12, -20}}), Line(points = {{-40, 20}, {-12, 20}}), Line(points = {{-40, 60}, {-12, 60}}), Line(points = {{12, 0}, {60, 0}}, color = {0, 0, 127})}),
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent = {{-20, -88}, {20, -50}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-12, 50}, {12, -58}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-12, 50}, {-12, 90}, {-10, 96}, {-6, 98}, {0, 100}, {6, 98}, {10, 96}, {12, 90}, {12, 50}, {-12, 50}}, lineColor = {0, 0, 0}, lineThickness = 0.5), Line(points = {{-12, 50}, {-12, -54}}, thickness = 0.5), Line(points = {{12, 50}, {12, -54}}, thickness = 0.5), Line(points = {{-40, -10}, {-12, -10}}), Line(points = {{-40, 30}, {-12, 30}}), Line(points = {{-40, 70}, {-12, 70}}), Text(extent = {{126, -30}, {6, -60}}, lineColor = {0, 0, 0}, textString = "T"), Text(extent = {{-150, 110}, {150, 150}}, textString = "%name", lineColor = {0, 0, 255}), Line(points = {{12, 0}, {60, 0}}, color = {0, 0, 127})}));
    end Temperature;
  end Sensors;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
    uses(Modelica(version = "3.2.2"), ThermoPower(version = "3.1")));
end TPPSim;
