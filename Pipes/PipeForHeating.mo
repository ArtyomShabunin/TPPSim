within TPPSim.Pipes;
model PipeForHeating "Модель для расчета прогрева паропровода"
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
  deltaVFlow * rho_v * der(h_v) = alfa_flow * deltaSFlow * (t_m - t_flow) - (D_flow_n[2] * h_n[2] - D_flow_n[1] * h_n[1]);
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
//alfa_flow = 20000;
  alfa_flow = alfaForSH(h_v = h_v, D_flow_n1 = D_flow_n[1], p_v = p_v, Din = Din, f_flow = f_flow);
//Про две фазы
  D_flow_v = D_flow_n[2];
  D_flow_n[2] = D_flow_n[1] "Уравнение сплошности";
  sat_v = Medium_F.setSat_p(p_v);
  hl = Medium_F.bubbleEnthalpy(sat_v);
  hv = Medium_F.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
  p_v = p_n[1];
  lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
  Xi_flow = lambda_tr * Lpipe / Din;
  dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
  p_n[1] - p_n[2] = dp_fric;
  dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
initial equation
  der(h_v) = 0;
  der(t_m) = 0;
  annotation(
    Documentation(info = "<html>
        <body>
          <p>Модель для расчета прогрева паропровода</p>
        </body>
      </html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end PipeForHeating;