within TPPSim.Boilers;

model OnePVerticalHRSG
  extends TPPSim.Boilers.BaseClases.Icons.Icon1pVerticalHRSG;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  outer Modelica.Fluid.System system;
  TPPSim.Pipes.ComplexPipe pipe(Din = 0.3, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {40, 0}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.012, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple ECO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.215e-3, z1 = 58, z2 = 8, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Drums.Drum drum(Din = 1.718, Hw_start = 0.5, L = 9, delta = 0.02) annotation(
    Placement(visible = true, transformation(origin = {22, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, z1 = 58, z2 = 6, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Pumps.simplePump circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {7, 5}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-18, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Обратный клапан
  //Регуляторы
  TPPSim.Controls.LC LC(DFmax = 46, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-18, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -224}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b steam(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.simpleValve FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {1, 27}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
equation
  connect(FW_In, ECO.flowIn) annotation(
    Line(points = {{-100, 68}, {-8, 68}, {-8, 24}, {-8, 24}}));
  connect(gasSink.ports[1], ECO.gasOut) annotation(
    Line(points = {{-18, 100}, {-18, 100}, {-18, 26}, {-18, 26}}, color = {0, 127, 255}, thickness = 0.5));
  connect(gasIn, SH.gasIn) annotation(
    Line(points = {{-18, -120}, {-18, -120}, {-18, -24}, {-18, -24}}));
  connect(FWCV.flowIn, ECO.flowOut) annotation(
    Line(points = {{-4, 27}, {-4, 18}, {-6, 18}, {-6, 16}, {-8, 16}}, color = {0, 127, 255}));
  connect(FWCV.flowOut, drum.fedWater) annotation(
    Line(points = {{6, 27}, {8, 27}, {8, 31}, {10, 31}, {10, 32}, {14, 32}, {14, 30}, {16, 30}}, color = {0, 127, 255}));
  connect(LC.y, FWCV.D_flow_in) annotation(
    Line(points = {{81, 20}, {89, 20}, {89, 34}, {3, 34}, {3, 30}, {1.5, 30}, {1.5, 28}, {0, 28}}, color = {0, 0, 127}));
  connect(drum.waterLevel, LC.u) annotation(
    Line(points = {{33, 27}, {41, 27}, {41, 29}, {51, 29}, {51, 19}, {59, 19}, {59, 21}, {57, 21}, {57, 21}, {57, 21}, {57, 19}}, color = {0, 0, 127}));
  connect(circPump.port_b, EVO.flowIn) annotation(
    Line(points = {{2, 5}, {0, 5}, {0, 6}, {-4, 6}, {-4, 4}, {-8, 4}}, color = {0, 127, 255}));
  connect(drum.downStr, circPump.port_a) annotation(
    Line(points = {{15, 11}, {14.75, 11}, {14.75, 13}, {14.5, 13}, {14.5, 7}, {13.25, 7}, {13.25, 7}, {12.625, 7}, {12.625, 5}, {12, 5}}, color = {0, 127, 255}));
  connect(EVO.flowOut, drum.upStr) annotation(
    Line(points = {{-8, -4}, {-6, -4}, {-6, -2}, {-4, -2}, {-4, -10}, {28, -10}, {28, 13}, {28.5, 13}, {28.5, 11}, {29, 11}}, color = {0, 127, 255}));
  connect(EVO.gasOut, ECO.gasIn) annotation(
    Line(points = {{-18, 5}, {-18, 15}}, color = {0, 127, 255}));
  connect(SH.gasOut, EVO.gasIn) annotation(
    Line(points = {{-18, -15}, {-18, -5}, {-18, -5}, {-18, 5}, {-19, 5}, {-19, -3}, {-18.5, -3}, {-18.5, -5}, {-18, -5}}, color = {0, 127, 255}));
  connect(drum.steam, pipe.waterIn) annotation(
    Line(points = {{29, 29}, {34.5, 29}, {34.5, 31}, {40, 31}, {40, 17.5}, {40, 17.5}, {40, 4}}, color = {0, 127, 255}));
  connect(SH.flowOut, steam) annotation(
    Line(points = {{-8, -24}, {100, -24}}, color = {0, 127, 255}));
  connect(pipe.waterOut, SH.flowIn) annotation(
    Line(points = {{40, -4.84}, {40, -12.84}, {-8, -12.84}, {-8, -14.42}, {-8, -14.42}, {-8, -16}}, color = {0, 127, 255}));
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
    Icon(coordinateSystem(extent = {{-200, -300}, {200, 300}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-100, -120}, {100, 120}})),
    __OpenModelica_commandLineOptions = "");
end OnePVerticalHRSG;
