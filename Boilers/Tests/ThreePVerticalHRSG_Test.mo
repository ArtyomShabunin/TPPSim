within TPPSim.Boilers.Tests;

model ThreePVerticalHRSG_Test
  extends TPPSim.Boilers.Tests.ThreePVerticalHRSG_Test_partial;
  TPPSim.Boilers.ThreePVerticalHRSG Boiler annotation(
    Placement(visible = true, transformation(origin = {30, -20}, extent = {{20, -30}, {-20, 30}}, rotation = 0)));
equation
  connect(Boiler.HP_p_drum, HP_pressure_control.u2) annotation(
    Line(points = {{50, 4}, {54, 4}, {54, -50}, {-4, -50}, {-4, -58}, {-26, -58}, {-26, -50}, {-38, -50}, {-38, -54}, {-38, -54}}, color = {0, 0, 127}));
  connect(Boiler.check_valve_pos, IP_pressure_control.u4) annotation(
    Line(points = {{10, -20}, {8, -20}, {8, -18}, {-12, -18}, {-12, -64}, {0, -64}, {0, -64}}, color = {255, 0, 255}));
  connect(booleanToReal2.y, Boiler.HP_vent_pos) annotation(
    Line(points = {{44, -82}, {60, -82}, {60, 14}, {42, 14}, {42, 10}, {42, 10}}, color = {0, 0, 127}));
  connect(booleanToReal1.y, Boiler.RH_vent_pos) annotation(
    Line(points = {{44, -62}, {56, -62}, {56, 10}, {50, 10}, {50, 10}}, color = {0, 0, 127}));
  connect(flowSource.ports[1], Boiler.cond_In) annotation(
    Line(points = {{76, -8}, {58, -8}, {58, -12}, {50, -12}, {50, -10}}, color = {0, 127, 255}, thickness = 0.5));
  connect(GT.flowOut, Boiler.gasIn) annotation(
    Line(points = {{-56, -42}, {10, -42}, {10, -42}, {10, -42}}, color = {0, 127, 255}));
  connect(Boiler.RH_Out, HRH_pipe.waterIn) annotation(
    Line(points = {{10, -32}, {6, -32}, {6, -36}, {2, -36}, {2, -34}}, color = {0, 127, 255}));
  connect(HP_pipe.waterIn, Boiler.HP_Out) annotation(
    Line(points = {{2, -26}, {6, -26}, {6, -30}, {10, -30}, {10, -28}}, color = {0, 127, 255}));
  connect(Boiler.RH_In, CRH_pipe.waterOut) annotation(
    Line(points = {{10, -24}, {8, -24}, {8, -20}, {4, -20}, {4, -20}}, color = {0, 127, 255}));
  connect(Boiler.LP_Out, ST.LP) annotation(
    Line(points = {{10, -18}, {2, -18}, {2, 14}, {-28, 14}, {-28, 10}, {-28, 10}}, color = {0, 127, 255}));
  annotation(
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end ThreePVerticalHRSG_Test;
