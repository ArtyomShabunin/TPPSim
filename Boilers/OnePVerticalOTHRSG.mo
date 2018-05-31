within TPPSim.Boilers;

model OnePVerticalOTHRSG
  extends TPPSim.Boilers.BaseClases.Icons.Icon1pVerticalOTHRSG;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  outer Modelica.Fluid.System system;
  inner parameter Boolean SH_cold_start = true "Исходное состояние - холодное" annotation(
    Dialog(group = "Исходное состояние"));
  parameter Modelica.SIunits.AbsolutePressure HP_p_flow_start = system.p_ambient "Начальное давление пара в БВД" annotation(
    Dialog(group = "Контур ВД"));
  TPPSim.Pipes.ComplexPipe pipe(Din = 0.3, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, t_m_start = 373.15) annotation(
    Placement(visible = true, transformation(origin = {30, -4}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, Lpipe = 18.492, delta = 0.002, delta_fin = 0.001, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.012, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 91.09e-3, s2 = 79e-3, sfin = 5.102e-3, z1 = 58, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple ECO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.215e-3, z1 = 58, z2 = 8, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, z1 = 58, z2 = 6, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-18, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Обратный клапан
  //Регуляторы
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-18, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -224}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b steam(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {128, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
//  TPPSim.Valves.simpleValve FWCV(redeclare package Medium = Medium_F, dp = 100000, m_flow_small = 0.0001, setD_flow = 30, use_D_flow_in = true) annotation(
//    Placement(visible = true, transformation(origin = {-37, 49}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Sensors.Temperature overheat_T(TemperatureType_set = TPPSim.Sensors.TemperatureType.overheating)  annotation(
    Placement(visible = true, transformation(origin = {44, 6}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  TPPSim.Controls.TC tc1(T_sprh = 60,yMax = 1, y_start = 0.3)  annotation(
    Placement(visible = true, transformation(origin = {26, 42}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure pressure1(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {67, 7}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {92, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Drums.Separator separator1(redeclare package Medium = Medium_F, Din_down_pipe = 0.2, Din_sep = 0.5, H_down_pipe = 10, H_sep = 3, L_start = 7) annotation(
    Placement(visible = true, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump sink_valve(redeclare package Medium = Medium_F, setD_flow = 0, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {34, -50}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary sink(redeclare package Medium = Medium_F, nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {90, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature t_g(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {4, -12}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  TPPSim.Controls.LC_sink lC_sink1(DFmax = 30, DFmin = 0, L = 7)  annotation(
    Placement(visible = true, transformation(origin = {45, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  TPPSim.Pumps.pressurePump FW_pump(redeclare package Medium = Medium_F, set_p = 6e+06, use_p_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveIncompressible FWCV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 200, dp_nominal = 100000, filteredOpening = true, riseTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-31, 51}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure pressure2(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-7,77}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
    Placement(visible = true, transformation(origin = {-49, 83}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1e5)  annotation(
    Placement(visible = true, transformation(origin = {-90, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater1 annotation(
    Placement(visible = true, transformation(origin = {58, 63}, extent = {{-8, -9}, {8, 9}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant const2(k = 100 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {48, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(tc1.y, FWCV.opening) annotation(
    Line(points = {{17, 42}, {10, 42}, {10, 68}, {-31, 68}, {-31, 57}}, color = {0, 0, 127}));
  connect(FW_pump.port_b, FWCV.port_a) annotation(
    Line(points = {{-60, 50}, {-53, 50}, {-53, 51}, {-38, 51}}, color = {0, 127, 255}));
  connect(FWCV.port_b, ECO.flowIn) annotation(
    Line(points = {{-24, 51}, {-2, 51}, {-2, 26}, {-8, 26}}, color = {0, 127, 255}));
  connect(FWCV.port_b, pressure2.port) annotation(
    Line(points = {{-24, 51}, {-7, 51}, {-7, 72}}, color = {0, 127, 255}));
  connect(greater1.y, tc1.on) annotation(
    Line(points = {{49, 63}, {44, 63}, {44, 47}, {36, 47}}, color = {255, 0, 255}));
  connect(t_g.T, greater1.u1) annotation(
    Line(points = {{6, -12}, {10, -12}, {10, 0}, {6, 0}, {6, 28}, {72, 28}, {72, 63}, {68, 63}}, color = {0, 0, 127}));
  connect(const2.y, greater1.u2) annotation(
    Line(points = {{60, 96}, {78, 96}, {78, 70}, {68, 70}}, color = {0, 0, 127}));
  connect(specificEnthalpy.h_out, tc1.h) annotation(
    Line(points = {{104, 14}, {102, 14}, {102, 42}, {36, 42}}, color = {0, 0, 127}));
  connect(pressure1.p, tc1.p) annotation(
    Line(points = {{72, 8}, {76, 8}, {76, 37}, {36, 37}}, color = {0, 0, 127}));
  connect(separator1.fedWater, overheat_T.port) annotation(
    Line(points = {{10, 8}, {10, 8}, {10, 18}, {38, 18}, {38, 6}, {44, 6}, {44, 6}}, color = {0, 127, 255}));
  connect(add1.y, FW_pump.p_in) annotation(
    Line(points = {{-56, 84}, {-70, 84}, {-70, 60}, {-70, 60}}, color = {0, 0, 127}));
  connect(const.y, add1.u1) annotation(
    Line(points = {{-78, 110}, {-36, 110}, {-36, 88}, {-40, 88}, {-40, 88}}, color = {0, 0, 127}));
  connect(pressure2.p, add1.u2) annotation(
    Line(points = {{-12, 78}, {-38, 78}, {-38, 79}, {-41, 79}}, color = {0, 0, 127}));
  connect(FW_In, FW_pump.port_a) annotation(
    Line(points = {{-100, 68}, {-92, 68}, {-92, 50}, {-80, 50}, {-80, 50}}));
  connect(lC_sink1.y, sink_valve.D_flow_in) annotation(
    Line(points = {{52, -14}, {58, -14}, {58, -38}, {34, -38}, {34, -44}, {34, -44}}, color = {0, 0, 127}));
  connect(separator1.level, lC_sink1.u) annotation(
    Line(points = {{22, 6}, {24, 6}, {24, -14}, {36, -14}, {36, -14}}, color = {0, 0, 127}));
  connect(separator1.steam, pipe.waterIn) annotation(
    Line(points = {{16, 12}, {30, 12}, {30, 0}, {30, 0}}, color = {0, 127, 255}));
  connect(specificEnthalpy.port, separator1.fedWater) annotation(
    Line(points = {{92, 4}, {80, 4}, {80, 18}, {10, 18}, {10, 8}, {10, 8}}, color = {0, 127, 255}));
  connect(EVO.flowOut, separator1.fedWater) annotation(
    Line(points = {{-8, -4}, {2, -4}, {2, 8}, {10, 8}, {10, 8}}, color = {0, 127, 255}));
  connect(separator1.downWater, sink_valve.port_a) annotation(
    Line(points = {{16, -10}, {16, -10}, {16, -50}, {28, -50}, {28, -50}}, color = {0, 127, 255}));
  connect(SH.gasOut, t_g.port) annotation(
    Line(points = {{-18, -20}, {-18, -20}, {-18, -16}, {4, -16}, {4, -16}}, color = {0, 127, 255}));
  connect(sink_valve.port_b, sink.ports[1]) annotation(
    Line(points = {{40, -50}, {80, -50}, {80, -50}, {80, -50}}, color = {0, 127, 255}));
  connect(pipe.waterIn, pressure1.port) annotation(
    Line(points = {{30, 0}, {68, 0}, {68, 2}, {68, 2}}, color = {0, 127, 255}));
  connect(pipe.waterOut, SH.flowIn) annotation(
    Line(points = {{30, -9}, {30, -22}, {-8, -22}}, color = {0, 127, 255}));
  connect(ECO.flowOut, EVO.flowIn) annotation(
    Line(points = {{-8, 18}, {-4, 18}, {-4, 4}, {-8, 4}, {-8, 4}}, color = {0, 127, 255}));
  connect(ECO.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{-18, 28}, {-18, 28}, {-18, 100}, {-18, 100}}, color = {0, 127, 255}));
  connect(EVO.gasOut, ECO.gasIn) annotation(
    Line(points = {{-18, 6}, {-18, 6}, {-18, 18}, {-18, 18}}, color = {0, 127, 255}));
  connect(SH.gasOut, EVO.gasIn) annotation(
    Line(points = {{-18, -20}, {-18, -20}, {-18, -4}, {-18, -4}}, color = {0, 127, 255}));
  connect(gasIn, SH.gasIn) annotation(
    Line(points = {{-18, -120}, {-18, -120}, {-18, -30}, {-18, -30}}));
  connect(SH.flowOut, steam) annotation(
    Line(points = {{-8, -30}, {80, -30}, {80, -24}, {100, -24}, {100, -24}}, color = {0, 127, 255}));
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
end OnePVerticalOTHRSG;
