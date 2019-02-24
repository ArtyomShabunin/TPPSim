within TPPSim.Boilers.Tests;

model ThreePVerticalHRSG_Test
  extends TPPSim.Boilers.Tests.ThreePVerticalHRSG_Test_partial(ST.Kv_HP_RS = 355, HP_pressure_control.set_p = 1.262e+07, derN_set.k = 15e6 / 60, IP_pressure_control.set_p = 200000, LP_pressure_control.set_p = 150000);
  TPPSim.Boilers.ThreePVerticalHRSG Boiler annotation(
    Placement(visible = true, transformation(origin = {30, -20}, extent = {{20, -30}, {-20, 30}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant derP_set_1(k = 3e5 / 60) annotation(
    Placement(visible = true, transformation(origin = {-134, -68}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant derP_set_2(k = 6e5 / 60) annotation(
    Placement(visible = true, transformation(origin = {-134, -86}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {-112, -78}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 20e5)  annotation(
    Placement(visible = true, transformation(origin = {-134, -46}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Less less1 annotation(
    Placement(visible = true, transformation(origin = {-111, -56}, extent = {{-7, -8}, {7, 8}}, rotation = 0)));
equation
  connect(HP_pressure_control.y2, Boiler.HP_vent_pos) annotation(
    Line(points = {{-40, -66}, {-38, -66}, {-38, -84}, {60, -84}, {60, 14}, {42, 14}, {42, 10}, {42, 10}}, color = {0, 0, 127}));
  connect(derN_set.y, GT.derN_set) annotation(
    Line(points = {{-88, -40}, {-82, -40}, {-82, -34}, {-64, -34}, {-64, -36}, {-62, -36}}, color = {0, 0, 127}));
  connect(less1.y, switch1.u2) annotation(
    Line(points = {{-104, -56}, {-102, -56}, {-102, -68}, {-122, -68}, {-122, -78}, {-120, -78}, {-120, -78}}, color = {255, 0, 255}));
  connect(Boiler.HP_p_drum, less1.u1) annotation(
    Line(points = {{50, 4}, {52, 4}, {52, 22}, {-120, 22}, {-120, -56}, {-120, -56}}, color = {0, 0, 127}));
  connect(const2.y, less1.u2) annotation(
    Line(points = {{-128, -46}, {-124, -46}, {-124, -62}, {-120, -62}, {-120, -62}}, color = {0, 0, 127}));
  connect(switch1.y, HP_pressure_control.p_speed_in) annotation(
    Line(points = {{-106, -78}, {-44, -78}, {-44, -52}, {-36, -52}, {-36, -54}, {-36, -54}}, color = {0, 0, 127}));
  connect(derP_set_1.y, switch1.u1) annotation(
    Line(points = {{-128, -68}, {-124, -68}, {-124, -72}, {-120, -72}, {-120, -74}}, color = {0, 0, 127}));
  connect(derP_set_2.y, switch1.u3) annotation(
    Line(points = {{-128, -86}, {-124, -86}, {-124, -82}, {-120, -82}, {-120, -82}}, color = {0, 0, 127}));
  connect(GT.flowOut, Boiler.gasIn) annotation(
    Line(points = {{-56, -46}, {-42, -46}, {-42, -42}, {10, -42}, {10, -42}}, color = {0, 127, 255}));
  connect(Boiler.LP_Out, LP_pipe.waterIn) annotation(
    Line(points = {{10, -18}, {10, -18}, {10, -14}, {8, -14}}, color = {0, 127, 255}));
  connect(Boiler.HP_p_drum, HP_pressure_control.u2) annotation(
    Line(points = {{50, 4}, {54, 4}, {54, -50}, {-4, -50}, {-4, -58}, {-26, -58}, {-26, -50}, {-38, -50}, {-38, -54}, {-38, -54}}, color = {0, 0, 127}));
  connect(Boiler.check_valve_pos, IP_pressure_control.u4) annotation(
    Line(points = {{10, -20}, {8, -20}, {8, -18}, {-12, -18}, {-12, -64}, {0, -64}, {0, -64}}, color = {255, 0, 255}));
  connect(booleanToReal1.y, Boiler.RH_vent_pos) annotation(
    Line(points = {{44, -62}, {56, -62}, {56, 10}, {50, 10}, {50, 10}}, color = {0, 0, 127}));
  connect(flowSource.ports[1], Boiler.cond_In) annotation(
    Line(points = {{76, -8}, {58, -8}, {58, -12}, {50, -12}, {50, -10}}, color = {0, 127, 255}, thickness = 0.5));
  connect(Boiler.RH_Out, HRH_pipe.waterIn) annotation(
    Line(points = {{10, -32}, {6, -32}, {6, -36}, {2, -36}, {2, -34}}, color = {0, 127, 255}));
  connect(HP_pipe.waterIn, Boiler.HP_Out) annotation(
    Line(points = {{2, -26}, {6, -26}, {6, -30}, {10, -30}, {10, -28}}, color = {0, 127, 255}));
  connect(Boiler.RH_In, CRH_pipe.waterOut) annotation(
    Line(points = {{10, -24}, {8, -24}, {8, -20}, {4, -20}, {4, -20}}, color = {0, 127, 255}));
  annotation(
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
    experiment(StartTime = 0, StopTime = 20000, Tolerance = 1.5e-2, Interval = 10));
end ThreePVerticalHRSG_Test;
