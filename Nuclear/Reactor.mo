within TPPSim.Nuclear;

model Reactor
  extends TPPSim.Nuclear.BaseClases.Icons.IconReactor;
  extends TPPSim.Nuclear.BaseClases.BaseSteamGenerator;
  replaceable package Medium_F = TPPSim.Media.Sodium_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  import Modelica.Fluid.Types;
  import TPPSim.functions.coorSecGen;
  parameter TPPSim.Choices.piez_type piez_type = TPPSim.Choices.piez_type.const "Способ расчета пьезометрического перепада давления";
  //Исходное состояние
  final outer parameter Boolean SH_cold_start "Исходное состояние - холодное";
  //Параметры разбиения
  parameter Integer numberOfVolumes "Число участков разбиения" annotation(
    Dialog(group = "Параметры разбиения"));
  //Расчетные параметры
  final inner parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z / 4 "Площадь для прохода теплоносителя";
  final inner parameter Modelica.SIunits.Length deltaLpipe = Lpipe / numberOfVolumes "Длина теплообменной трубки для элемента разбиения";
  final inner parameter Modelica.SIunits.Area deltaSFlow = deltaLpipe * Modelica.Constants.pi * Din * z "Внутренняя площадь одного участка";
  final inner parameter Modelica.SIunits.Volume deltaVFlow = k_volume * deltaLpipe * f_flow "Внутренний объем одного участка";
  final inner parameter Modelica.SIunits.Mass deltaMMetal = k_weight_metal * rho_m * deltaLpipe * Modelica.Constants.pi * ((Din + 2 * delta) ^ 2 - Din ^ 2) * z / 4 "Масса металла участка ряда труб";
  final inner parameter Modelica.SIunits.Area f_sodium = Modelica.Constants.pi * (Dcase ^ 2 - z * (Din + 2 * delta) ^ 2) / 4 "Площадь для прохода натрия";
  final inner parameter Modelica.SIunits.Volume deltaVSodium = k_volume_sodium * deltaLpipe * f_sodium "Объем одного участка по стороне натрия";
  final inner parameter Modelica.SIunits.Area H_sodium = deltaLpipe * Modelica.Constants.pi * (Din + 2 * delta) * z "Площадь поверхности теплообмена со стороны натрия";
  //Переменные
  inner Medium_F.SpecificEnthalpy h_gl[1, numberOfVolumes + 1](start = fill(h_flow_start, 1, numberOfVolumes + 1)) "Энтальпия вода/пар (глобальная переменная)";
  inner Medium_F.MassFlowRate D_gl[1, numberOfVolumes + 1](start = fill(m_flow_start, 1, numberOfVolumes + 1)) "Массовый расход вода/пар (глобальная переменная)";
  inner Medium_F.AbsolutePressure p_gl[1, numberOfVolumes + 1](start = fill(p_flow_start, 1, numberOfVolumes + 1)) "Давление вода/пар (глобальная переменная)";
  replaceable TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE[1, numberOfVolumes](redeclare package Medium = Medium_F, section = coorSecGen(1, numberOfVolumes), deltaHpipe = fill(deltaLpipe, 1, numberOfVolumes)) annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  //  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature heat[numberOfVolumes, 1](T = system.T_start) annotation(
  //    Placement(visible = true, transformation(origin = {-32, 86}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //  outer Modelica.Fluid.System system;
  //  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow heat2[numberOfVolumes, 1](Q_flow = 0)  annotation(
  //    Placement(visible = true, transformation(origin = {28, 88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heat_source[1, numberOfVolumes] annotation(
    Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput heat_in annotation(
    Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
// Тепловые потоки
  for i in 1:numberOfVolumes loop
    connect(heat_source[1, i].port, flowHE[1, i].heat);
    heat_source[1, i].Q_flow = heat_in / numberOfVolumes;
  end for;
// Охладитель
  h_gl[1, 1] = inStream(flowIn.h_outflow);
  flowIn.h_outflow = h_gl[1, 1];
  D_gl[1, 1] = flowIn.m_flow;
  p_gl[1, 1] = flowIn.p;
  h_gl[1, numberOfVolumes + 1] = flowOut.h_outflow;
  D_gl[1, numberOfVolumes + 1] = -flowOut.m_flow;
  p_gl[1, numberOfVolumes + 1] = flowOut.p;
equation

end Reactor;
