within TPPSim.Steam_turbine;
model dummy_ST_2
  extends TPPSim.Steam_turbine.BaseClasses.Icons.icon_dummy_ST;
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  outer Modelica.Fluid.System system;
  //Параметры
  parameter Real Kv_HP_RS = 0 "Пропускная способность БРОУ ВД [м3/ч]";
  parameter Real Kv_IP_RS = 0 "Пропускная способность БРОУ СД [м3/ч]";
  parameter Real Kv_LP_CV = 0 "Пропускная способность РК НД [м3/ч]";
  TPPSim.Valves.ReducingStation HP_RS(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = Kv_HP_RS, dp_nominal = 9e+06, min_delta = 90, set_down_T = 573.15, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {2, 62}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible IP_RS(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = Kv_IP_RS, dp_nominal = 3e+06, filteredOpening = true, riseTime = 10) annotation(
      Placement(visible = true, transformation(origin = {12, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium, T = 60 + 273.15, nPorts = 3, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-88, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  ThermoPower.Water.SteamTurbineStodola HPT(Kt = 0.0038, PRstart = 1, eta_iso_nom = 0.9, pnom = 130e5, wnom = 77)  annotation(
    Placement(visible = true, transformation(origin = {2, 32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible HPCV(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1000, dp_nominal = 9e+06) annotation(
    Placement(visible = true, transformation(origin = {30, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort1(redeclare package Medium = Medium, nPorts_b = 2)  annotation(
    Placement(visible = true, transformation(origin = {63.8, 40.5}, extent = {{4.2, -10.5}, {-4.2, 10.5}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort2(redeclare package Medium = Medium, nPorts_b = 2) annotation(
    Placement(visible = true, transformation(origin = {-79.8, 19.5}, extent = {{-4.2, -10.5}, {4.2, 10.5}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort3(redeclare package Medium = Medium, nPorts_b = 2) annotation(
    Placement(visible = true, transformation(origin = {66.2, -10.5}, extent = {{4.2, -10.5}, {-4.2, 10.5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible IPT(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1230, dp_nominal = 3e+06) annotation(
    Placement(visible = true, transformation(origin = {-8, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constSpeed(w_fixed = Modelica.Constants.pi * 50)  annotation(
    Placement(visible = true, transformation(origin = {-23, 31}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a HP(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {98, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-158, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b CRH(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-296, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput HP_RS_pos annotation(
    Placement(visible = true, transformation(origin = {100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {-70, 196}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Interfaces.FluidPort_a cooling_water(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {300, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a HRH(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-122, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible LP_CV(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = Kv_LP_CV, dp_nominal = 371000, m_flow_nominal = 12.83, p_nominal = 3.71e+05, rho_nominal = 1.61) annotation(
    Placement(visible = true, transformation(origin = {-10, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a LP(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {180, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput RP_RS_t annotation(
    Placement(visible = true, transformation(origin = {100, 94}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-38, 196}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput HP_RS_apos annotation(
    Placement(visible = true, transformation(origin = {-100, 90}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-34, -198}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput HP_CV_pos annotation(
    Placement(visible = true, transformation(origin = {100, 62}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-8, 196}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput HP_CV_apos annotation(
    Placement(visible = true, transformation(origin = {-100, 72}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-64, -198}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput IP_RS_pos annotation(
    Placement(visible = true, transformation(origin = {100, 14}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {24, 196}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput IP_RS_apos annotation(
    Placement(visible = true, transformation(origin = {-100, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-4, -198}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput IP_CV_pos annotation(
    Placement(visible = true, transformation(origin = {100, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {56, 196}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput IP_CV_apos annotation(
    Placement(visible = true, transformation(origin = {-100, -58}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {28, -198}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput LP_CV_pos annotation(
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {86, 196}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput LP_CV_apos annotation(
    Placement(visible = true, transformation(origin = {-100, -90}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {60, -198}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
equation
  connect(HP_RS.opening_actual, HP_RS_apos) annotation(
    Line(points = {{0, 66}, {-48, 66}, {-48, 90}, {-100, 90}, {-100, 90}}, color = {0, 0, 127}));
  connect(RP_RS_t, HP_RS.T_in) annotation(
    Line(points = {{100, 94}, {-6, 94}, {-6, 70}, {-6, 70}}, color = {0, 0, 127}));
  connect(HP_RS_pos, HP_RS.opening) annotation(
    Line(points = {{100, 80}, {6, 80}, {6, 70}, {6, 70}}, color = {0, 0, 127}));
  connect(HP_RS.flowOut, multiPort2.ports_b[2]) annotation(
    Line(points = {{-8, 62}, {-48, 62}, {-48, 19.5}, {-76, 19.5}}, color = {0, 127, 255}));
  connect(cooling_water, HP_RS.waterIn) annotation(
    Line(points = {{-100, 50}, {-2, 50}, {-2, 52}, {-2, 52}}));
  connect(multiPort1.ports_b[2], HP_RS.flowIn) annotation(
    Line(points = {{60, 40}, {44, 40}, {44, 62}, {12, 62}, {12, 62}}, color = {0, 127, 255}, thickness = 0.5));
  connect(LP_CV.opening_actual, LP_CV_apos) annotation(
    Line(points = {{-16, -78}, {-50, -78}, {-50, -90}, {-100, -90}, {-100, -90}}, color = {0, 0, 127}));
  connect(LP_CV.port_b, flowSink.ports[3]) annotation(
    Line(points = {{-20, -80}, {-66, -80}, {-66, -32}, {-72, -32}, {-72, -30}, {-78, -30}}, color = {0, 127, 255}));
  connect(LP, LP_CV.port_a) annotation(
    Line(points = {{100, -80}, {50, -80}, {50, -80}, {0, -80}, {0, -80}, {0, -80}}));
  connect(LP_CV_pos, LP_CV.opening) annotation(
    Line(points = {{100, -60}, {-10, -60}, {-10, -72}, {-10, -72}}, color = {0, 0, 127}));
  connect(IPT.opening_actual, IP_CV_apos) annotation(
    Line(points = {{-14, -28}, {-40, -28}, {-40, -58}, {-100, -58}, {-100, -58}}, color = {0, 0, 127}));
  connect(IP_CV_pos, IPT.opening) annotation(
    Line(points = {{100, -40}, {60, -40}, {60, -20}, {-8, -20}, {-8, -22}}, color = {0, 0, 127}));
  connect(IP_RS.opening_actual, IP_RS_apos) annotation(
    Line(points = {{6, -8}, {-100, -8}}, color = {0, 0, 127}));
  connect(IP_RS_pos, IP_RS.opening) annotation(
    Line(points = {{100, 14}, {12, 14}, {12, -2}, {12, -2}}, color = {0, 0, 127}));
  connect(HPCV.opening_actual, HP_CV_apos) annotation(
    Line(points = {{24, 42}, {-66, 42}, {-66, 72}, {-100, 72}, {-100, 72}}, color = {0, 0, 127}));
  connect(HP_CV_pos, HPCV.opening) annotation(
    Line(points = {{100, 62}, {58, 62}, {58, 58}, {30, 58}, {30, 48}, {30, 48}}, color = {0, 0, 127}));
  connect(multiPort3.ports_b[1], IPT.port_a) annotation(
    Line(points = {{62, -10.5}, {55, -10.5}, {55, -10.5}, {48, -10.5}, {48, -30.5}, {2, -30.5}, {2, -30.5}}, color = {0, 127, 255}, thickness = 0.5));
  connect(IPT.port_b, flowSink.ports[1]) annotation(
    Line(points = {{-18, -30}, {-33, -30}, {-33, -30}, {-48, -30}, {-48, -30}, {-78, -30}, {-78, -30}, {-78, -30}, {-78, -30}, {-78, -30}, {-78, -30}, {-78, -30}}, color = {0, 127, 255}));
  connect(HRH, multiPort3.port_a) annotation(
    Line(points = {{100, -10}, {85, -10}, {85, -10}, {70, -10}, {70, -10}, {70, -10}, {70, -10}, {70, -10}}));
  connect(multiPort3.ports_b[2], IP_RS.port_a) annotation(
    Line(points = {{62, -10.5}, {43, -10.5}, {43, -10.5}, {24, -10.5}, {24, -10.5}, {22, -10.5}, {22, -10.5}}, color = {0, 127, 255}, thickness = 0.5));
  connect(IP_RS.port_b, flowSink.ports[2]) annotation(
    Line(points = {{2, -10}, {-33, -10}, {-33, -10}, {-68, -10}, {-68, -28}, {-78, -28}, {-78, -30}}, color = {0, 127, 255}));
  connect(HPT.outlet, multiPort2.ports_b[1]) annotation(
    Line(points = {{-6, 40}, {-40, 40}, {-40, 19.5}, {-76, 19.5}}, color = {0, 0, 255}));
  connect(multiPort2.port_a, CRH) annotation(
    Line(points = {{-84, 19.5}, {-85, 19.5}, {-85, 20}, {-100, 20}}, color = {0, 127, 255}));
  connect(HPCV.port_b, HPT.inlet) annotation(
    Line(points = {{20, 40}, {10, 40}, {10, 40}, {10, 40}}, color = {0, 127, 255}));
  connect(multiPort1.ports_b[1], HPCV.port_a) annotation(
    Line(points = {{60, 40}, {40, 40}, {40, 40}, {40, 40}}, color = {0, 127, 255}, thickness = 0.5));
  connect(HP, multiPort1.port_a) annotation(
    Line(points = {{98, 40}, {68, 40}, {68, 40}, {68, 40}}));
  connect(HPT.shaft_b, constSpeed.flange) annotation(
    Line(points = {{-4.4, 32}, {-11.4, 32}, {-11.4, 31}, {-18.4, 31}}));
  annotation(Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}}, initialScale = 0.1)), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end dummy_ST_2;
