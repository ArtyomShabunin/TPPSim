within TPPSim.Pipes;
model ElementarySteamPipe"Модель элементарного участка паропровода"
  extends TPPSim.Pipes.BaseClases.BaseElementaryPipe(redeclare replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
  import Modelica.Fluid.Types;
  //Используемые уравнения динамики
  outer parameter Types.Dynamics energyDynamics "Параметры уравнения сохранения энергии";
  outer parameter Types.Dynamics massDynamics "Параметры уравнения сохранения массы";
  outer parameter Modelica.Fluid.Types.Dynamics momentumDynamics "Параметры уравнения сохранения момента"; 
  //Переменные
  Modelica.SIunits.DerDensityByEnthalpy drdh;
  Modelica.SIunits.DerDensityByPressure drdp;
  Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
  replaceable TPPSim.thermal.hfrConvHeating Q_calc;
  inner Medium.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";  
  inner Medium.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
  inner Medium.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
equation
  if energyDynamics == Types.Dynamics.SteadyState then
    0 = Q - (D[section[1], section[2] + 1] * h[section[1], section[2] + 1] - D[section[1], section[2]] * h[section[1], section[2]]);
  else
    deltaVFlow * stateFlow.d * der(stateFlow.h) = Q - (D[section[1], section[2] + 1] * h[section[1], section[2] + 1] - D[section[1], section[2]] * h[section[1], section[2]]);
  end if;
  stateFlow.h = h[section[1], section[2] + 1];
//Уравнение теплового баланса металла
  deltaMMetal * C_m * der(t_m) =  - Q "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения состояния
  stateFlow.d = Medium.density_ph(stateFlow.p, stateFlow.h);
  stateFlow.T = Medium.temperature_ph(stateFlow.p, stateFlow.h);
  stateFlow.phase = Modelica.Media.Water.IF97_Utilities.phase_ph.phase_ph(stateFlow.p, stateFlow.h);
  sat_v = Medium.setSat_p(stateFlow.p);
  hl = Medium.bubbleEnthalpy(sat_v);
  hv = Medium.dewEnthalpy(sat_v);
  drdp = min(0.00004, Medium.density_derp_h(stateFlow));
  drdh = max(-0.0002, Medium.density_derh_p(stateFlow));
//Уравнения для расчета процессов теплообмена
  w_flow_v = D_flow_v / stateFlow.d / f_flow "Расчет скорости потока вода/пар в конечных объемах";
//Про две фазы
  D_flow_v = D[section[1], section[2] + 1];
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
  if massDynamics == Types.Dynamics.SteadyState then
    D[section[1], section[2] + 1] = D[section[1], section[2]];
  else
    D[section[1], section[2] + 1] = D[section[1], section[2]] - deltaVFlow * drdp * der(stateFlow.p) - deltaVFlow * drdh * der(stateFlow.h) "Уравнение сплошности";
  end if;
//Уравнения для расчета процессов массообмена
  stateFlow.p = p[section[1], section[2]];
  lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
  Xi_flow = lambda_tr * deltaLpipe / Din;
  dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * stateFlow.d / 2 / Modelica.Constants.g_n;
  if momentumDynamics == Types.Dynamics.SteadyState then
    p[section[1], section[2]] - p[section[1], section[2] + 1] = dp_fric;     
  else
    p[section[1], section[2]] - p[section[1], section[2] + 1] = dp_fric + der(D_flow_v) * deltaLpipe / f_flow;
  end if;
  dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
initial equation
  if energyDynamics == Types.Dynamics.FixedInitial then
    stateFlow.h = h_start;
  elseif energyDynamics == Types.Dynamics.SteadyStateInitial then
    der(stateFlow.h) = 0;
  end if;
  if massDynamics == Types.Dynamics.FixedInitial then
    stateFlow.p = p_flow_start;
  elseif massDynamics == Types.Dynamics.SteadyStateInitial then
    der(stateFlow.p) = 0;
  end if;
  if momentumDynamics == Types.Dynamics.SteadyStateInitial then
    der(D_flow_v) = 0;
  end if; 
  t_m = t_m_start;  
  annotation(
        Documentation(info = "<html><head></head><body>
      Модель элементарного участка паропровода.
      </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>Match 15, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end ElementarySteamPipe;
