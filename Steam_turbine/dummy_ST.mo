within TPPSim.Steam_turbine;
model dummy_ST
  extends TPPSim.Steam_turbine.BaseClasses.Icons.icon_dummy_ST;
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  outer Modelica.Fluid.System system;
  TPPSim.Valves.ReducingStation HP_RS(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 600, dp_nominal = 9e+06, min_delta = 90, set_down_T = 573.15, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {2, 62}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible IP_RS(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1800, dp_nominal = 3e+06) annotation(
      Placement(visible = true, transformation(origin = {10, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium, T = 60 + 273.15, nPorts = 3, p = system.p_ambient, use_T = true, use_p = true) annotation(
    Placement(visible = true, transformation(origin = {-90, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.CombiTimeTable BROU_pos_table(columns = {2, 3, 4, 5},fileName = "C:/Users/User/Documents/TPPSim/Boilers/Tests/pos_BROU.txt", tableName = "tabl", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant set_T_HPRS(k = 300 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-36, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Water.SteamTurbineStodola HPT(Kt = 0.0038, PRstart = 1, eta_iso_nom = 0.9, pnom = 130e5, wnom = 77)  annotation(
    Placement(visible = true, transformation(origin = {2, 32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible HPCV(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1000, dp_nominal = 9e+06) annotation(
    Placement(visible = true, transformation(origin = {30, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort1(redeclare package Medium = Medium, nPorts_b = 2)  annotation(
    Placement(visible = true, transformation(origin = {63.8, 40.5}, extent = {{4.2, -10.5}, {-4.2, 10.5}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort2(redeclare package Medium = Medium, nPorts_b = 2) annotation(
    Placement(visible = true, transformation(origin = {-79.8, 19.5}, extent = {{-4.2, -10.5}, {4.2, 10.5}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort3(redeclare package Medium = Medium, nPorts_b = 2) annotation(
    Placement(visible = true, transformation(origin = {64.2, -30.5}, extent = {{4.2, -10.5}, {-4.2, 10.5}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible IPT(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1230, dp_nominal = 3e+06) annotation(
    Placement(visible = true, transformation(origin = {-10, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constSpeed(w_fixed = Modelica.Constants.pi * 50)  annotation(
    Placement(visible = true, transformation(origin = {-23, 31}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Controls.pressure_control_2 HP_pressure_control(P_activation = 300000, T = 20, k = 0.000001, pos_start = 0.01, set_p = 6.7e+06, speed_p = 1e5 / 60)  annotation(
    Placement(visible = true, transformation(origin = {30, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Sensors.Pressure HP_pressure(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {90, 70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure IP_pressure(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {70, 22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Controls.pressure_control_3 IP_pressure_control(P_activation = 300000, T = 35, k = 0.000005, pos_start = 0.01, set_p = 2e+06, speed_p = 0.4e5 / 60) annotation(
    Placement(visible = true, transformation(origin = {30, -2}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanConstant booleanConst(k = false)  annotation(
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1(realFalse = 1, realTrue = 0)  annotation(
    Placement(visible = true, transformation(origin = {66, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal2(realFalse = 1, realTrue = 0)  annotation(
    Placement(visible = true, transformation(origin = {70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a HP(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {98, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-158, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b CRH(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-296, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput HP_drum_p annotation(
    Placement(visible = true, transformation(origin = {-40, 104}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {30, 196}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Interfaces.FluidPort_a cooling_water(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {300, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput HP_vent_valv_pos annotation(
    Placement(visible = true, transformation(origin = {66, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {108, 196}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Fluid.Interfaces.FluidPort_a HRH(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {98, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-122, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput check_valve_pos annotation(
    Placement(visible = true, transformation(origin = {104, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {66, 196}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput HRH_vent_valv_pos annotation(
    Placement(visible = true, transformation(origin = {106, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {142, 196}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(IP_RS.port_b, flowSink.ports[2]) annotation(
    Line(points = {{0, -30}, {-70, -30}, {-70, -48}, {-80, -48}, {-80, -50}}, color = {0, 127, 255}));
  connect(IPT.port_b, flowSink.ports[1]) annotation(
    Line(points = {{-20, -50}, {-80, -50}, {-80, -50}, {-80, -50}}, color = {0, 127, 255}));
  connect(multiPort3.ports_b[2], IP_RS.port_a) annotation(
    Line(points = {{60, -30}, {22, -30}, {22, -30}, {20, -30}, {20, -30}}, color = {0, 127, 255}, thickness = 0.5));
  connect(multiPort3.ports_b[1], IPT.port_a) annotation(
    Line(points = {{60, -30}, {46, -30}, {46, -50}, {0, -50}, {0, -50}}, color = {0, 127, 255}, thickness = 0.5));
  connect(HPT.outlet, multiPort2.ports_b[1]) annotation(
    Line(points = {{-6, 40}, {-40, 40}, {-40, 19.5}, {-76, 19.5}}, color = {0, 0, 255}));
  connect(HP_RS.flowOut, multiPort2.ports_b[2]) annotation(
    Line(points = {{-8, 62}, {-48, 62}, {-48, 19.5}, {-76, 19.5}}, color = {0, 127, 255}));
  connect(multiPort2.port_a, CRH) annotation(
    Line(points = {{-84, 19.5}, {-85, 19.5}, {-85, 20}, {-100, 20}}, color = {0, 127, 255}));
  connect(BROU_pos_table.y[4], IPT.opening) annotation(
    Line(points = {{-78, 90}, {-60, 90}, {-60, -20}, {-10, -20}, {-10, -42}, {-10, -42}}, color = {0, 0, 127}, thickness = 0.5));
  connect(IP_pressure_control.y, IP_RS.opening) annotation(
    Line(points = {{30, -12}, {30, -12}, {30, -20}, {10, -20}, {10, -22}}, color = {0, 0, 127}));
  connect(IPT.opening_actual, IP_pressure_control.u3) annotation(
    Line(points = {{-17, -48}, {-18, -48}, {-18, 16}, {28, 16}, {28, 10}}, color = {0, 0, 127}));
  connect(IP_RS.opening_actual, IP_pressure_control.u1) annotation(
    Line(points = {{4, -28}, {0, -28}, {0, 12}, {24, 12}, {24, 10}}, color = {0, 0, 127}));
  connect(IP_pressure.p, IP_pressure_control.u2) annotation(
    Line(points = {{60, 22}, {36, 22}, {36, 10}, {36, 10}}, color = {0, 0, 127}));
  connect(HRH, IP_pressure.port) annotation(
    Line(points = {{98, -30}, {70, -30}, {70, 12}, {70, 12}}));
  connect(HRH, multiPort3.port_a) annotation(
    Line(points = {{98, -30}, {68, -30}, {68, -30}, {68, -30}}));
  connect(check_valve_pos, IP_pressure_control.u4) annotation(
    Line(points = {{104, 0}, {42, 0}, {42, 2}, {42, 2}}, color = {255, 0, 255}));
  connect(IP_pressure_control.y2, booleanToReal2.u) annotation(
    Line(points = {{40, -12}, {38, -12}, {38, -70}, {58, -70}, {58, -70}}, color = {255, 0, 255}));
  connect(booleanToReal2.y, HRH_vent_valv_pos) annotation(
    Line(points = {{82, -70}, {98, -70}, {98, -70}, {106, -70}}, color = {0, 0, 127}));
  connect(HP_pressure_control.y2, booleanToReal1.u) annotation(
    Line(points = {{22, 70}, {22, 70}, {22, 66}, {66, 66}, {66, 68}}, color = {255, 0, 255}));
  connect(booleanToReal1.y, HP_vent_valv_pos) annotation(
    Line(points = {{66, 92}, {66, 92}, {66, 104}, {66, 104}}, color = {0, 0, 127}));
  connect(HP, HP_pressure.port) annotation(
    Line(points = {{98, 40}, {90, 40}, {90, 60}}));
  connect(booleanConst.y, HP_pressure_control.u4) annotation(
    Line(points = {{-78, 70}, {-14, 70}, {-14, 86}, {18, 86}, {18, 86}}, color = {255, 0, 255}));
  connect(set_T_HPRS.y, HP_RS.T_in) annotation(
    Line(points = {{-24, 78}, {-6, 78}, {-6, 70}, {-6, 70}}, color = {0, 0, 127}));
  connect(HP_pressure_control.y, HP_RS.opening) annotation(
    Line(points = {{30, 70}, {30, 70}, {30, 64}, {16, 64}, {16, 72}, {6, 72}, {6, 70}}, color = {0, 0, 127}));
  connect(BROU_pos_table.y[2], HPCV.opening) annotation(
    Line(points = {{-78, 90}, {-58, 90}, {-58, 54}, {30, 54}, {30, 48}, {30, 48}}, color = {0, 0, 127}, thickness = 0.5));
  connect(cooling_water, HP_RS.waterIn) annotation(
    Line(points = {{-100, 50}, {-2, 50}, {-2, 52}, {-2, 52}}));
  connect(multiPort1.ports_b[2], HP_RS.flowIn) annotation(
    Line(points = {{60, 40}, {44, 40}, {44, 62}, {12, 62}, {12, 62}}, color = {0, 127, 255}, thickness = 0.5));
  connect(HPCV.port_b, HPT.inlet) annotation(
    Line(points = {{20, 40}, {10, 40}, {10, 40}, {10, 40}}, color = {0, 127, 255}));
  connect(multiPort1.ports_b[1], HPCV.port_a) annotation(
    Line(points = {{60, 40}, {40, 40}, {40, 40}, {40, 40}}, color = {0, 127, 255}, thickness = 0.5));
  connect(HP, multiPort1.port_a) annotation(
    Line(points = {{98, 40}, {68, 40}, {68, 40}, {68, 40}}));
  connect(HPCV.opening_actual, HP_pressure_control.u3) annotation(
    Line(points = {{24, 42}, {18, 42}, {18, 56}, {50, 56}, {50, 98}, {32, 98}, {32, 92}, {32, 92}}, color = {0, 0, 127}));
  connect(HP_RS.opening_actual, HP_pressure_control.u1) annotation(
    Line(points = {{0, 66}, {0, 66}, {0, 96}, {36, 96}, {36, 92}, {36, 92}}, color = {0, 0, 127}));
  connect(HP_drum_p, HP_pressure_control.u2) annotation(
    Line(points = {{-40, 104}, {-40, 104}, {-40, 92}, {-4, 92}, {-4, 98}, {24, 98}, {24, 92}, {24, 92}}, color = {0, 0, 127}));
  connect(HPT.shaft_b, constSpeed.flange) annotation(
    Line(points = {{-4.4, 32}, {-11.4, 32}, {-11.4, 31}, {-18.4, 31}}));
  annotation(Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}}, initialScale = 0.1)), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end dummy_ST;
