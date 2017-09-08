within TPPSim.HRSG_HeatExch;
model FlowSide2phHE
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
    0.5 * deltaVFlow * stateFlow.d * der(stateFlow.h) = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T) - D_flow_v * (stateFlow.h - h_gl[section[1], section[2]]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
    0.5 * deltaVFlow * stateFlow.d * der(h_gl[section[1], section[2] + 1]) = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T) - D_flow_v * (h_gl[section[1], section[2] + 1] - stateFlow.h) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
  else
    0 = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T) - D_flow_v * (stateFlow.h - h_gl[section[1], section[2]]);
    0 = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T) - D_flow_v * (h_gl[section[1], section[2] + 1] - stateFlow.h);
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
  stateFlow.d = Medium.density_ph(stateFlow.p, stateFlow.h);
  stateFlow.T = Medium.temperature_ph(stateFlow.p, stateFlow.h);
  stateFlow.phase = Modelica.Media.Water.IF97_Utilities.phase_ph.phase_ph(stateFlow.p, stateFlow.h);
//Уравнения для расчета процессов теплообмена
  w_flow_v = D_flow_v / stateFlow.d / f_flow "Расчет скорости потока вода/пар в конечных объемах";
//Про две фазы
  x_v = if noEvent(stateFlow.h < hl) then 0 elseif noEvent(stateFlow.h > hv) then 1 else (stateFlow.h - hl) / (hv - hl);
  D_flow_v = D_gl[section[1], section[2] + 1];
  D_gl[section[1], section[2] + 1] = D_gl[section[1], section[2]] - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
  if DynamicMassBalance == true then
    C1 = deltaVFlow * drdh * der(stateFlow.h);
    C2 = deltaVFlow * drdp * der(stateFlow.p);
  else
    C1 = 0;
    C2 = 0;
  end if;
  drdp = min(0.0005, Medium.density_derp_h(stateFlow));
  drdh = max(-0.002, Medium.density_derh_p(stateFlow));
  sat_v = Medium.setSat_p(stateFlow.p);
  hl = Medium.bubbleEnthalpy(sat_v);
  hv = Medium.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
  stateFlow.p = p_gl[section[1], section[2]];
  lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
  Xi_flow = lambda_tr * deltaLpipe / Din;
  dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * stateFlow.d / 2 / Modelica.Constants.g_n;
  if DynamicMomentum then
    p_gl[section[1], section[2]] - p_gl[section[1], section[2] + 1] = dp_fric + der(D_flow_v) * deltaLpipe / f_flow;
  else
    p_gl[section[1], section[2]] - p_gl[section[1], section[2] + 1] = dp_fric;
  end if;
  dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
initial equation
  if DynamicEnergyBalance == true and DynamicMassBalance == true then
    der(stateFlow.h) = 0;
    der(h_gl[section[1], section[2] + 1]) = 0;
    der(stateFlow.p) = 0;
  end if;
  if DynamicEnergyBalance == true and DynamicMassBalance == false then
    der(stateFlow.h) = 0;
    der(h_gl[section[1], section[2] + 1]) = 0;
  end if;
  if DynamicEnergyBalance == false and DynamicMassBalance == true then
    der(stateFlow.h) = 0;
    der(stateFlow.p) = 0;
  end if;
  if DynamicTm == true then
    der(t_m) = 0;
  end if;
  if DynamicMomentum then
    der(D_flow_v) = 0;
  end if;
  annotation(
    Documentation(info = "<html><head></head><body>Аналог FlowSideOTE3 с глобальными переменными</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>August 15, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end FlowSide2phHE;
