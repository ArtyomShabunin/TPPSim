within TPPSim.Gas_turbine;
model simple_startupGT "Упрощенная модель пуска ГТУ"
  extends TPPSim.Gas_turbine.BaseClases.Icons.IconGTstartUp;
  replaceable package Medium = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  final parameter Real temperature_exh[:, 2] = {{0.0, 2.57}, {11.94, 3.46}, {17.9104, 4.23}, {17.9105, 7.32}, {20.8955, 15.79}, {20.8956, 40.82}, {23.8806, 45.44}, {23.8807, 52.75}, {26.8657, 52.75}, {26.8658, 57.89}, {29.8507, 60.97}, {32.84, 62.25}, {35.82, 64.3}, {38.81, 66.2}, {44.78, 67.51}, {50.75, 68.79}, {53.73, 70.08}, {59.7, 71.23}, {68.66, 72.39}, {74.63, 73.16}, {80.6, 73.67}, {92.54, 74.57}, {107.46, 75.47}, {122.39, 76.23}, {143.28, 76.88}, {155.22, 77.0}, {170.15, 76.87}, {191.05, 76.36}, {205.97, 75.46}, {217.91, 74.69}, {229.85, 73.66}, {238.81, 72.76}, {244.78, 71.86}, {253.73, 70.71}, {259.7, 69.42}, {265.67, 68.65}, {274.63, 67.75}, {280.6, 66.6}, {286.57, 65.19}, {295.52, 63.77}, {301.49, 62.49}, {310.45, 60.56}, {316.42, 59.41}, {334.33, 57.74}, {382.09, 57.74}, {382.0901, 60.3}, {841.79, 100.58}, {1671.64, 100.58}, {2361.19, 100.74}, {2492.54, 100.74}, {2782.09, 100.0}, {2933.39, 100.0}};
  final parameter Real flow_exh[:, 2] = {{0.0, 0.0}, {11.94, 2.31}, {32.84, 7.83}, {50.75, 10.27}, {74.63, 13.09}, {107.46, 16.29}, {140.3, 18.99}, {176.12, 22.58}, {197.02, 25.53}, {217.91, 29.12}, {235.82, 31.82}, {244.78, 34.51}, {256.72, 38.1}, {274.63, 42.21}, {292.54, 46.19}, {307.46, 51.06}, {319.4, 55.69}, {328.36, 60.18}, {334.33, 58.38}, {382.09, 58.38}, {385.08, 58.51}, {838.81, 58.73}, {1677.61, 99.88}, {2922.39, 100.0}};
  parameter Real Tnom = 517.2 + 273.15;
  parameter Real Gnom = 1292.6 / 3.6;
  parameter Modelica.SIunits.Temperature Tstart = 60 + 273.15 "Начальная входная температура газов";
  //Состав выхлопных газов
  Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {54, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable tempTable(table = temperature_exh) annotation(
    Placement(visible = true, transformation(origin = {-72, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable flowTable(table = flow_exh) annotation(
    Placement(visible = true, transformation(origin = {-72, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain temp_gain(k = Tnom / 100) annotation(
    Placement(visible = true, transformation(origin = {-46, -16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain flow_gain(k = Gnom / 100) annotation(
    Placement(visible = true, transformation(origin = {-46, 16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation(
    Placement(visible = true, transformation(origin = {-9, -19}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Max max2 annotation(
    Placement(visible = true, transformation(origin = {-9, 13}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant minT(k = Tstart) annotation(
    Placement(visible = true, transformation(origin = {-31, -29}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant minG(k = 10) annotation(
    Placement(visible = true, transformation(origin = {-31, 9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Continuous.Filter filter1(f_cut = 1) annotation(
    Placement(visible = true, transformation(origin = {13, -19}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Continuous.Filter filter2(f_cut = 1) annotation(
    Placement(visible = true, transformation(origin = {13, 13}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(gasSource.ports[1], flowOut) annotation(
    Line(points = {{64, 0}, {98, 0}, {98, 0}, {98, 0}}, color = {0, 127, 255}, thickness = 0.5));
  connect(filter1.y, gasSource.T_in) annotation(
    Line(points = {{18, -18}, {28, -18}, {28, 4}, {42, 4}, {42, 4}}, color = {0, 0, 127}));
  connect(max1.y, filter1.u) annotation(
    Line(points = {{-4, -18}, {6, -18}, {6, -18}, {8, -18}}, color = {0, 0, 127}));
  connect(minT.y, max1.u2) annotation(
    Line(points = {{-26, -28}, {-22, -28}, {-22, -22}, {-14, -22}, {-14, -22}}, color = {0, 0, 127}));
  connect(temp_gain.y, max1.u1) annotation(
    Line(points = {{-40, -16}, {-16, -16}, {-16, -16}, {-14, -16}}, color = {0, 0, 127}));
  connect(tempTable.y, temp_gain.u) annotation(
    Line(points = {{-60, -16}, {-54, -16}, {-54, -16}, {-54, -16}}, color = {0, 0, 127}));
  connect(filter2.y, gasSource.m_flow_in) annotation(
    Line(points = {{18, 14}, {44, 14}, {44, 8}, {44, 8}}, color = {0, 0, 127}));
  connect(max2.y, filter2.u) annotation(
    Line(points = {{-4, 14}, {6, 14}, {6, 14}, {8, 14}}, color = {0, 0, 127}));
  connect(minG.y, max2.u2) annotation(
    Line(points = {{-26, 10}, {-16, 10}, {-16, 10}, {-14, 10}}, color = {0, 0, 127}));
  connect(flow_gain.y, max2.u1) annotation(
    Line(points = {{-40, 16}, {-16, 16}, {-16, 16}, {-14, 16}}, color = {0, 0, 127}));
  connect(flowTable.y, flow_gain.u) annotation(
    Line(points = {{-60, 16}, {-54, 16}, {-54, 16}, {-54, 16}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html><head></head><body>Модель построена на основе расчетных данных по пуску SGT5-4000F.</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>July 07, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end simple_startupGT;
