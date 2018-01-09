within TPPSim.Valves.Tests;
model ReducingStationLP_Test
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  Modelica.Fluid.Sources.Boundary_pT flowOut(redeclare package Medium = Medium, T = 300 + 273.15, nPorts = 1, p = system.p_ambient, use_T_in = false, use_p_in = false) annotation(
    Placement(visible = true, transformation(origin = {70, -28}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = {2, 3, 4},fileName = "C:/Users/User/Documents/TPPSim/Valves/Tests/P_BROU_LP_inlet.txt", tableName = "tabl", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-64, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible valveCompressible1(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1100, dp_nominal = 9e+06, m_flow_nominal = 10, p_nominal = system.p_ambient) annotation(
    Placement(visible = true, transformation(origin = {4, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T flowIn(redeclare package Medium = Medium, T = 500, m_flow = 10, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-70, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, valveCompressible1.opening) annotation(
    Line(points = {{2, 10}, {4, 10}, {4, -20}, {4, -20}}, color = {0, 0, 127}));
  connect(combiTimeTable1.y[3], flowIn.m_flow_in) annotation(
    Line(points = {{-52, 22}, {-46, 22}, {-46, -4}, {-86, -4}, {-86, -20}, {-80, -20}, {-80, -20}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[1], flowIn.T_in) annotation(
    Line(points = {{-52, 22}, {-46, 22}, {-46, -4}, {-90, -4}, {-90, -24}, {-82, -24}, {-82, -24}}, color = {0, 0, 127}, thickness = 0.5));
  connect(valveCompressible1.port_b, flowOut.ports[1]) annotation(
    Line(points = {{14, -28}, {60, -28}, {60, -28}, {60, -28}}, color = {0, 127, 255}));
  connect(flowIn.ports[1], valveCompressible1.port_a) annotation(
    Line(points = {{-60, -28}, {-6, -28}}, color = {0, 127, 255}, thickness = 0.5));
end ReducingStationLP_Test;
