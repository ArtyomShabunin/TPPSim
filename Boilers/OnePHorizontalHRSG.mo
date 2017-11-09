within TPPSim.Boilers;

model OnePHorizontalHRSG
  extends TPPSim.Boilers.BaseClases.Icons.Icon1pHorizontalHRSG;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  outer Modelica.Fluid.System system;
  TPPSim.Pipes.ComplexPipe pipe(Din = 0.3, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-66, -6}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.012, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-70, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_simple ECO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.215e-3, z1 = 58, z2 = 8, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {30, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Drums.Drum drum(Din = 1.718, Hw_start = 0.48, L = 9, delta = 0.02) annotation(
    Placement(visible = true, transformation(origin = {-20, -2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
//  TPPSim.HRSG_HeatExch.GFHE_EVO EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.492, circ_type_set = TPPSim.Choices.circ_type.forced, delta = 0.002, delta_fin = 0.0008, dp_circ(displayUnit = "bar") = fill(1e5, 6), flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flow_circ = fill(10, 6), gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, start_flow_circ = 1, z1 = 58, z2 = 6, zahod = 6) annotation(
//    Placement(visible = true, transformation(origin = {-28, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  TPPSim.HRSG_HeatExch.GFHE_simple EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, z1 = 58, z2 = 6, zahod = 6) annotation(
    Placement(visible = true, transformation(origin = {-24, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //Обратный клапан
  //Регуляторы
  TPPSim.Controls.LC LC(DFmax = 46, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {-6, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-300, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {150, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b steamOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-170, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.simpleValve FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {21, -3}, extent = {{5, -5}, {-5, 5}}, rotation = -90)));
  TPPSim.Pipes.ComplexPipe downPipe(redeclare TPPSim.Pipes.ElementaryPipe Pipe, Din = 0.5, Lpiezo = -18.492, Lpipe = 18.492, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, n_parallel = 2, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-12, -22}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.Pumps.simplePump circulation(redeclare package Medium = Medium_F, setD_flow = 60)  annotation(
    Placement(visible = true, transformation(origin = {-12, -44}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
equation
  connect(circulation.port_b, EVO.flowIn) annotation(
    Line(points = {{-16, -44}, {-34, -44}, {-34, -20}, {-28, -20}, {-28, -20}}, color = {0, 127, 255}));
  connect(downPipe.waterOut, circulation.port_a) annotation(
    Line(points = {{-12, -26}, {-12, -26}, {-12, -36}, {-6, -36}, {-6, -44}, {-8, -44}, {-8, -44}}, color = {0, 127, 255}));
  connect(EVO.flowOut, drum.upStr) annotation(
    Line(points = {{-24, -20}, {-24, -15}, {-27, -15}, {-27, -11}}, color = {0, 127, 255}));
  connect(SH.gasOut, EVO.gasIn) annotation(
    Line(points = {{-64, -30}, {-19, -30}}, color = {0, 127, 255}));
  connect(EVO.gasOut, ECO.gasIn) annotation(
    Line(points = {{-29, -30}, {25, -30}}, color = {0, 127, 255}));
  connect(drum.downStr, downPipe.waterIn) annotation(
    Line(points = {{-13, -11}, {-13, -12.5}, {-12, -12.5}, {-12, -17}}, color = {0, 127, 255}));
  connect(LC.y, FWCV.D_flow_in) annotation(
    Line(points = {{6, 30}, {30, 30}, {30, -4}, {22, -4}, {22, -2}}, color = {0, 0, 127}));
  connect(drum.waterLevel, LC.u) annotation(
    Line(points = {{-30, 6}, {-36, 6}, {-36, 30}, {-18, 30}, {-18, 30}}, color = {0, 0, 127}));
  connect(drum.steam, pipe.waterIn) annotation(
    Line(points = {{-27, 7}, {-66, 7}, {-66, -2}}, color = {0, 127, 255}));
  connect(FWCV.flowOut, drum.fedWater) annotation(
    Line(points = {{22, 2}, {22, 8}, {-13, 8}, {-13, 7}}, color = {0, 127, 255}));
  connect(ECO.flowOut, FWCV.flowIn) annotation(
    Line(points = {{26, -20}, {26, -16}, {21, -16}, {21, -8}}, color = {0, 127, 255}));
  connect(ECO.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{35, -30}, {59, -30}, {59, -30}, {59, -30}}, color = {0, 127, 255}));
  connect(ECO.flowIn, FW_In) annotation(
    Line(points = {{34, -20}, {50, -20}, {50, 0}, {100, 0}}, color = {0, 127, 255}));
  connect(gasIn, SH.gasIn) annotation(
    Line(points = {{-100, -30}, {-74, -30}, {-74, -30}, {-74, -30}}));
  connect(SH.flowOut, steamOut) annotation(
    Line(points = {{-74, -20}, {-74, -20}, {-74, 0}, {-100, 0}, {-100, 0}}, color = {0, 127, 255}));
  connect(SH.flowIn, pipe.waterOut) annotation(
    Line(points = {{-66, -20}, {-66, -20}, {-66, -10}, {-66, -10}}, color = {0, 127, 255}));
//  for i in 1:6 loop
//    connect(downPipe.waterOut, EVO.flowIn[i]);
//    connect(EVO.flowOut[i], drum.upStr);
//  end for;
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
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}}, initialScale = 0.1)),
    Diagram(coordinateSystem(initialScale = 0.1)),
    __OpenModelica_commandLineOptions = "");
end OnePHorizontalHRSG;
