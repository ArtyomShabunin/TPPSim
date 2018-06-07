within TPPSim.Boilers.Tests;

model ThreePVerticalHRSG_Test
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  package Medium_G = TPPSim.Media.ExhaustGas;
  inner Modelica.Fluid.System system(T_start = 60 + 273.15,allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Boilers.ThreePVerticalHRSG Boiler(redeclare package Medium_G = Medium_G, redeclare package Medium_F = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {26, 10}, extent = {{20, -30}, {-20, 30}}, rotation = 0)));
  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 1292.6 / 3.6, Tnom = 517.2 + 273.15, Tstart = system.T_start) annotation(
    Placement(visible = true, transformation(origin = {-70, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 2, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant LP_CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-3, 25}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible LP_CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 4.1e+06, m_flow_nominal = 10, p_nominal = 41e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {-10, 12}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant IP_CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-11, 39}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible HP_CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {-34, -4}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible IP_CV(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(
    Placement(visible = true, transformation(origin = {-22, 6}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant HP_CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-43, 15}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible IP_FW_pump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {49, -41}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible HP_FW_pump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {51, -21}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = system.T_start, nPorts = 1, p = system.p_ambient)  annotation(
    Placement(visible = true, transformation(origin = {86, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Pumps.simplePumpFlexible condPump(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {59, 21}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
equation
  connect(HP_CV.port_b, Boiler.RH_In) annotation(
    Line(points = {{-38, -4}, {-42, -4}, {-42, -26}, {38, -26}, {38, -12}, {52, -12}, {52, 0}, {46, 0}, {46, 2}}, color = {0, 127, 255}));
  connect(HP_CV_const.y, HP_CV.opening) annotation(
    Line(points = {{-38, 16}, {-34, 16}, {-34, 0}, {-34, 0}}, color = {0, 0, 127}));
  connect(Boiler.HP_steamOut, HP_CV.port_a) annotation(
    Line(points = {{12, 4}, {0, 4}, {0, -4}, {-30, -4}, {-30, -4}}, color = {0, 127, 255}));
  connect(IP_CV_const.y, IP_CV.opening) annotation(
    Line(points = {{-16, 40}, {-22, 40}, {-22, 9}}, color = {0, 0, 127}));
  connect(IP_CV.port_b, flowSink.ports[1]) annotation(
    Line(points = {{-26, 6}, {-26, 30}, {-60, 30}}, color = {0, 127, 255}));
  connect(Boiler.RH_Out, IP_CV.port_a) annotation(
    Line(points = {{12, 0}, {-5, 0}, {-5, 6}, {-18, 6}}, color = {0, 127, 255}));
  connect(LP_CV.port_a, Boiler.LP_steamOut) annotation(
    Line(points = {{-6, 12}, {12, 12}, {12, 12}, {12, 12}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], condPump.port_a) annotation(
    Line(points = {{76, 20}, {71, 20}, {71, 21}, {64, 21}}, color = {0, 127, 255}, thickness = 0.5));
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
  connect(LP_CV.port_b, flowSink.ports[2]) annotation(
    Line(points = {{-14, 12}, {-20, 12}, {-20, 32}, {-60, 32}, {-60, 30}}, color = {0, 127, 255}));
  connect(GT.flowOut, Boiler.gasIn) annotation(
    Line(points = {{-60, -12}, {6, -12}}, color = {0, 127, 255}));
  connect(LP_CV_const.y, LP_CV.opening) annotation(
    Line(points = {{-8, 26}, {-10, 26}, {-10, 16}, {-10, 16}}, color = {0, 0, 127}));
end ThreePVerticalHRSG_Test;
