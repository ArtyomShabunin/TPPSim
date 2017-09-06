within TPPSim.HRSG_HeatExch;
model GFHE_new
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseGFHE;
  //Исходные данные по разбиению
  parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(
    Dialog(group = "Конструктивные характеристики"));
protected
  inner parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(
    Dialog(group = "Конструктивные характеристики"));
  inner parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
  inner parameter Modelica.SIunits.Length deltaLpipe = Lpipe / numberOfTubeSections "Длина теплообменной трубки для элемента разбиения";
  inner parameter Modelica.SIunits.Area deltaSFlow = deltaLpipe * Modelica.Constants.pi * Din * z1 "Внутренняя площадь одного участка ряда труб";
  inner parameter Modelica.SIunits.Volume deltaVFlow = deltaLpipe * f_flow "Внутренний объем одного участка ряда труб";
  inner parameter Modelica.SIunits.Mass deltaMMetal = rho_m * deltaLpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 "Масса металла участка ряда труб";
  inner parameter Modelica.SIunits.Volume deltaVGas = deltaLpipe * (s1 * s2 - Modelica.Constants.pi * (Din + 2 * delta) ^ 2 / 4) * z1 "Объем одного участка газового тракта";
  inner parameter Modelica.SIunits.Area f_gas = (1 - (Din + 2 * delta) / s1 * (1 + 2 * hfin * delta_fin / sfin / (Din + 2 * delta))) * deltaLpipe * s2 * z1 "Площадь для прохода газов";
  //Характеристики оребрения
  inner parameter Real H_fin = (omega * deltaLpipe * (1 - delta_fin / sfin) + (2 * Modelica.Constants.pi * (Dfin ^ 2 - (Din + 2 * delta) ^ 2) / 4 + Modelica.Constants.pi * Dfin * delta_fin) * (deltaLpipe / sfin)) * z1 * zahod "Площадь оребренной поверхности";
  //Переменные
  Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
  Modelica.SIunits.Length deltaHpipe[numberOfFlueSections, numberOfTubeSections] "Разность высот на участке ряда труб";
  TPPSim.HRSG_HeatExch.GasSideHE gasHE[numberOfFlueSections, numberOfTubeSections](redeclare package Medium = Medium_G, DynamicEnergyBalance = gas_DynamicEnergyBalance, DynamicMassBalance = gas_DynamicMassBalance) annotation(
    Placement(visible = true, transformation(origin = {0, -36}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  replaceable TPPSim.HRSG_HeatExch.FlowSideOTE flowHE[numberOfFlueSections, numberOfTubeSections](redeclare package Medium = Medium_F, DynamicMomentum = flow_DynamicMomentum, DynamicMassBalance = flow_DynamicMassBalance, DynamicEnergyBalance = flow_DynamicEnergyBalance, DynamicTm = flow_DynamicTm) annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.Collector collFlow(redeclare package Medium = Medium_F, zahod = zahod);
  TPPSim.HRSG_HeatExch.Collector collGas(redeclare package Medium = Medium_G, zahod = numberOfTubeSections);
  TPPSim.HRSG_HeatExch.CollectorMix2 collFlowOut(redeclare package Medium = Medium_F, zahod = zahod, Din = Din, L = Lpipe, delta = delta);
equation
  for i in 1:numberOfFlueSections loop
    hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева(минус 1 - нечетный, плюс 1 - четный)";
  end for;
  if HRSG_type_set == TPPSim.Choices.HRSG_type.verticalBottom or HRSG_type_set == TPPSim.Choices.HRSG_type.verticalTop then
    deltaHpipe = fill(0, numberOfFlueSections, numberOfTubeSections);
  else
    for i in 1:numberOfFlueSections loop
      for j in 1:numberOfTubeSections loop
        if HRSG_type_set == TPPSim.Choices.HRSG_type.horizontalBottom then
          deltaHpipe[i, j] = (-1) * hod[i * (j - 1) + j] * Lpipe / numberOfTubeSections "Разность высотных отметок труб для горизонтального КУ с нижним входным коллектором";
        elseif HRSG_type_set == TPPSim.Choices.HRSG_type.horizontalTop then
          deltaHpipe[i, j] = hod[i * (j - 1) + j] * Lpipe / numberOfTubeSections "Разность высотных отметок труб для горизонтального КУ с верхним входным коллектором";
        end if;
      end for;
    end for;
  end if;
  for i in 1:numberOfFlueSections - 1 loop
    for j in 1:numberOfTubeSections loop
      connect(gasHE[i, j].gasOut, gasHE[i + 1, j].gasIn);
    end for;
  end for;
  for i in 1:numberOfFlueSections loop
    for j in 1:numberOfTubeSections - 1 loop
      connect(flowHE[i, j].waterOut, flowHE[i, j + 1].waterIn);
    end for;
  end for;
//Гибы
  for i in 1:numberOfFlueSections - zahod loop
    connect(flowHE[i, numberOfTubeSections].waterOut, flowHE[i + zahod, 1].waterIn);
  end for;
//Тепловые потоки
  for i in 1:numberOfFlueSections loop
    for j in 1:numberOfTubeSections loop
      connect(flowHE[i, j].heat, gasHE[numberOfFlueSections - (i - 1), j].heat);
    end for;
  end for;
//Граничные условия
//Газы
  for j in 1:numberOfTubeSections loop
    connect(collGas.flowOut[j], gasHE[1, j].gasIn);
//connect(gasIn, gasHE[1, j].gasIn);
    connect(gasHE[numberOfFlueSections, j].gasOut, gasOut);
  end for;
  connect(gasIn, collGas.flowIn);
//Воды/Пар
  for i in 1:zahod loop
    connect(collFlow.flowOut[i], flowHE[i, 1].waterIn);
    connect(collFlowOut.flowIn[i], flowHE[numberOfFlueSections - (i - 1), numberOfTubeSections].waterOut);
// connect(flowIn, flowHE[i, 1].waterIn);
//connect(flowHE[numberOfFlueSections - (i - 1), numberOfTubeSections].waterOut, flowOut);
  end for;
  connect(flowIn, collFlow.flowIn);
  connect(flowOut, collFlowOut.flowOut);
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    version = "",
    uses);
end GFHE_new;