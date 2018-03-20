within TPPSim.Boilers;

model OnePHorizontalHRSG "Одноконтурный горизонтальный котел-утилизатор"
  extends TPPSim.Boilers.BaseClases.Icons.Icon1pHorizontalHRSG;
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
    Placement(visible = true, transformation(origin = {14, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //Испаритель ВД
  TPPSim.HRSG_HeatExch.GFHE_EVO HP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.29, circ_type_set = TPPSim.Choices.circ_type.forced, delta = 3.404e-3, delta_fin = 0.9906e-3, dp_circ(displayUnit = "bar") = fill(1e5, 16), flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flow_circ = {2, 2.5, 3, 4, 8, 9, 10, 12, 13, 14, 24, 27, 40, 45, 60, 65}, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15.88e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, piez_type = TPPSim.Choices.piez_type.var, s1 = 85.15e-3, s2 = 111.1e-3, sfin = 2.921e-3, start_flow_circ = 1, z1 = 126, z2 = 16, zahod = 16) annotation(
    Placement(visible = true, transformation(origin = {-32, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //Пароперегреватели ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 2.667e-3, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12.7e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 4.526e-3, z1 = 120, z2 = 3, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-52, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //Барабаны
  TPPSim.Drums.Drum HP_drum(Din = 1.6, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.34, L = 14.05, delta = 0.0105, ps_start = HP_p_flow_start, t_m_steam_start = HP_t_m_steam_start, t_m_water_start = HP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {-32, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  //Трубопроводы (вода)
  TPPSim.Pipes.ComplexPipe HP_downPipe(redeclare TPPSim.Pipes.ElementaryPipe Pipe, Din = 0.3, Lpiezo = -18.29, Lpipe = 18.29, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -10}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //Паропроводы
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {-48, 10}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //Регуляторы уровня
  TPPSim.Controls.LC HP_LC(DFmax = 95, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {3, 29}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //РПК
  TPPSim.Valves.simpleValve HP_FWCV(redeclare package Medium = Medium_F, dp = 100000, m_flow_small = 0.0001, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {41, 9}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
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
  TPPSim.Pumps.simplePump HP_blowdown(redeclare package Medium = Medium_F, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-15, -29}, extent = {{-5, 5}, {5, -5}}, rotation = 90)));
  Modelica.Fluid.Sources.FixedBoundary flash_tank(redeclare package Medium = Medium_F, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {32, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(HP_blowdown.port_b, flash_tank.ports[1]) annotation(
    Line(points = {{-15, -34}, {31, -34}, {31, -40}, {31, -40}}, color = {0, 127, 255}));
  connect(HP_LC.y1, HP_blowdown.D_flow_in) annotation(
    Line(points = {{8.5, 30.5}, {16.5, 30.5}, {16.5, 32.5}, {24.5, 32.5}, {24.5, -27.5}, {-9.5, -27.5}, {-9.5, -28.5}, {-9.5, -28.5}, {-9.5, -27.5}}, color = {0, 0, 127}));
  connect(HP_drum.HPFW, HP_blowdown.port_a) annotation(
    Line(points = {{-21.6, 5}, {-17.6, 5}, {-17.6, 5}, {-13.6, 5}, {-13.6, -25}, {-13.6, -25}, {-13.6, -25}, {-13.6, -25}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{19, -10}, {38, -10}, {38, -8}, {59, -8}, {59, -8}, {57, -8}, {57, -10}, {57, -10}}, color = {0, 127, 255}));
  connect(HP_FW_In, HP_FWCV.flowIn) annotation(
    Line(points = {{68, 10}, {57, 10}, {57, 12}, {46, 12}, {46, 10}, {46, 10}}));
  connect(HP_FWCV.flowOut, HP_ECO_2.flowIn) annotation(
    Line(points = {{36, 9}, {27, 9}, {27, 11}, {18, 11}, {18, -1}, {19, -1}, {19, -1}, {18, -1}}, color = {0, 127, 255}));
  connect(HP_LC.y, HP_FWCV.D_flow_in) annotation(
    Line(points = {{8.5, 29}, {25.5, 29}, {25.5, 29}, {42.5, 29}, {42.5, 9}, {42, 9}, {42, 9}, {41.5, 9}}, color = {0, 0, 127}));
  connect(HP_drum.waterLevel, HP_LC.u) annotation(
    Line(points = {{-43, 16}, {-50, 16}, {-50, 16}, {-57, 16}, {-57, 28}, {-30, 28}, {-30, 28}, {-3, 28}}, color = {0, 0, 127}));
  connect(HP_drum.steam, HP_pipe.waterIn) annotation(
    Line(points = {{-39, 19}, {-45, 19}, {-45, 19}, {-49, 19}, {-49, 13}, {-49, 13}, {-49, 13}, {-49, 13}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, HP_SH_1.flowIn) annotation(
    Line(points = {{-48, 5.16}, {-48, -0.84}}, color = {0, 127, 255}));
  connect(HP_drum.downStr, HP_downPipe.waterIn) annotation(
    Line(points = {{-25, 1}, {-25.625, 1}, {-25.625, 1}, {-24.25, 1}, {-24.25, 1}, {-23.5, 1}, {-23.5, 1}, {-22, 1}, {-22, 3}, {-19, 3}, {-19, -5}, {-18, -5}, {-18, -7}, {-18.5, -7}, {-18.5, -7}, {-18.75, -7}, {-18.75, -5}, {-18.875, -5}, {-18.875, -7}, {-19, -7}}, color = {0, 127, 255}));
  connect(HP_ECO_2.flowOut, HP_drum.fedWater) annotation(
    Line(points = {{10, 0}, {10, 0}, {10, 2}, {10, 2}, {10, 22}, {-24, 22}, {-24, 20}, {-24, 20}, {-24, 20}}, color = {0, 127, 255}));
  connect(HP_SH_1.flowOut, HP_Out) annotation(
    Line(points = {{-56, 0}, {-56, 0}, {-56, 12}, {-82, 12}, {-82, 11}, {-82, 11}, {-82, 10}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasIn, gasIn) annotation(
    Line(points = {{-57, -10}, {-68, -10}, {-68, -8}, {-79, -8}, {-79, -8}, {-82, -8}, {-82, -10}, {-83, -10}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasOut, HP_EVO.gasIn) annotation(
    Line(points = {{-47, -10}, {-36, -10}}, color = {0, 127, 255}));
  connect(HP_EVO.gasOut, HP_ECO_2.gasIn) annotation(
    Line(points = {{-27, -10}, {9, -10}, {9, -10}, {9, -10}}, color = {0, 127, 255}));
  for i in 1:16 loop
    connect(HP_downPipe.waterOut, HP_EVO.flowIn[i]);
    connect(HP_EVO.flowOut[i], HP_drum.upStr);
  end for;
  annotation(
    Documentation(info = "<html>
  <p>
  Модель одноконтурного котла-утилизатора для отработки моделей поверхностей нагрева, барабана и т.д.
  </p>
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>September 07, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}}, initialScale = 0.1)),
    Diagram(coordinateSystem(initialScale = 0.1)),
    __OpenModelica_commandLineOptions = "");
end OnePHorizontalHRSG;
