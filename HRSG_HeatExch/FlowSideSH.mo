within TPPSim.HRSG_HeatExch;
model FlowSideSH
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseFlowSideHE(redeclare replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model");
  import Modelica.Fluid.Types;
  outer parameter Boolean SH_cold_start "Исходное состояние - холодное";
  Boolean SH_cold(start = SH_cold_start, fixed = true);
  Modelica.SIunits.DerDensityByEnthalpy drdh "Производная плотности потока по энтальпии на участках ряда труб";
  Modelica.SIunits.DerDensityByPressure drdp "Производная плотности потока по давлению на участках ряда труб";
algorithm
  when t_m >= Medium.saturationTemperature(system.p_ambient) then
    SH_cold := false;
  end when;
equation
  if flowEnergyDynamics == Types.Dynamics.SteadyState then
    if noEvent(SH_cold) then
      stateFlow.h = h_gl[section[1], section[2]];
      h_gl[section[1], section[2] + 1] = stateFlow.h;
    else
      D_flow_v * (stateFlow.h - h_gl[section[1], section[2]]) = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T) ;
      D_flow_v * (h_gl[section[1], section[2] + 1] - stateFlow.h) = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T);
    end if;  
  else
    if noEvent(SH_cold) then
      0.5 * deltaVFlow * stateFlow.d * der(stateFlow.h) = - D_flow_v * (stateFlow.h - h_gl[section[1], section[2]]);
      0.5 * deltaVFlow * stateFlow.d * der(h_gl[section[1], section[2] + 1]) = - D_flow_v * (h_gl[section[1], section[2] + 1] - stateFlow.h);   
    else
      0.5 * deltaVFlow * stateFlow.d * der(stateFlow.h) = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T) - D_flow_v * (stateFlow.h - h_gl[section[1], section[2]]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
      0.5 * deltaVFlow * stateFlow.d * der(h_gl[section[1], section[2] + 1]) = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T) - D_flow_v * (h_gl[section[1], section[2] + 1] - stateFlow.h) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
    end if;
  end if;
//Уравнение теплового баланса металла
  if metalDynamics == Types.Dynamics.SteadyState then
    if noEvent(SH_cold) then
      Q_flow = 0;
    else
      Q_flow = alfa_flow * deltaSFlow * (t_m - stateFlow.T);
    end if;  
  else
    if noEvent(SH_cold) then
      deltaMMetal * C_m * der(t_m) = Q_flow;
    else
      deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - stateFlow.T) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
    end if;
  end if;
//Уравнения для heat
  heat.Q_flow = Q_flow;
  heat.T = t_m;
//Уравнения состояния
  stateFlow.d = Medium.density_ph(stateFlow.p, stateFlow.h);
  stateFlow.T = Medium.temperature_ph(stateFlow.p, stateFlow.h);
  stateFlow.phase = Modelica.Media.Water.IF97_Utilities.phase_ph.phase_ph(stateFlow.p, stateFlow.h);
  drdp = Medium.density_derp_h(stateFlow);
  drdh = Medium.density_derh_p(stateFlow);  
  w_flow_v = D_flow_v / stateFlow.d / f_flow "Расчет скорости потока вода/пар в конечных объемах";
  D_flow_v = D_gl[section[1], section[2] + 1];
  if flowMassDynamics == Types.Dynamics.SteadyState then
    D_gl[section[1], section[2] + 1] = D_gl[section[1], section[2]];  
  else
    if noEvent(SH_cold) then
      D_gl[section[1], section[2] + 1] = D_gl[section[1], section[2]] - deltaVFlow * drdp * der(stateFlow.p);
    else
      D_gl[section[1], section[2] + 1] = D_gl[section[1], section[2]] - deltaVFlow * (drdh * der(stateFlow.h) + drdp * der(stateFlow.p)) "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
    end if;
  end if;
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
  stateFlow.p = p_gl[section[1], section[2]];
//Основное уравнение гидравлики
  lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
  Xi_flow = lambda_tr * deltaLpipe / Din;
  dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * stateFlow.d / 2 / Modelica.Constants.g_n;
  if flowMomentumDynamics == Types.Dynamics.SteadyState then
    p_gl[section[1], section[2]] - p_gl[section[1], section[2] + 1] = dp_fric;
  else
    p_gl[section[1], section[2]] - p_gl[section[1], section[2] + 1] = dp_fric + der(D_flow_v) * deltaLpipe / f_flow;
  end if;
initial equation

  if flowEnergyDynamics == Types.Dynamics.FixedInitial and flowMassDynamics == Types.Dynamics.FixedInitial then
    h_gl[section[1], section[2] + 1] = h_flow_start;
    stateFlow.h = h_flow_start;
    stateFlow.p = p_flow_start;
  elseif flowEnergyDynamics == Types.Dynamics.SteadyStateInitial and flowMassDynamics == Types.Dynamics.SteadyStateInitial then
    der(stateFlow.h) = 0;
    der(h_gl[section[1], section[2] + 1]) = 0;
    der(stateFlow.p) = 0;
  elseif flowEnergyDynamics == Types.Dynamics.FixedInitial and flowMassDynamics == Types.Dynamics.SteadyStateInitial then
    h_gl[section[1], section[2] + 1] = h_flow_start;
    stateFlow.h = h_flow_start;
    der(stateFlow.p) = 0;
  elseif flowEnergyDynamics == Types.Dynamics.SteadyStateInitial and flowMassDynamics == Types.Dynamics.FixedInitial then
    der(stateFlow.h) = 0;
    der(h_gl[section[1], section[2] + 1]) = 0;
    stateFlow.p = p_flow_start;              
  elseif flowEnergyDynamics == Types.Dynamics.FixedInitial and flowMassDynamics == Types.Dynamics.SteadyState then
    h_gl[section[1], section[2] + 1] = h_flow_start;
    stateFlow.h = h_flow_start;
  elseif flowEnergyDynamics == Types.Dynamics.SteadyStateInitial and flowMassDynamics == Types.Dynamics.SteadyState then
    der(stateFlow.h) = 0;
    der(h_gl[section[1], section[2] + 1]) = 0;
  elseif flowEnergyDynamics == Types.Dynamics.SteadyState and flowMassDynamics == Types.Dynamics.FixedInitial then
    stateFlow.h = h_flow_start;
    stateFlow.p = p_flow_start;
  elseif flowEnergyDynamics == Types.Dynamics.SteadyState and flowMassDynamics == Types.Dynamics.SteadyStateInitial then
    der(stateFlow.h) = 0;
    der(stateFlow.p) = 0; 
  end if;
  
  if metalDynamics == Types.Dynamics.SteadyStateInitial then
    der(t_m) = 0;
  elseif metalDynamics == Types.Dynamics.FixedInitial then
    t_m = T_m_start;
  end if;

  if flowMomentumDynamics == Types.Dynamics.SteadyStateInitial then
    der(D_flow_v) = 0;
  elseif flowMomentumDynamics == Types.Dynamics.FixedInitial then
    D_flow_v = m_flow_start;
  end if;

  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end FlowSideSH;
