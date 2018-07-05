within TPPSim.Boilers;

model ThreePVerticalHRSG_2
  extends TPPSim.Boilers.ThreePVerticalHRSG_pattern;
  //Контур ВД
  //Испаритель ВД
  TPPSim.HRSG_HeatExch.GFHE HP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 30e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 4e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, h_flow_start = 251.2e3, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 82.04e-3, s2 = 70e-3, sfin = 3.55e-3, z1 = 174, z2 = 8, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, -112}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Барабан и цирк. насос ВД
  TPPSim.Drums.Drum HP_drum(Din = 1.718, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.5, L = 9, delta = 0.02, ps_start = HP_p_flow_start, t_m_steam_start = HP_t_m_steam_start, t_m_water_start = HP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {24, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump HP_circPump(redeclare package Medium = Medium_F, setD_flow = 0.001, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {3, -109}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp HP_set_flow(duration = 60, height = 500, offset = 0.01, startTime = 1) annotation(
    Placement(visible = true, transformation(origin = {22, -82}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  //Регуляторы
  TPPSim.Controls.LC LC(DFmax = 46, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {64, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Пароперегреватель ВД
  TPPSim.HRSG_HeatExch.GFHE_simple HP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 32e-3, Lpipe = 20.4, delta = 4e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 17e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 82.03e-3, s2 = 110e-3, sfin = 6.4e-3, z1 = 174, z2 = 6, zahod = 3) annotation(
    Placement(visible = true, transformation(origin = {-18, -138}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы ВД
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {46, -126}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //Контур СД
  //Испаритель СД
  TPPSim.HRSG_HeatExch.GFHE IP_EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE, redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 34e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalBottom, Lpipe = 20.4, delta = 2e-3, delta_fin = 0.8e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 15e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 1, s1 = 91.64e-3, s2 = 79e-3, sfin = 4.287e-3, z1 = 118, z2 = 6, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {-18, 26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Барабан СД
  TPPSim.Drums.Drum IP_drum(Din = 1.4, Dynamics = if SH_cold_start then Modelica.Fluid.Types.Dynamics.SteadyStateInitial else Modelica.Fluid.Types.Dynamics.FixedInitial, Hw_start = 0.4, L = 13.1, delta = 30e-3, ps_start = HP_p_flow_start, t_m_steam_start = HP_t_m_steam_start, t_m_water_start = HP_t_m_water_start) annotation(
    Placement(visible = true, transformation(origin = {22, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePump IP_circPump(redeclare package Medium = Medium_F, setD_flow = 0.001, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {3, 33}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp IP_set_flow(duration = 60, height = 200, offset = 0.01, startTime = 2) annotation(
    Placement(visible = true, transformation(origin = {18, 68}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  //Регуляторы
  TPPSim.Controls.LC IP_LC(DFmax = 46, DFmin = 0) annotation(
    Placement(visible = true, transformation(origin = {66, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Пароперегреватель СД
  TPPSim.HRSG_HeatExch.GFHE_simple IP_SH_1(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 34e-3, Lpipe = 20.4, delta = 2e-3, delta_fin = 1e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, hfin = 9e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfVolumes = 2, p_flow_start = HP_p_flow_start, s1 = 64.64e-3, s2 = 70e-3, sfin = 5.102e-3, z1 = 168, z2 = 1, zahod = 1) annotation(
    Placement(visible = true, transformation(origin = {-18, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Трубопроводы СД
  TPPSim.Pipes.ComplexPipe IP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, p_flow_start = HP_p_flow_start) annotation(
    Placement(visible = true, transformation(origin = {38, 18}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
equation
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
  connect(HP_EVO.flowOut, HP_drum.upStr) annotation(
    Line(points = {{-8, -116}, {0, -116}, {0, -126}, {32, -126}, {32, -118}, {32, -118}}, color = {0, 127, 255}));
  connect(HP_circPump.port_b, HP_EVO.flowIn) annotation(
    Line(points = {{-2, -108}, {-8, -108}, {-8, -108}, {-8, -108}}, color = {0, 127, 255}));
  connect(HP_drum.downStr, HP_circPump.port_a) annotation(
    Line(points = {{18, -118}, {8, -118}, {8, -108}, {8, -108}}, color = {0, 127, 255}));
  connect(HP_SH_1.gasIn, RH_1.gasOut) annotation(
    Line(points = {{-18, -142}, {-18, -142}, {-18, -156}, {-18, -156}}, color = {0, 127, 255}));
  connect(HP_EVO.gasIn, HP_SH_1.gasOut) annotation(
    Line(points = {{-18, -116}, {-18, -116}, {-18, -132}, {-18, -132}}, color = {0, 127, 255}));
  connect(IP_SH_2.gasIn, HP_EVO.gasOut) annotation(
    Line(points = {{-18, -82}, {-18, -82}, {-18, -106}, {-18, -106}}, color = {0, 127, 255}));
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
  <p>
  Модель трехконтурного барабанного котла-утилизатора.
  </p>
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>September 07, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(graphics = {Ellipse(origin = {-154, 161}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-28, 29}, {32, -31}}, endAngle = 360), Ellipse(origin = {60, 161}, lineColor = {156, 156, 156}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Sphere, extent = {{-28, 29}, {32, -31}}, endAngle = 360), Text(origin = {-152, 160}, lineColor = {115, 0, 0}, extent = {{-20, 20}, {22, -20}}, textString = "HP"), Text(origin = {62, 160}, lineColor = {170, 0, 0}, extent = {{-20, 20}, {22, -20}}, textString = "IP")}, coordinateSystem(extent = {{-200, -300}, {200, 300}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-100, -300}, {100, 200}})),
    __OpenModelica_commandLineOptions = "");
end ThreePVerticalHRSG_2;
