within TPPSim.Pipes;
model SteamPipe "Модель паропровода"
  extends TPPSim.Pipes.BaseClases.BasePipe(redeclare replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
  import TPPSim.functions.alfaForSH;
  import TPPSim.functions.calc_rho_v;
  import TPPSim.functions.drdh_drdp;
  //Переменные
  Modelica.SIunits.DerDensityByPressure drdp_v;
  Medium_F.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
  Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
  Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
  Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
equation
//0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
//0.5 * deltaVFlow * rho_v * der(h_n[2]) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя";
//deltaVFlow * rho_v * der(h_v) = -D_flow_v * (h_n[2] - h_n[1]);
  deltaVFlow * rho_v * der(h_v) = alfa_flow * deltaSFlow * (t_m - t_flow) - (D_flow_n[2] * h_n[2] - D_flow_n[1] * h_n[1]);
//0.5 * deltaVFlow * rho_v * der(h_n[2]) = -D_flow_v * (h_n[2] - h_v);
  h_v = h_n[2];
//Уравнение теплового баланса металла
  deltaMMetal * C_m * der(t_m) = -alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения состояния
  stateFlow = Medium_F.setState_ph(p_v, h_v);
  t_flow = Medium_F.temperature(stateFlow);
//drdp_v = Medium_F.density_derp_h(stateFlow);
  (, drdp_v) = drdh_drdp(h_v, h_n, p_v, p_n);
  rho_v = Medium_F.density(stateFlow);
//Уравнения для расчета процессов теплообмена
  w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
  alfa_flow = 20000;
//alfa_flow = alfaForSH(h_v = h_v, D_flow_n1 = D_flow_n[1], p_v = p_v, Din = Din, f_flow = f_flow) if t_m > t_flow else 4000;
//Про две фазы
  D_flow_v = D_flow_n[2];
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
  D_flow_n[2] = D_flow_n[1] - deltaVFlow * drdp_v * der(p_v) "Уравнение сплошности";
//drdp_new = if abs(p_n[2] - p_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
  sat_v = Medium_F.setSat_p(p_v);
  hl = Medium_F.bubbleEnthalpy(sat_v);
  hv = Medium_F.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
  p_v = p_n[1];
  lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
  Xi_flow = lambda_tr * Lpipe / Din;
  dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
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
  if DynamicMomentum then
    der(D_flow_n[2]) = 0;
  end if;
  annotation(
    Documentation(info = "<html>
        <body>
          <p>Модель паропровода с коэффициентом теплоотдачи между стенкой и паром равным 20000. Имеется ввиду,  что теплообмен происходит при конденсации что справедливо для пароотводящих труб барабанов и сепараторов во время пуска.</p>
        </body>
      </html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end SteamPipe;