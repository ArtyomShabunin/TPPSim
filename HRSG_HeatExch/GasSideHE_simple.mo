within TPPSim.HRSG_HeatExch;
model GasSideHE_simple "Gas Flow Heat Exchanger Side. Модель газовой стороны газо-водяного/парового теплообменника котла-утилизатора с глобальными переменными."
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconGasSideHE;
  import Modelica.Fluid.Types;
  import TPPSim.functions.deltaPg_lite;
  replaceable package Medium = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Integer[2] section;
  final outer parameter Real k_gamma_gas "Поправка к коэффициенту теплоотдачи со стороны газов";
  //Конструктивные характеристики
  final outer parameter Integer numberOfFlueSections "Число участков разбиения вдоль газохода";
  final outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр трубок теплообменника";
  final outer parameter Modelica.SIunits.Length delta "Толщина стенки трубки теплообменника";
  //Поток газов
  final outer parameter Modelica.SIunits.Volume deltaVGas "Объем одного участка газового тракта";
  final outer parameter Modelica.SIunits.Area f_gas "Площадь для прохода газов на одном участке разбиения";
  //Характеристики оребрения
  final outer parameter Real n_fin "Показатель степени 'n' в формуле коэффициента теплоотдачи";
  final outer parameter Real Cs "Коэффициент, определяемый в зависимости от от относительного поперечного и продольного шага труб в пучке, типа пучка и коэффициента оребрения";
  final outer parameter Real Cz "Поправка на число рядов труб по ходу газов";
  final outer parameter Real H_fin "Площадь оребренной поверхности";
  final outer parameter Real Kaer "Коэффициент для расчета аэродинамического сопротивления";
  //Параметры уравнений динамики
  outer parameter Types.Dynamics gasEnergyDynamics "Параметры уравнения сохранения энергии газов" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  outer parameter Types.Dynamics gasMassDynamics "Параметры уравнения сохранения массы газов" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics")); 
  //Переменные
  outer Medium.SpecificEnthalpy hgas_gl "Энтальпия газов (глобальная переменная)";
  outer Medium.MassFlowRate Dgas_gl "Массовый расход газов (глобальная переменная)";
  outer Medium.AbsolutePressure pgas_gl "Давление газов (глобальная переменная)";
  //Medium.Temperature T_out "Температура газов за участком поверхностей нагрева";
  Medium.ThermodynamicState state;
  Medium.DynamicViscosity mu "Динамическая вязкость газов";
  Medium.ThermalConductivity k "Коэффициент теплопроводности газов";
  Modelica.SIunits.PerUnit Re "Число Рейнольдса";
  Medium.PrandtlNumber Pr "Число Прандтля";
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_gas "Коэффициент теплопередачи со стороны потока газов";


  //Начальные значения
  outer parameter Modelica.SIunits.Temperature T_gas_start = system.T_start "Начальная температура газов" annotation(Dialog(tab = "Initialization"));  
  outer parameter Modelica.SIunits.AbsolutePressure p_gas_start = system.p_start "Начальное давление газов" annotation(Dialog(tab = "Initialization"));   
  //Интерфейс
  outer Modelica.Fluid.System system;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  outer Modelica.Fluid.Interfaces.FluidPort_a gasIn;

equation
  if gasEnergyDynamics == Types.Dynamics.SteadyState then
    0 = Dgas_gl[section[1], section[2]] * (hgas_gl[section[1], section[2]] - hgas_gl[section[1] + 1, section[2]]) + heat.Q_flow;
  else
    deltaVGas * Medium.density(state) * der(hgas_gl[section[1] + 1, section[2]]) = Dgas_gl[section[1], section[2]] * (hgas_gl[section[1], section[2]] - hgas_gl[section[1] + 1, section[2]]) + heat.Q_flow;
  end if;
  heat.Q_flow = -alfa_gas * H_fin * (state.T - heat.T);
//Уравнения состояния
  state = Medium.setState_phX(system.p_ambient, 0.5*(hgas_gl[section[1], section[2]]+hgas_gl[section[1] + 1, section[2]]), actualStream(gasIn.Xi_outflow));
  Dgas_gl[section[1] + 1, section[2]] = Dgas_gl[section[1], section[2]];

//Коэффициент теплоотдачи
  mu = Medium.dynamicViscosity(state);
  k = Medium.thermalConductivity(state);
  Pr = Medium.prandtlNumber(state);
  Re = abs(Dgas_gl[section[1], section[2]] * (Din + 2 * delta) / (f_gas * mu));
  alfa_gas = k_gamma_gas * 0.113 * Cs * Cz * k / (Din + 2 * delta) * Re ^ n_fin * Pr ^ 0.33;
  pgas_gl[section[1] + 1, section[2]] = pgas_gl[section[1], section[2]];
initial equation
  if gasEnergyDynamics  == Types.Dynamics.SteadyStateInitial then
    der(hgas_gl[section[1] + 1, section[2]]) = 0;
  elseif gasEnergyDynamics  == Types.Dynamics.FixedInitial then
    state.T = T_gas_start;
  end if;
  annotation(
    Documentation(info = "<html>
    <p>Моделирует газовую сторону элементарного элемента поверхности нагрева котла-утилизатора. Предназначена для использования в модели поверхности нагрева котла-утилизатора (GFHE). Все параметры для GasSideHE - глобальные параметры GFHE.</p>
    <p>Модель включает уравнения сохранения энергии и сплошности для газох. Уравнение теплообмена между газами и оребренной поверхностью нагрева. Упрощенное уравнение для расчета аэродинамического сопротивления поверхности нагрева.</p>
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>August 07, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Diagram(graphics));
end GasSideHE_simple;
