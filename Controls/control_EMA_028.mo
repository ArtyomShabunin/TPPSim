within TPPSim.Controls;

block control_EMA_028
  TPPSim.Controls.pressure_control_2 HP_pressure_control(P_activation = 300000, T = 20, k = 0.000001, pos_start = 0.01, set_p = 6.7e+06, speed_p = 1e5 / 60) annotation(
    Placement(visible = true, transformation(origin = {-30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Controls.pressure_control_3 IP_pressure_control(P_activation = 300000, T = 35, k = 0.000005, pos_start = 0.01, set_p = 2e+06, speed_p = 0.4e5 / 60) annotation(
    Placement(visible = true, transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(k = false) annotation(
    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1(realFalse = 1, realTrue = 0) annotation(
    Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal2(realFalse = 1, realTrue = 0) annotation(
    Placement(visible = true, transformation(origin = {50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant LP_CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus sensorBus annotation(
    Placement(visible = true, transformation(origin = {-70, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus actuatorsBus annotation(
    Placement(visible = true, transformation(origin = {70, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(LP_CV_const.y, actuatorsBus.LP_CV_pos) annotation(
    Line(points = {{62, -30}, {70, -30}, {70, 100}, {70, 100}}, color = {0, 0, 127}));
  connect(booleanToReal1.y, actuatorsBus.HP_vent_pos) annotation(
    Line(points = {{2, 10}, {12, 10}, {12, -8}, {70, -8}, {70, 100}, {70, 100}}, color = {0, 0, 127}));
  connect(booleanToReal2.y, actuatorsBus.IP_vent_pos) annotation(
    Line(points = {{62, 10}, {70, 10}, {70, 100}, {70, 100}}, color = {0, 0, 127}));
  connect(IP_pressure_control.y, actuatorsBus.IP_RS_pos) annotation(
    Line(points = {{30, 40}, {30, 40}, {30, 32}, {70, 32}, {70, 100}, {70, 100}}, color = {0, 0, 127}));
  connect(HP_pressure_control.y, actuatorsBus.HP_RS_pos) annotation(
    Line(points = {{-30, 40}, {-30, 40}, {-30, 32}, {70, 32}, {70, 100}, {70, 100}}, color = {0, 0, 127}));
  connect(IP_pressure_control.y2, booleanToReal2.u) annotation(
    Line(points = {{22, 40}, {22, 40}, {22, 10}, {38, 10}, {38, 10}}, color = {255, 0, 255}));
  connect(IP_pressure_control.u4, sensorBus.check_valve_pos) annotation(
    Line(points = {{18, 54}, {0, 54}, {0, 80}, {-70, 80}, {-70, 100}}, color = {255, 0, 255}));
  connect(IP_pressure_control.u1, sensorBus.IP_RS_apos) annotation(
    Line(points = {{36, 62}, {36, 76}, {-70, 76}, {-70, 100}}, color = {0, 0, 127}));
  connect(IP_pressure_control.u3, sensorBus.IP_CV_apos) annotation(
    Line(points = {{32, 62}, {32, 76}, {-70, 76}, {-70, 100}}, color = {0, 0, 127}));
  connect(IP_pressure_control.u2, sensorBus.IP_p_sensor) annotation(
    Line(points = {{24, 62}, {24, 76}, {-70, 76}, {-70, 100}}, color = {0, 0, 127}));
  connect(HP_pressure_control.u1, sensorBus.HP_RS_apos) annotation(
    Line(points = {{-24, 62}, {-24, 72}, {-70, 72}, {-70, 100}}, color = {0, 0, 127}));
  connect(HP_pressure_control.u3, sensorBus.HP_CV_apos) annotation(
    Line(points = {{-28, 62}, {-28, 72}, {-70, 72}, {-70, 100}}, color = {0, 0, 127}));
  connect(HP_pressure_control.u2, sensorBus.HP_p_sensor) annotation(
    Line(points = {{-36, 62}, {-36, 72}, {-70, 72}, {-70, 100}}, color = {0, 0, 127}));
  connect(HP_pressure_control.y2, booleanToReal1.u) annotation(
    Line(points = {{-38, 40}, {-38, 40}, {-38, 10}, {-22, 10}, {-22, 10}}, color = {255, 0, 255}));
  connect(booleanConstant1.y, HP_pressure_control.u4) annotation(
    Line(points = {{-60, 50}, {-54, 50}, {-54, 54}, {-42, 54}, {-42, 56}}, color = {255, 0, 255}));
end control_EMA_028;