within TPPSim.Boilers.Tests;

model EMA_028_HRSG_Test
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  package Medium_G = TPPSim.Media.ExhaustGas;
  inner Modelica.Fluid.System system(T_start = 60 + 273.15,allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 2482.5 / 3.6, Tnom = 569.1 + 273.15, Tstart = system.T_start) annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 2, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant HP_CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-37, 35}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = system.T_start, nPorts = 1, p = system.p_ambient)  annotation(
    Placement(visible = true, transformation(origin = {86, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible condPump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {59, 23}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Valves.ReducingStation HP_RS(redeclare package Medium = Medium_F, down_T = 603.15, dp_nominal = 9.451e+06, m_flow_nominal = 72, p_nominal = 1.2431e+07, rho_nominal (displayUnit = "kg/m3") = 36.72) annotation(
      Placement(visible = true, transformation(origin = {-30, 20}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 2.861e+06, m_flow_nominal = 82.86, p_nominal = 28.61e+05, rho_nominal = 7.827) annotation(
      Placement(visible = true, transformation(origin = {-24, 8}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  TPPSim.Boilers.EMA_028_HRSG boiler annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-30, -20}, {30, 20}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible LP_CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 371000, m_flow_nominal = 12.83, p_nominal = 3.71e+05, rho_nominal = 1.61) annotation(
    Placement(visible = true, transformation(origin = {-10, 36}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible HP_FWP annotation(
    Placement(visible = true, transformation(origin = {17, -29}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible IP_FWP annotation(
    Placement(visible = true, transformation(origin = {17, -37}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
equation
  connect(HP_FWP.port_b, boiler.HP_FW_In) annotation(
    Line(points = {{14, -28}, {16, -28}, {16, -18}, {16, -18}}, color = {0, 127, 255}));
  connect(IP_FWP.port_b, boiler.IP_FW_In) annotation(
    Line(points = {{14, -36}, {10, -36}, {10, -24}, {18, -24}, {18, -18}, {18, -18}}, color = {0, 127, 255}));
  connect(boiler.FW_Out, IP_FWP.port_a) annotation(
    Line(points = {{20, -18}, {20, -18}, {20, -26}, {24, -26}, {24, -36}, {20, -36}, {20, -36}}, color = {0, 127, 255}));
  connect(boiler.FW_Out, HP_FWP.port_a) annotation(
    Line(points = {{20, -18}, {20, -18}, {20, -28}, {20, -28}, {20, -28}}, color = {0, 127, 255}));
  connect(condPump.port_b, boiler.cond_In) annotation(
    Line(points = {{54, 24}, {24, 24}, {24, 8}, {26, 8}}, color = {0, 127, 255}));
  connect(HP_CV_const.y, LP_CV.opening) annotation(
    Line(points = {{-32, 36}, {-26, 36}, {-26, 44}, {-10, 44}, {-10, 40}, {-10, 40}}, color = {0, 0, 127}));
  connect(LP_CV.port_b, flowSink.ports[2]) annotation(
    Line(points = {{-14, 36}, {-20, 36}, {-20, 46}, {-46, 46}, {-46, 32}, {-60, 32}, {-60, 30}}, color = {0, 127, 255}));
  connect(boiler.LP_Out, LP_CV.port_a) annotation(
    Line(points = {{16, 8}, {14, 8}, {14, 36}, {-6, 36}, {-6, 36}}, color = {0, 127, 255}));
  connect(CV.port_b, flowSink.ports[1]) annotation(
    Line(points = {{-28, 8}, {-48, 8}, {-48, 30}, {-60, 30}, {-60, 30}}, color = {0, 127, 255}));
  connect(boiler.RH_Out, CV.port_a) annotation(
    Line(points = {{-8, 8}, {-20, 8}, {-20, 8}, {-20, 8}}, color = {0, 127, 255}));
  connect(HP_CV_const.y, CV.opening) annotation(
    Line(points = {{-32, 36}, {-24, 36}, {-24, 12}, {-24, 12}}, color = {0, 0, 127}));
  connect(HP_RS.flowOut, boiler.RH_In) annotation(
    Line(points = {{-34, 20}, {-42, 20}, {-42, 14}, {-4, 14}, {-4, 8}, {-4, 8}}, color = {0, 127, 255}));
  connect(boiler.HP_Out, HP_RS.flowIn) annotation(
    Line(points = {{-6, 8}, {-6, 8}, {-6, 20}, {-26, 20}, {-26, 20}}, color = {0, 127, 255}));
  connect(GT.flowOut, boiler.gasIn) annotation(
    Line(points = {{-60, -10}, {-42, -10}, {-42, -14}, {-20, -14}, {-20, -14}}, color = {0, 127, 255}));
  connect(condPump.port_b, HP_RS.waterIn) annotation(
    Line(points = {{54, 24}, {-18, 24}, {-18, 16}, {-32, 16}, {-32, 16}, {-32, 16}}, color = {0, 127, 255}));
  connect(HP_CV_const.y, HP_RS.opening) annotation(
    Line(points = {{-32, 36}, {-28, 36}, {-28, 24}, {-28, 24}}, color = {0, 0, 127}));
  connect(flowSource.ports[1], condPump.port_a) annotation(
    Line(points = {{76, 20}, {71, 20}, {71, 23}, {64, 23}}, color = {0, 127, 255}, thickness = 0.5));
end EMA_028_HRSG_Test;
