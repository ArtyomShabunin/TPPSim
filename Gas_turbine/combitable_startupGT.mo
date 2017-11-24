within TPPSim.Gas_turbine;
model combitable_startupGT "Упрощенная модель пуска ГТУ"
  extends TPPSim.Gas_turbine.BaseClases.Icons.IconGTstartUp;
  replaceable package Medium = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  outer Modelica.Fluid.System system;
  parameter String fileName="NoName" "File where matrix is stored"
    annotation (Dialog(
      group="Table data definition",
      enable=tableOnFile,
      loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
          caption="Open file in which table is present")));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1( columns = {2, 3, 4, 5, 6, 7, 8, 9, 10},fileName = fileName, tableName = "tabl", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Состав выхлопных газов
  Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_X_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {54, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Filter filter1(f_cut = 1) annotation(
    Placement(visible = true, transformation(origin = {15, 1}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Continuous.Filter filter2(f_cut = 1) annotation(
    Placement(visible = true, transformation(origin = {15, 19}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation(
    Placement(visible = true, transformation(origin = {-11, 3}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant max_T(k = system.T_start)  annotation(
    Placement(visible = true, transformation(origin = {-35, 11}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
equation
  connect(max_T.y, max1.u1) annotation(
    Line(points = {{-30, 12}, {-26, 12}, {-26, 6}, {-18, 6}, {-18, 6}}, color = {0, 0, 127}));
  connect(max1.y, filter1.u) annotation(
    Line(points = {{-6, 4}, {0, 4}, {0, 0}, {10, 0}, {10, 2}}, color = {0, 0, 127}));
  connect(combiTimeTable1.y[2], max1.u2) annotation(
    Line(points = {{-58, 0}, {-18, 0}, {-18, 0}, {-18, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[3:8], gasSource.X_in) annotation(
    Line(points = {{-58, 0}, {-28, 0}, {-28, -4}, {42, -4}, {42, -4}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTimeTable1.y[1], filter2.u) annotation(
    Line(points = {{-58, 0}, {-48, 0}, {-48, 20}, {10, 20}, {10, 20}}, color = {0, 0, 127}, thickness = 0.5));
  connect(filter2.y, gasSource.m_flow_in) annotation(
    Line(points = {{20.5, 19}, {44, 19}, {44, 8}}, color = {0, 0, 127}));
  connect(filter1.y, gasSource.T_in) annotation(
    Line(points = {{20.5, 1}, {28, 1}, {28, 4}, {42, 4}}, color = {0, 0, 127}));
  connect(gasSource.ports[1], flowOut) annotation(
    Line(points = {{64, 0}, {98, 0}, {98, 0}, {98, 0}}, color = {0, 127, 255}, thickness = 0.5));
  annotation(
    Documentation(info = "<html><head></head><body>Модель построена на основе расчетных данных по пуску SGT5-4000F.</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>July 07, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end combitable_startupGT;
