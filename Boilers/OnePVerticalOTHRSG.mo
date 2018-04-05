﻿within TPPSim.Boilers;

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
  TPPSim.HRSG_HeatExch.GFHE EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 0.038, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 18.492, delta = 0.002, delta_fin = 0.0008, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 0.015, k_gamma_gas = 1, m_flow_start = 10, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 91.09e-3, s2 = 79e-3, sfin = 2.735e-3, z1 = 58, z2 = 6, zahod = 2) annotation(
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
  TPPSim.Valves.simpleValve FWCV(redeclare package Medium = Medium_F, dp = 100000, m_flow_small = 0.0001, setD_flow = 30, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-37, 49}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Drums.Separator2 separator21(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {14, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Sensors.Temperature overheat_T(TemperatureType_set = TPPSim.Sensors.TemperatureType.overheating)  annotation(
    Placement(visible = true, transformation(origin = {44, 6}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  TPPSim.Controls.TC tc1 annotation(
    Placement(visible = true, transformation(origin = {30, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure pressure1(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {67, 7}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {92, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(specificEnthalpy.h_out, tc1.h) annotation(
    Line(points = {{104, 14}, {106, 14}, {106, 44}, {42, 44}, {42, 46}}, color = {0, 0, 127}));
  connect(pressure1.p, tc1.p) annotation(
    Line(points = {{72, 8}, {76, 8}, {76, 36}, {42, 36}, {42, 36}}, color = {0, 0, 127}));
  connect(separator21.fedWater, specificEnthalpy.port) annotation(
    Line(points = {{8, 12}, {6, 12}, {6, 22}, {56, 22}, {56, -4}, {92, -4}, {92, 4}, {92, 4}}, color = {0, 127, 255}));
  connect(pipe.waterIn, pressure1.port) annotation(
    Line(points = {{30, 0}, {68, 0}, {68, 2}, {68, 2}}, color = {0, 127, 255}));
  connect(tc1.y, FWCV.D_flow_in) annotation(
    Line(points = {{18, 40}, {8, 40}, {8, 64}, {-37, 64}, {-37, 50}}, color = {0, 0, 127}));
  connect(FW_In, FWCV.flowIn) annotation(
    Line(points = {{-100, 68}, {-78, 68}, {-78, 49}, {-42, 49}}));
  connect(FWCV.flowOut, ECO.flowIn) annotation(
    Line(points = {{-32, 49}, {-8, 49}, {-8, 26}}, color = {0, 127, 255}));
  connect(pipe.waterIn, overheat_T.port) annotation(
    Line(points = {{30, 0}, {44, 0}, {44, 2}, {44, 2}}, color = {0, 127, 255}));
  connect(separator21.steam, pipe.waterIn) annotation(
    Line(points = {{14, 16}, {30, 16}, {30, 1}}, color = {0, 127, 255}));
  connect(pipe.waterOut, SH.flowIn) annotation(
    Line(points = {{30, -9}, {30, -22}, {-8, -22}}, color = {0, 127, 255}));
  connect(EVO.flowOut, separator21.fedWater) annotation(
    Line(points = {{-8, -4}, {0, -4}, {0, 11}, {7, 11}}, color = {0, 127, 255}));
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