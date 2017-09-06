within TPPSim.HRSG_HeatExch;
model FlowSideECO
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseFlowSideHE(redeclare replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
  import TPPSim.functions.alfaForSH;
  //Переменные
  Medium.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
  Real x_v "Степень сухости";
  Medium.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
  Medium.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
  Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
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
  alfa_flow = alfaForSH(h_v = h_v, D_flow_n1 = D_flow_in, p_v = p_v, Din = Din, f_flow = f_flow);
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium.setState_ph(p_v, h_v[i, j]);
  x_v = if h_v < hl then 0 elseif h_v > hv then 1 else (h_v - hl) / (hv - hl);
  D_flow_v = -waterOut.m_flow;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
  -waterOut.m_flow = D_flow_in "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
  sat_v = Medium.setSat_p(p_v);
  hl = Medium.bubbleEnthalpy(sat_v);
  hv = Medium.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
  p_v = waterIn.p;
  lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
  Xi_flow = lambda_tr * deltaLpipe / Din;
  dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * 1000 / 2 / Modelica.Constants.g_n;
  if DynamicMomentum then
    waterIn.p - waterOut.p = dp_fric + der(-waterOut.m_flow) * deltaLpipe / f_flow;
  else
    waterIn.p - waterOut.p = dp_fric;
  end if;
  dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
initial equation
  if DynamicEnergyBalance == true then
    der(h_v) = 0;
    der(h_n[2]) = 0;
  end if;
  if DynamicTm == true then
    der(t_m) = 0;
  end if;
  if DynamicMomentum then
    der(-waterOut.m_flow) = 0;
  end if;
  annotation(
    Documentation(info = "Модель экономайзер. Жидкость несжимаема. Коэффициент теплоотдачи к воде не учитывает ее кипение."),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
end FlowSideECO;