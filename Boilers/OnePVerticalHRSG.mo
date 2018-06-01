within TPPSim.Boilers;

model OnePVerticalHRSG
  extends TPPSim.Boilers.BaseClases.Icons.Icon1pVerticalHRSG;
  package Medium_G = TPPSim.Media.ExhaustGas;
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  outer Modelica.Fluid.System system;
  inner parameter Boolean SH_cold_start = true "Исходное состояние - холодное" annotation(
    Dialog(group = "Исходное состояние"));
  parameter Modelica.SIunits.AbsolutePressure IP_p_flow_start = system.p_ambient "Начальное давление пара в БСД" annotation(
    Dialog(group = "Контур СД"));
  parameter Modelica.SIunits.Temperature IP_t_m_steam_start = 100 + 273.15 "Начальная температура металла верха БСД" annotation(
    Dialog(group = "Контур СД"));
  parameter Modelica.SIunits.Temperature IP_t_m_water_start = 100 + 273.15 "Начальная температура металла низа БСД" annotation(
    Dialog(group = "Контур СД"));
  parameter Modelica.SIunits.SpecificEnthalpy IP_pipe2_h_start = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(IP_p_flow_start) + 100 "Начальная энтальпия пара в парапроводе за ПеСД" annotation(
    Dialog(group = "Контур СД"));
  //Контур СД
  //Испаритель СД
  TPPSim.HRSG_HeatExch.GFHE IP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfa20000 alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 34e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 20.4, delta = 2e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, s1 = 91.64e-3, s2 = 79e-3, sfin = 4.287e-3, z1 = 118, z2 = 6, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-16, 54}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Барабан СД
  TPPSim.Drums.Drum IP_drum(Din = 1.4, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.4, L = 13.1, delta = 30e-3, ps_start = IP_p_flow_start, t_m_steam_start = IP_t_m_steam_start, t_m_water_start = IP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {24, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Пароперегреватель СД
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 34e-3, Lpipe = 20.4, delta = 2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 9e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = IP_p_flow_start, s1 = 64.64e-3, s2 = 70e-3, sfin = 5.102e-3, z1 = 168, z2 = 1, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-16, 34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 30e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 9e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = IP_p_flow_start, s1 = 59.03e-3, s2 = 63.75e-3, sfin = 5.102e-3, z1 = 242, z2 = 2, zahod = 1) annotation(
      Placement(visible = true, transformation(origin = {-16, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Промежуточный пароперегреватель
    TPPSim.HRSG_HeatExch.GFHE_simple RH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, Lpipe = 20.4, delta = 3.2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = IP_p_flow_start, s1 = 82.42e-3, s2 = 110e-3, sfin = 7.5e-3, z1 = 174, z2 = 4, zahod = 4) annotation(
      Placement(visible = true, transformation(origin = {-16, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    TPPSim.HRSG_HeatExch.GFHE_simple RH_2(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, Lpipe = 20.4, delta = 3.2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = IP_p_flow_start, s1 = 82.42e-3, s2 = 137e-3, sfin = 7.5e-3, z1 = 174, z2 = 4, zahod = 4) annotation(
      Placement(visible = true, transformation(origin = {-16, -58}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    TPPSim.HRSG_HeatExch.GFHE_simple RH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, Lpipe = 20.4, delta = 3.2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = IP_p_flow_start, s1 = 82.42e-3, s2 = 110e-3, sfin = 7.5e-3, z1 = 174, z2 = 4, zahod = 4) annotation(
      Placement(visible = true, transformation(origin = {-16, -86}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Паропровод СД
  TPPSim.Pipes.ComplexPipe IP_pipe_1(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 4, numberOfVolumes = 2, p_flow_start = IP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {24, 38}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  //Контур НД
  //ГПК
  //Испаритель НД
  //Барабан НД
  //Пароперегреватель НД
  //Паропровод НД
  //Клапаны
  //Паровые продувки
  TPPSim.Pumps.simplePump IP_circPump(redeclare package Medium = Medium_F, setD_flow = 50) annotation(
    Placement(visible = true, transformation(origin = {9, 59}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //Обратный клапан
  //Регуляторы
  TPPSim.Controls.LC IP_LC(DFmax = 70, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {72, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Датчики температуры газов
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-16, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -224}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b IP_Out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {100, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a IP_FW_In(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-100, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-202, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Valves.simpleValve IP_FWCV(redeclare package Medium = Medium_F, dp = 100000, setD_flow = 5, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {7, 85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //Атмосфера
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-16, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(RH_3.flowOut, IP_Out) annotation(
    Line(points = {{-6, -90}, {102, -90}, {102, -90}, {100, -90}}, color = {0, 127, 255}));
  connect(RH_2.flowOut, RH_3.flowIn) annotation(
    Line(points = {{-6, -62}, {0, -62}, {0, -82}, {-6, -82}, {-6, -82}}, color = {0, 127, 255}));
  connect(RH_3.gasIn, gasIn) annotation(
    Line(points = {{-16, -90}, {-16, -90}, {-16, -120}, {-16, -120}}, color = {0, 127, 255}));
  connect(RH_2.gasIn, RH_3.gasOut) annotation(
    Line(points = {{-16, -62}, {-16, -62}, {-16, -80}, {-16, -80}}, color = {0, 127, 255}));
  connect(RH_1.flowOut, RH_2.flowIn) annotation(
    Line(points = {{-6, -22}, {0, -22}, {0, -54}, {-6, -54}, {-6, -54}}, color = {0, 127, 255}));
  connect(RH_2.gasOut, RH_1.gasIn) annotation(
    Line(points = {{-16, -52}, {-16, -52}, {-16, -22}, {-16, -22}}, color = {0, 127, 255}));
  connect(IP_SH_2.flowOut, RH_1.flowIn) annotation(
    Line(points = {{-6, 8}, {0, 8}, {0, -14}, {-6, -14}, {-6, -14}}, color = {0, 127, 255}));
  connect(IP_SH_2.gasIn, RH_1.gasOut) annotation(
    Line(points = {{-16, 8}, {-16, 8}, {-16, -12}, {-16, -12}}, color = {0, 127, 255}));
  connect(IP_SH_1.flowOut, IP_SH_2.flowIn) annotation(
    Line(points = {{-6, 30}, {0, 30}, {0, 16}, {-6, 16}, {-6, 16}}, color = {0, 127, 255}));
  connect(IP_SH_1.gasIn, IP_SH_2.gasOut) annotation(
    Line(points = {{-16, 30}, {-16, 30}, {-16, 18}, {-16, 18}}, color = {0, 127, 255}));
  connect(IP_drum.steam, IP_pipe_1.waterIn) annotation(
    Line(points = {{32, 84}, {32, 84}, {32, 92}, {44, 92}, {44, 38}, {28, 38}, {28, 38}}, color = {0, 127, 255}));
  connect(gasSink.ports[1], IP_EVO.gasOut) annotation(
    Line(points = {{-16, 100}, {-16, 100}, {-16, 60}, {-16, 60}}, color = {0, 127, 255}, thickness = 0.5));
  connect(IP_FW_In, IP_FWCV.flowIn) annotation(
    Line(points = {{-100, 86}, {2, 86}}));
  connect(IP_LC.y, IP_FWCV.D_flow_in) annotation(
    Line(points = {{83, 74}, {84, 74}, {84, 74}, {85, 74}, {85, 72}, {87, 72}, {87, 72}, {91, 72}, {91, 86}, {7, 86}, {7, 87}, {7, 87}, {7, 88.5}, {7, 88.5}, {7, 86.25}, {7, 86.25}, {7, 86}}, color = {0, 0, 127}));
  connect(IP_FWCV.flowOut, IP_drum.fedWater) annotation(
    Line(points = {{12, 85}, {12.75, 85}, {12.75, 85}, {13.5, 85}, {13.5, 85}, {15, 85}, {15, 83}, {18, 83}, {18, 84}, {18, 84}, {18, 84.5}, {18, 84.5}, {18, 83.75}, {18, 83.75}, {18, 83}}, color = {0, 127, 255}));
  connect(IP_drum.waterLevel, IP_LC.u) annotation(
    Line(points = {{35, 80}, {35.2812, 80}, {35.2812, 80}, {35.5625, 80}, {35.5625, 80}, {36.125, 80}, {36.125, 78}, {37.25, 78}, {37.25, 78}, {39.5, 78}, {39.5, 80}, {42, 80}, {42, 80}, {51, 80}, {51, 72}, {59, 72}, {59, 72}, {57, 72}, {57, 74}, {59, 74}, {59, 73}, {59, 73}, {59, 74.5}, {59, 74.5}, {59, 73.25}, {59, 73.25}, {59, 72}}, color = {0, 0, 127}));
  connect(IP_circPump.port_b, IP_EVO.flowIn) annotation(
    Line(points = {{4, 59}, {3.875, 59}, {3.875, 59}, {3.75, 59}, {3.75, 57}, {3.5, 57}, {3.5, 57}, {3, 57}, {3, 61}, {2, 61}, {2, 58}, {-2, 58}, {-2, 58}, {-4, 58}, {-4, 58}, {-5, 58}, {-5, 58}, {-6, 58}}, color = {0, 127, 255}));
  connect(IP_drum.downStr, IP_circPump.port_a) annotation(
    Line(points = {{17, 65}, {16.9688, 65}, {16.9688, 65}, {16.9375, 65}, {16.9375, 65}, {16.875, 65}, {16.875, 63}, {16.75, 63}, {16.75, 63}, {16.5, 63}, {16.5, 63}, {16, 63}, {16, 57}, {15, 57}, {15, 57}, {14.5, 57}, {14.5, 57}, {14.25, 57}, {14.25, 59}, {14.125, 59}, {14.125, 59}, {14.0625, 59}, {14.0625, 59}, {14, 59}}, color = {0, 127, 255}));
  connect(IP_pipe_1.waterOut, IP_SH_1.flowIn) annotation(
    Line(points = {{19.16, 38}, {6.16, 38}, {6.16, 38}, {-6.84, 38}, {-6.84, 36}, {-6.84, 36}, {-6.84, 38}, {-6.84, 38}, {-6.84, 38}, {-6.84, 38}}, color = {0, 127, 255}));
  connect(IP_SH_1.gasOut, IP_EVO.gasIn) annotation(
    Line(points = {{-16, 39}, {-16, 49}}, color = {0, 127, 255}));
  connect(IP_EVO.flowOut, IP_drum.upStr) annotation(
    Line(points = {{-6, 50}, {-5.75, 50}, {-5.75, 50}, {-5.5, 50}, {-5.5, 50}, {-5, 50}, {-5, 48}, {-4, 48}, {-4, 48}, {-2, 48}, {-2, 46}, {30, 46}, {30, 61}, {30.5, 61}, {30.5, 63}, {30.75, 63}, {30.75, 63}, {30.875, 63}, {30.875, 63}, {30.9375, 63}, {30.9375, 65}, {30.9688, 65}, {30.9688, 65}, {31, 65}}, color = {0, 127, 255}));
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
