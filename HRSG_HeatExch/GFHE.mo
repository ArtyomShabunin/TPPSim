﻿within TPPSim.HRSG_HeatExch;
model GFHE
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseGFHE;
  import TPPSim.functions.coorSecGen;
  //Исходные данные по разбиению
  inner parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(
    Dialog(group = "Конструктивные характеристики"));
  inner parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(
    Dialog(group = "Конструктивные характеристики"));
  inner parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
  inner parameter Modelica.SIunits.Length deltaLpipe = Lpipe / numberOfTubeSections "Длина теплообменной трубки для элемента разбиения";
  final inner parameter Modelica.SIunits.Area deltaSFlow = deltaLpipe * Modelica.Constants.pi * Din * z1 "Внутренняя площадь одного участка ряда труб";
  final inner parameter Modelica.SIunits.Volume deltaVFlow = deltaLpipe * f_flow "Внутренний объем одного участка ряда труб";
  final inner parameter Modelica.SIunits.Mass deltaMMetal = rho_m * deltaLpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 "Масса металла участка ряда труб";
  final inner parameter Modelica.SIunits.Volume deltaVGas = deltaLpipe * (s1 * s2 - Modelica.Constants.pi * (Din + 2 * delta) ^ 2 / 4) * z1 "Объем одного участка газового тракта";
  final inner parameter Modelica.SIunits.Area f_gas = (1 - (Din + 2 * delta) / s1 * (1 + 2 * hfin * delta_fin / sfin / (Din + 2 * delta))) * deltaLpipe * s2 * z1 "Площадь для прохода газов";
  final parameter Integer[numberOfFlueSections, numberOfTubeSections, 2] section_set = coorSecGen(numberOfFlueSections, numberOfTubeSections);
  //Характеристики оребрения
  final inner parameter Real H_fin = (omega * deltaLpipe * (1 - delta_fin / sfin) + (2 * Modelica.Constants.pi * (Dfin ^ 2 - (Din + 2 * delta) ^ 2) / 4 + Modelica.Constants.pi * Dfin * delta_fin) * (deltaLpipe / sfin)) * z1 * zahod "Площадь оребренной поверхности";
  //Переменные
  inner Medium_F.SpecificEnthalpy h_gl[numberOfFlueSections, numberOfTubeSections + 1] "Энтальпия вода/пар (глобальная переменная)";
  inner Medium_F.MassFlowRate D_gl[numberOfFlueSections, numberOfTubeSections + 1] "Массовый расход вода/пар (глобальная переменная)";
  inner Medium_F.AbsolutePressure p_gl[numberOfFlueSections, numberOfTubeSections + 1] "Давление вода/пар (глобальная переменная)";
  inner Medium_G.SpecificEnthalpy hgas_gl[numberOfFlueSections + 1, numberOfTubeSections] "Энтальпия газов (глобальная переменная)";
  inner Medium_G.MassFlowRate Dgas_gl[numberOfFlueSections + 1, numberOfTubeSections] "Массовый расход газов (глобальная переменная)";
  inner Medium_G.AbsolutePressure pgas_gl[numberOfFlueSections + 1, numberOfTubeSections] "Давление газов (глобальная переменная)";
  Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
  Modelica.SIunits.Length deltaHpipe[numberOfFlueSections, numberOfTubeSections] "Разность высот на участке ряда труб";
  TPPSim.HRSG_HeatExch.GasSideHE_glob gasHE[numberOfFlueSections, numberOfTubeSections](redeclare package Medium = Medium_G, DynamicEnergyBalance = gas_DynamicEnergyBalance, DynamicMassBalance = gas_DynamicMassBalance, section = section_set) annotation(
    Placement(visible = true, transformation(origin = {0, -36}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  replaceable TPPSim.HRSG_HeatExch.FlowSideOTE_glob flowHE[numberOfFlueSections, numberOfTubeSections](redeclare package Medium = Medium_F, DynamicMomentum = flow_DynamicMomentum, DynamicMassBalance = flow_DynamicMassBalance, DynamicEnergyBalance = flow_DynamicEnergyBalance, DynamicTm = flow_DynamicTm, section = section_set) annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.Splitter collFlow(redeclare package Medium = Medium_F, zahod = zahod) annotation(
    Placement(visible = true, transformation(origin = {-30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  /*TPPSim.HRSG_HeatExch.MixCollector collFlowOut(redeclare package Medium = Medium_F, zahod = zahod, numberOfTubeSections = numberOfTubeSections, numberOfFlueSections = numberOfFlueSections, Din = Din, L = Lpipe, delta = delta) annotation(
                                                                                                                                                    Placement(visible = true, transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));*/
  TPPSim.HRSG_HeatExch.Mixer collFlowOut(redeclare package Medium = Medium_F, zahod = zahod, numberOfTubeSections = numberOfTubeSections, numberOfFlueSections = numberOfFlueSections) annotation(
    Placement(visible = true, transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GasSplitter collGas(redeclare package Medium = Medium_G, numberOfTubeSections = numberOfTubeSections) annotation(
    Placement(visible = true, transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GasMixer collGasOut(redeclare package Medium = Medium_G, numberOfTubeSections = numberOfTubeSections, numberOfFlueSections = numberOfFlueSections) annotation(
    Placement(visible = true, transformation(origin = {30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
//Гибы
  for i in 1:numberOfFlueSections - zahod loop
    h_gl[i, numberOfTubeSections + 1] = h_gl[i + zahod, 1];
    D_gl[i, numberOfTubeSections + 1] = D_gl[i + zahod, 1];
    p_gl[i, numberOfTubeSections + 1] = p_gl[i + zahod, 1];
  end for;
//Тепловые потоки
  for i in 1:numberOfFlueSections loop
    for j in 1:numberOfTubeSections loop
      connect(flowHE[i, j].heat, gasHE[numberOfFlueSections - (i - 1), j].heat);
    end for;
  end for;
//Граничные условия
  flowIn.h_outflow = inStream(flowOut.h_outflow);
  gasIn.h_outflow = inStream(gasOut.h_outflow);
  gasIn.Xi_outflow = inStream(gasOut.Xi_outflow);
  inStream(gasIn.Xi_outflow) = gasOut.Xi_outflow;
  annotation(
    Documentation(info = "<html><head></head><body>Аналог GFHE_new с глобальными переменными</body></html>", revisions = "<html><head></head><body>
<ul>
  <li><i>August 15, 2017</i>
by Artyom Shabunin:<br></li>
</ul></body></html>"));
end GFHE;