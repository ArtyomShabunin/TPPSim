within TPPSim.Pipes;

model ComplexPipe_2
  extends TPPSim.Pipes.BaseClases.BaseComplexPipe_2;

  //Параметры разбиения
  parameter Integer numberOfVolumes "Число участков разбиения" annotation(
    Dialog(group = "Параметры разбиения"));
  //Расчетные конструктивные параметры
  final parameter Modelica.SIunits.Length deltaLpipe = Lpipe / numberOfVolumes;
  final parameter Modelica.SIunits.Length deltaLpiezo = Lpiezo / numberOfVolumes;
  final parameter Modelica.SIunits.Area deltaSFlow = n_parallel * deltaLpipe * Modelica.Constants.pi * Din "Внутренняя площадь одного участка ряда труб";
  final parameter Modelica.SIunits.Volume deltaVFlow = k_volume * n_parallel * deltaLpipe * Modelica.Constants.pi * Din ^ 2 / 4 "Внутренний объем одного участка ряда труб";
  final parameter Modelica.SIunits.Mass deltaMMetal = k_weight_metal * n_parallel * rho_m * deltaLpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) / 4 "Масса металла участка ряда труб";
  final parameter Modelica.SIunits.Area f_flow = n_parallel * Modelica.Constants.pi * Din ^ 2 / 4 "Площадь для прохода теплоносителя";
  //Переменные
  replaceable TPPSim.Pipes.ElementaryPipe_2 Pipe[1, numberOfVolumes](redeclare package Medium = Medium,
                                                                     ke = fill(ke,1, numberOfVolumes),
                                                                     Din = fill(Din,1, numberOfVolumes),
                                                                     f_flow = fill(f_flow,1, numberOfVolumes), 
                                                                     C_m = fill(C_m, 1, numberOfVolumes),
                                                                     deltaLpipe = fill(deltaLpipe, 1, numberOfVolumes),
                                                                     deltaLpiezo = fill(deltaLpiezo, 1, numberOfVolumes),
                                                                     deltaSFlow = fill(deltaSFlow, 1, numberOfVolumes),
                                                                     deltaVFlow = fill(deltaVFlow, 1, numberOfVolumes),
                                                                     deltaMMetal = fill(deltaMMetal, 1, numberOfVolumes),
                                                                     p_flow_start = fill(p_flow_start, 1, numberOfVolumes),
                                                                     h_start = fill(h_start, 1, numberOfVolumes),
                                                                     t_m_start = fill(t_m_start, 1, numberOfVolumes),
                                                                     energyDynamics = fill(energyDynamics, 1, numberOfVolumes),
                                                                     massDynamics = fill(energyDynamics, 1, numberOfVolumes),
                                                                     momentumDynamics = fill(momentumDynamics, 1, numberOfVolumes))
                                                                     annotation(
    Placement(visible = true, transformation(origin = {-5.32907e-15, 5.32907e-15}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {121, 0}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation

  // Объединение элементарных моделей трубопровода
  for i in 1:(numberOfVolumes-1) loop
    Pipe[1,i].p[2] = Pipe[1,i+1].p[1];
    Pipe[1,i].D[2] + Pipe[1,i+1].D[1] = 0;
    
    Pipe[1,i].H[2] = semiLinear(Pipe[1,i].D_flow_v, Pipe[1,i].stateFlow.h, Pipe[1,i+1].H[1] / Pipe[1,i].D_flow_v);
    Pipe[1,i+1].H[1] = semiLinear(Pipe[1,i+1].D_flow_v, Pipe[1,i].H[2] / Pipe[1,i+1].D_flow_v, Pipe[1,i+1].stateFlow.h);    
  end for;
   
  Pipe[1, 1].H[1] = semiLinear(Pipe[1,1].D_flow_v, inStream(waterIn.h_outflow), Pipe[1,1].stateFlow.h);
  Pipe[1, numberOfVolumes].H[2] = semiLinear(Pipe[1,numberOfVolumes].D_flow_v, Pipe[1,numberOfVolumes].stateFlow.h, inStream(waterOut.h_outflow));

  for i in 1:numberOfVolumes loop
//    Pipe[1,i].stateFlow.p = semiLinear(Pipe[1,i].D_flow_v, Pipe[1,i].p[1]/Pipe[1,i].D_flow_v, Pipe[1,i].p[2]/Pipe[1,i].D_flow_v);
//    Pipe[1,i].D_flow_v + semiLinear((Pipe[1,i].p[1] - Pipe[1,i].p[2]), Pipe[1,i].D[2]/(Pipe[1,i].p[1] - Pipe[1,i].p[2]), Pipe[1,i].D[1]/(Pipe[1,i].p[1] - Pipe[1,i].p[2])) = 0;
    Pipe[1,i].stateFlow.p = Pipe[1,i].p[1];
    Pipe[1,i].D_flow_v + Pipe[1,i].D[2] = 0;
  end for;
  
  waterIn.h_outflow = Pipe[1,1].stateFlow.h;
  Pipe[1, 1].D[1] = waterIn.m_flow;
  Pipe[1, 1].p[1] = waterIn.p;
  Pipe[1, numberOfVolumes].stateFlow.h = waterOut.h_outflow;
  Pipe[1, numberOfVolumes].D[2] = waterOut.m_flow;
  Pipe[1, numberOfVolumes].p[2] = waterOut.p;
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
