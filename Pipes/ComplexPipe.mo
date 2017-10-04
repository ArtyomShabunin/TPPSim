within TPPSim.Pipes;

model ComplexPipe
  extends TPPSim.Pipes.BaseClases.BaseComplexPipe(redeclare replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
  import TPPSim.functions.coorSecGen;
  //Параметры разбиения
  parameter Integer numberOfVolumes "Число участков разбиения" annotation(
    Dialog(group = "Параметры разбиения"));
  //final parameter Integer[numberOfVolumes, 1, 2] section_set = coorSecGen(numberOfVolumes, 1);
  //Расчетные конструктивные параметры
  final inner parameter Modelica.SIunits.Length deltaLpipe = Lpipe / numberOfVolumes;
  final inner parameter Modelica.SIunits.Area deltaSFlow = deltaLpipe * Modelica.Constants.pi * Din "Внутренняя площадь одного участка ряда труб";
  final inner parameter Modelica.SIunits.Volume deltaVFlow = deltaLpipe * Modelica.Constants.pi * Din ^ 2 / 4 "Внутренний объем одного участка ряда труб";
  final inner parameter Modelica.SIunits.Mass deltaMMetal = rho_m * deltaLpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) / 4 "Масса металла участка ряда труб";
  final inner parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 / 4 "Площадь для прохода теплоносителя";
  //Переменные
  inner Medium.SpecificEnthalpy h[1, numberOfVolumes + 1] "Энтальпия вода/пар (глобальная переменная)";
  inner Medium.MassFlowRate D[1, numberOfVolumes + 1] "Массовый расход вода/пар (глобальная переменная)";
  inner Medium.AbsolutePressure p[1, numberOfVolumes + 1] "Давление вода/пар (глобальная переменная)";
  TPPSim.Pipes.ElementarySteamPipe Pipe[1, numberOfVolumes](redeclare package Medium = Medium, section = coorSecGen(1, numberOfVolumes)) annotation(
    Placement(visible = true, transformation(origin = {-5.32907e-15, 5.32907e-15}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
equation
  h[1, 1] = inStream(waterIn.h_outflow);
  waterIn.h_outflow = inStream(waterOut.h_outflow);
  D[1, 1] = waterIn.m_flow;
  p[1, 1] = waterIn.p;
  h[1, numberOfVolumes + 1] = waterOut.h_outflow;
  D[1, numberOfVolumes + 1] = -waterOut.m_flow;
  p[1, numberOfVolumes + 1] = waterOut.p;
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end ComplexPipe;
