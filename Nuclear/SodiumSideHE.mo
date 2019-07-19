within TPPSim.Nuclear;

model SodiumSideHE "Модель натриевой стороны парогенератора"
  extends TPPSim.Nuclear.BaseClases.Icons.IconSodiumSideHE;
  import Modelica.Fluid.Types;
  replaceable package Medium = TPPSim.Media.Sodium_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Integer[2] section;
  final outer parameter Real k_gamma_sodium "Поправка к коэффициенту теплоотдачи со стороны натрия";
  //Конструктивные характеристики
//  final outer parameter Integer numberOfSections "Число участков разбиения по ходу теплоносителя";
  final outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр трубок теплообменника";
  final outer parameter Modelica.SIunits.Length delta "Толщина стенки трубки теплообменника";
  final outer parameter Modelica.SIunits.Diameter Dcase "Внутренний диаметр корпуса теплообменника"; 
  //Поток натрия
  final outer parameter Modelica.SIunits.Volume deltaVSodium "Объем одного участка со стороны натрия";
  final outer parameter Modelica.SIunits.Area f_sodium "Площадь для прохода натрия на одном участке разбиения";
  //Характеристики оребрения
  final outer parameter Real H_sodium "Площадь поверхности теплообмена со стороны натрия";
  //Параметры уравнений динамики
  final outer parameter Types.Dynamics sodiumEnergyDynamics "Параметры уравнения сохранения энергии";
  //Переменные
  outer Medium.SpecificEnthalpy hsodium_gl "Энтальпия натрия (глобальная переменная)";
  outer Medium.MassFlowRate Dsodium_gl "Массовый расход натрия (глобальная переменная)";
  outer Medium.AbsolutePressure psodium_gl "Давление натрия (глобальная переменная)";
  Medium.ThermodynamicState state;
  Medium.DynamicViscosity mu "Динамическая вязкость натрия";
  Modelica.SIunits.PerUnit Re "Число Рейнольдса";
  Medium.PrandtlNumber Pr "Число Прандтля";
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_sodium "Коэффициент теплопередачи со стороны потока натрия";


  //Начальные значения
  final outer parameter Modelica.SIunits.Temperature T_sodium_start "Начальная температура газов";  
  //Интерфейс

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

equation
  if sodiumEnergyDynamics == Types.Dynamics.SteadyState then
    0 = Dsodium_gl[section[1], section[2]] * (hsodium_gl[section[1], section[2]] - hsodium_gl[section[1] + 1, section[2]]) + heat.Q_flow;
  else
    deltaVSodium * Medium.density(state) * der(hsodium_gl[section[1] + 1, section[2]]) = Dsodium_gl[section[1], section[2]] * (hsodium_gl[section[1], section[2]] - hsodium_gl[section[1] + 1, section[2]]) + heat.Q_flow;
  end if;
  heat.Q_flow = -alfa_sodium * H_sodium * (state.T - heat.T);
//Уравнения состояния
  state = Medium.setState_phX(psodium_gl[section[1] + 1, section[2]], 0.5*(hsodium_gl[section[1], section[2]]+hsodium_gl[section[1] + 1, section[2]]));
  Dsodium_gl[section[1] + 1, section[2]] = Dsodium_gl[section[1], section[2]];

//Коэффициент теплоотдачи
  mu = Medium.dynamicViscosity(state);
  Pr = Medium.prandtlNumber(state);
  Re = abs(Dsodium_gl[section[1], section[2]] * (Din + 2 * delta) / (f_sodium * mu)); // Проверить
  alfa_sodium = 1; // Переписать
  psodium_gl[section[1] + 1, section[2]] = psodium_gl[section[1], section[2]];
initial equation
  if sodiumEnergyDynamics  == Types.Dynamics.SteadyStateInitial then
    der(hsodium_gl[section[1] + 1, section[2]]) = 0;
  elseif sodiumEnergyDynamics  == Types.Dynamics.FixedInitial then
    state.T = T_sodium_start;
  end if;
  annotation(
    Documentation(info = "<html>
    <p>Моделирует сторону натриевого теплоносителя элементарного элемента парогенератора АЭС. Предназначена для использования в модели парогенератора. Все параметры для SodiumSideHE - глобальные параметры.</p>
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>July 18, 2019</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Diagram(graphics));

end SodiumSideHE;
