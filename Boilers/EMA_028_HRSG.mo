within TPPSim.Boilers;

model EMA_028_HRSG "Котел-утилизатор ЭМА-028-КУ энергоблока ПГУ-410 Ново-Салаватской ТЭЦ"
  extends TPPSim.Boilers.BaseClases.Icons.Icon3pHorizontalHRSG;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  outer Modelica.Fluid.System system;
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-26, -10}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //Экономайзеры ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_ECO_2(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.0381, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.29, delta = 0.003404, delta_fin = 0.0009906, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.01588, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 2.421e-3, z1 = 120, z2 = 10, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {30, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));  
//Испаритель ВД
  TPPSim.HRSG_HeatExch.GFHE_EVO HP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.0381, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.29, circ_type_set = TPPSim.Choices.circ_type.forced, delta = 0.003404, delta_fin = 0.0009906, dp_circ(displayUnit = "bar") = fill(1e5, 16), flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flow_circ = fill(210, 16), gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.01588, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 85.15e-3, s2 = 111.1e-3, sfin = 2.921e-3, start_flow_circ = 1, z1 = 126, z2 = 16, zahod = 16) annotation(
    Placement(visible = true, transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //Пароперегреватели ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.0381, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 0.002667, delta_fin = 0.009906, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.0127, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 4.526e-3, z1 = 120, z2 = 3, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-30, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));   
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.0381, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.29, delta = 0.003048, delta_fin = 0.009906, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.0127, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 5.412e-3, z1 = 120, z2 = 3, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-50, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));   
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.0381, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalTop, Lpipe = 18.29, delta = 0.009906, delta_fin = 0.00448, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.0127, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 89.39e-3, s2 = 111.1e-3, sfin = 4.48e-3, z1 = 120, z2 = 6, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-70, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  
  
  
  TPPSim.Drums.Drum HP_drum(Din = 1.6, Hw_start = 0.5, L = 14.05, delta = 0.0105) annotation(
    Placement(visible = true, transformation(origin = {-10, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //Обратный клапан
  //Регуляторы
  TPPSim.Controls.LC HP_LC(DFmax = 75, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-10, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-300, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {150, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b steamOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-170, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.simpleValve HP_FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {25, -5}, extent = {{5, -5}, {-5, 5}}, rotation = -90)));
  TPPSim.Pipes.ComplexPipe HP_downPipe(redeclare TPPSim.Pipes.ElementaryPipe Pipe, Din = 0.3, Lpiezo = -18.29, Lpipe = 18.29, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {4, -30}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));

equation
  connect(HP_SH_1.gasOut, HP_EVO.gasIn) annotation(
    Line(points = {{-24, -30}, {-16, -30}, {-16, -30}, {-14, -30}}, color = {0, 127, 255}));
  connect(HP_SH_2.gasOut, HP_SH_1.gasIn) annotation(
    Line(points = {{-44, -30}, {-36, -30}, {-36, -30}, {-34, -30}}, color = {0, 127, 255}));
  connect(HP_SH_3.gasOut, HP_SH_2.gasIn) annotation(
    Line(points = {{-64, -30}, {-56, -30}, {-56, -30}, {-54, -30}}, color = {0, 127, 255}));
  connect(HP_ECO_2.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{35, -30}, {80, -30}}, color = {0, 127, 255}));
  connect(HP_ECO_2.flowIn, FW_In) annotation(
    Line(points = {{34, -20}, {67, -20}, {67, 0}, {100, 0}}, color = {0, 127, 255}));
  connect(HP_FWCV.flowOut, HP_drum.fedWater) annotation(
    Line(points = {{26, 0}, {-2, 0}, {-2, 0}, {-2, 0}}, color = {0, 127, 255}));
  connect(HP_FWCV.D_flow_in, HP_LC.y) annotation(
    Line(points = {{26, -4}, {36, -4}, {36, 18}, {2, 18}, {2, 18}}, color = {0, 0, 127}));
  connect(HP_ECO_2.flowOut, HP_FWCV.flowIn) annotation(
    Line(points = {{26, -20}, {26, -16}, {25, -16}, {25, -10}}, color = {0, 127, 255}));
  connect(HP_EVO.gasOut, HP_ECO_2.gasIn) annotation(
    Line(points = {{-5, -30}, {25, -30}}, color = {0, 127, 255}));
  connect(HP_drum.waterLevel, HP_LC.u) annotation(
    Line(points = {{-20, -2}, {-34, -2}, {-34, 18}, {-22, 18}, {-22, 18}}, color = {0, 0, 127}));
  connect(HP_SH_2.flowOut, HP_SH_3.flowIn) annotation(
    Line(points = {{-54, -20}, {-66, -20}, {-66, -20}, {-66, -20}}, color = {0, 127, 255}));
  connect(HP_SH_1.flowOut, HP_SH_2.flowIn) annotation(
    Line(points = {{-34, -20}, {-46, -20}, {-46, -20}, {-46, -20}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, HP_SH_1.flowIn) annotation(
    Line(points = {{-26, -14}, {-26, -14}, {-26, -20}, {-26, -20}}, color = {0, 127, 255}));
  connect(HP_drum.steam, HP_pipe.waterIn) annotation(
    Line(points = {{-16, 0}, {-26, 0}, {-26, -6}, {-26, -6}}, color = {0, 127, 255}));
  connect(HP_drum.downStr, HP_downPipe.waterIn) annotation(
    Line(points = {{-2, -18}, {4, -18}, {4, -26}, {4, -26}}, color = {0, 127, 255}));
  connect(HP_downPipe.waterOut, HP_EVO.flowIn[i]) annotation(
    Line);
  connect(HP_EVO.flowOut[i], HP_drum.upStr) annotation(
    Line);
  connect(gasIn, HP_SH_3.gasIn) annotation(
    Line(points = {{-100, -30}, {-74, -30}, {-74, -30}, {-74, -30}}));
  connect(HP_SH_3.flowOut, steamOut) annotation(
    Line(points = {{-74, -20}, {-74, -20}, {-74, 0}, {-100, 0}, {-100, 0}}, color = {0, 127, 255}));
  for i in 1:16 loop
    connect(HP_downPipe.waterOut, HP_EVO.flowIn[i]);
    connect(HP_EVO.flowOut[i], HP_drum.upStr);
  end for;
protected
  annotation(
    Documentation(info = "<html>
  <p>
  Модель КУ ЭМА-028-КУ, тип Еп-264/297/43-13.0/3.0/0.47-558/558/237-11.6вв.<br>
  Индексы в обозначении КУ означают следующее:<br><br>
  Еп - тип котла-утилизатора с естественной циркуляцией и промежуточным перегревом;<br>
  264 - паропроизводительность контура высокого давления (ВД), т/ч;<br>
  297 - паропроизводительность контура горячего промперегрева (ГПП), т/ч;<br>
  43 - паропроизводительность контура низкого давления (НД), т/ч;<br>
  13.0 - давление пара на выходе из контура высокого давления (абс.), МПа;<br>
  3.0 - давление пара на выходе из контура горячего промперегрева (абс.), МПа;<br>
  0.47 - давление пара на выходе из контура низкого давления (абс.), МПа;<br>
  558 - температура пара на выходе из контура высокого давления, С;<br>
  558 - температура пара на выходе из контура горячего промперегрева, С;<br>
  273 - температура пара на выходе из контура низкого давления, С;<br>
  11.6вв - максимальная тепловая мощность ВВТО, МВт;<br><br>
  Параметры указаны для номинальной нагрузки ГТУ при температуре наружного воздуха +15С, относитльеной влажности 60% и атмосферном давлении 1.013бар.
  </p>
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>October 11, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}}, initialScale = 0.1)),
    Diagram(coordinateSystem(initialScale = 0.1)),
    __OpenModelica_commandLineOptions = "");
end EMA_028_HRSG;
