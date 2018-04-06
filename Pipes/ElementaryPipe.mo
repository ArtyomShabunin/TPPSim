within TPPSim.Pipes;
model ElementaryPipe "Модель паропровода"
  extends TPPSim.Pipes.BaseClases.BaseElementaryPipe(redeclare replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
  import Modelica.Fluid.Types;
  //Используемые уравнения динамики
  outer parameter Types.Dynamics energyDynamics "Параметры уравнения сохранения энергии";
  outer parameter Types.Dynamics massDynamics "Параметры уравнения сохранения массы";
  outer parameter Modelica.Fluid.Types.Dynamics momentumDynamics "Параметры уравнения сохранения момента"; 
  //Переменные
  TPPSim.thermal.hfrConvHeating Q_calc;
  Modelica.SIunits.DerDensityByPressure drdp;
  Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
equation
  if energyDynamics == Types.Dynamics.SteadyState then
    0 = Q - (D[section[1], section[2] + 1] * h[section[1], section[2] + 1] - D[section[1], section[2]] * h[section[1], section[2]]);  
  else
    deltaVFlow * stateFlow.d * der(stateFlow.h) = Q - (D[section[1], section[2] + 1] * h[section[1], section[2] + 1] - D[section[1], section[2]] * h[section[1], section[2]]);
  end if;
  stateFlow.h = h[section[1], section[2] + 1];
//Уравнение теплового баланса металла
  deltaMMetal * C_m * der(t_m) = -Q "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения состояния
  stateFlow.d = Medium.density_ph(stateFlow.p, stateFlow.h);
  stateFlow.T = Medium.temperature_ph(stateFlow.p, stateFlow.h);
  stateFlow.phase = Modelica.Media.Water.IF97_Utilities.phase_ph.phase_ph(stateFlow.p, stateFlow.h);
  drdp = Medium.density_derp_h(stateFlow);
//Уравнения для расчета процессов теплообмена
  w_flow_v = D_flow_v / stateFlow.d / f_flow "Расчет скорости потока вода/пар в конечных объемах";
//  alfa_flow = 20000;
//Про две фазы
  D_flow_v = D[section[1], section[2] + 1];
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
  if massDynamics == Types.Dynamics.SteadyState then
    D[section[1], section[2] + 1] = D[section[1], section[2]];
  else
    D[section[1], section[2] + 1] = D[section[1], section[2]] - deltaVFlow * drdp * der(stateFlow.p) "Уравнение сплошности";
  end if;
//Уравнения для расчета процессов массообмена
  stateFlow.p = p[section[1], section[2]];
  lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
  Xi_flow = lambda_tr * deltaLpipe / Din;
  //dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * stateFlow.d / 2;
  if momentumDynamics == Types.Dynamics.SteadyState then
    p[section[1], section[2]] - p[section[1], section[2] + 1] = dp_fric + dp_piez;     
  else
    p[section[1], section[2]] - p[section[1], section[2] + 1] = dp_fric + dp_piez + der(D_flow_v) * deltaLpipe / f_flow;
  end if;
  //dp_piez = stateFlow.d * Modelica.Constants.g_n * deltaLpiezo "Расчет перепада давления из-за изменения пьезометрической высоты";
  
  //dp_piez = 0;
  
  if initial() then
    dp_fric = D[section[1], section[2]] * abs(D[section[1], section[2]])  * Xi_flow / 983 / (f_flow ^ 2) / 2;
    dp_piez = 980 * Modelica.Constants.g_n * deltaLpiezo "Расчет перепада давления из-за изменения пьезометрической высоты";          
  else
    dp_fric = w_flow_v * abs(w_flow_v) * Xi_flow * stateFlow.d / 2;
    dp_piez = stateFlow.d * Modelica.Constants.g_n * deltaLpiezo "Расчет перепада давления из-за изменения пьезометрической высоты";        
  end if; 
initial equation
  if energyDynamics == Types.Dynamics.FixedInitial then
    stateFlow.h = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(system.p_start); 
  elseif energyDynamics == Types.Dynamics.SteadyStateInitial then
    der(stateFlow.h) = 0;    
  end if;
  if massDynamics == Types.Dynamics.FixedInitial then
    stateFlow.p = system.p_start;
  elseif massDynamics == Types.Dynamics.SteadyStateInitial then
    der(stateFlow.p) = 0;
  end if;
  if momentumDynamics == Types.Dynamics.SteadyStateInitial then
    der(D_flow_v) = 0;
  elseif momentumDynamics == Types.Dynamics.FixedInitial then
    D_flow_v = 0;
  end if; 
  der(t_m) = 0;  
  annotation(
    Documentation(info = "<html>
        <body>
          <p>Модель паропровода с коэффициентом теплоотдачи между стенкой и паром равным 20000. Имеется ввиду,  что теплообмен происходит при конденсации что справедливо для пароотводящих труб барабанов и сепараторов во время пуска.</p>
        </body>
      </html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end ElementaryPipe;
