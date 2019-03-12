within TPPSim.Boilers.Tests;

model Glycol_HE_2
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = TPPSim.Media.Glycol_ph;
//  replaceable package Medium_F = Modelica.Media.Water.StandardWater;
  parameter Real T_flow_in_set = 70 "Температура раствора этиленгликоля перед теплообменником";
  parameter Real m_flow_set = 739208 / 3600 "Массовый расход раствора этиленгликоля";
  parameter Real bypass_pos_set = 0.558 "Положение шибера на байпасе теплообменника";
  parameter Real gas_massflow_set = 192.4 "Массовый расход выхлопных газов ГТУ";
  parameter Real T_gas_in_set = 351 "Температура выхлопных газов ГТУ";
  TPPSim.HRSG_HeatExch.GFHE HE(redeclare TPPSim.HRSG_HeatExch.GlycolSideHE flowHE(redeclare TPPSim.thermal.alfaForGlycol alpha), redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F, Din = 36e-3, HRSG_type_set = TPPSim.Choices.HRSG_type.verticalTop, Lpipe = 5, T_gas_start = T_flow_in_set+273.15, T_m_start = T_flow_in_set+273.15, delta = 3e-3, delta_fin = 1.3e-3, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, gasEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, gasMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, h_flow_start = TPPSim.Media.Glycol_ph.specificEnthalpy_pT(1e5, T_flow_in_set+273.15), hfin = 16e-3, k_gamma_gas = 1, k_volume = 1.2, k_volume_gas = 1.2, k_weight_metal = 1.2, metalDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfTubeSections = 3, p_flow_start = 100000, p_gas_start = 100000, s1 = 133e-3, s2 = 78.5e-3, sfin = 6.1e-3, z1 = 26, z2 = 20, zahod = 2) annotation(
    Placement(visible = true, transformation(origin = {20, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 150}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T gas_source(redeclare package Medium = Medium_G, T = 494 + 273.15, m_flow = 190.476, nPorts = 1, use_T_in = true, use_X_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {70, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary gas_sink(redeclare package Medium = Medium_G, T = 300 + 273.15, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T bypas(redeclare package Medium = Medium_G, T = 494 + 273.15, m_flow = 190.476, nPorts = 1, use_T_in = true, use_X_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {70, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flow_source(redeclare package Medium = Medium_F, T = 60 + 273.15, m_flow = 739208 / 3600, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-24, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flow_sink(redeclare package Medium = Medium_F, T = 70 + 273.15, nPorts = 1, p = 120e5, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {70, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort mixer(redeclare package Medium = Medium_G, nPorts_b = 2) annotation(
    Placement(visible = true, transformation(origin = {-24, -70}, extent = {{-4, -10}, {4, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature T_flow_out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {40, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature T_gas_out(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-40, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {-10, 144}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {30, 150}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant gas_massflow(k = gas_massflow_set)  annotation(
    Placement(visible = true, transformation(origin = {-70, 150}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant bypass_pos(k = bypass_pos_set)  annotation(
    Placement(visible = true, transformation(origin = {-70, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant flow_massflow(k = m_flow_set)  annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T_flow_in(k = T_flow_in_set+273.15) annotation(
    Placement(visible = true, transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp T_gas_in(duration = 60, height = (T_gas_in_set + 273.15) - (T_flow_in_set+273.15), offset = T_flow_in_set+273.15, startTime = 0)  annotation(
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature T_gas_he_out(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-10, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant O2(k = 0.143)  annotation(
    Placement(visible = true, transformation(origin = {-90, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant CO2(k = 0.03)  annotation(
    Placement(visible = true, transformation(origin = {-50, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant H2O(k = 0.066)  annotation(
    Placement(visible = true, transformation(origin = {-10, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Ar(k = 0.009)  annotation(
    Placement(visible = true, transformation(origin = {30, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant NO2(k = 0)  annotation(
    Placement(visible = true, transformation(origin = {70, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum N(k = {-1, -1, -1, -1, -1, 1}, nu = 6)  annotation(
    Placement(visible = true, transformation(origin = {10, -150}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant sum(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-90, -150}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {2, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy_in(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {10, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy_out(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {30, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-26, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product HeatRate annotation(
    Placement(visible = true, transformation(origin = {-62, 34}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(HE.flowOut, specificEnthalpy_out.port) annotation(
    Line(points = {{24, -40}, {24, -40}, {24, 24}, {30, 24}, {30, 40}, {30, 40}}, color = {0, 127, 255}));
  connect(HE.flowIn, specificEnthalpy_in.port) annotation(
    Line(points = {{16, -40}, {16, -40}, {16, 12}, {10, 12}, {10, 20}, {10, 20}}, color = {0, 127, 255}));
  connect(add2.y, HeatRate.u1) annotation(
    Line(points = {{-38, 40}, {-50, 40}, {-50, 40}, {-50, 40}}, color = {0, 0, 127}));
  connect(massFlowRate1.m_flow, HeatRate.u2) annotation(
    Line(points = {{2, 4}, {2, 4}, {2, 20}, {-44, 20}, {-44, 28}, {-50, 28}, {-50, 28}}, color = {0, 0, 127}));
  connect(specificEnthalpy_in.h_out, add2.u2) annotation(
    Line(points = {{0, 30}, {-8, 30}, {-8, 34}, {-14, 34}, {-14, 34}}, color = {0, 0, 127}));
  connect(specificEnthalpy_out.h_out, add2.u1) annotation(
    Line(points = {{20, 50}, {-8, 50}, {-8, 46}, {-14, 46}, {-14, 46}}, color = {0, 0, 127}));
  connect(T_gas_in.y, gas_source.T_in) annotation(
    Line(points = {{-59, 90}, {88, 90}, {88, -46}, {82, -46}}, color = {0, 0, 127}));
  connect(T_gas_in.y, bypas.T_in) annotation(
    Line(points = {{-59, 90}, {88, 90}, {88, -76}, {82, -76}}, color = {0, 0, 127}));
  connect(bypass_pos.y, product1.u2) annotation(
    Line(points = {{-59, 120}, {-50, 120}, {-50, 120}, {-39, 120}, {-39, 138}, {-21, 138}, {-21, 138}, {-23, 138}, {-23, 138}}, color = {0, 0, 127}));
  connect(gas_massflow.y, product1.u1) annotation(
    Line(points = {{-59, 150}, {-50, 150}, {-50, 152}, {-41, 152}, {-41, 150}, {-21, 150}, {-21, 150}, {-23, 150}}, color = {0, 0, 127}));
  connect(gas_massflow.y, add1.u1) annotation(
    Line(points = {{-59, 150}, {-49, 150}, {-49, 152}, {-39, 152}, {-39, 160}, {7, 160}, {7, 158}, {19, 158}, {19, 158}, {17, 158}, {17, 160}, {17, 160}, {17, 156}}, color = {0, 0, 127}));
  connect(product1.y, add1.u2) annotation(
    Line(points = {{1, 144}, {8, 144}, {8, 144}, {17, 144}, {17, 144}, {17, 144}}, color = {0, 0, 127}));
  connect(add1.y, gas_source.m_flow_in) annotation(
    Line(points = {{41, 150}, {60, 150}, {60, 130}, {96, 130}, {96, -42}, {80, -42}}, color = {0, 0, 127}));
  connect(product1.y, bypas.m_flow_in) annotation(
    Line(points = {{1, 144}, {10, 144}, {10, 120}, {92, 120}, {92, -72}, {80, -72}}, color = {0, 0, 127}));
  connect(massFlowRate1.port_b, HE.flowIn) annotation(
    Line(points = {{12, -8}, {16, -8}, {16, -40}, {16, -40}}, color = {0, 127, 255}));
  connect(flow_source.ports[1], massFlowRate1.port_a) annotation(
    Line(points = {{-14, -8}, {-8, -8}, {-8, -8}, {-8, -8}}, color = {0, 127, 255}, thickness = 0.5));
  connect(flow_massflow.y, flow_source.m_flow_in) annotation(
    Line(points = {{-58, 0}, {-34, 0}}, color = {0, 0, 127}));
  connect(T_flow_in.y, flow_source.T_in) annotation(
    Line(points = {{-58, -30}, {-40, -30}, {-40, -4}, {-36, -4}}, color = {0, 0, 127}));
  connect(N.y, gas_source.X_in[4]) annotation(
    Line(points = {{22, -150}, {86, -150}, {86, -54}, {82, -54}, {82, -54}}, color = {0, 0, 127}));
  connect(NO2.y, gas_source.X_in[6]) annotation(
    Line(points = {{82, -110}, {86, -110}, {86, -54}, {82, -54}, {82, -54}}, color = {0, 0, 127}));
  connect(Ar.y, gas_source.X_in[5]) annotation(
    Line(points = {{42, -110}, {46, -110}, {46, -92}, {86, -92}, {86, -54}, {82, -54}, {82, -54}}, color = {0, 0, 127}));
  connect(H2O.y, gas_source.X_in[3]) annotation(
    Line(points = {{2, -110}, {8, -110}, {8, -92}, {86, -92}, {86, -54}, {82, -54}, {82, -54}}, color = {0, 0, 127}));
  connect(CO2.y, gas_source.X_in[2]) annotation(
    Line(points = {{-38, -110}, {-34, -110}, {-34, -92}, {86, -92}, {86, -54}, {82, -54}, {82, -54}}, color = {0, 0, 127}));
  connect(O2.y, gas_source.X_in[1]) annotation(
    Line(points = {{-78, -110}, {-66, -110}, {-66, -92}, {86, -92}, {86, -54}, {82, -54}, {82, -54}}, color = {0, 0, 127}));
  connect(N.y, bypas.X_in[4]) annotation(
    Line(points = {{22, -150}, {86, -150}, {86, -84}, {82, -84}, {82, -84}}, color = {0, 0, 127}));
  connect(NO2.y, bypas.X_in[6]) annotation(
    Line(points = {{82, -110}, {86, -110}, {86, -84}, {82, -84}, {82, -84}}, color = {0, 0, 127}));
  connect(Ar.y, bypas.X_in[5]) annotation(
    Line(points = {{42, -110}, {46, -110}, {46, -92}, {86, -92}, {86, -84}, {82, -84}, {82, -84}}, color = {0, 0, 127}));
  connect(H2O.y, bypas.X_in[3]) annotation(
    Line(points = {{2, -110}, {8, -110}, {8, -92}, {86, -92}, {86, -84}, {82, -84}, {82, -84}}, color = {0, 0, 127}));
  connect(CO2.y, bypas.X_in[2]) annotation(
    Line(points = {{-38, -110}, {-34, -110}, {-34, -92}, {86, -92}, {86, -84}, {82, -84}, {82, -84}}, color = {0, 0, 127}));
  connect(O2.y, bypas.X_in[1]) annotation(
    Line(points = {{-78, -110}, {-66, -110}, {-66, -92}, {86, -92}, {86, -84}, {82, -84}, {82, -84}}, color = {0, 0, 127}));
  connect(sum.y, N.u[6]) annotation(
    Line(points = {{-78, -150}, {-2, -150}, {-2, -150}, {0, -150}}, color = {0, 0, 127}));
  connect(NO2.y, N.u[5]) annotation(
    Line(points = {{82, -110}, {86, -110}, {86, -138}, {-4, -138}, {-4, -150}, {0, -150}, {0, -150}}, color = {0, 0, 127}));
  connect(Ar.y, N.u[4]) annotation(
    Line(points = {{42, -110}, {46, -110}, {46, -134}, {-8, -134}, {-8, -150}, {0, -150}, {0, -150}}, color = {0, 0, 127}));
  connect(H2O.y, N.u[3]) annotation(
    Line(points = {{2, -110}, {8, -110}, {8, -128}, {-12, -128}, {-12, -150}, {0, -150}, {0, -150}}, color = {0, 0, 127}));
  connect(CO2.y, N.u[2]) annotation(
    Line(points = {{-38, -110}, {-34, -110}, {-34, -150}, {0, -150}, {0, -150}}, color = {0, 0, 127}));
  connect(O2.y, N.u[1]) annotation(
    Line(points = {{-78, -110}, {-76, -110}, {-76, -150}, {0, -150}, {0, -150}}, color = {0, 0, 127}));
  connect(mixer.port_a, T_gas_out.port) annotation(
    Line(points = {{-28, -70}, {-40, -70}, {-40, -60}, {-40, -60}}, color = {0, 127, 255}));
  connect(HE.gasOut, T_gas_he_out.port) annotation(
    Line(points = {{16, -50}, {-10, -50}, {-10, -50}, {-10, -50}}, color = {0, 127, 255}));
  connect(HE.gasOut, mixer.ports_b[1]) annotation(
    Line(points = {{16, -50}, {8, -50}, {8, -68}, {-20, -68}, {-20, -70}}, color = {0, 127, 255}));
  connect(mixer.port_a, gas_sink.ports[1]) annotation(
    Line(points = {{-28, -70}, {-60, -70}}, color = {0, 127, 255}));
  connect(bypas.ports[1], mixer.ports_b[2]) annotation(
    Line(points = {{60, -80}, {4, -80}, {4, -70}, {-20, -70}}, color = {0, 127, 255}, thickness = 0.5));
  connect(HE.flowOut, T_flow_out.port) annotation(
    Line(points = {{24, -40}, {25, -40}, {25, -40}, {24, -40}, {24, -20}, {40, -20}, {40, -6}, {40, -6}}, color = {0, 127, 255}));
  connect(HE.flowOut, flow_sink.ports[1]) annotation(
    Line(points = {{24, -40}, {24, -40}, {24, -40}, {24, -40}, {24, -20}, {60, -20}, {60, -20}, {60, -20}, {60, -20}}, color = {0, 127, 255}));
  connect(gas_source.ports[1], HE.gasIn) annotation(
    Line(points = {{60, -50}, {26, -50}}, color = {0, 127, 255}, thickness = 0.5));
  annotation(
    experiment(StartTime = 0, StopTime = 3000, Tolerance = 0.001, Interval = 10),
    Diagram(coordinateSystem(extent = {{-100, -160}, {100, 160}})),
    Icon(coordinateSystem(extent = {{-100, -160}, {100, 160}})),
    __OpenModelica_commandLineOptions = "");
end Glycol_HE_2;
