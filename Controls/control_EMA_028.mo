within TPPSim.Controls;

block control_EMA_028
  TPPSim.Controls.pressure_control_2 HP_pressure_control(P_activation = 300000, T = 20, k = 0.000001, pos_start = 0.01, set_p = 6.7e+06, speed_p = 1e5 / 60) annotation(
    Placement(visible = true, transformation(origin = {-30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  TPPSim.Controls.pressure_control_3 IP_pressure_control(P_activation = 300000, T = 35, k = 0.000005, pos_start = 0.01, set_p = 2e+06, speed_p = 0.4e5 / 60) annotation(
    Placement(visible = true, transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(k = false) annotation(
    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1(realFalse = 1, realTrue = 0) annotation(
    Placement(visible = true, transformation(origin = {52, -34}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal2(realFalse = 1, realTrue = 0) annotation(
    Placement(visible = true, transformation(origin = {66, -22}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant set_T_HPRS(k = 300 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {15, -39}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant HP_CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-37, -43}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus sensorBus annotation(
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(HP_pressure_control.u1, sensorBus.HP_RS_apos) annotation(
    Line(points = {{-24, 62}, {-24, 62}, {-24, 72}, {-70, 72}, {-70, 90}, {-70, 90}}, color = {0, 0, 127}));
  connect(HP_pressure_control.u3, sensorBus.HP_CV_apos) annotation(
    Line(points = {{-28, 62}, {-28, 62}, {-28, 72}, {-70, 72}, {-70, 90}, {-70, 90}}, color = {0, 0, 127}));
  connect(HP_pressure_control.u2, sensorBus.HP_p_sensor) annotation(
    Line(points = {{-36, 62}, {-36, 62}, {-36, 72}, {-70, 72}, {-70, 90}, {-70, 90}}, color = {0, 0, 127}));
  connect(booleanConstant1.y, HP_pressure_control.u4) annotation(
    Line(points = {{-60, 50}, {-54, 50}, {-54, 54}, {-42, 54}, {-42, 56}}, color = {255, 0, 255}));

end control_EMA_028;