within TPPSim.Boilers.Tests;

model ThreePVerticalHRSG_Test
  extends TPPSim.Boilers.Tests.ThreePVerticalHRSG_Test_partial;
  TPPSim.Boilers.ThreePVerticalHRSG Boiler annotation(
    Placement(visible = true, transformation(origin = {30, -20}, extent = {{20, -30}, {-20, 30}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID PID(controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialOutput, k = 4e6 / 60, yMax = 4e6 / 60, yMin = 0, y_start = 4e6 / 60)  annotation(
    Placement(visible = true, transformation(origin = {-75, -91}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.95)  annotation(
    Placement(visible = true, transformation(origin = {-102, -106}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(PID.y, GT.derN_set) annotation(
    Line(points = {{-68, -90}, {-66, -90}, {-66, -58}, {-84, -58}, {-84, -34}, {-62, -34}, {-62, -36}}, color = {0, 0, 127}));
  connect(ST.HP_RS_apos, PID.u_m) annotation(
    Line(points = {{-50, -30}, {-50, -104}, {-74, -104}, {-74, -99}, {-75, -99}}, color = {0, 0, 127}));
  connect(const.y, PID.u_s) annotation(
    Line(points = {{-90, -106}, {-88, -106}, {-88, -90}, {-83, -90}, {-83, -91}}, color = {0, 0, 127}));
  connect(GT.flowOut, Boiler.gasIn) annotation(
    Line(points = {{-56, -46}, {-42, -46}, {-42, -42}, {10, -42}, {10, -42}}, color = {0, 127, 255}));
  connect(Boiler.LP_Out, LP_pipe.waterIn) annotation(
    Line(points = {{10, -18}, {10, -18}, {10, -14}, {8, -14}}, color = {0, 127, 255}));
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
  connect(Boiler.RH_Out, HRH_pipe.waterIn) annotation(
    Line(points = {{10, -32}, {6, -32}, {6, -36}, {2, -36}, {2, -34}}, color = {0, 127, 255}));
  connect(HP_pipe.waterIn, Boiler.HP_Out) annotation(
    Line(points = {{2, -26}, {6, -26}, {6, -30}, {10, -30}, {10, -28}}, color = {0, 127, 255}));
  connect(Boiler.RH_In, CRH_pipe.waterOut) annotation(
    Line(points = {{10, -24}, {8, -24}, {8, -20}, {4, -20}, {4, -20}}, color = {0, 127, 255}));
  annotation(
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
    experiment(StartTime = 0, StopTime = 20000, Tolerance = 1e-2, Interval = 10));
end ThreePVerticalHRSG_Test;
