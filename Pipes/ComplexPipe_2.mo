within TPPSim.Pipes;

model ComplexPipe_2
  extends TPPSim.Pipes.BaseClases.BaseComplexPipe_2;
  replaceable package Medium = TPPSim.Media.Sodium_ph;
  import TPPSim.functions.coorSecGen;
  //Параметры разбиения
  parameter Integer numberOfVolumes "Число участков разбиения" annotation(
    Dialog(group = "Параметры разбиения"));
  //Расчетные конструктивные параметры
  final inner parameter Modelica.SIunits.Length deltaLpipe = Lpipe / numberOfVolumes;
  final inner parameter Modelica.SIunits.Length deltaLpiezo = Lpiezo / numberOfVolumes;
  final inner parameter Modelica.SIunits.Area deltaSFlow = n_parallel * deltaLpipe * Modelica.Constants.pi * Din "Внутренняя площадь одного участка ряда труб";
  final inner parameter Modelica.SIunits.Volume deltaVFlow = k_volume * n_parallel * deltaLpipe * Modelica.Constants.pi * Din ^ 2 / 4 "Внутренний объем одного участка ряда труб";
  final inner parameter Modelica.SIunits.Mass deltaMMetal = k_weight_metal * n_parallel * rho_m * deltaLpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) / 4 "Масса металла участка ряда труб";
  final inner parameter Modelica.SIunits.Area f_flow = n_parallel * Modelica.Constants.pi * Din ^ 2 / 4 "Площадь для прохода теплоносителя";
  //Переменные
  inner Medium.SpecificEnthalpy h[1, numberOfVolumes + 1] "Энтальпия вода/пар (глобальная переменная)";
  inner Medium.MassFlowRate D[1, numberOfVolumes + 1] "Массовый расход вода/пар (глобальная переменная)";
  inner Medium.AbsolutePressure p[1, numberOfVolumes + 1] "Давление вода/пар (глобальная переменная)";
  replaceable TPPSim.Pipes.ElementaryPipe_2 Pipe[1, numberOfVolumes](redeclare package Medium = Medium, section = coorSecGen(1, numberOfVolumes)) annotation(
    Placement(visible = true, transformation(origin = {-5.32907e-15, 5.32907e-15}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {121, 0}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  h[1, 1] = inStream(waterIn.h_outflow);
  waterIn.h_outflow = h[1, 1];
  D[1, 1] = waterIn.m_flow;
  p[1, 1] = waterIn.p;
  h[1, numberOfVolumes + 1] = waterOut.h_outflow;
  D[1, numberOfVolumes + 1] = -waterOut.m_flow;
  p[1, numberOfVolumes + 1] = waterOut.p;
  annotation(
    Documentation(info = "<html>
<style>
p {
  text-indent: 20px;
  text-align: 'justify';
 }
</style>
<p>Модель аналогиченя ComplexPipe, но здесь определен package Medium. Модель разработана для натриевого теплоносителя</p>
</html>", revisions = "<html>
<ul>
<li><i>03 August 2019</i>
by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
   Создан.</li>
</ul>
</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end ComplexPipe_2;
