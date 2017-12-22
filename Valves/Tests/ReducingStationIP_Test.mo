within TPPSim.Valves.Tests;
model ReducingStationIP_Test
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT flowIn(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_p_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT flowOut(redeclare package Medium = Medium, nPorts = 2, p = system.p_ambient)  annotation(
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible BROU_IP(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1800, dp_nominal = 3e+06) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = {2, 3, 4, 5, 6}, fileName = "C:/Users/User/Documents/TPPSim/Valves/Tests/pos_BROU_IP.txt", tableName = "tabl", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveCompressible IPT(redeclare package Medium = Medium, CvData = Modelica.Fluid.Types.CvTypes.Kv, Kv = 1230, dp_nominal = 3e+06) annotation(
    Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Fittings.MultiPort multiPort1(redeclare package Medium = Medium, nPorts_b = 2) annotation(
    Placement(visible = true, transformation(origin = {-38, 0}, extent = {{-4, -10}, {4, 10}}, rotation = 0)));
equation
  connect(combiTimeTable1.y[3], flowIn.T_in) annotation(
    Line(points = {{-59, 70}, {-36, 70}, {-36, 44}, {-96, 44}, {-96, 4}, {-82, 4}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[4], flowIn.p_in) annotation(
    Line(points = {{-59, 70}, {-34, 70}, {-34, 40}, {-90, 40}, {-90, 8}, {-82, 8}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[2], IPT.opening) annotation(
    Line(points = {{-59, 70}, {24, 70}, {24, -20}, {0, -20}, {0, -32}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[1], BROU_IP.opening) annotation(
    Line(points = {{-59, 70}, {0, 70}, {0, 8}}, color = {0, 0, 127}, thickness = 0.5));
  connect(BROU_IP.port_b, flowOut.ports[2]) annotation(
    Line(points = {{10, 0}, {60, 0}, {60, 0}, {60, 0}}, color = {0, 127, 255}));
  connect(IPT.port_b, flowOut.ports[1]) annotation(
    Line(points = {{10, -40}, {36, -40}, {36, 0}, {60, 0}, {60, 0}}, color = {0, 127, 255}));
  connect(multiPort1.ports_b[1], IPT.port_a) annotation(
    Line(points = {{-34, 0}, {-34, 0}, {-34, -40}, {-10, -40}, {-10, -40}}, color = {0, 127, 255}, thickness = 0.5));
  connect(multiPort1.ports_b[2], BROU_IP.port_a) annotation(
    Line(points = {{-34, 0}, {-10, 0}, {-10, 0}, {-10, 0}}, color = {0, 127, 255}, thickness = 0.5));
  connect(flowIn.ports[1], multiPort1.port_a) annotation(
    Line(points = {{-60, 0}, {-42, 0}, {-42, 0}, {-42, 0}}, color = {0, 127, 255}, thickness = 0.5));
end ReducingStationIP_Test;
