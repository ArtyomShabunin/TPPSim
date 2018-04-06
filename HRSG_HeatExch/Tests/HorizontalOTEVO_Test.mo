within TPPSim.HRSG_HeatExch.Tests;

model HorizontalOTEVO_Test "Тестовая модель для опробования модели горизонтального прямоточного испарителя Бенсона"
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  package Medium_G = TPPSim.Media.ExhaustGas;
  inner Modelica.Fluid.System system(T_start = 333.15,allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 1292.6 / 3.6, Tnom = 517.2 + 273.15, Tstart = system.T_start) annotation(
    Placement(visible = true, transformation(origin = {-70, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-29, 53}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, allowFlowReversal = false, checkValve = true, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {-42, 30}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {86, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible FW_Pump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {59, 31}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GFHE_EVO_benson EVO_1(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 38.1e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.horizontalBottom, Lpipe = 18.29, delta_fin = 0.9906e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flow_circ = {1.3, 2.7, 4.9, 6.9, 9.1, 11.4, 13.2, 15.3, 16.9, 18.4} / 100, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, hfin = 15.88e-3, k_gamma_gas = 1, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, numberOfTubeSections = 2, s1 = 85.15e-3, s2 = 111.1e-3, sfin = 2.921e-3, z1 = 126, z2 = 10, zahod = 10) annotation(
    Placement(visible = true, transformation(origin = {8, -12}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Valves.simpleValve HP_FWCV(redeclare package Medium = Medium_F, dp = 100000, m_flow_small = 0.0001, setD_flow = 30, use_D_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {35, 11}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = system.T_ambient, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {68, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, t_m_start = 373.15) annotation(
    Placement(visible = true, transformation(origin = {-24, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  TPPSim.Pipes.ComplexPipe HP_pipe_1(Din = 0.15, Lpipe = 5, delta = 0.01, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, metalDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 8, numberOfVolumes = 2, t_m_start = 373.15) annotation(
    Placement(visible = true, transformation(origin = {8, 8}, extent = {{-4, -4}, {4, 4}}, rotation = 90)));
  TPPSim.Drums.Separator2 separator21(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-4, 12}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure pressure1(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {8, 34}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {22, 34}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  TPPSim.Controls.TC tc1(T_sprh = 60)  annotation(
    Placement(visible = true, transformation(origin = {22, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(tc1.y, HP_FWCV.D_flow_in) annotation(
    Line(points = {{34, 54}, {40, 54}, {40, 32}, {35, 32}, {35, 12}}, color = {0, 0, 127}));
  connect(FW_Pump.port_b, HP_FWCV.flowIn) annotation(
    Line(points = {{54, 32}, {50, 32}, {50, 11}, {40, 11}}, color = {0, 127, 255}));
  connect(HP_FWCV.flowOut, EVO_1.flowIn) annotation(
    Line(points = {{30, 11}, {24, 11}, {24, -30}, {8, -30}, {8, -22}}, color = {0, 127, 255}));
  connect(specificEnthalpy.h_out, tc1.h) annotation(
    Line(points = {{26, 34}, {28, 34}, {28, 42}, {2, 42}, {2, 60}, {10, 60}, {10, 60}}, color = {0, 0, 127}));
  connect(pressure1.p, tc1.p) annotation(
    Line(points = {{12, 34}, {14, 34}, {14, 40}, {6, 40}, {6, 50}, {10, 50}, {10, 50}}, color = {0, 0, 127}));
  connect(separator21.fedWater, specificEnthalpy.port) annotation(
    Line(points = {{4, 20}, {22, 20}, {22, 30}, {22, 30}}, color = {0, 127, 255}));
  connect(separator21.fedWater, pressure1.port) annotation(
    Line(points = {{4, 20}, {4, 20}, {4, 30}, {8, 30}, {8, 30}}, color = {0, 127, 255}));
  connect(CV_const.y, CV.opening) annotation(
    Line(points = {{-34.5, 53}, {-42, 53}, {-42, 34}}, color = {0, 0, 127}));
  connect(CV.port_b, flowSink.ports[1]) annotation(
    Line(points = {{-46, 30}, {-60, 30}, {-60, 30}, {-60, 30}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, CV.port_a) annotation(
    Line(points = {{-28, 30}, {-38, 30}, {-38, 30}, {-38, 30}}, color = {0, 127, 255}));
  connect(HP_pipe_1.waterOut, separator21.fedWater) annotation(
    Line(points = {{8, 12}, {8, 12}, {8, 20}, {4, 20}, {4, 20}}, color = {0, 127, 255}));
  connect(EVO_1.flowOut, HP_pipe_1.waterIn) annotation(
    Line(points = {{8, -2}, {8, -2}, {8, 4}, {8, 4}}, color = {0, 127, 255}));
  connect(separator21.steam, HP_pipe.waterIn) annotation(
    Line(points = {{-4, 24}, {-2, 24}, {-2, 30}, {-19, 30}}, color = {0, 127, 255}));
  connect(EVO_1.gasOut, gasSink.ports[1]) annotation(
    Line(points = {{14, -12}, {58, -12}, {58, -12}, {58, -12}}, color = {0, 127, 255}));
  connect(GT.flowOut, EVO_1.gasIn) annotation(
    Line(points = {{-60, -12}, {2, -12}, {2, -12}, {4, -12}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], FW_Pump.port_a) annotation(
    Line(points = {{76, 20}, {71, 20}, {71, 31}, {64, 31}}, color = {0, 127, 255}, thickness = 0.5));
  annotation(
    Documentation(info = "<html><head></head><body>...</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>April 04, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end HorizontalOTEVO_Test;
