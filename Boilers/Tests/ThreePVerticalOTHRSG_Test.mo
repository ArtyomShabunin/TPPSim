within TPPSim.Boilers.Tests;

model ThreePVerticalOTHRSG_Test
  extends TPPSim.Boilers.Tests.ThreePVerticalHRSG_Test_partial(ST.Kv_HP_RS = 275, HP_pressure_control.set_p = 1.75e+07, HP_pressure_control.use_p_speed_in = false, HP_pressure_control.k = 0.000005);
  TPPSim.Boilers.ThreePVerticalOTHRSG Boiler annotation(
    Placement(visible = true, transformation(origin = {30, -20}, extent = {{20, -30}, {-20, 30}}, rotation = 0)));
equation
  connect(HP_pressure_control.y2, Boiler.HP_vent_pos) annotation(
    Line(points = {{-40, -66}, {-36, -66}, {-36, -78}, {60, -78}, {60, 14}, {42, 14}, {42, 10}, {42, 10}}, color = {0, 0, 127}));
  connect(derN_set.y, GT.derN_set) annotation(
    Line(points = {{-88, -40}, {-84, -40}, {-84, -34}, {-64, -34}, {-64, -36}, {-62, -36}}, color = {0, 0, 127}));
  connect(LP_pipe.waterIn, Boiler.LP_Out) annotation(
    Line(points = {{8, -14}, {10, -14}, {10, -18}, {10, -18}}, color = {0, 127, 255}));
  connect(GT.flowOut, Boiler.gasIn) annotation(
    Line(points = {{-56, -42}, {10, -42}, {10, -42}, {10, -42}}, color = {0, 127, 255}));
  connect(flowSource.ports[1], Boiler.cond_In) annotation(
    Line(points = {{76, -8}, {56, -8}, {56, -12}, {50, -12}, {50, -10}}, color = {0, 127, 255}, thickness = 0.5));
  connect(Boiler.HP_p_drum, HP_pressure_control.u2) annotation(
    Line(points = {{50, 4}, {52, 4}, {52, -90}, {-44, -90}, {-44, -50}, {-38, -50}, {-38, -54}, {-38, -54}}, color = {0, 0, 127}));
  connect(Boiler.check_valve_pos, IP_pressure_control.u4) annotation(
    Line(points = {{10, -20}, {6, -20}, {6, -14}, {-12, -14}, {-12, -64}, {0, -64}, {0, -64}}, color = {255, 0, 255}));
  connect(Boiler.RH_Out, HRH_pipe.waterIn) annotation(
    Line(points = {{10, -32}, {2, -32}, {2, -34}, {2, -34}}, color = {0, 127, 255}));
  connect(Boiler.HP_Out, HP_pipe.waterIn) annotation(
    Line(points = {{10, -28}, {2, -28}, {2, -26}, {2, -26}}, color = {0, 127, 255}));
  connect(Boiler.RH_In, CRH_pipe.waterOut) annotation(
    Line(points = {{10, -24}, {6, -24}, {6, -22}, {4, -22}, {4, -20}}, color = {0, 127, 255}));
  connect(booleanToReal1.y, Boiler.RH_vent_pos) annotation(
    Line(points = {{44, -62}, {58, -62}, {58, 12}, {50, 12}, {50, 10}, {50, 10}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-140, -100}, {100, 100}})),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
    experiment(StartTime = 0, StopTime = 15000, Tolerance = 1e-2, Interval = 10));
end ThreePVerticalOTHRSG_Test;
