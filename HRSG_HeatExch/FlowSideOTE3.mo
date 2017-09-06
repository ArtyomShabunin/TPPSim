within TPPSim.HRSG_HeatExch;
model FlowSideOTE3
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseFlowSideHE(redeclare replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
  //Переменные
  Modelica.SIunits.DerDensityByEnthalpy drdh;
  Modelica.SIunits.DerDensityByPressure drdp;
  Medium.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
  Real x_v "Степень сухости";
  Medium.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
  Medium.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
  Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
  Real C1 "Показатель в числителе уравнения сплошности";
  Real C2 "Показатель в знаменателе уравнения сплошности";
equation
  if DynamicEnergyBalance == true then
    0.5 * deltaVFlow * stateFlow.d * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
    0.5 * deltaVFlow * stateFlow.d * der(h_n[2]) = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
  else
    0 = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T) - D_flow_v * (h_v - h_n[1]);
    0 = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T) - D_flow_v * (h_n[2] - h_v);
  end if;
//Уравнение теплового баланса металла
  if DynamicTm == true then
    deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - stateFlow.T) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
  else
    0 = Q_flow - alfa_flow * deltaSFlow * (t_m - stateFlow.T);
  end if;
//Уравнения для heat
  heat.Q_flow = Q_flow;
  heat.T = t_m;
//Уравнения состояния
  stateFlow = Medium.setState_ph(p_v, h_v);
//Уравнения для расчета процессов теплообмена
  w_flow_v = D_flow_v / stateFlow.d / f_flow "Расчет скорости потока вода/пар в конечных объемах";
  alfa_flow = 20000;
//Про две фазы
  x_v = if noEvent(h_v < hl) then 0 elseif noEvent(h_v > hv) then 1 else (h_v - hl) / (hv - hl);
  D_flow_v = -waterOut.m_flow;
  -waterOut.m_flow = D_flow_in - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
  if DynamicMassBalance == true then
    C1 = deltaVFlow * drdh * der(h_v);
    C2 = deltaVFlow * drdp * der(p_v);
  else
    C1 = 0;
    C2 = 0;
  end if;
  drdp = min(0.0005, Medium.density_derp_h(stateFlow));
  drdh = max(-0.002, Medium.density_derh_p(stateFlow));
  sat_v = Medium.setSat_p(p_v);
  hl = Medium.bubbleEnthalpy(sat_v);
  hv = Medium.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
  p_v = waterIn.p;
  lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
  Xi_flow = lambda_tr * deltaLpipe / Din;
  dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * stateFlow.d / 2 / Modelica.Constants.g_n;
  if DynamicMomentum then
    waterIn.p - waterOut.p = dp_fric + der(D_flow_v) * deltaLpipe / f_flow;
  else
    waterIn.p - waterOut.p = dp_fric;
  end if;
  dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
initial equation
  if DynamicEnergyBalance == true and DynamicMassBalance == true then
    der(h_v) = 0;
    der(h_n[2]) = 0;
    der(p_v) = 0;
  end if;
  if DynamicEnergyBalance == true and DynamicMassBalance == false then
    der(h_v) = 0;
    der(h_n[2]) = 0;
  end if;
  if DynamicEnergyBalance == false and DynamicMassBalance == true then
    der(h_v) = 0;
    der(p_v) = 0;
  end if;
  if DynamicTm == true then
    der(t_m) = 0;
  end if;
  if DynamicMomentum then
    der(D_flow_v) = 0;
  end if;
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
end FlowSideOTE3;