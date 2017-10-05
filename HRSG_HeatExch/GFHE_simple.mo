within TPPSim.HRSG_HeatExch;
model GFHE_simple
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseGFHE;
  import TPPSim.functions.coorSecGen;
  //Параметры разбиения
  parameter Integer numberOfVolumes "Число участков разбиения" annotation(
    Dialog(group = "Параметры разбиения"));
  final inner parameter Integer numberOfFlueSections = numberOfVolumes "Число участков разбиения газохода";
  //final parameter Integer[numberOfVolumes, 1, 2] section_set = coorSecGen(numberOfVolumes, 1);  
  //Расчетные параметры
  final inner parameter Modelica.SIunits.Area f_flow = zahod * Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
  final inner parameter Modelica.SIunits.Length deltaLpipe = Lpipe * z2 / zahod / numberOfVolumes "Длина теплообменной трубки для элемента разбиения";
  final inner parameter Modelica.SIunits.Area deltaSFlow = deltaLpipe * zahod * Modelica.Constants.pi * Din * z1 "Внутренняя площадь одного участка ряда труб";
  final inner parameter Modelica.SIunits.Volume deltaVFlow = deltaLpipe * f_flow "Внутренний объем одного участка ряда труб";
  final inner parameter Modelica.SIunits.Mass deltaMMetal = rho_m * deltaLpipe * zahod * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 "Масса металла участка ряда труб";
  final inner parameter Modelica.SIunits.Volume deltaVGas = Lpipe * (s1 * s2 - Modelica.Constants.pi * (Din + 2 * delta) ^ 2 / 4) * z1 * z2 / numberOfVolumes "Объем одного участка газового тракта";
  final inner parameter Modelica.SIunits.Area f_gas = (1 - (Din + 2 * delta) / s1 * (1 + 2 * hfin * delta_fin / sfin / (Din + 2 * delta))) * Lpipe * s2 * z1 "Площадь для прохода газов";
  //Характеристики оребрения
  final inner parameter Real H_fin = (omega * Lpipe * (1 - delta_fin / sfin) + (2 * Modelica.Constants.pi * (Dfin ^ 2 - (Din + 2 * delta) ^ 2) / 4 + Modelica.Constants.pi * Dfin * delta_fin) * (Lpipe / sfin)) * z1 * z2 / numberOfVolumes "Площадь оребренной поверхности";
  //Переменные
  inner Medium_F.SpecificEnthalpy h_gl[1, numberOfVolumes + 1] "Энтальпия вода/пар (глобальная переменная)";
  inner Medium_F.MassFlowRate D_gl[1, numberOfVolumes + 1] "Массовый расход вода/пар (глобальная переменная)";
  inner Medium_F.AbsolutePressure p_gl[1, numberOfVolumes + 1] "Давление вода/пар (глобальная переменная)";
  inner Medium_G.SpecificEnthalpy hgas_gl[numberOfVolumes + 1, 1] "Энтальпия газов (глобальная переменная)";
  inner Medium_G.MassFlowRate Dgas_gl[numberOfVolumes + 1, 1] "Массовый расход газов (глобальная переменная)";
  inner Medium_G.AbsolutePressure pgas_gl[numberOfVolumes + 1, 1] "Давление газов (глобальная переменная)";
  TPPSim.HRSG_HeatExch.GasSideHE gasHE[numberOfVolumes, 1](redeclare package Medium = Medium_G, section = coorSecGen(numberOfVolumes, 1)) annotation(
    Placement(visible = true, transformation(origin = {0, -36}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  replaceable TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE[1, numberOfVolumes](redeclare package Medium = Medium_F, section = coorSecGen(1, numberOfVolumes)) annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
equation
  for i in 1:numberOfVolumes loop
    connect(flowHE[1, i].heat, gasHE[numberOfVolumes + 1 - i, 1].heat);
  end for;
  h_gl[1, 1] = inStream(flowIn.h_outflow);
  flowIn.h_outflow = inStream(flowOut.h_outflow);
  D_gl[1, 1] = flowIn.m_flow;
  p_gl[1, 1] = flowIn.p;
  h_gl[1, numberOfVolumes + 1] = flowOut.h_outflow;
  D_gl[1, numberOfVolumes + 1] = -flowOut.m_flow;
  p_gl[1, numberOfVolumes + 1] = flowOut.p;
  hgas_gl[1, 1] = inStream(gasIn.h_outflow);
  gasIn.h_outflow = inStream(gasOut.h_outflow);
  Dgas_gl[1, 1] = gasIn.m_flow;
  pgas_gl[1, 1] = gasIn.p;
  hgas_gl[numberOfVolumes + 1, 1] = gasOut.h_outflow;
  Dgas_gl[numberOfVolumes + 1, 1] = -gasOut.m_flow;
  pgas_gl[numberOfVolumes + 1, 1] = gasOut.p;
  gasIn.Xi_outflow = inStream(gasOut.Xi_outflow);
  inStream(gasIn.Xi_outflow) = gasOut.Xi_outflow;
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    version = "",
    uses);
end GFHE_simple;
