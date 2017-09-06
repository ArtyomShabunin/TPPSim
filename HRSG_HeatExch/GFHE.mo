within TPPSim.HRSG_HeatExch;
model GFHE
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseGFHE;
  //Исходные данные по разбиению
  parameter Integer numberOfVolumes "Число участков разбиения";
  final inner parameter Integer numberOfFlueSections = numberOfVolumes "Число участков разбиения газохода";
  //Конструктивные характеристики
protected
  inner parameter Modelica.SIunits.Area f_flow = zahod * Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
  inner parameter Modelica.SIunits.Length deltaLpipe = Lpipe * z2 / zahod / numberOfVolumes "Длина теплообменной трубки для элемента разбиения";
  inner parameter Modelica.SIunits.Area deltaSFlow = deltaLpipe * zahod * Modelica.Constants.pi * Din * z1 "Внутренняя площадь одного участка ряда труб";
  inner parameter Modelica.SIunits.Volume deltaVFlow = deltaLpipe * f_flow "Внутренний объем одного участка ряда труб";
  inner parameter Modelica.SIunits.Mass deltaMMetal = rho_m * deltaLpipe * zahod * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 "Масса металла участка ряда труб";
  inner parameter Modelica.SIunits.Volume deltaVGas = Lpipe * (s1 * s2 - Modelica.Constants.pi * (Din + 2 * delta) ^ 2 / 4) * z1 * z2 / numberOfVolumes "Объем одного участка газового тракта";
  inner parameter Modelica.SIunits.Area f_gas = (1 - (Din + 2 * delta) / s1 * (1 + 2 * hfin * delta_fin / sfin / (Din + 2 * delta))) * Lpipe * s2 * z1 "Площадь для прохода газов";
  //Характеристики оребрения
  inner parameter Real H_fin = (omega * Lpipe * (1 - delta_fin / sfin) + (2 * Modelica.Constants.pi * (Dfin ^ 2 - (Din + 2 * delta) ^ 2) / 4 + Modelica.Constants.pi * Dfin * delta_fin) * (Lpipe / sfin)) * z1 * z2 / numberOfVolumes "Площадь оребренной поверхности";
  TPPSim.HRSG_HeatExch.GasSideHE gasHE[numberOfVolumes](redeclare package Medium = Medium_G, DynamicEnergyBalance = gas_DynamicEnergyBalance, DynamicMassBalance = gas_DynamicMassBalance) annotation(
    Placement(visible = true, transformation(origin = {0, -36}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  replaceable TPPSim.HRSG_HeatExch.FlowSideOTE flowHE[numberOfVolumes](redeclare package Medium = Medium_F, DynamicMomentum = flow_DynamicMomentum, DynamicMassBalance = flow_DynamicMassBalance, DynamicEnergyBalance = flow_DynamicEnergyBalance, DynamicTm = flow_DynamicTm) annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
equation
  connect(flowIn, flowHE[1].waterIn) annotation(
    Line(points = {{-50, 50}, {-26, 50}, {-26, 50}, {-30, 50}}));
  connect(flowHE[numberOfVolumes].waterOut, flowOut) annotation(
    Line(points = {{30, 50}, {48, 50}, {48, 50}, {50, 50}}, color = {0, 127, 255}, thickness = 0.5));
  connect(gasIn, gasHE[1].gasIn) annotation(
    Line(points = {{-50, -50}, {-30, -50}, {-30, -50}, {-30, -50}}));
  connect(gasHE[numberOfVolumes].gasOut, gasOut) annotation(
    Line(points = {{30, -50}, {52, -50}, {52, -50}, {50, -50}}, color = {0, 127, 255}, thickness = 0.5));
  for i in 1:numberOfVolumes - 1 loop
    connect(gasHE[i].gasOut, gasHE[i + 1].gasIn);
    connect(flowHE[i].waterOut, flowHE[i + 1].waterIn);
  end for;
  for i in 1:numberOfVolumes loop
    connect(flowHE[i].heat, gasHE[numberOfVolumes + 1 - i].heat);
  end for;
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    version = "",
    uses);
end GFHE;