within TPPSim.HRSG_HeatExch;
model FlowSideOTE2
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseFlowSideHE(redeclare replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
  import TPPSim.functions.alfaFor2ph;
  import TPPSim.functions.calc_rho_v;
  import TPPSim.functions.calc_rho_drdh_drdp;
  //Переменные
  //Modelica.SIunits.DerDensityByEnthalpy drdh_new;
  //Modelica.SIunits.DerDensityByPressure drdp_new;
  Modelica.SIunits.DerDensityByEnthalpy drdh_v1, drdh_v2;
  Modelica.SIunits.DerDensityByPressure drdp_v;
  //Medium.Density rho_v_test;
  Medium.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
  Real x_v "Степень сухости";
  Medium.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
  Medium.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
  Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
  Real C1 "Показатель в числителе уравнения сплошности";
  Real C2 "Показатель в знаменателе уравнения сплошности";
equation
  0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
  0.5 * deltaVFlow * rho_v * der(h_n[2]) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
  deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
  heat.Q_flow = Q_flow;
  heat.T = t_m;
//Уравнения состояния
  stateFlow = Medium.setState_ph(p_v, h_v);
  t_flow = Medium.temperature(stateFlow);
//rho_v = calc_rho_v(h_n, p_v);
//Уравнения для расчета процессов теплообмена
  w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
  alfa_flow = alfaFor2ph(h_n = h_n, D_flow_v = D_flow_v, p_v = p_v, Din = Din, f_flow = f_flow);
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium.setState_ph(p_v, h_v[i, j]);
  x_v = if h_v < hl then 0 elseif h_v > hv then 1 else (h_v - hl) / (hv - hl);
  D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
  D_flow_n[2] = D_flow_n[1] - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
  C1 = deltaVFlow * (drdh_v1 * der(h_v) + drdh_v1 * der(h_n[2]));
  C2 = deltaVFlow * drdp_v * der(p_v);
  (rho_v, drdp_v, drdh_v1, drdh_v2) = calc_rho_drdh_drdp(h_n, p_v);
//drdh_new = if abs(h_n[2] - h_n[1]) > 0.01 then (Medium.density(Medium.setState_ph(p_v, h_n[2])) - Medium.density(Medium.setState_ph(p_v, h_n[1]))) / (h_n[2] - h_n[1]) else (Medium.density(Medium.setState_ph(p_v, h_n[2])) - Medium.density(Medium.setState_ph(p_v, h_n[2] - 0.01))) / 0.01;
//drdp_new = if abs(p_n[2] - p_n[1]) > 0.01 then (Medium.density(Medium.setState_ph(p_n[2], h_v)) - Medium.density(Medium.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium.density(Medium.setState_ph(p_n[2], h_v)) - Medium.density(Medium.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
  sat_v = Medium.setSat_p(p_v);
  hl = Medium.bubbleEnthalpy(sat_v);
  hv = Medium.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
  p_v = p_n[1];
  lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
  Xi_flow = lambda_tr * deltaLpipe / Din;
  dp_fric = w_flow_v ^ 2 * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
//p_n[1] - p_n[2] = dp_fric;
  p_n[1] - p_n[2] = dp_fric + der(D_flow_n[2]) * deltaLpipe / f_flow;
  dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
initial equation
  der(h_v) = 0;
  der(t_m) = 0;
  der(p_v) = 0;
  der(h_n[2]) = 0;
  der(D_flow_n[2]) = 0;
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
end FlowSideOTE2;