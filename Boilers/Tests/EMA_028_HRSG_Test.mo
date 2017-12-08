within TPPSim.Boilers.Tests;

model EMA_028_HRSG_Test
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  package Medium_G = TPPSim.Media.ExhaustGas;
  inner Modelica.Fluid.System system(T_start = 60 + 273.15,allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 2482.5 / 3.6, Tnom = 569.1 + 273.15, Tstart = system.T_start) annotation(
  //    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.combitable_startupGT GT(redeclare package Medium = Medium_G, fileName = "C:/Users/User/Documents/TPPSim/Gas_turbine/Tests/my.txt") annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 2, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant HP_CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-39, 35}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = system.T_start, nPorts = 1, p = system.p_ambient)  annotation(
    Placement(visible = true, transformation(origin = {86, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible condPump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {59, 23}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Valves.ReducingStation HP_RS(redeclare package Medium = Medium_F, down_T = 603.15, dp_nominal = 9.451e+06, m_flow_nominal = 72, p_nominal = 1.2431e+07, rho_nominal (displayUnit = "kg/m3") = 36.72) annotation(
      Placement(visible = true, transformation(origin = {-34, 20}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 2.861e+06, m_flow_nominal = 82.86, p_nominal = 28.61e+05, rho_nominal = 7.827) annotation(
      Placement(visible = true, transformation(origin = {-24, 8}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  TPPSim.Boilers.EMA_028_HRSG boiler(redeclare package Medium_F = Medium_F, redeclare package Medium_G = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {10, 4}, extent = {{-30, -20}, {30, 20}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible LP_CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 371000, m_flow_nominal = 12.83, p_nominal = 3.71e+05, rho_nominal = 1.61) annotation(
    Placement(visible = true, transformation(origin = {-10, 36}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible HP_FWP annotation(
    Placement(visible = true, transformation(origin = {17, -29}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible IP_FWP annotation(
    Placement(visible = true, transformation(origin = {17, -37}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.377, Lpipe = 155, delta = 0.05, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-17, 19}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe CRH_pipe(Din = 0.487, Lpipe = 65, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-35, 13}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
equation
  connect(CRH_pipe.waterOut, boiler.RH_In) annotation(
    Line(points = {{-32, 14}, {-4, 14}, {-4, 12}, {-4, 12}}, color = {0, 127, 255}));
  connect(HP_RS.flowOut, CRH_pipe.waterIn) annotation(
    Line(points = {{-38, 20}, {-40, 20}, {-40, 12}, {-38, 12}, {-38, 14}}, color = {0, 127, 255}));
  connect(HP_RS.flowIn, HP_pipe.waterOut) annotation(
    Line(points = {{-30, 20}, {-20, 20}, {-20, 20}, {-20, 20}}, color = {0, 127, 255}));
  connect(boiler.HP_Out, HP_pipe.waterIn) annotation(
    Line(points = {{-6, 12}, {-6, 12}, {-6, 20}, {-14, 20}, {-14, 20}}, color = {0, 127, 255}));
  connect(HP_CV_const.y, HP_RS.opening) annotation(
    Line(points = {{-33.5, 35}, {-33, 35}, {-33, 23}}, color = {0, 0, 127}));
  connect(HP_CV_const.y, CV.opening) annotation(
    Line(points = {{-33.5, 35}, {-24, 35}, {-24, 12}}, color = {0, 0, 127}));
  connect(HP_CV_const.y, LP_CV.opening) annotation(
    Line(points = {{-33.5, 35}, {-26, 35}, {-26, 44}, {-10, 44}, {-10, 40}}, color = {0, 0, 127}));
  connect(condPump.port_b, HP_RS.waterIn) annotation(
    Line(points = {{54, 24}, {-18, 24}, {-18, 16}, {-36, 16}}, color = {0, 127, 255}));
  connect(GT.flowOut, boiler.gasIn) annotation(
    Line(points = {{-60, -10}, {-42, -10}, {-42, -9}, {-20, -9}}, color = {0, 127, 255}));
  connect(boiler.RH_Out, CV.port_a) annotation(
    Line(points = {{-9, 11}, {-14, 11}, {-14, 8}, {-20, 8}}, color = {0, 127, 255}));
  connect(boiler.LP_Out, LP_CV.port_a) annotation(
    Line(points = {{15, 11}, {14, 11}, {14, 36}, {-6, 36}}, color = {0, 127, 255}));
  connect(condPump.port_b, boiler.cond_In) annotation(
    Line(points = {{54, 24}, {24, 24}, {24, 11}, {25, 11}}, color = {0, 127, 255}));
  connect(boiler.FW_Out, HP_FWP.port_a) annotation(
    Line(points = {{21, -15}, {21, -23}, {20, -23}, {20, -28}}, color = {0, 127, 255}));
  connect(boiler.FW_Out, IP_FWP.port_a) annotation(
    Line(points = {{21, -15}, {21, -26}, {24, -26}, {24, -36}, {20, -36}}, color = {0, 127, 255}));
  connect(IP_FWP.port_b, boiler.IP_FW_In) annotation(
    Line(points = {{14, -36}, {10, -36}, {10, -24}, {17, -24}, {17, -15}}, color = {0, 127, 255}));
  connect(HP_FWP.port_b, boiler.HP_FW_In) annotation(
    Line(points = {{14, -28}, {15, -28}, {15, -15}}, color = {0, 127, 255}));
  connect(LP_CV.port_b, flowSink.ports[2]) annotation(
    Line(points = {{-14, 36}, {-20, 36}, {-20, 46}, {-46, 46}, {-46, 32}, {-60, 32}, {-60, 30}}, color = {0, 127, 255}));
  connect(CV.port_b, flowSink.ports[1]) annotation(
    Line(points = {{-28, 8}, {-48, 8}, {-48, 30}, {-60, 30}, {-60, 30}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], condPump.port_a) annotation(
    Line(points = {{76, 20}, {71, 20}, {71, 23}, {64, 23}}, color = {0, 127, 255}, thickness = 0.5));
end EMA_028_HRSG_Test;
