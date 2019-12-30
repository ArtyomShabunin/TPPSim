within TPPSim.Pipes.BaseClases;

partial model BaseComplexPipe_2 "Базовая модель сложной трубы (второй вариант)"
  extends TPPSim.Pipes.BaseClases.Icons.IconComplexPipe;  
  replaceable package Medium = TPPSim.Media.Sodium_ph;
  import Modelica.Fluid.Types.*;
  //Характеристики металла
  parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
    Dialog(group = "Характеристики металла"));
  parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
    Dialog(group = "Характеристики металла"));
  //Конструктивные характеристики
  parameter Modelica.SIunits.Diameter Din = 0.3 "Внутренний диаметр трубопровода" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Length delta = 0.01 "Толщина стенки трубопровода" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Length Lpipe = 25 "Длина теплообменной трубки" annotation(
    Dialog(group = "Конструктивные характеристики"));
  inner parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость"  annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Length Lpiezo = 0 "Перепад высот между выходом и входом трубы"   annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Real n_parallel = 1 "Число параллельных трубопроводов" annotation(
    Dialog(group = "Конструктивные характеристики"));
  //Поправки
  parameter Real k_weight_metal = 1 "Поправка к массе металла поверхности нагрева" annotation(
    Dialog(group = "Поправки"));
  parameter Real k_volume = 1 "Поправка к объему" annotation(
    Dialog(group = "Поправки"));
  
  //Параметры уравнений динамики
  parameter Dynamics energyDynamics = Dynamics.FixedInitial "Параметры уравнения сохранения энергии" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  parameter Dynamics massDynamics = Dynamics.FixedInitial "Параметры уравнения сохранения массы" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  parameter Dynamics momentumDynamics = Dynamics.SteadyState "Параметры уравнения сохранения момента" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  //Начальные значения
  parameter Modelica.SIunits.AbsolutePressure p_flow_start = system.p_ambient "Начальное давление вода/пар" annotation(Dialog(tab = "Initialization"));
  parameter Modelica.SIunits.SpecificEnthalpy h_start = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(p_flow_start) + 100 "Начальная энтельпия вода/пар" annotation(Dialog(tab = "Initialization"));
  parameter Modelica.SIunits.Temperature t_m_start = system.T_start "Начальная температура металла" annotation(Dialog(tab = "Initialization"));
  //Интерфейс
  outer Modelica.Fluid.System system;
  annotation(
    Documentation(info = "<html>
<style>
p {
  text-indent: 20px;
  text-align: 'justify';
 }
</style>
<p>Модель аналогиченя BaseComplexPipe, но здесь не определен package Medium. Модель разработана для натриевого теплоносителя</p>
</html>", revisions = "<html>
<ul>
<li><i>03 August 2019</i>
by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
   Создан.</li>
</ul>
</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end BaseComplexPipe_2;
