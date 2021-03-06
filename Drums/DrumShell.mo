﻿within TPPSim.Drums;
model DrumShell "Оболочка барабана"
  import Modelica.Constants.pi;
  parameter Real C_m = 578.05 "Удельная теплоемкость металла";
  parameter Real rho_m = 7800 "Плотность металла";
  parameter Real k_m = 47 "Удельная теплопроводность металла";
  parameter Real Din = 2 "Внутренний диаметр барабана";
  parameter Real delta = 0.1 "Толщина стенки барабана";
  constant Integer N = 10 "Число участков разбиения";
  final outer parameter Medium.Temperature t_m_steam_start "Начальная температура металла верха барабана";
  final outer parameter Medium.Temperature t_m_water_start "Начальная температура металла низа барабана";  
  //Верхняя образующая
  parameter DomainLineSegment1D omega_top(x0 = Din/2, L = delta, N = N) "domain";
  field Real T_top(domain = omega_top) "field";
  //Нижняя образующая
  parameter DomainLineSegment1D omega_bot(x0 = Din/2, L = delta, N = N) "domain";
  field Real T_bot(domain = omega_bot) "field";  
  
  
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  outer Modelica.SIunits.Area S_top "Площадь поверхности теплообмена в верхней части барабана";
  outer Modelica.SIunits.Area S_bot "Площадь поверхности теплообмена в нижней части барабана";         
  outer Medium.Temperature ts "Температура насыщения в барабане (пар)";
//  outer Medium.Temperature tw "Температура воды в барабане";    
  outer Modelica.SIunits.HeatFlowRate Q_top "Тепловой поток к металлу верхней части барабана";
  outer Modelica.SIunits.HeatFlowRate Q_bot "Тепловой поток к металлу нижней части барабана";
  outer Medium.MassFlowRate D_st_circ "Пар поступающий в паровое пространство барабана из циркуляционных контуров ";
  outer Medium.MassFlowRate D_st_eco "Расход пара из питательной воды или необходимый для нагрева до h' недогретой питательной воды";
  outer Medium.MassFlowRate Dvipar "Выпар в паровой объем";
  outer Medium.SpecificEnthalpy h_dew "Энтальпия пара на линии насыщения при давлении в барабане";
  outer Medium.SpecificEnthalpy h_bubble "Энтальпия воды на линии насыщения при давлении в барабане";
  outer Medium.ThermodynamicState state_w "Термодинамическое состояние воды в водяном объеме"; 
  
initial equation
//  der(T_top) = fill(0, N);
//  der(T_bot) = fill(0, N);

  T_top = fill(t_m_steam_start, N);
  T_bot = fill(t_m_water_start, N);
equation
  //Уравнения для верхней образующей барабана
  der(T_top) = k_m/C_m/rho_m * (pder(T_top,x,x) + pder(T_top,x) / (omega_top.x + Din/2)) indomain omega_top "Дифференциальное уравнение теплопроводности в цилиндрических координатах для верхней образующей барабана";
  -k_m * pder(T_top,x) = Q_top / S_top indomain omega_top.left "Граничное условие на внутренней поверхности стенки верхней образующей";
  pder(T_top,x) = 0  indomain omega_top.right "Граничное условие на наружной поверхности стенки";
  Q_top = min(2000 * S_top * max((ts - T_top), 0), max((D_st_circ + D_st_eco + Dvipar) * (h_dew - h_bubble), 0)) indomain omega_top.left;
  
  //Уравнения для верхней образующей барабана
  der(T_bot) = k_m/C_m/rho_m * (pder(T_bot,x,x) + pder(T_bot,x) / (omega_bot.x + Din/2)) indomain omega_bot "Дифференциальное уравнение теплопроводности в цилиндрических координатах для верхней образующей барабана";
  -k_m * pder(T_bot,x) = Q_bot / S_bot indomain omega_bot.left "Граничное условие на внутренней поверхности стенки верхней образующей";
  pder(T_bot,x) = 0  indomain omega_bot.right "Граничное условие на наружной поверхности стенки";    
  Q_bot = 1000 * S_bot * max((state_w.T - T_bot), 0) indomain omega_bot.left;

  annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
    uses(Modelica(version = "3.2.1")),
    Documentation(info = "<html>
<style>
p {
  text-indent: 20px;
  text-align: 'justify';
 }
</style>
<p>Модель для расчета распределения температуры по толщине стенки барабана.</p>
</html>", revisions = "<html>
<ul>
<li><i>15 July 2018</i>
by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
   Создан.</li>
</ul>
</html>"));
end DrumShell;
