within TPPSim.Pipes.BaseClases;

partial model BaseElementaryPipe_2
  extends TPPSim.Pipes.BaseClases.Icons.IconElementaryPipe;
  //Параметры разбиения
  parameter Integer[2] section "Координаты участка";
  //Характеристики металла
  outer parameter Modelica.SIunits.SpecificHeatCapacity C_m "Удельная теплоемкость металла";
  //Конструктивные характеристики
  outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр трубопровода";
  outer parameter Modelica.SIunits.Length ke "Абсолютная эквивалентная шероховатость";
  //Расчетные конструктивные параметры
  final outer parameter Modelica.SIunits.Length deltaLpipe;
  final outer parameter Modelica.SIunits.Length deltaLpiezo;
  final outer parameter Modelica.SIunits.Area deltaSFlow "Внутренняя площадь одного участка ряда труб";
  final outer parameter Modelica.SIunits.Volume deltaVFlow "Внутренний объем одного участка ряда труб";
  final outer parameter Modelica.SIunits.Mass deltaMMetal "Масса металла участка ряда труб";
  final outer parameter Modelica.SIunits.Area f_flow "Площадь для прохода теплоносителя";
  //Начальные значения 
  outer parameter Modelica.SIunits.AbsolutePressure p_flow_start "Начальное давление вода/пар" annotation(Dialog(tab = "Initialization"));
  outer parameter Modelica.SIunits.SpecificEnthalpy h_start "Начальная энтельпия вода/пар" annotation(Dialog(tab = "Initialization"));
  outer parameter Modelica.SIunits.Temperature t_m_start "Начальная температура металла" annotation(Dialog(tab = "Initialization"));  
  //Переменные

  inner Modelica.SIunits.Temperature t_m "Температура металла на участках трубопровода";
  inner Modelica.SIunits.HeatFlowRate Q "Тепло переданное стенкой паропровода потоку пара";
  Modelica.SIunits.Velocity w_flow_v "Скорость потока вода/пар в конечных объемах";
  Real dp_fric "Потеря давления из-за сил трения";
  Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
  Real lambda_tr "Коэффициент трения";
  //Интерфейс
  outer Modelica.Fluid.System system;
  annotation(
    Documentation(info = "<html><head></head><body>
      Базовая модель элемента паропровода.
      </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>Match 15, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end BaseElementaryPipe_2;
