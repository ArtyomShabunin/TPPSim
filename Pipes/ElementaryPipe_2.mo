within TPPSim.Pipes;

model ElementaryPipe_2
  extends TPPSim.Pipes.BaseClases.BaseElementaryPipe_2;
  
  import Modelica.Fluid.Types.*;
  //Используемые уравнения динамики
  parameter Dynamics energyDynamics "Параметры уравнения сохранения энергии";
  parameter Dynamics massDynamics "Параметры уравнения сохранения массы";
  parameter Dynamics momentumDynamics "Параметры уравнения сохранения момента"; 
  //Переменные
  Medium.AbsolutePressure p[2] "Давление потока вода/пар в узловых точках";
  Medium.SpecificEnthalpy H[2] "Теплота потока вода/пар в узловых точках";  
  Medium.MassFlowRate D[2] "Массовый расход потока вода/пар в узловых точках";  
  inner Medium.ThermodynamicState stateFlow(p(start = system.p_start)) "Термодинамическое состояние потока натрия";
  inner Medium.MassFlowRate D_flow_v(start = 0) "Массовый расход потока вода/пар";
  //TPPSim.thermal.hfrConvHeatingSodium Q_calc;
  Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
equation
  if energyDynamics == Dynamics.SteadyState then
    0 = Q - (H[2] - H[1]);  
  else
    deltaVFlow * stateFlow.d * der(stateFlow.h) = Q - (H[2] - H[1]);
  end if;

  Q = 0; //УДАЛИ!!!!!!!!!!!!!!!!
//Уравнение теплового баланса металла
  deltaMMetal * C_m * der(t_m) = -Q "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения состояния
  stateFlow.d = Medium.density_ph(stateFlow.p, stateFlow.h);
  stateFlow.T = Medium.temperature_ph(stateFlow.p, stateFlow.h);
//Уравнения для расчета процессов теплообмена
  w_flow_v = D_flow_v / stateFlow.d / f_flow "Расчет скорости потока вода/пар в конечных объемах";

  D[2] + D[1] = 0;
//Уравнения для расчета процессов массообмена
  lambda_tr = 1 / (1.14 + 2 * log10(0.3 / 0.00014)) ^ 2;
  Xi_flow = lambda_tr * deltaLpipe / 0.3;

  w_flow_v = sqrt(abs(2 * dp_fric / Xi_flow / stateFlow.d)) * sign(dp_fric);
  
  if momentumDynamics == Dynamics.SteadyState then
    p[1] - p[2] = dp_fric + dp_piez;     
  else
    p[1] - p[2] = dp_fric + dp_piez + der(D_flow_v) * deltaLpipe / f_flow;
  end if;
  dp_piez = stateFlow.d * Modelica.Constants.g_n * deltaLpiezo "Расчет перепада давления из-за изменения пьезометрической высоты";
initial equation
  if energyDynamics == Dynamics.FixedInitial then
    stateFlow.h = h_start; 
  elseif energyDynamics == Dynamics.SteadyStateInitial then
    der(stateFlow.h) = 0;    
  end if;
  der(D_flow_v) = 0;
  der(t_m) = 0;  
  annotation(
    Documentation(info = "<html>
        <body>
          <p>Модель паропровода с коэффициентом теплоотдачи между стенкой и паром равным 20000. Имеется ввиду,  что теплообмен происходит при конденсации что справедливо для пароотводящих труб барабанов и сепараторов во время пуска.</p>
        </body>
      </html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end ElementaryPipe_2;
