﻿within TPPSim.HRSG_HeatExch;
model GFHE_EVO "Модель испарителя барабанного горизонтального КУ"
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseGFHE;
  import TPPSim.functions.coorSecGen;  
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter TPPSim.Choices.piez_type piez_type = TPPSim.Choices.piez_type.const "Способ расчета пьезометрического перепада давления";
  //Параметры циркуляции
  parameter TPPSim.Choices.circ_type circ_type_set = TPPSim.Choices.circ_type.forced "Тип механизма циркуляции в испарителе" annotation(
    Dialog(group = "Параметры циркуляции"));  
  parameter Modelica.SIunits.MassFlowRate[numberOfFlueSections] flow_circ "Номинальный расход через каждый из рядов труб (массив из z2 элементов)" annotation(
    Dialog(group = "Параметры циркуляции"));
  parameter Modelica.SIunits.MassFlowRate start_flow_circ = 1 "Начальное значение расходя через ряд труб испарителя" annotation(
    Dialog(group = "Параметры циркуляции"));    
  parameter Modelica.SIunits.AbsolutePressure[numberOfFlueSections] dp_circ "Номинальный перепад давления на подводящем трубопроводе ряда труб (массив из z2 элементов)" annotation(
    Dialog(group = "Параметры циркуляции"));
  //Параметры разбиения
  inner parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы"  annotation(
    Dialog(group = "Параметры разбиения"));
  final inner parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(
    Dialog(group = "Параметры разбиения"));    
  final parameter Integer[numberOfFlueSections, numberOfTubeSections, 2] section_set = coorSecGen(numberOfFlueSections, numberOfTubeSections);  
  //Расчетные параметры
  final inner parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
  final inner parameter Modelica.SIunits.Length deltaLpipe = Lpipe / numberOfTubeSections "Длина теплообменной трубки для элемента разбиения";
  final inner parameter Modelica.SIunits.Area deltaSFlow = deltaLpipe * Modelica.Constants.pi * Din * z1 "Внутренняя площадь одного участка ряда труб";
  final inner parameter Modelica.SIunits.Volume deltaVFlow = k_volume * deltaLpipe * f_flow "Внутренний объем одного участка ряда труб";
  final inner parameter Modelica.SIunits.Mass deltaMMetal = k_weight_metal * rho_m * deltaLpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 "Масса металла участка ряда труб";
  final inner parameter Modelica.SIunits.Volume deltaVGas = k_volume_gas * deltaLpipe * (s1 * s2 - Modelica.Constants.pi * (Din + 2 * delta) ^ 2 / 4) * z1 "Объем одного участка газового тракта";
  final inner parameter Modelica.SIunits.Area f_gas = (1 - (Din + 2 * delta) / s1 * (1 + 2 * hfin * delta_fin / sfin / (Din + 2 * delta))) * deltaLpipe * s2 * z1 "Площадь для прохода газов";
  //Характеристики оребрения
  final inner parameter Real H_fin = (omega * deltaLpipe * (1 - delta_fin / sfin) + (2 * Modelica.Constants.pi * (Dfin ^ 2 - (Din + 2 * delta) ^ 2) / 4 + Modelica.Constants.pi * Dfin * delta_fin) * (deltaLpipe / sfin)) * z1 "Площадь оребренной поверхности";
  //Переменные
  inner Medium_F.SpecificEnthalpy h_gl[numberOfFlueSections, numberOfTubeSections + 1] "Энтальпия вода/пар (глобальная переменная)";
  inner Medium_F.MassFlowRate D_gl[numberOfFlueSections, numberOfTubeSections + 1] "Массовый расход вода/пар (глобальная переменная)";
  inner Medium_F.AbsolutePressure p_gl[numberOfFlueSections, numberOfTubeSections + 1] "Давление вода/пар (глобальная переменная)";
  inner Medium_G.SpecificEnthalpy hgas_gl[numberOfFlueSections + 1, numberOfTubeSections] "Энтальпия газов (глобальная переменная)";
  inner Medium_G.MassFlowRate Dgas_gl[numberOfFlueSections + 1, numberOfTubeSections] "Массовый расход газов (глобальная переменная)";
  inner Medium_G.AbsolutePressure pgas_gl[numberOfFlueSections + 1, numberOfTubeSections] "Давление газов (глобальная переменная)";
  replaceable TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE[numberOfFlueSections, numberOfTubeSections](redeclare package Medium = Medium_G, section = section_set) annotation(
    Placement(visible = true, transformation(origin = {0, -36}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  replaceable TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE[numberOfFlueSections, numberOfTubeSections](redeclare package Medium = Medium_F, section = section_set, deltaHpipe = TPPSim.functions.hSecGen(numberOfTubeSections, numberOfFlueSections, HRSG_type_set, zahod, Lpipe), piez_type = piez_type) annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GasSplitter collGas(redeclare package Medium = Medium_G, numberOfTubeSections = numberOfTubeSections) annotation(
    Placement(visible = true, transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.HRSG_HeatExch.GasMixer collGasOut(redeclare package Medium = Medium_G, numberOfTubeSections = numberOfTubeSections, numberOfFlueSections = numberOfFlueSections) annotation(
    Placement(visible = true, transformation(origin = {30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
//Интерфейс
  inner Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {50, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-50, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPorts_a[numberOfFlueSections] flowIn(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-50, 32}, extent = {{-10, -40}, {10, 40}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -40}, {10, 40}}, rotation = -90)));
  Modelica.Fluid.Interfaces.FluidPorts_b[numberOfFlueSections] flowOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {50, 34}, extent = {{-10, -40}, {10, 40}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -40}, {10, 40}}, rotation = 90)));
//  final Boolean forced_circ[numberOfFlueSections](start = fill(true,numberOfFlueSections), fixed = true);
//algorithm
//  for i in 1:numberOfFlueSections loop
//    when flowIn[i].p - p_gl[i, 1] > dp_circ[i]*(start_flow_circ / flow_circ[i])^2 and circ_type_set == TPPSim.Choices.circ_type.natural then 
//      forced_circ[i] := false;
//    end when;
//  end for;
equation
  for i in 1:numberOfFlueSections loop    
    h_gl[i, 1] = inStream(flowIn[i].h_outflow);
    h_gl[i, 1] = flowIn[i].h_outflow;
    D_gl[i, 1] = flowIn[i].m_flow;
    if circ_type_set == TPPSim.Choices.circ_type.natural then
      if initial() then
        D_gl[i, 1] = start_flow_circ;
//      elseif noEvent(forced_circ[i]) then
//        D_gl[i, 1] = start_flow_circ;     
      else    
        D_gl[i, 1] = max(start_flow_circ, flow_circ[i] * sign(flowIn[i].p - p_gl[i, 1]) * sqrt(abs(flowIn[i].p - p_gl[i, 1]) / dp_circ[i]));
      end if;
    else
      D_gl[i, 1] = flow_circ[i];
    end if;  
    h_gl[i, numberOfTubeSections + 1] = flowOut[i].h_outflow;    
    D_gl[i, numberOfTubeSections + 1] = -flowOut[i].m_flow;
    p_gl[i, numberOfTubeSections + 1] = flowOut[i].p;   
  end for;
//Тепловые потоки
  for i in 1:numberOfFlueSections loop
    for j in 1:numberOfTubeSections loop
      connect(flowHE[i, j].heat, gasHE[numberOfFlueSections - (i - 1), j].heat);
    end for;
  end for;
//Граничные условия
  gasIn.h_outflow = inStream(gasOut.h_outflow);
  gasIn.Xi_outflow = inStream(gasOut.Xi_outflow);
  inStream(gasIn.Xi_outflow) = gasOut.Xi_outflow;
initial equation
  annotation(
    Documentation(info = "<html><head></head><body>Модель испарителя с возможностью расчета естественной циркуляции теплоносителя (пока не работает)</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>August 15, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end GFHE_EVO;
