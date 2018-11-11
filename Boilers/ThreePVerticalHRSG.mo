within TPPSim.Boilers;

model ThreePVerticalHRSG "Вертикальный трехконтурынй барабанный КУ"
  extends TPPSim.Boilers.ThreePVerticalHRSG_pattern(RH_3.k_weight_metal = 1.2, RH_3.s1 = 82e-3, RH_3.z2 = 4, RH_3.hfin = 1e-3, HP_SH_3.Din = 30e-3, HP_SH_3.hfin = 9e-3, HP_SH_3.sfin = 6.828e-3, RH_2.hfin = 14e-3, RH_2.s1 = 82.03e-3, RH_2.s2 = 110e-3, RH_2.sfin = 6.198e-3, HP_SH_2.Din = 30e-3, HP_SH_2.hfin = 12e-3, HP_SH_2.sfin = 9.345e-3, RH_1.hfin = 12e-3, RH_1.s1 = 82.03e-3, RH_1.sfin = 2.861e-3, IP_SH_2.s1 = 82.03e-3, IP_SH_2.s2 = 110e-3, IP_SH_2.Din = 32e-3, IP_SH_2.delta = 3e-3, IP_SH_2.hfin = 1e-3, IP_SH_2.z1 = 174, IP_SH_2.z2 = 2, IP_SH_2.zahod = 2, HP_ECO_3.sfin = 2.592e-3, HP_ECO_3.z2 = 3, LP_SH_3.hfin = 1e-3, LP_SH_3.s1 = 82.03e-3, LP_SH_3.z2 = 2, LP_SH_3.zahod = 2, HP_ECO_2.sfin = 2.986e-3, HP_ECO_2.z2 = 4, LP_SH_2.sfin = 2.273e-3, LP_SH_2.zahod = 2, IP_ECO_HP_ECO_1.s1_1 = 77.83e-3, IP_ECO_HP_ECO_1.s2_1 = 110e-3, IP_ECO_HP_ECO_1.sfin_1 = 2.507e-3, IP_ECO_HP_ECO_1.z1_1 = 24, IP_ECO_HP_ECO_1.z2_1 = 6, IP_ECO_HP_ECO_1.s2_2 = 110e-3, IP_ECO_HP_ECO_1.sfin_2 = 3.459e-3, IP_ECO_HP_ECO_1.z1_2 = 150, LP_SH_1.hfin = 1e-3, LP_SH_1.zahod = 2, LP_EVO.Din = 32e-3, LP_EVO.sfin = 3.417e-3, LP_EVO.zahod = 2, cond_HE.Din = 26e-3, cond_HE.delta = 3e-3, cond_HE.sfin = 3.187e-3, cond_HE.z2 = 14, HP_vent.checkValve = true, HP_vent.filteredOpening = true, RH_vent.checkValve = true, RH_vent.filteredOpening = true);
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
  TPPSim.HRSG_HeatExch.GFHE HP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 26e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 3e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, h_flow_start = 251.2e3, hfin = 15e-3, k_gamma_gas = 1, k_volume = 1.5, k_volume_gas = 1.2, k_weight_metal = 1.5, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.03e-3, s2 = 70e-3, sfin = 2.7e-3, z1 = 174, z2 = 14, zahod = 7) annotation(
    Placement(visible = true, transformation(origin = {-18, -100}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Барабан и цирк. насос ВД
  TPPSim.Drums.Drum_2 HP_drum(Din = 1.718, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.5, L = 9, delta = 0.02, ps_start = HP_p_flow_start, t_m_steam_start = HP_t_m_steam_start, t_m_water_start = HP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {24, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump HP_circPump(redeclare package Medium = Medium_F, setD_flow = 0.001, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {3, -109}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp HP_set_flow(duration = 60, height = 500, offset = 0.01, startTime = 1) annotation(
    Placement(visible = true, transformation(origin = {22, -82}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  //Регуляторы
  TPPSim.Controls.LC LC(DFmax = 46, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {64, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Пароперегреватель ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 30e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 12e-3, k_gamma_gas = 1, k_volume = 1.2, k_volume_gas = 1.2, k_weight_metal = 1.2, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, sfin = 3.853e-3, z1 = 174, z2 = 3, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -138}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы ВД
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {46, -126}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //Контур СД
  //Испаритель СД
  TPPSim.HRSG_HeatExch.GFHE IP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 3e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15e-3, k_gamma_gas = 1, k_volume = 1.5, k_volume_gas = 1.2, k_weight_metal = 1.5, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, sfin = 2.897e-3, z1 = 174, z2 = 8, zahod = 2) annotation(
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
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 3e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 1e-3, k_gamma_gas = 1, k_volume = 1.2, k_volume_gas = 1.2, k_weight_metal = 1.2, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, sfin = 5.102e-3, z1 = 174, z2 = 2, zahod = 2)
 annotation(
    Placement(visible = true, transformation(origin = {-18, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_3(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 3e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 1e-3, k_gamma_gas = 1, k_volume = 1.2, k_volume_gas = 1.2, k_weight_metal = 1.2, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, sfin = 5.102e-3, z1 = 174, z2 = 2, zahod = 2)
 annotation(
    Placement(visible = true, transformation(origin = {-18, -118}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
 
//Трубопроводы СД
  TPPSim.Pipes.ComplexPipe IP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {38, 18}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
equation
  connect(IP_SH_3.flowOut, IP_massFlowRate.port_a) annotation(
    Line(points = {{-8, -122}, {-8, -122}, {-8, -126}, {0, -126}, {0, -62}, {0, -62}}, color = {0, 127, 255}));
  connect(IP_SH_2.flowOut, IP_SH_3.flowIn) annotation(
    Line(points = {{-8, -82}, {-8, -82}, {-8, -88}, {-32, -88}, {-32, -108}, {-12, -108}, {-12, -114}, {-8, -114}, {-8, -114}}, color = {0, 127, 255}));
  connect(IP_SH_3.gasOut, HP_EVO.gasIn) annotation(
    Line(points = {{-18, -112}, {-18, -112}, {-18, -104}, {-18, -104}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasOut, IP_SH_3.gasIn) annotation(
    Line(points = {{-18, -132}, {-18, -132}, {-18, -122}, {-18, -122}}, color = {0, 127, 255}));
  connect(HP_drum.upStr, HP_EVO.flowOut) annotation(
    Line(points = {{32, -118}, {30, -118}, {30, -122}, {-4, -122}, {-4, -112}, {-8, -112}, {-8, -104}, {-8, -104}}, color = {0, 127, 255}));
  connect(IP_SH_2.gasIn, HP_EVO.gasOut) annotation(
    Line(points = {{-18, -82}, {-18, -95}}, color = {0, 127, 255}));
  connect(HP_circPump.port_b, HP_EVO.flowIn) annotation(
    Line(points = {{-2, -108}, {-5, -108}, {-5, -96}, {-8, -96}}, color = {0, 127, 255}));
  connect(HP_ECO_3.flowOut, HP_drum.fedWater) annotation(
    Line(points = {{-8, -62}, {-4, -62}, {-4, -100}, {18, -100}, {18, -100}}, color = {0, 127, 255}));
  connect(HP_set_flow.y, HP_circPump.D_flow_in) annotation(
    Line(points = {{18, -82}, {14, -82}, {14, -94}, {2, -94}, {2, -104}, {4, -104}}, color = {0, 0, 127}));
  connect(LC.y, HP_FWCV.opening) annotation(
    Line(points = {{76, -80}, {78, -80}, {78, -28}, {-52, -28}, {-52, 0}, {-50, 0}}, color = {0, 0, 127}));
  connect(HP_drum.waterLevel, LC.u) annotation(
    Line(points = {{36, -104}, {38, -104}, {38, -80}, {52, -80}, {52, -80}}, color = {0, 0, 127}));
  connect(HP_drum.p_drum, HP_p_drum) annotation(
    Line(points = {{36, -100}, {52, -100}, {52, -116}, {104, -116}, {104, -116}}, color = {0, 0, 127}));
  connect(HP_SH_1.flowOut, HP_SH_2.flowIn) annotation(
    Line(points = {{-8, -142}, {-4, -142}, {-4, -184}, {-8, -184}, {-8, -184}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, HP_SH_1.flowIn) annotation(
    Line(points = {{46, -130}, {46, -130}, {46, -134}, {-8, -134}, {-8, -134}}, color = {0, 127, 255}));
  connect(HP_drum.steam, HP_pipe.waterIn) annotation(
    Line(points = {{32, -100}, {32, -100}, {32, -96}, {42, -96}, {42, -108}, {46, -108}, {46, -122}, {46, -122}}, color = {0, 127, 255}));
  connect(HP_drum.downStr, HP_circPump.port_a) annotation(
    Line(points = {{18, -118}, {8, -118}, {8, -108}, {8, -108}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasIn, RH_1.gasOut) annotation(
    Line(points = {{-18, -142}, {-18, -142}, {-18, -156}, {-18, -156}}, color = {0, 127, 255}));
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
    Icon(graphics = {Ellipse(origin = {-154, 161}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-28, 29}, {32, -31}}, endAngle = 360), Ellipse(origin = {60, 161}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-28, 29}, {32, -31}}, endAngle = 360), Text(origin = {-152, 160}, lineColor = {115, 0, 0}, extent = {{-20, 20}, {22, -20}}, textString = "HP"), Text(origin = {62, 160}, lineColor = {170, 0, 0}, extent = {{-20, 20}, {22, -20}}, textString = "IP")}, coordinateSystem(extent = {{-200, -300}, {200, 300}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-100, -300}, {100, 200}})),
    __OpenModelica_commandLineOptions = "");
end ThreePVerticalHRSG;
