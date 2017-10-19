within TPPSim.HRSG_HeatExch.BaseClases;
partial model BaseGFHE_simple
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseGFHE;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  //Параметры разбиения
  parameter Integer numberOfVolumes "Число участков разбиения" annotation(
    Dialog(group = "Параметры разбиения"));
  final inner parameter Integer numberOfFlueSections = numberOfVolumes "Число участков разбиения газохода (используется в формуле аэродинамического сопротивления участка)";
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
  annotation(
    Documentation(info = "<HTML></html>"),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    version = "",
    uses);
end BaseGFHE_simple;
