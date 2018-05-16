within TPPSim.Boilers;

model OnePHorizontalOTHRSG "Одноконтурный горизонтальный прямоточный котел-утилизатор"
  extends TPPSim.Boilers.BaseClases.Icons.Icon1pHorizontalOTHRSG;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  outer Modelica.Fluid.System system;
  inner parameter Boolean SH_cold_start = true "Исходное состояние - холодное" annotation(
    Dialog(group = "Исходное состояние"));
  parameter Modelica.SIunits.AbsolutePressure HP_p_flow_start = system.p_ambient "Начальное давление пара в БВД" annotation(
    Dialog(group = "Контур ВД"));
  parameter Modelica.SIunits.Temperature HP_t_m_steam_start = 100 + 273.15 "Начальная температура металла верха БВД" annotation(
    Dialog(group = "Контур ВД"));
  parameter Modelica.SIunits.Temperature HP_t_m_water_start = 100 + 273.15 "Начальная температура металла низа БВД" annotation(
    Dialog(group = "Контур ВД"));
  //Контур ВД
  //Экономайзеры ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.29, delta = 3.404e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15.88e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 2.421e-3, z1 = 120, z2 = 10, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {20, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //Испаритель ВД
  TPPSim.HRSG_HeatExch.GFHE_EVO_benson HP_EVO_1(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.29, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flow_circ = {1.3, 2.7, 4.9, 6.9, 9.1, 11.4, 13.2, 15.3, 16.9, 18.4} / 100, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, hfin = 15.88e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, piez_type = TPPSim.Choices.piez_type.zero, s1 = 85.15e-3, s2 = 111.1e-3, sfin = 2.921e-3, z1 = 126, z2 = 10, zahod = 10) annotation(
    Placement(visible = true, transformation(origin = {-14, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  //Пароперегреватели ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 2.667e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12.7e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 4.526e-3, z1 = 120, z2 = 3, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-52, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //Барабаны
  //Трубопроводы (вода)
  //Паропроводы
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, t_m_start = 373.15) annotation(
    Placement(visible = true, transformation(origin = {-48, 16}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Pipes.ComplexPipe HP_pipe_2(redeclare TPPSim.Pipes.ElementaryPipe Pipe, Din = 0.3, Lpiezo = 0, Lpipe = 18.29, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 2, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-20, 16}, extent = {{4, -4}, {-4, 4}}, rotation = -90)));
  TPPSim.Pipes.ComplexPipe HP_pipe_3(redeclare TPPSim.Pipes.ElementaryPipe Pipe, Din = 0.3, Lpiezo = 0, Lpipe = 18.29, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 2, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-10, 10}, extent = {{4, -4}, {-4, 4}}, rotation = -90)));
  TPPSim.Pipes.ComplexPipe HP_pipe_4(redeclare TPPSim.Pipes.ElementaryPipe Pipe, Din = 0.3, Lpiezo = 0, Lpipe = 19, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {0, -8}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //Регуляторы уровня
  //РПК
  TPPSim.Valves.simpleValve HP_FWCV(redeclare package Medium = Medium_F, dp = 0, m_flow_small = 0.0001, setD_flow = 0, use_D_flow_in = false) annotation(
    Placement(visible = true, transformation(origin = {27, 13}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  //Атмосфера
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {68, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-82, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-300, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b HP_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-82, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-168, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a HP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {68, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {156, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_EVO_benson HP_EVO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.29, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flow_circ = {16, 17.3, 18.6, 22.4, 25.6} / 100, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, hfin = 15.88e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, piez_type = TPPSim.Choices.piez_type.zero, s1 = 85.15e-3, s2 = 111.1e-3, sfin = 2.921e-3, z1 = 126, z2 = 5, zahod = 5) annotation(
    Placement(visible = true, transformation(origin = {-32, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  Modelica.Fluid.Sensors.Temperature t_gas_start(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-67, 31}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //  Drums.Separator2 separator21 annotation(
  //    Placement(visible = true, transformation(origin = {-36, 18}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Drums.Separator separator1(redeclare package Medium = Medium_F, Din_down_pipe = 0.2, Din_sep = 0.5, H_down_pipe = 10, H_sep = 3, L_start = 7) annotation(
    Placement(visible = true, transformation(origin = {-34, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump circPump(redeclare package Medium = Medium_F, setD_flow = 20) annotation(
    Placement(visible = true, transformation(origin = {-13, -41}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
equation
  connect(circPump.port_b, HP_ECO_2.flowIn) annotation(
    Line(points = {{-6, -40}, {32, -40}, {32, 0}, {24, 0}, {24, 0}}, color = {0, 127, 255}));
  connect(separator1.downWater, circPump.port_a) annotation(
    Line(points = {{-34, 16}, {-34, -41}, {-20, -41}}, color = {0, 127, 255}));
  connect(HP_pipe_2.waterOut, separator1.fedWater) annotation(
    Line(points = {{-20, 20}, {-20, 33}, {-27, 33}}, color = {0, 127, 255}));
  connect(separator1.steam, HP_pipe.waterIn) annotation(
    Line(points = {{-34, 37}, {-48, 37}, {-48, 20}}, color = {0, 127, 255}));
  connect(HP_EVO_2.flowOut, HP_pipe_2.waterIn) annotation(
    Line(points = {{-32, 0}, {-32, 11}, {-20, 11}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasOut, t_gas_start.port) annotation(
    Line(points = {{-46, -10}, {-42, -10}, {-42, 26}, {-66, 26}, {-66, 26}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{26, -10}, {58, -10}, {58, -10}, {58, -10}}, color = {0, 127, 255}));
  connect(HP_EVO_1.gasOut, HP_ECO_2.gasIn) annotation(
    Line(points = {{-8, -10}, {16, -10}, {16, -10}, {16, -10}}, color = {0, 127, 255}));
  connect(HP_pipe_4.waterOut, HP_EVO_1.flowIn) annotation(
    Line(points = {{0, -12}, {0, -12}, {0, -26}, {-14, -26}, {-14, -20}, {-14, -20}}, color = {0, 127, 255}));
  connect(HP_ECO_2.flowOut, HP_pipe_4.waterIn) annotation(
    Line(points = {{16, 0}, {16, 0}, {16, 4}, {0, 4}, {0, -4}, {0, -4}}, color = {0, 127, 255}));
  connect(HP_FWCV.flowOut, HP_ECO_2.flowIn) annotation(
    Line(points = {{22, 14}, {18, 14}, {18, 6}, {24, 6}, {24, 0}, {24, 0}}, color = {0, 127, 255}));
  connect(HP_FW_In, HP_FWCV.flowIn) annotation(
    Line(points = {{68, 10}, {40, 10}, {40, 14}, {32, 14}, {32, 14}}));
  connect(HP_pipe_3.waterOut, HP_EVO_2.flowIn) annotation(
    Line(points = {{-10, 14}, {-18, 14}, {-18, 2}, {-24, 2}, {-24, -28}, {-32, -28}, {-32, -20}, {-32, -20}}, color = {0, 127, 255}));
  connect(HP_EVO_1.flowOut, HP_pipe_3.waterIn) annotation(
    Line(points = {{-14, 0}, {-14, 0}, {-14, 6}, {-10, 6}, {-10, 6}}, color = {0, 127, 255}));
  connect(HP_EVO_2.gasIn, HP_SH_1.gasOut) annotation(
    Line(points = {{-36, -10}, {-46, -10}, {-46, -10}, {-46, -10}}, color = {0, 127, 255}));
  connect(HP_EVO_1.gasIn, HP_EVO_2.gasOut) annotation(
    Line(points = {{-18, -10}, {-26, -10}, {-26, -10}, {-26, -10}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, HP_SH_1.flowIn) annotation(
    Line(points = {{-48, 12}, {-48, 12}, {-48, 0}, {-48, 0}}, color = {0, 127, 255}));
  connect(HP_SH_1.flowOut, HP_Out) annotation(
    Line(points = {{-56, 0}, {-56, 0}, {-56, 12}, {-82, 12}, {-82, 11}, {-82, 11}, {-82, 10}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasIn, gasIn) annotation(
    Line(points = {{-57, -10}, {-68, -10}, {-68, -8}, {-79, -8}, {-79, -8}, {-82, -8}, {-82, -10}, {-83, -10}}, color = {0, 127, 255}));
  annotation(
    Documentation(info = "<html>
  <p>
  Модель одноконтурного горизонтального котла-утилизатора для отработки модели прямоточного испарителя.
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>September 07, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}}, initialScale = 0.1)),
    Diagram(coordinateSystem(initialScale = 0.1)),
    __OpenModelica_commandLineOptions = "");
end OnePHorizontalOTHRSG;
