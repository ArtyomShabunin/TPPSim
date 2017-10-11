within TPPSim.Boilers.Tests;

model EMA_028_HRSG_Test
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  package Medium_G = TPPSim.Media.ExhaustGas;
  inner Modelica.Fluid.System system(T_start = 60 + 273.15,allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 2482.5 / 3.6, Tnom = 569.1 + 273.15, Tstart = system.T_start) annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant HP_CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-37, 35}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = system.T_start, nPorts = 1, p = system.p_ambient)  annotation(
    Placement(visible = true, transformation(origin = {86, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible condPump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {59, 23}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Valves.ReducingStation HP_RS(redeclare package Medium = Medium_F, down_T = 873.15, dp_nominal = 1.2431e+07, m_flow_nominal = 72, p_nominal = 1.2431e+07, rho_nominal (displayUnit = "kg/m3") = 36.72) annotation(
    Placement(visible = true, transformation(origin = {-30, 20}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  TPPSim.Boilers.EMA_028_HRSG boiler annotation(
    Placement(visible = true, transformation(origin = {12, 0}, extent = {{-30, -20}, {30, 20}}, rotation = 0)));
equation
  connect(GT.flowOut, boiler.gasIn) annotation(
    Line(points = {{-60, -10}, {-39, -10}, {-39, -14}, {-18, -14}}, color = {0, 127, 255}));
  connect(HP_RS.flowOut, flowSink.ports[1]) annotation(
    Line(points = {{-34, 20}, {-48, 20}, {-48, 30}, {-60, 30}, {-60, 30}}, color = {0, 127, 255}));
  connect(condPump.port_b, HP_RS.waterIn) annotation(
    Line(points = {{54, 24}, {-12, 24}, {-12, 16}, {-32, 16}, {-32, 16}}, color = {0, 127, 255}));
  connect(boiler.steamOut, HP_RS.flowIn) annotation(
    Line(points = {{-5, 7}, {-5, 20}, {-26, 20}}, color = {0, 127, 255}));
  connect(condPump.port_b, boiler.FW_In) annotation(
    Line(points = {{54, 23}, {27, 23}, {27, 7}}, color = {0, 127, 255}));
  connect(HP_CV_const.y, HP_RS.opening) annotation(
    Line(points = {{-31.5, 35}, {-29.5, 35}, {-29.5, 35}, {-29.5, 35}, {-29.5, 23}, {-27.5, 23}, {-27.5, 23}, {-27.5, 23}}, color = {0, 0, 127}));
  connect(flowSource.ports[1], condPump.port_a) annotation(
    Line(points = {{76, 20}, {71, 20}, {71, 23}, {64, 23}}, color = {0, 127, 255}, thickness = 0.5));
  connect(Boiler.RH_Out, IP_CV.port_a) annotation(
    Line(points = {{12, 0}, {0, 0}, {0, 6}, {-18, 6}, {-18, 6}, {-18, 6}}, color = {0, 127, 255}));
  connect(Boiler.HP_steamOut, HP_RS.flowIn) annotation(
    Line(points = {{12, 4}, {-8, 4}, {-8, 0}, {-32, 0}, {-32, 0}}, color = {0, 127, 255}));
  connect(LP_CV.port_a, Boiler.LP_steamOut) annotation(
    Line(points = {{-6, 12}, {12, 12}, {12, 12}, {12, 12}}, color = {0, 127, 255}));
  connect(HP_RS.flowOut, Boiler.RH_In) annotation(
    Line(points = {{-40, 0}, {-44, 0}, {-44, -32}, {62, -32}, {62, 0}, {46, 0}, {46, 2}}, color = {0, 127, 255}));
  connect(condPump.port_b, Boiler.condIn) annotation(
    Line(points = {{54, 21}, {50, 21}, {50, 20}, {46, 20}}, color = {0, 127, 255}));
  connect(IP_FW_pump.port_b, Boiler.IP_FW_In) annotation(
    Line(points = {{56, -40}, {64, -40}, {64, 10}, {46, 10}, {46, 10}}, color = {0, 127, 255}));
  connect(HP_FW_pump.port_b, Boiler.HP_FW_In) annotation(
    Line(points = {{56, -20}, {60, -20}, {60, 4}, {46, 4}, {46, 4}}, color = {0, 127, 255}));
  connect(Boiler.FW_out, HP_FW_pump.port_a) annotation(
    Line(points = {{42, -8}, {42, -9.5}, {46, -9.5}, {46, -21}}, color = {0, 127, 255}));
  connect(Boiler.FW_out, IP_FW_pump.port_a) annotation(
    Line(points = {{42, -8}, {42, -8}, {42, -40}, {44, -40}, {44, -40}}, color = {0, 127, 255}));
end EMA_028_HRSG_Test;
