﻿within TPPSim.Pipes.BaseClases;
partial model BaseComplexPipe "Базовая модель сложной трубы"
  extends TPPSim.Pipes.BaseClases.Icons.IconComplexPipe;
  import Modelica.Fluid.Types;
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  //Характеристики металла
  parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
    Dialog(group = "Характеристики металла"));
  inner parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
    Dialog(group = "Характеристики металла"));
  //Конструктивные характеристики
  inner parameter Modelica.SIunits.Diameter Din = 0.3 "Внутренний диаметр трубопровода" annotation(
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
  //Параметры уравнений динамики
  inner parameter Types.Dynamics energyDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения энергии" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  inner parameter Types.Dynamics massDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения массы" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  inner parameter Modelica.Fluid.Types.Dynamics momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState "Параметры уравнения сохранения момента" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  //Начальные значения
  inner parameter Modelica.SIunits.AbsolutePressure p_flow_start = system.p_ambient "Начальное давление вода/пар" annotation(Dialog(tab = "Initialization"));
  inner parameter Modelica.SIunits.SpecificEnthalpy h_start = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(p_flow_start) + 100 "Начальная энтельпия вода/пар" annotation(Dialog(tab = "Initialization"));
  inner parameter Modelica.SIunits.Temperature t_m_start = system.T_start "Начальная температура металла" annotation(Dialog(tab = "Initialization"));
  //Интерфейс
  outer Modelica.Fluid.System system;
  Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {121, 0}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  annotation(
    Documentation(info = "<html>
    <p>Базовая модель трубопровода состоящего из элементарных трубопроводов.</p>
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>October 03, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end BaseComplexPipe;
