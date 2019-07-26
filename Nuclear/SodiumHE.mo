within TPPSim.Nuclear;

model SodiumHE
  extends TPPSim.Nuclear.BaseClases.BaseSteamGenerator;
  extends TPPSim.Nuclear.BaseClases.Icons.IconSodiumHE;
  replaceable package Medium_S = TPPSim.Media.Sodium_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
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
  inner Medium_F.SpecificEnthalpy h_gl[1, numberOfVolumes + 1](start=fill(h_flow_start, 1, numberOfVolumes+1)) "Энтальпия вода/пар (глобальная переменная)";
  inner Medium_F.MassFlowRate D_gl[1, numberOfVolumes + 1](start=fill(m_flow_start, 1, numberOfVolumes+1)) "Массовый расход вода/пар (глобальная переменная)";
  inner Medium_F.AbsolutePressure p_gl[1, numberOfVolumes + 1](start=fill(p_flow_start, 1, numberOfVolumes+1)) "Давление вода/пар (глобальная переменная)";

  inner Medium_S.SpecificEnthalpy hsodium_gl[numberOfVolumes + 1, 1](start=fill(TPPSim.Media.Sodium_ph.specificEnthalpy_pT(p_sodium_start, T_sodium_start), numberOfVolumes+1, 1)) "Энтальпия газов (глобальная переменная)";
  inner Medium_S.MassFlowRate Dsodium_gl[numberOfVolumes + 1, 1] "Массовый расход газов (глобальная переменная)";
  inner Medium_S.AbsolutePressure psodium_gl[numberOfVolumes + 1, 1] "Давление газов (глобальная переменная)";
    
  replaceable TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE[1, numberOfVolumes](redeclare package Medium = Medium_F, section = coorSecGen(1, numberOfVolumes), deltaHpipe = fill(deltaLpipe, 1, numberOfVolumes)) annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));

  TPPSim.Nuclear.SodiumSideHE sodiumHE[numberOfVolumes, 1](redeclare package Medium = Medium_S, section = coorSecGen(numberOfVolumes, 1)) annotation(
    Placement(visible = true, transformation(origin = {0, -32}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  //  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature heat[numberOfVolumes, 1](T = system.T_start) annotation(
  //    Placement(visible = true, transformation(origin = {-32, 86}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //  outer Modelica.Fluid.System system;
  Modelica.Fluid.Interfaces.FluidPort_a sodiumIn(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b sodiumOut(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
//  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow heat2[numberOfVolumes, 1](Q_flow = 0)  annotation(
//    Placement(visible = true, transformation(origin = {28, 88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = { 50, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
// Тепловые потоки
  for i in 1:numberOfVolumes loop
//    connect(heat[i, 1].port, sodiumHE[i, 1].heat);
//    connect(heat2[i, 1].port, flowHE[1, i].heat);
    connect(flowHE[1, i].heat, sodiumHE[numberOfVolumes - i + 1, 1].heat);
  end for;
// Вода/Пар
  h_gl[1, 1] = inStream(flowIn.h_outflow);
  flowIn.h_outflow = h_gl[1, 1];
  D_gl[1, 1] = flowIn.m_flow;
  p_gl[1, 1] = flowIn.p;
  h_gl[1, numberOfVolumes + 1] = flowOut.h_outflow;
  D_gl[1, numberOfVolumes + 1] = -flowOut.m_flow;
  p_gl[1, numberOfVolumes + 1] = flowOut.p;
// Натрий
  hsodium_gl[1, 1] = inStream(sodiumIn.h_outflow);
  sodiumIn.h_outflow = hsodium_gl[1, 1];
  Dsodium_gl[1, 1] = sodiumIn.m_flow;
  psodium_gl[1, 1] = sodiumIn.p;
  hsodium_gl[numberOfVolumes + 1, 1] = sodiumOut.h_outflow;
  Dsodium_gl[numberOfVolumes + 1, 1] = -sodiumOut.m_flow;
  psodium_gl[numberOfVolumes + 1, 1] = sodiumOut.p;
end SodiumHE;
