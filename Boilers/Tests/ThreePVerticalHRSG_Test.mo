within TPPSim.Boilers.Tests;

model ThreePVerticalHRSG_Test
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  package Medium_G = TPPSim.Media.ExhaustGas;
  inner Modelica.Fluid.System system(T_start = 60 + 273.15, allowFlowReversal = false, m_flow_small = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Gas_turbine.simple_startupGT GT(redeclare package Medium = Medium_G, Gnom = 2920.4 / 3.6, Tnom = 630.9 + 273.15, Tstart = system.T_start) annotation(
    Placement(visible = true, transformation(origin = {-66, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant LP_CV_const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-27, 29}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant IP_CV_const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-27, 45}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant HP_CV_const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-69, 61}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary flowSource(redeclare package Medium = Medium_F, T = 30 + 273.15, nPorts = 2, p = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {86, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Boilers.ThreePVerticalHRSG Boiler annotation(
    Placement(visible = true, transformation(origin = {30, -20}, extent = {{20, -30}, {-20, 30}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant HP_vent_const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {33, 33}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Steam_turbine.dummy_ST ST annotation(
    Placement(visible = true, transformation(origin = {-46, -10}, extent = {{-30, -20}, {30, 20}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HP_pipe(Din = 0.377, Lpipe = 155, delta = 0.05, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-1, -27}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe CRH_pipe(Din = 0.48, Lpipe = 65, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {1, -21}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Pipes.ComplexPipe HRH_pipe(Din = 0.48, Lpipe = 92.8, delta = 0.025, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, n_parallel = 1, numberOfVolumes = 2) annotation(
    Placement(visible = true, transformation(origin = {-1, -35}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant RH_vent_const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {59, 33}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant IP_RS_cons(k = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-27, 61}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant set_T_HPRS(k = 300 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-69, 45}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant HP_RS_const(k = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-69, 29}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Controls.pressure_control_2 HP_pressure_control(P_activation = 300000, T = 20, k = 0.000001, pos_start = 0.05, set_p = 1.7e+07, speed_p = 1e5 / 60) annotation(
    Placement(visible = true, transformation(origin = {-35, -61}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));
  Modelica.Fluid.Sensors.Pressure HP_p(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-23, -47}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(k = false) annotation(
    Placement(visible = true, transformation(origin = {-53, -59}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  TPPSim.Controls.pressure_control_3 IP_pressure_control(P_activation = 200000, T = 35, k = 0.000001, pos_start = 0.05, set_p = 3.5e+06, speed_p = 0.4e5 / 60) annotation(
    Placement(visible = true, transformation(origin = {5, -65}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));
  Modelica.Fluid.Sensors.Pressure IP_p(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-9, -53}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  TPPSim.Controls.pressure_control_3 LP_pressure_control(P_activation = 150000, T = 35, k = 0.00005, pos_start = 0.01, set_p = 520000, speed_p = 220) annotation(
    Placement(visible = true, transformation(origin = {-3, 43}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));
  Modelica.Fluid.Sensors.Pressure LP_p(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {11, 27}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
equation
  connect(flowSource.ports[1], Boiler.cond_In) annotation(
    Line(points = {{76, -8}, {65, -8}, {65, -10}, {50, -10}}, color = {0, 127, 255}, thickness = 0.5));
  connect(flowSource.ports[2], ST.cooling_water) annotation(
    Line(points = {{76, -8}, {64, -8}, {64, 18}, {-12, 18}, {-12, 0}, {-16, 0}, {-16, 2}}, color = {0, 127, 255}, thickness = 0.5));
  connect(IP_p.p, IP_pressure_control.u2) annotation(
    Line(points = {{-6, -52}, {2, -52}, {2, -58}, {2, -58}}, color = {0, 0, 127}));
  connect(Boiler.HP_p_drum, HP_pressure_control.u2) annotation(
    Line(points = {{50, 4}, {58, 4}, {58, -84}, {-44, -84}, {-44, -46}, {-38, -46}, {-38, -54}, {-38, -54}}, color = {0, 0, 127}));
  connect(LP_pressure_control.y2, LP_pressure_control.u4) annotation(
    Line(points = {{-8, 38}, {-10, 38}, {-10, 44}, {-8, 44}, {-8, 44}}, color = {255, 0, 255}));
  connect(LP_pressure_control.y, ST.LP_CV_pos) annotation(
    Line(points = {{-3, 37.5}, {-2, 37.5}, {-2, 22}, {-18, 22}, {-18, 18}, {-38, 18}, {-38, 10}}, color = {0, 0, 127}));
  connect(LP_p.p, LP_pressure_control.u2) annotation(
    Line(points = {{14, 28}, {18, 28}, {18, 56}, {-6, 56}, {-6, 49}}, color = {0, 0, 127}));
  connect(IP_CV_const.y, LP_pressure_control.u3) annotation(
    Line(points = {{-32, 46}, {-36, 46}, {-36, 38}, {-14, 38}, {-14, 52}, {-2, 52}, {-2, 49}}, color = {0, 0, 127}));
  connect(IP_CV_const.y, LP_pressure_control.u1) annotation(
    Line(points = {{-32, 46}, {-36, 46}, {-36, 38}, {-14, 38}, {-14, 52}, {0, 52}, {0, 49}}, color = {0, 0, 127}));
  connect(Boiler.check_valve_pos, IP_pressure_control.u4) annotation(
    Line(points = {{10, -20}, {-12, -20}, {-12, -64}, {0, -64}, {0, -64}}, color = {255, 0, 255}));
  connect(Boiler.LP_Out, LP_p.port) annotation(
    Line(points = {{10, -18}, {6, -18}, {6, 24}, {12, 24}, {12, 24}}, color = {0, 127, 255}));
  connect(IP_pressure_control.y, ST.IP_RS_pos) annotation(
    Line(points = {{6, -70}, {6, -70}, {6, -80}, {-86, -80}, {-86, 16}, {-44, 16}, {-44, 10}, {-44, 10}}, color = {0, 0, 127}));
  connect(HRH_pipe.waterOut, IP_p.port) annotation(
    Line(points = {{-4, -34}, {-6, -34}, {-6, -56}, {-8, -56}, {-8, -56}}, color = {0, 127, 255}));
  connect(ST.IP_CV_apos, IP_pressure_control.u3) annotation(
    Line(points = {{-44, -30}, {-44, -30}, {-44, -32}, {-22, -32}, {-22, -40}, {-10, -40}, {-10, -44}, {4, -44}, {4, -54}, {6, -54}, {6, -58}, {6, -58}}, color = {0, 0, 127}));
  connect(ST.IP_RS_apos, IP_pressure_control.u1) annotation(
    Line(points = {{-46, -30}, {-46, -30}, {-46, -34}, {-8, -34}, {-8, -40}, {6, -40}, {6, -52}, {8, -52}, {8, -58}, {8, -58}}, color = {0, 0, 127}));
  connect(HP_pipe.waterOut, HP_p.port) annotation(
    Line(points = {{-4, -26}, {-14, -26}, {-14, -50}, {-22, -50}, {-22, -50}}, color = {0, 127, 255}));
  connect(booleanConstant1.y, HP_pressure_control.u4) annotation(
    Line(points = {{-47, -59}, {-45, -59}, {-45, -58}, {-40, -58}}, color = {255, 0, 255}));
  connect(HP_pressure_control.y, ST.HP_RS_pos) annotation(
    Line(points = {{-34, -66}, {-36, -66}, {-36, -70}, {-80, -70}, {-80, 14}, {-54, 14}, {-54, 10}, {-52, 10}}, color = {0, 0, 127}));
  connect(ST.HP_RS_apos, HP_pressure_control.u1) annotation(
    Line(points = {{-50, -30}, {-50, -36}, {-32, -36}, {-32, -55}}, color = {0, 0, 127}));
  connect(ST.HP_CV_apos, HP_pressure_control.u3) annotation(
    Line(points = {{-52, -30}, {-52, -38}, {-34, -38}, {-34, -55}}, color = {0, 0, 127}));
  connect(set_T_HPRS.y, ST.RP_RS_t) annotation(
    Line(points = {{-63.5, 45}, {-56.5, 45}, {-56.5, 47}, {-49.5, 47}, {-49.5, 11}, {-49.5, 11}, {-49.5, 9}, {-49.5, 9}}, color = {0, 0, 127}));
  connect(RH_vent_const.y, Boiler.RH_vent_pos) annotation(
    Line(points = {{53.5, 33}, {51.75, 33}, {51.75, 33}, {50, 33}, {50, 21.5}, {50, 21.5}, {50, 10}}, color = {0, 0, 127}));
  connect(Boiler.RH_Out, HRH_pipe.waterIn) annotation(
    Line(points = {{10, -32.6}, {8, -32.6}, {8, -32.6}, {6, -32.6}, {6, -35.6}, {4.5, -35.6}, {4.5, -35.6}, {3, -35.6}}, color = {0, 127, 255}));
  connect(HRH_pipe.waterOut, ST.HRH) annotation(
    Line(points = {{-4.63, -35}, {-6.13, -35}, {-6.13, -35}, {-7.63, -35}, {-7.63, 12}, {-57.63, 12}, {-57.63, 11}, {-57.63, 11}, {-57.63, 10}}, color = {0, 127, 255}));
  connect(Boiler.RH_In, CRH_pipe.waterOut) annotation(
    Line(points = {{9.8, -24.4}, {7.8, -24.4}, {7.8, -24.4}, {5.8, -24.4}, {5.8, -21.4}, {5.3, -21.4}, {5.3, -21.4}, {4.8, -21.4}}, color = {0, 127, 255}));
  connect(ST.CRH, CRH_pipe.waterIn) annotation(
    Line(points = {{-75.6, 10}, {-75.6, 10}, {-75.6, 10}, {-75.6, 10}, {-75.6, 20}, {-1.6, 20}, {-1.6, -20}, {-1.6, -20}, {-1.6, -20}, {-1.6, -20}}, color = {0, 127, 255}));
  connect(Boiler.HP_Out, HP_pipe.waterIn) annotation(
    Line(points = {{10, -29}, {6, -29}, {6, -27}, {2, -27}, {2, -25}, {2, -25}, {2, -27}, {2, -27}}, color = {0, 127, 255}));
  connect(HP_pipe.waterOut, ST.HP) annotation(
    Line(points = {{-4.63, -27}, {-5.63, -27}, {-5.63, -25}, {-4.63, -25}, {-4.63, 17}, {-60.63, 17}, {-60.63, 11}, {-62.63, 11}, {-62.63, 9}, {-62.63, 9}}, color = {0, 127, 255}));
  connect(Boiler.LP_Out, ST.LP) annotation(
    Line(points = {{10, -17.2}, {8, -17.2}, {8, -17.2}, {6, -17.2}, {6, 14.8}, {-28, 14.8}, {-28, 10.8}, {-28, 10.8}, {-28, 10.8}, {-28, 10.8}}, color = {0, 127, 255}));
  connect(HP_CV_const.y, ST.HP_CV_pos) annotation(
    Line(points = {{-63.5, 61}, {-46, 61}, {-46, 10}}, color = {0, 0, 127}));
  connect(IP_CV_const.y, ST.IP_CV_pos) annotation(
    Line(points = {{-32.5, 45}, {-36.25, 45}, {-36.25, 45}, {-40, 45}, {-40, 27.5}, {-40, 27.5}, {-40, 10}}, color = {0, 0, 127}));
  connect(HP_vent_const.y, Boiler.HP_vent_pos) annotation(
    Line(points = {{38.5, 33}, {40.25, 33}, {40.25, 33}, {42, 33}, {42, 21.5}, {42, 21.5}, {42, 10}}, color = {0, 0, 127}));
  connect(GT.flowOut, Boiler.gasIn) annotation(
    Line(points = {{-56, -42}, {10, -42}}, color = {0, 127, 255}));
  annotation(
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end ThreePVerticalHRSG_Test;
