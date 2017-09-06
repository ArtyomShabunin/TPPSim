within TPPSim.Drums;
model Separator
  //Вспомогательные функции
  extends TPPSim.Drums.BaseClases.Icons.Separator_Icon;

  function separatorWaterVolume "Формула для расчета объема воды в сепараторе"
    extends Modelica.Icons.Function;
    input Real R "внутренний радиус сепаратора";
    input Real Hw "уровень воды в сепараторе";
    output Real V "объем занимаемый водой в сепараторе";
  algorithm
    V := Hw * Modelica.Constants.pi * R ^ 2;
  end separatorWaterVolume;

  function separatorMetallVolume "Объем металла над и под уровнем воды в сепараторе"
    extends Modelica.Icons.Function;
    input Real R "внутренний радиус барабана";
    input Real delta "толщина стенки барабана";
    input Real L "длина сепаратора";
    input Real Hw "уровень воды в сепараторе";
    input String area "верх или низ сепаратора";
    output Real V "объем металла";
  protected
    Real Vbottom;
    Real Vtop;
  algorithm
    Vbottom := Hw * Modelica.Constants.pi * ((R + delta) ^ 2 - R ^ 2) + delta * Modelica.Constants.pi * R ^ 2;
    Vtop := (L - Hw) * Modelica.Constants.pi * ((R + delta) ^ 2 - R ^ 2) + delta * Modelica.Constants.pi * R ^ 2;
    V := if area == "top" then Vtop else Vbottom;
  end separatorMetallVolume;

  function separatoSteamSurface "Расчет площади внутренней поверхности парового объема сепаратора"
  end separatoSteamSurface;

  //***Исходные данные
  replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  parameter Medium.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
  parameter Real k = 0.9 "Доля пара, которая практически сразу выделяется из водяного объема";
  //***Геометрические характеристики сепаратора
  parameter Integer n_sep = 1 "Количество сепараторов";
  parameter Modelica.SIunits.Length Din "Внутренний диаметр сепаратора";
  parameter Modelica.SIunits.Length L "Длина (высота) сепаратора";
  parameter Modelica.SIunits.Length delta "Толщина стенки сепаратора";
  //**
  //***Характеристики металла
  parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
    Dialog(group = "Металл"));
  parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
    Dialog(group = "Металл"));
  //**
  //Начальные значения
  //**
  parameter Modelica.SIunits.Length Hw_start = 2 "Начальное значение уровня воды в сепараторе";
  parameter Medium.AbsolutePressure ps_start "Начальное значение давления пара в барабане";
  parameter Medium.Temperature t_start "Стартовая температура";
  parameter Medium.SaturationProperties sat_start "State vector to compute saturation properties для парового объема (стартовый)";
  parameter Modelica.SIunits.Volume Vw_start = separatorWaterVolume(Din / 2, Hw_start);
  parameter Modelica.SIunits.Mass Gw_start = Vw_start * Medium.bubbleDensity(Medium.setSat_p(ps_start));
  //**
  //Переменные
  //**
  Modelica.SIunits.Volume Vs "Объем парового пространства сепаратора";
  Medium.Temperature ts "Температура насыщения в сепараторе";
  Medium.ThermodynamicState state_eco "Термодинамическое состояние потока питательной воды";
  Real x_eco "Степень сухости питательной воды";
  Medium.SaturationProperties sat "State vector to compute saturation properties для парового объема";
  Medium.Temperature t_m_steam(start = t_start) "Температура металла паровой части барабана";
  Medium.Temperature t_m_water(start = t_start) "Температура металла водяной части барабана";
  Medium.MassFlowRate D_fw "Расход питательной воды";
  Medium.MassFlowRate D_st_eco "Расход пара из питательной воды или необходимый для нагрева до h' недогретой питательной воды";
  Medium.MassFlowRate Dsteam(start = -1.44504, nominal = -1.44504) "Расход пара из сепаратора";
  Medium.MassFlowRate D_cond_dr "Пар конденсирующийся на стенках барабана";
  Modelica.SIunits.Mass G_m_steam(start = rho_m * separatorMetallVolume(Din / 2, delta, L, Hw_start, "top")) "Масса металла паровой части сепаратора";
  Modelica.SIunits.Mass G_m_water(start = rho_m * separatorMetallVolume(Din / 2, delta, L, Hw_start, "bottom")) "Масса металла водяной части сепараратора";
  Modelica.SIunits.DerDensityByPressure d_rhoDew_by_press "Производная плотности сухого пара от давления";
  Medium.MassFlowRate Dvipar "Выпар в паровой объем";
  Modelica.SIunits.Length Hw(start = Hw_start) "Уровень воды в сепараторе";
  Modelica.SIunits.Volume Vw(start = Vw_start, nominal = Vw_start, min = 0, max = separatorWaterVolume(Din / 2, L)) "Объем водяной части барабана";
  Medium.MassFlowRate D_downStr "Расход воды в сливную трубу";
  Medium.AbsolutePressure ps(start = ps_start) "Давление насыщения в сепараторе";
  Medium.SpecificEnthalpy h_dew(start = Medium.bubbleEnthalpy(sat_start)) "Энтальпия пара на линии насыщения при давлении в сепараторе";
  Medium.SpecificEnthalpy h_bubble(start = Medium.bubbleEnthalpy(sat_start)) "Энтальпия воды на линии насыщения при давлении в сепараторе";
  Medium.AbsolutePressure pw(start = ps_start + 0.5 * Hw_start * Medium.bubbleDensity(Medium.setSat_p(ps_start)) * Modelica.Constants.g_n) "Давление воды в барабане";
  Medium.Density rhow "Плотность воды в сепараторе";
  Medium.SpecificEnthalpy hw(start = Medium.bubbleEnthalpy(sat_start)) "Энтальпия воды в водяном объеме";
  Medium.ThermodynamicState state_w "Термодинамическое состояние воды в водяном объеме";
  Real x_w "Степень сухости воды в водяном объеме";
  Modelica.SIunits.Mass Gw(start = Gw_start, nominal = separatorWaterVolume(Din / 2, Hw_start) * Medium.bubbleDensity(Medium.setSat_p(ps_start)), min = 0, fixed = true) "Масса воды в барабане";
  Medium.SaturationProperties sat_w "State vector to compute saturation properties для водяного объема";
  Medium.MassFlowRate D_w_eco "Расход воды из экономайзера, с учетом выделившегося или дополнительно конденсировавшегося пара";
  Medium.Density rhow_dew "Плотность воды на линии насыщения в водяном объеме сепаратора";
  Medium.Density rhow_bubble "Плотность пара на линии насыщения в водяном объеме сепаратора";
  Real alpha_cond;
  //***Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a fedWater(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-104, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b steam(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b downStr(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput waterLevel annotation(
    Placement(visible = true, transformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput steamFeedback annotation(
    Placement(visible = true, transformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput drainFeedback annotation(
    Placement(visible = true, transformation(origin = {110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
//Временные ур-я
  fedWater.m_flow = D_fw;
  steamFeedback = -Dsteam;
  drainFeedback = -(D_fw + Dsteam);
//С обратной связью надо что-то делать!!!
  waterLevel = Hw;
//Паровое пространство барабана
  state_eco = Medium.setState_ph(ps, inStream(fedWater.h_outflow));
  x_eco = Medium.vapourQuality(state_eco);
  sat = Medium.setSat_p(ps);
  ts = Medium.saturationTemperature_sat(sat);
  h_dew = Medium.dewEnthalpy(sat);
  h_bubble = Medium.bubbleEnthalpy(sat);
  alpha_cond = 20000;
  D_cond_dr * (h_dew - h_bubble) = alpha_cond * (ts - t_m_steam);
  D_st_eco = D_fw * (if inStream(fedWater.h_outflow) > h_dew then 1 elseif inStream(fedWater.h_outflow) < h_bubble then 0 else (inStream(fedWater.h_outflow) - h_bubble) / (h_dew - h_bubble));
  G_m_steam = rho_m * n_sep * separatorMetallVolume(Din / 2, delta, L, Hw, "top");
  D_cond_dr * (h_dew - h_bubble) = G_m_steam * C_m * der(t_m_steam);
  der(ps) = (D_st_eco + Dvipar + Dsteam - D_cond_dr) / Vs / d_rhoDew_by_press "Уравнение определения давления в паровом пространстве";
  ps = steam.p;
  d_rhoDew_by_press = Medium.dDewDensity_dPressure(sat);
  Vs = n_sep * 0.25 * Modelica.Constants.pi * Din ^ 2 * L - Vw;
//Водяное пространство барабана
  D_w_eco = D_fw * (if inStream(fedWater.h_outflow) > h_dew then 0 elseif inStream(fedWater.h_outflow) < h_bubble then 1 else (h_dew - inStream(fedWater.h_outflow)) / (h_dew - h_bubble));
  Dvipar = Gw * x_w * k;
  pw = ps + 0.5 * Hw * rhow * Modelica.Constants.g_n;
  sat_w = Medium.setSat_p(pw);
  rhow = Medium.density_ph(pw, hw);
  state_w = Medium.setState_ph(pw, hw);
  x_w = Medium.vapourQuality(state_w);
  t_m_water = Medium.saturationTemperature(pw) "Принимаем, что нижняя стенка барабанна в каждый момент времени равна температуре насыщения в водяном пространстве барабана";
  G_m_water = rho_m * separatorMetallVolume(Din / 2, delta, L, Hw, "bottom");
  D_w_eco + D_cond_dr + D_downStr - Dvipar = der(Gw);
//D_w_circ * h_dew + D_w_eco * h_dew - D_downStr * hw - Dvipar * h_bubble = der(Gw * hw + G_m_water * C_m * t_m_water);
  D_w_eco * h_bubble + D_downStr * hw - Dvipar * h_dew = Gw * der(hw) + G_m_water * C_m * der(t_m_water);
  rhow_dew = Medium.dewDensity(sat_w);
  rhow_bubble = Medium.bubbleDensity(sat_w);
  Vw = Gw * (1 - x_w) / rhow_bubble + Gw * x_w * (1 - k) / rhow_dew;
  Vw = n_sep * separatorWaterVolume(Din / 2, Hw);
//Питательная вода
  fedWater.h_outflow = hw;
  fedWater.p = ps;
//Выход насыщенного пара
  steam.h_outflow = if inStream(fedWater.h_outflow) > h_dew then inStream(fedWater.h_outflow) else h_dew;
  steam.m_flow = -(D_st_eco + Dvipar + Dsteam - D_cond_dr);
//Опускной стояк
  downStr.h_outflow = if inStream(fedWater.h_outflow) < h_bubble then inStream(fedWater.h_outflow) else hw;
  downStr.m_flow = D_downStr;
  downStr.p = pw;
initial equation
//der(t_m_steam) = 0;
  der(ps) = 0;
//der(Gw) = 0;
  der(hw) = 0;
  annotation(
    uses(Modelica(version = "3.2.1")));
end Separator;