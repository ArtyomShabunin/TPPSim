within TPPSim.Gas_turbine.GT_param;
model GT_param "Параметризованная модель ГТУ"
  extends TPPSim.Gas_turbine.BaseClases.Icons.IconGTstartUp;
  replaceable package Medium = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Modelica.SIunits.Temperature Tnom = 517.2 + 273.15 "Номинальная температура выхлопных газов ГТУ";
  parameter Modelica.SIunits.MassFlowRate Gnom = 1292.6 / 3.6 "Номинальный расход выхлопных газов ГТУ";
  parameter Modelica.SIunits.Power Nnom = 300e6 "Номинальная электрическая мощность ГТУ, МВт";
  parameter Modelica.SIunits.Temperature Tmin = 60 + 273.15 "Минимальная температура газов";
  parameter Modelica.SIunits.Power N_sync = 6e6 "Стартовая нагрузка ГТУ";
  parameter Real derN_sync = 2000 "Скорость нагружения до стартовой нагрузки, Вт/с";
  parameter Modelica.SIunits.Time delta_time_N_sync = 5 * 60 "Продолжительность минимальной выдержки ГТУ на стартовой нагрузке";
  parameter Modelica.SIunits.Power N_init "Начальная нагрузка ГТУ";  
//Переменные
  Modelica.SIunits.Power N "Электрическая нагрузка ГТУ";
  Modelica.SIunits.Temperature T_g "Температура выхлопных газов ГТУ";
  Modelica.SIunits.Frequency n "Частота врящения вала ГТУ";
  Modelica.SIunits.MassFlowRate G_g "Массовый расход выхлопных газов ГТУ";
  Modelica.SIunits.Time time_sync "Момент времени в который произошла синхронизация генератора ГТУ с энергосистемой";
  //Состав выхлопных газов
  Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {54, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
      Placement(visible = true, transformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable stage_1(columns = {2, 3, 4},fileName = "C:/Users/ASShabunin/TPPSim/Gas_turbine/GT_param/GT_param_SGT_4000F.txt", startTime = 0, tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds stage_2(columns = {2, 3, 4},fileName = "C:/Users/ASShabunin/TPPSim/Gas_turbine/GT_param/GT_param_SGT_4000F.txt", tableName = "tab2", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput derN_set annotation(
    Placement(visible = true, transformation(origin = {20, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {30, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput N_set annotation(
    Placement(visible = true, transformation(origin = {60, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {80, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Sources.CombiTimeTable stage_1_sync(columns = {5}, fileName = "C:/Users/ASShabunin/TPPSim/Gas_turbine/GT_param/GT_param_SGT_4000F.txt", smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, startTime = 0, tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Filter filter1(f_cut = 1) annotation(
    Placement(visible = true, transformation(origin = {10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Filter filter2(f_cut = 1) annotation(
    Placement(visible = true, transformation(origin = {10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
initial equation
  time_sync = 0;
  N = if N_init < N_sync then 0 else N_init;
equation
  connect(filter1.y, gasSource.T_in) annotation(
    Line(points = {{22, -10}, {30, -10}, {30, 4}, {42, 4}, {42, 4}}, color = {0, 0, 127}));
  connect(filter2.y, gasSource.m_flow_in) annotation(
    Line(points = {{22, 30}, {28, 30}, {28, 8}, {44, 8}, {44, 8}}, color = {0, 0, 127}));
  when N > N_sync then
    time_sync = time;
  end when;
  connect(gasSource.ports[1], flowOut) annotation(
    Line(points = {{64, 0}, {96, 0}, {96, 0}, {98, 0}}, color = {0, 127, 255}, thickness = 0.5));
  if noEvent(N < N_sync) then
    if noEvent(stage_1_sync.y[1] < 1) then
      der(N) = 0;
      T_g = ((Tnom - 273.15) * stage_1.y[1] / 100) + 273.15;
      n = 50 * stage_1.y[2] / 100;
      G_g = Gnom * stage_1.y[3] / 100;
    else
      der(N) = N_sync;
      T_g = ((Tnom - 273.15) * stage_2.y[1] / 100) + 273.15;
      n = 50;
      G_g = Gnom * stage_2.y[3] / 100;    
    end if;
  else
    if noEvent(time < (time_sync + delta_time_N_sync) and time_sync > 0) then
      der(N) = 0;
    elseif noEvent(N < N_set) then
      der(N) = derN_set;
    else
      der(N) = 0;
    end if;
    T_g = ((Tnom - 273.15) * stage_2.y[1] / 100) + 273.15;
    n = 50;
    G_g = Gnom * stage_2.y[3] / 100;    
  end if;
  stage_2.u = 100 * N / Nnom;
  filter2.u = max(G_g, 10);
  filter1.u = max(T_g, Tmin);    
  annotation(
    Documentation(info = "<html>
<style>
p {
  text-indent: 20px;
  text-align: 'justify';
 }
</style>
<p>Модель ГТУ на базе расчетного графика пуска ГТУ SGT5-4000F, с возможностью внешнего управления скорость изменения нагрузки и нагрузкой.</p>
<p>Кроме того модель имеет следующие параметры:</p>
<ul>
  <li>Стартовая нагрузка ГТУ - нагрузка на которую выходит ГТУ сразу после синхронизации с энергосистемой;</li>
  <li>Начальная нагрузка ГТУ - нагрузка которую несет ГТУ сразу после инициализации системы (начальное условие);</li>
  <li>Скорость с которой ГТУ выходит на стартовую нагрузку;</li>
  <li>Минимальная выдержка ГТУ на стартовой нагрузке.</li>
</ul>
</html>", revisions = "<html>
<ul>
<li><i>22 July 2018</i>
by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
   Создан.</li>
</ul>
</html>"));
end GT_param;
