﻿within TPPSim.Boilers;

model ThreePVerticalOTHRSG_2
  extends TPPSim.Boilers.ThreePVerticalHRSG_pattern;
  //Параметры
  parameter Modelica.SIunits.Temperature HP_t_m_steam_start = 100 + 273.15 "Начальная температура металла верха БВД" annotation(
    Dialog(group = "Контур ВД"));
  parameter Modelica.SIunits.Temperature HP_t_m_water_start = 100 + 273.15 "Начальная температура металла низа БВД" annotation(
    Dialog(group = "Контур ВД"));
  parameter Modelica.SIunits.Temperature IP_t_m_steam_start = 100 + 273.15 "Начальная температура металла верха БСД" annotation(
    Dialog(group = "Контур СД"));
  parameter Modelica.SIunits.Temperature IP_t_m_water_start = 100 + 273.15 "Начальная температура металла низа БСД" annotation(
    Dialog(group = "Контур СД"));
  //Контур ВД
  //Испаритель ВД
  TPPSim.HRSG_HeatExch.GFHE HP_EVO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 24e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -130}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE HP_EVO_1(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 30e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.04, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 13, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, -104}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Сепаратор ВД
  TPPSim.Drums.Separator HP_separator(redeclare package Medium = Medium_F, Din_down_pipe = 0.2, Din_sep = 0.5, H_down_pipe = 10, H_sep = 3, L_start = 7) annotation(
    Placement(visible = true, transformation(origin = {18, -126}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Регуляторы ВД
  TPPSim.Controls.LC HP_LC(DFmax = 1, DFmin = 0, k = 0.1) annotation(
    Placement(visible = true, transformation(origin = {49, -129}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  TPPSim.Controls.TC HP_TC(T_sprh = 60, k = 2e-006, yMax = 1, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {49, -107}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  TPPSim.Pumps.simplePump HP_sink_valve(redeclare package Medium = Medium_F, setD_flow = 0, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {46, -210}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure HPTC_p(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {26, -106}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Fluid.Sensors.SpecificEnthalpy HPTC_enth(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {14, -94}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  TPPSim.Sensors.Temperature HP_overheat(TemperatureType_set = TPPSim.Sensors.TemperatureType.overheating) annotation(
    Placement(visible = true, transformation(origin = {4, -104}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {7, -79}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));
  Modelica.Blocks.Continuous.LimPID PID( controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.001, yMax = 1, yMin = 0)  annotation(
    Placement(visible = true, transformation(origin = {62, -176}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));  
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {66, -196}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 60, height = 20, offset = 0, startTime = 5)  annotation(
    Placement(visible = true, transformation(origin = {50, -148}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));  
//Трубопроводы ВД
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {28, -166}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //Контур СД
  //Испаритель СД
  TPPSim.HRSG_HeatExch.GFHE IP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 34e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 2e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, s1 = 91.64e-3, s2 = 79e-3, sfin = 4.287e-3, z1 = 118, z2 = 6, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Барабан СД
  TPPSim.Drums.Drum IP_drum(Din = 1.4, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.4, L = 13.1, delta = 30e-3, ps_start = IP_p_flow_start, t_m_steam_start = IP_t_m_steam_start, t_m_water_start = HP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {22, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump IP_circPump(redeclare package Medium = Medium_F, setD_flow = 0.001, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {3, 33}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp IP_set_flow(duration = 60, height = 200, offset = 0.01, startTime = 2) annotation(
    Placement(visible = true, transformation(origin = {18, 68}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  //Регуляторы
  TPPSim.Controls.LC IP_LC(DFmax = 46, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {66, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Пароперегреватель СД
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 34e-3, Lpipe = 20.4, delta = 2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 9e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 64.64e-3, s2 = 70e-3, sfin = 5.102e-3, z1 = 168, z2 = 1, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы СД
  TPPSim.Pipes.ComplexPipe IP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {38, 18}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1 annotation(
    Placement(visible = true, transformation(origin = {-40, -68}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 5, offset = 0, startTime = 5)  annotation(
    Placement(visible = true, transformation(origin = {-86, -36}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation(
    Placement(visible = true, transformation(origin = {34, -28}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater1 annotation(
    Placement(visible = true, transformation(origin = {-44, -118}, extent = {{6, 6}, {-6, -6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 50)  annotation(
    Placement(visible = true, transformation(origin = {-56, -98}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1 annotation(
    Placement(visible = true, transformation(origin = {-36, -146}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
    Placement(visible = true, transformation(origin = {10, -148}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
equation
  connect(IP_SH_2.flowOut, IP_massFlowRate.port_a) annotation(
    Line(points = {{-8, -82}, {0, -82}, {0, -62}, {0, -62}}, color = {0, 127, 255}));
  connect(add1.y, HP_LC.u) annotation(
    Line(points = {{16, -148}, {34, -148}, {34, -128}, {41, -128}, {41, -129}}, color = {0, 0, 127}));
  connect(HP_LC.y, max1.u1) annotation(
    Line(points = {{57, -129}, {62, -129}, {62, -24}, {42, -24}}, color = {0, 0, 127}));
  connect(booleanToReal1.y, add1.u2) annotation(
    Line(points = {{-30, -146}, {-14, -146}, {-14, -152}, {2, -152}, {2, -152}}, color = {0, 0, 127}));
  connect(HP_separator.level, add1.u1) annotation(
    Line(points = {{24, -120}, {26, -120}, {26, -138}, {-2, -138}, {-2, -144}, {2, -144}, {2, -144}}, color = {0, 0, 127}));
  connect(greater1.y, booleanToReal1.u) annotation(
    Line(points = {{-50, -118}, {-54, -118}, {-54, -132}, {-48, -132}, {-48, -146}, {-44, -146}, {-44, -146}}, color = {255, 0, 255}));
  connect(HP_overheat.deltaTs, greater1.u1) annotation(
    Line(points = {{2, -104}, {0, -104}, {0, -118}, {-36, -118}, {-36, -118}}, color = {0, 0, 127}));
  connect(HP_separator.fedWater, HP_overheat.port) annotation(
    Line(points = {{12, -118}, {10, -118}, {10, -108}, {4, -108}, {4, -108}}, color = {0, 127, 255}));
  connect(const.y, greater1.u2) annotation(
    Line(points = {{-50, -98}, {-32, -98}, {-32, -112}, {-36, -112}, {-36, -114}}, color = {0, 0, 127}));
  connect(max1.y, HP_FWCV.opening) annotation(
    Line(points = {{28, -28}, {-50, -28}, {-50, 0}, {-50, 0}}, color = {0, 0, 127}));
  connect(HP_TC.y, max1.u2) annotation(
    Line(points = {{56, -106}, {58, -106}, {58, -32}, {42, -32}, {42, -32}}, color = {0, 0, 127}));
  connect(HP_sink_valve.port_b, HP_ECO_3.flowIn) annotation(
    Line(points = {{52, -210}, {78, -210}, {78, -124}, {66, -124}, {66, -54}, {-8, -54}, {-8, -54}, {-8, -54}}, color = {0, 127, 255}));
  connect(product1.y, HP_sink_valve.D_flow_in) annotation(
    Line(points = {{66, -202}, {66, -202}, {66, -204}, {54, -204}, {54, -194}, {46, -194}, {46, -204}, {46, -204}}, color = {0, 0, 127}));
  connect(ramp2.y, product1.u1) annotation(
    Line(points = {{56, -148}, {70, -148}, {70, -188}, {70, -188}}, color = {0, 0, 127}));
  connect(PID.y, product1.u2) annotation(
    Line(points = {{62, -182}, {62, -182}, {62, -188}, {62, -188}}, color = {0, 0, 127}));
  connect(ramp2.y, PID.u_s) annotation(
    Line(points = {{56, -148}, {62, -148}, {62, -168}, {62, -168}}, color = {0, 0, 127}));
  connect(HP_separator.steam, HP_pipe.waterIn) annotation(
    Line(points = {{18, -114}, {28, -114}, {28, -161}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, HP_SH_2.flowIn) annotation(
    Line(points = {{28, -171}, {28, -184}, {-8, -184}}, color = {0, 127, 255}));
  connect(massFlowRate1.m_flow, PID.u_m) annotation(
    Line(points = {{12, -78}, {32, -78}, {32, -176}, {54, -176}, {54, -176}}, color = {0, 0, 127}));
  connect(HP_separator.downWater, HP_sink_valve.port_a) annotation(
    Line(points = {{18, -136}, {18, -210}, {40, -210}}, color = {0, 127, 255}));
  connect(HP_ECO_3.flowOut, massFlowRate1.port_a) annotation(
    Line(points = {{-8, -62}, {-4, -62}, {-4, -72}, {0, -72}, {0, -74}, {7, -74}}, color = {0, 127, 255}));
  connect(massFlowRate1.port_b, HP_EVO_1.flowIn) annotation(
    Line(points = {{7, -84}, {0, -84}, {0, -94}, {-4, -94}, {-4, -100}, {-8, -100}}, color = {0, 127, 255}));
  connect(realToBoolean1.y, HP_TC.on) annotation(
    Line(points = {{-34, -68}, {40, -68}, {40, -102}, {40, -102}}, color = {255, 0, 255}));
  connect(ramp1.y, realToBoolean1.u) annotation(
    Line(points = {{-80, -36}, {-50, -36}, {-50, -68}, {-48, -68}, {-48, -68}}, color = {0, 0, 127}));
  connect(HPTC_p.p, HP_p_drum) annotation(
    Line(points = {{32, -106}, {34, -106}, {34, -116}, {104, -116}, {104, -116}}, color = {0, 0, 127}));
  connect(HPTC_enth.h_out, HP_TC.h) annotation(
    Line(points = {{20, -94}, {36, -94}, {36, -107}, {41, -107}}, color = {0, 0, 127}));
  connect(HPTC_p.p, HP_TC.p) annotation(
    Line(points = {{32, -106}, {34, -106}, {34, -111}, {41, -111}}, color = {0, 0, 127}));
  connect(HP_separator.steam, HPTC_p.port) annotation(
    Line(points = {{18, -114}, {26, -114}, {26, -112}, {26, -112}}, color = {0, 127, 255}));
  connect(HP_separator.fedWater, HPTC_enth.port) annotation(
    Line(points = {{12, -118}, {10, -118}, {10, -100}, {14, -100}}, color = {0, 127, 255}));
  connect(HP_EVO_2.flowOut, HP_separator.fedWater) annotation(
    Line(points = {{-8, -134}, {0, -134}, {0, -119}, {11, -119}}, color = {0, 127, 255}));
  connect(HP_EVO_1.flowOut, HP_EVO_2.flowIn) annotation(
    Line(points = {{-8, -108}, {-4, -108}, {-4, -126}, {-8, -126}, {-8, -126}}, color = {0, 127, 255}));
  connect(HP_EVO_2.gasIn, RH_1.gasOut) annotation(
    Line(points = {{-18, -134}, {-18, -134}, {-18, -156}, {-18, -156}}, color = {0, 127, 255}));
  connect(HP_EVO_1.gasIn, HP_EVO_2.gasOut) annotation(
    Line(points = {{-18, -108}, {-18, -108}, {-18, -124}, {-18, -124}}, color = {0, 127, 255}));
  connect(IP_SH_2.gasIn, HP_EVO_1.gasOut) annotation(
    Line(points = {{-18, -82}, {-18, -82}, {-18, -98}, {-18, -98}}, color = {0, 127, 255}));
  connect(IP_drum.p_drum, IP_p_drum) annotation(
    Line(points = {{34, 52}, {40, 52}, {40, 90}, {88, 90}, {88, 90}}, color = {0, 0, 127}));
  connect(IP_drum.waterLevel, IP_LC.u) annotation(
    Line(points = {{34, 48}, {42, 48}, {42, 50}, {52, 50}, {52, 50}, {54, 50}}, color = {0, 0, 127}));
  connect(IP_ECO_HP_ECO_1.flowOut_1, IP_drum.fedWater) annotation(
    Line(points = {{-28, 62}, {-28, 62}, {-28, 54}, {14, 54}, {14, 52}, {16, 52}}, color = {0, 127, 255}));
  connect(IP_drum.downStr, IP_circPump.port_a) annotation(
    Line(points = {{15, 33}, {14, 33}, {14, 28}, {8, 28}, {8, 34}}, color = {0, 127, 255}));
  connect(IP_drum.steam, IP_pipe.waterIn) annotation(
    Line(points = {{29, 51}, {29, 54}, {38, 54}, {38, 22}}, color = {0, 127, 255}));
  connect(IP_EVO.flowOut, IP_drum.upStr) annotation(
    Line(points = {{-8, 22}, {29, 22}, {29, 33}}, color = {0, 127, 255}));
  connect(IP_set_flow.y, IP_circPump.D_flow_in) annotation(
    Line(points = {{14, 68}, {4, 68}, {4, 38}, {4, 38}}, color = {0, 0, 127}));
  connect(IP_LC.y, IP_FWCV.opening) annotation(
    Line(points = {{78, 50}, {80, 50}, {80, 66}, {36, 66}, {36, 58}, {-50, 58}, {-50, 64}, {-48, 64}}, color = {0, 0, 127}));
  connect(IP_SH_1.flowOut, IP_SH_2.flowIn) annotation(
    Line(points = {{-8, 0}, {-2, 0}, {-2, -74}, {-8, -74}, {-8, -74}}, color = {0, 127, 255}));
  connect(IP_pipe.waterOut, IP_SH_1.flowIn) annotation(
    Line(points = {{38, 14}, {38, 14}, {38, 8}, {-8, 8}, {-8, 8}}, color = {0, 127, 255}));
  connect(IP_circPump.port_b, IP_EVO.flowIn) annotation(
    Line(points = {{-2, 34}, {-8, 34}, {-8, 30}, {-8, 30}}, color = {0, 127, 255}));
  connect(IP_SH_1.gasIn, HP_ECO_2.gasOut) annotation(
    Line(points = {{-18, 0}, {-18, 0}, {-18, -12}, {-18, -12}}, color = {0, 127, 255}));
  connect(IP_EVO.gasIn, IP_SH_1.gasOut) annotation(
    Line(points = {{-18, 22}, {-18, 22}, {-18, 10}, {-18, 10}}, color = {0, 127, 255}));
  connect(LP_SH_2.gasIn, IP_EVO.gasOut) annotation(
    Line(points = {{-18, 42}, {-18, 42}, {-18, 32}, {-18, 32}}, color = {0, 127, 255}));
  annotation(
    Documentation(info = "<html>
<style>
p {
  text-indent: 20px;
  text-align: 'justify';
 }
</style>
<p>Модель трехконтурного вертикального котла-утилизатора с барабанами высокого, среднего и низкого давления.</p>
</html>", revisions = "<html>
<ul>
<li><i>07 July 2018</i>
by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
   Создан.</li>
</ul>
</html>"),
    Icon(graphics = {Ellipse(origin = {60, 161}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-28, 29}, {32, -31}}, endAngle = 360), Rectangle(origin = {-158, 130}, lineColor = {144, 144, 144}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-16, 50}, {10, -50}}), Rectangle(origin = {-161, -9}, lineColor = {144, 144, 144}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 85}, {5, -85}}), Polygon(origin = {-161, 77}, lineColor = {144, 144, 144}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, points = {{-13, 3}, {13, 3}, {5, -3}, {-5, -3}, {-5, -3}, {-13, 3}}), Text(origin = {-160, 160}, lineColor = {115, 0, 0}, extent = {{-20, 20}, {22, -20}}, textString = "HP"), Text(origin = {64, 162}, lineColor = {170, 0, 0}, extent = {{-20, 20}, {22, -20}}, textString = "IP")}, coordinateSystem(extent = {{-200, -300}, {200, 300}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-100, -300}, {100, 200}})),
    __OpenModelica_commandLineOptions = "");
end ThreePVerticalOTHRSG_2;
