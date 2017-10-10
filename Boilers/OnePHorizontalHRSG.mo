within TPPSim.Boilers;

model OnePHorizontalHRSG
  extends TPPSim.Boilers.BaseClases.Icons.Icon1pHorizontalHRSG;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  outer Modelica.Fluid.System system;
  TPPSim.Pipes.ComplexPipe pipe(Din = 0.3, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {38, -20}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.012, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -64}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple ECO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.215e-3, z1 = 58, z2 = 8, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Drums.Drum drum(Din = 1.718, Hw_start = 0.5, L = 9, delta = 0.02) annotation(
    Placement(visible = true, transformation(origin = {22, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_EVO EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, dp_circ (displayUnit = "bar") = {1e5, 1e5, 2e5, 2e5, 3e5, 3e5}, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flow_circ = fill(15, 6), gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, start_flow_circ = 1, z1 = 58, z2 = 6, zahod = 6) annotation(
    Placement(visible = true, transformation(origin = {-18, -22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //  TPPSim.Pumps.simplePump circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
  //    Placement(visible = true, transformation(origin = {5, -13}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-18, 68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Обратный клапан
  //Регуляторы
  TPPSim.Controls.LC LC(DFmax = 46, DFmin = 0, levelSP = 0.5) annotation(
    Placement(visible = true, transformation(origin = {70, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-18, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-300, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {150, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b steamOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-170, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.simpleValve FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {1, 31}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe downPipe(redeclare TPPSim.Pipes.ElementaryPipe Pipe, Din = 0.5, Lpiezo = -18.492, Lpipe = 18.492, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {16, 0}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
equation
  connect(FWCV.flowIn, ECO.flowOut) annotation(
    Line(points = {{-4, 31}, {-4, 22}, {-6, 22}, {-6, 20}, {-8, 20}}, color = {0, 127, 255}));
  connect(ECO.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-18, 29}, {-18, 58}}, color = {0, 127, 255}));
  connect(FW_In, ECO.flowIn) annotation(
    Line(points = {{-100, 46}, {-8, 46}, {-8, 28}}));
  connect(EVO.gasOut, ECO.gasIn) annotation(
    Line(points = {{-18, -17}, {-18, 19}}, color = {0, 127, 255}));
  for i in 1:6 loop
    connect(downPipe.waterOut, EVO.flowIn[i]) annotation(
      Line(points = {{0, -12}, {0, -12}, {0, 2}, {-62, 2}, {-62, -24}, {-28, -24}, {-28, -22}}, color = {0, 127, 255}));
    connect(EVO.flowOut[i], drum.upStr) annotation(
      Line(points = {{-8, -22}, {28, -22}, {28, 16}, {30, 16}}, color = {0, 127, 255}, thickness = 0.5));
  end for;
  connect(drum.downStr, downPipe.waterIn) annotation(
    Line(points = {{16, 16}, {16, 5}}, color = {0, 127, 255}));
  connect(EVO.gasIn, SH.gasOut) annotation(
    Line(points = {{-18, -27}, {-18, -59}}, color = {0, 127, 255}));
  connect(pipe.waterOut, SH.flowIn) annotation(
    Line(points = {{38, -25}, {38, -33.42}, {-8, -33.42}, {-8, -60}}, color = {0, 127, 255}));
  connect(drum.steam, pipe.waterIn) annotation(
    Line(points = {{29, 33}, {34.5, 33}, {34.5, 35}, {38, 35}, {38, -15}}, color = {0, 127, 255}));
  connect(SH.flowOut, steamOut) annotation(
    Line(points = {{-8, -68}, {51, -68}, {51, -52}, {100, -52}}, color = {0, 127, 255}));
  connect(SH.gasIn, gasIn) annotation(
    Line(points = {{-18, -69}, {-18, -22}}, color = {0, 127, 255}));
  connect(FWCV.flowOut, drum.fedWater) annotation(
    Line(points = {{6, 31}, {8, 31}, {8, 33}, {10, 33}, {10, 36}, {14, 36}, {14, 34}, {16, 34}}, color = {0, 127, 255}));
  connect(LC.y, FWCV.D_flow_in) annotation(
    Line(points = {{81, 24}, {85, 24}, {85, 26}, {89, 26}, {89, 38}, {3, 38}, {3, 32}, {0, 32}}, color = {0, 0, 127}));
  connect(drum.waterLevel, LC.u) annotation(
    Line(points = {{33, 31}, {41, 31}, {41, 33}, {51, 33}, {51, 23}, {59, 23}, {59, 23}, {57, 23}, {57, 23}}, color = {0, 0, 127}));
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
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    __OpenModelica_commandLineOptions = "");
end OnePHorizontalHRSG;
