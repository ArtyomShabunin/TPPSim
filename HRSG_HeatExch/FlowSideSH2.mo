within TPPSim.HRSG_HeatExch;
model FlowSideSH2
  import TPPSim.functions.alfaForSH;
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseFlowSideHE(redeclare replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model");
  Boolean SH_cold(start = true, fixed = true);
  Modelica.SIunits.DerDensityByEnthalpy drdh_v "Производная плотности потока по энтальпии на участках ряда труб";
  Modelica.SIunits.DerDensityByPressure drdp_v "Производная плотности потока по давлению на участках ряда труб";
algorithm
  when t_m >= stateFlow.T and SH_cold then
    SH_cold := false;
  end when;
equation
  if DynamicEnergyBalance then
    if noEvent(SH_cold) then
      deltaVFlow * stateFlow.d * der(h_v) = -D_flow_in * (h_n[2] - h_n[1]);
    else
      deltaVFlow * stateFlow.d * der(h_v) = alfa_flow * deltaSFlow * (t_m - stateFlow.T) - ((-waterOut.m_flow * h_n[2]) - D_flow_in * h_n[1]);
    end if;
  else
    if noEvent(SH_cold) then
      h_n[1] = h_n[2];
    else
      D_flow_in * (h_n[2] - h_n[1]) = alfa_flow * deltaSFlow * (t_m - stateFlow.T);
    end if;
  end if;
  h_v = h_n[2];
//Уравнение теплового баланса металла
  if DynamicTm then
    if noEvent(SH_cold) then
      deltaMMetal * C_m * der(t_m) = Q_flow;
    else
      deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - stateFlow.T) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
    end if;
  else
    if noEvent(SH_cold) then
      Q_flow = 0;
    else
      Q_flow = alfa_flow * deltaSFlow * (t_m - stateFlow.T);
    end if;
  end if;
//Уравнения для heat
  heat.Q_flow = Q_flow;
  heat.T = t_m;
//Уравнения состояния
  stateFlow = Medium.setState_ph(p_v, h_v);
  drdp_v = Medium.density_derp_h(stateFlow);
  drdh_v = Medium.density_derh_p(stateFlow);
  w_flow_v = D_flow_v / stateFlow.d / f_flow "Расчет скорости потока вода/пар в конечных объемах";
  alfa_flow = alfaForSH(h_v = h_v, D_flow_n1 = D_flow_in, p_v = p_v, Din = Din, f_flow = f_flow);
  D_flow_v = -waterOut.m_flow;
  if DynamicMassBalance == true then
    if noEvent(SH_cold) then
      -waterOut.m_flow = D_flow_in - deltaVFlow * drdp_v * der(p_v);
    else
      -waterOut.m_flow = D_flow_in - deltaVFlow * (drdh_v * der(h_v) + drdp_v * der(p_v)) "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
    end if;
  else
    -waterOut.m_flow = D_flow_in;
  end if;
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
  p_v = waterIn.p;
//Основное уравнение гидравлики
  lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
  Xi_flow = lambda_tr * deltaLpipe / Din;
  dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * stateFlow.d / 2 / Modelica.Constants.g_n;
  if DynamicMomentum then
    waterIn.p - waterOut.p = dp_fric + der(D_flow_v) * deltaLpipe / f_flow;
//waterIn.p - waterOut.p = dp_fric + der(w_flow_v) * deltaLpipe * rho_v;
  else
    waterIn.p - waterOut.p = dp_fric;
  end if;
initial equation
  if DynamicEnergyBalance and DynamicMassBalance then
    der(h_v) = 0;
    der(p_v) = 0;
  end if;
  if DynamicEnergyBalance == true and DynamicMassBalance == false then
    der(h_v) = 0;
  end if;
  if DynamicEnergyBalance == false and DynamicMassBalance == true then
    der(h_v) = 0;
    der(p_v) = 0;
  end if;
  if DynamicTm then
    der(t_m) = 0;
  end if;
  if DynamicMomentum then
    der(D_flow_v) = 0;
  end if;
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end FlowSideSH2;