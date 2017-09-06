within TPPSim.Pipes;
model Pipe
  extends TPPSim.Pipes.BaseClases.BasePipe(redeclare replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
  import TPPSim.functions.alfaFor2ph;
  import TPPSim.functions.calc_rho_v;
  //Переменные
  Modelica.SIunits.DerDensityByPressure drdp_new;
  Medium_F.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
  Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
  Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
  Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
equation
//0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
//0.5 * deltaVFlow * rho_v * der(h_n[2]) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя";
  0.5 * deltaVFlow * rho_v * der(h_v) = -D_flow_v * (h_v - h_n[1]);
  0.5 * deltaVFlow * rho_v * der(h_n[2]) = -D_flow_v * (h_n[2] - h_v);
//Уравнение теплового баланса металла
  deltaMMetal * C_m * der(t_m) = -alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения состояния
  stateFlow = Medium_F.setState_ph(p_v, h_v);
  t_flow = Medium_F.temperature(stateFlow);
  rho_v = calc_rho_v(h_n, p_v);
//Уравнения для расчета процессов теплообмена
  w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
  alfa_flow = alfaFor2ph(h_n = h_n, D_flow_v = D_flow_v, p_v = p_v, Din = Din, f_flow = f_flow);
//Про две фазы
  D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
  D_flow_n[2] = D_flow_n[1] - deltaVFlow * drdp_new * der(p_v) "Уравнение сплошности";
  drdp_new = if abs(p_n[2] - p_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
  sat_v = Medium_F.setSat_p(p_v);
  hl = Medium_F.bubbleEnthalpy(sat_v);
  hv = Medium_F.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
  p_v = p_n[1];
  lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
  Xi_flow = lambda_tr * Lpipe / Din;
  dp_fric = w_flow_v ^ 2 * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
//p_n[1] - p_n[2] = dp_fric;
  if DynamicMomentum then
    p_n[1] - p_n[2] = dp_fric + der(D_flow_n[2]) * Lpipe / f_flow;
  else
    p_n[1] - p_n[2] = dp_fric;
  end if;
  dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
initial equation
  der(h_v) = 0;
  der(t_m) = 0;
  der(p_v) = 0;
  der(h_n[2]) = 0;
  if DynamicMomentum then
    der(D_flow_n[2]) = 0;
  end if;
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end Pipe;