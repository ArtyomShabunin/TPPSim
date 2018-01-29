within TPPSim.Valves;
model ReducingStation
  extends TPPSim.Valves.BaseClases.Icons.IconReducingStation;
  replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  //Параметры клапана
  parameter Modelica.Fluid.Types.CvTypes CvData=Modelica.Fluid.Types.CvTypes.OpPoint
    "Selection of flow coefficient"
   annotation(Dialog(group = "Параметры клапана"));
  parameter Real Kv = 0 "Kv (metric) flow coefficient [m3/h]"
  annotation(Dialog(group = "Параметры клапана",
                    enable = (CvData==Modelica.Fluid.Types.CvTypes.Kv)));
  parameter Modelica.SIunits.AbsolutePressure dp_nominal annotation(
    Dialog(group = "Параметры клапана"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal annotation(
    Dialog(group = "Параметры клапана"));
  parameter Modelica.SIunits.AbsolutePressure p_nominal annotation(
    Dialog(group = "Параметры клапана"));
  parameter Modelica.SIunits.Density rho_nominal annotation(
    Dialog(group = "Параметры клапана"));
  //Параметры пароохладителя
  parameter Boolean use_T_in = false "Ипользвать порт 'T_in' для задания температуры за БРОУ" annotation(
    Dialog(group = "Параметры пароохладителя")); 
  parameter Modelica.SIunits.Temperature set_down_T "Температура пара за БРОУ" annotation(
    Dialog(group = "Параметры пароохладителя"));   
  parameter Real min_overheat = 5 "Минимальный перегрев за БРОУ" annotation(
    Dialog(group = "Параметры пароохладителя"));
  parameter Real min_delta = 100 "Минимальное охлаждение в БРОУ" annotation(
    Dialog(group = "Параметры пароохладителя"));       
  outer Modelica.Fluid.System system;  
  Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {26, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  Modelica.Fluid.Valves.ValveCompressible valve(redeclare package Medium = Medium, CvData = CvData, Kv = Kv, dp_nominal = dp_nominal, filteredOpening = true, m_flow_nominal = m_flow_nominal, p_nominal = p_nominal, rho_nominal = rho_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput opening annotation(
    Placement(visible = true, transformation(origin = {-30, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-32, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  TPPSim.Valves.Desuperheater desuperheater(redeclare package Medium = Medium, use_T_in = use_T_in, set_down_T = set_down_T) annotation(
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput T_in if use_T_in annotation(
    Placement(visible = true, transformation(origin = {40, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  TPPSim.Sensors.Temperature ts(TemperatureType_set = TPPSim.Sensors.TemperatureType.saturation)  annotation(
    Placement(visible = true, transformation(origin = {-30, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant overheat(k = min_overheat) annotation(
    Placement(visible = true, transformation(origin = {-30, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum min_t_1(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {4, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature T(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-8, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant delta(k = min_delta) annotation(
    Placement(visible = true, transformation(origin = {-10, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback min_t_2 annotation(
    Placement(visible = true, transformation(origin = {14, 24}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation(
    Placement(visible = true, transformation(origin = {38, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Min min1 annotation(
    Placement(visible = true, transformation(origin = {56, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput opening_actual annotation(
    Placement(visible = true, transformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {14, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(valve.opening_actual, opening_actual) annotation(
    Line(points = {{-22, 2}, {58, 2}, {58, 30}, {80, 30}, {80, 70}, {110, 70}, {110, 70}}, color = {0, 0, 127}));
  connect(flowIn, T.port) annotation(
    Line(points = {{-100, 0}, {-70, 0}, {-70, 14}, {-8, 14}, {-8, 14}}));
  connect(min1.u1, T_in) annotation(
    Line(points = {{44, 50}, {40, 50}, {40, 100}, {40, 100}}, color = {0, 0, 127}));
  connect(min1.u2, max1.y) annotation(
    Line(points = {{44, 38}, {38, 38}, {38, 16}, {54, 16}, {54, -16}, {50, -16}, {50, -16}}, color = {0, 0, 127}));
  connect(min1.y, desuperheater.T_in) annotation(
    Line(points = {{68, 44}, {70, 44}, {70, 10}, {70, 10}}, color = {0, 0, 127}));
  connect(min_t_1.y, max1.u2) annotation(
    Line(points = {{16, -50}, {20, -50}, {20, -22}, {26, -22}, {26, -22}}, color = {0, 0, 127}));
  connect(min_t_2.y, max1.u1) annotation(
    Line(points = {{24, 24}, {24, 24}, {24, -10}, {26, -10}}, color = {0, 0, 127}));
  connect(valve.port_b, desuperheater.flowIn) annotation(
    Line(points = {{-20, 0}, {60, 0}}, color = {0, 127, 255}));
  connect(desuperheater.waterIn, waterIn) annotation(
    Line(points = {{66, -10}, {66, -55}, {26, -55}, {26, -100}}, color = {0, 127, 255}));
  connect(desuperheater.flowOut, flowOut) annotation(
    Line(points = {{80, 0}, {100, 0}}, color = {0, 127, 255}));
  connect(delta.y, min_t_2.u2) annotation(
    Line(points = {{2, 58}, {14, 58}, {14, 32}, {14, 32}}, color = {0, 0, 127}));
  connect(T.T, min_t_2.u1) annotation(
    Line(points = {{0, 24}, {6, 24}, {6, 24}, {6, 24}}, color = {0, 0, 127}));
  connect(ts.deltaTs, min_t_1.u[1]) annotation(
    Line(points = {{-22, -40}, {-14, -40}, {-14, -50}, {-8, -50}, {-8, -50}}, color = {0, 0, 127}));
  connect(ts.port, valve.port_b) annotation(
    Line(points = {{-30, -50}, {-44, -50}, {-44, -20}, {-20, -20}, {-20, 0}, {-20, 0}}, color = {0, 127, 255}));
  connect(overheat.y, min_t_1.u[2]) annotation(
    Line(points = {{-18, -70}, {-14, -70}, {-14, -50}, {-8, -50}, {-8, -50}}, color = {0, 0, 127}));
//  connect(T_in, desuperheater.T_in);
  connect(opening, valve.opening) annotation(
    Line(points = {{-30, 100}, {-30, 100}, {-30, 8}, {-30, 8}}, color = {0, 0, 127}));
  connect(flowIn, valve.port_a) annotation(
    Line(points = {{-100, 0}, {-40, 0}, {-40, 0}, {-40, 0}}));
end ReducingStation;
