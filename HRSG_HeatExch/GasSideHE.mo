within TPPSim.HRSG_HeatExch;
model GasSideHE "Gas Flow Heat Exchanger Side. Модель газовой стороны газо-водяного/парового теплообменника котла-утилизатора"
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconGasSideHE;
  import TPPSim.functions.deltaPg_lite;
  replaceable package Medium = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
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
  //Настройки уравнений динамики
  parameter Boolean DynamicEnergyBalance "Использовать или нет уравнение сохранения энергии с производными";
  parameter Boolean DynamicMassBalance "Использовать или нет уравнение сохранение массы с производными";
  //Переменные
  Medium.Temperature T_out "Температура газов за участком поверхностей нагрева";
  Medium.Temperature T_in "Температура газов перед участком поверхностей нагрева";
  Medium.ThermodynamicState state;
  Medium.DynamicViscosity mu "Динамическая вязкость газов";
  Medium.ThermalConductivity k "Коэффициент теплопроводности газов";
  Modelica.SIunits.PerUnit Re "Число Рейнольдса";
  Medium.PrandtlNumber Pr "Число Прандтля";
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_gas "Коэффициент теплопередачи со стороны потока газов";
  Medium.AbsolutePressure deltaP "Аэродинамическое сопротивление";
  Medium.DerDensityByPressure drdp;
  Medium.DerDensityByTemperature drdT;
  //Интерфейс
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0), iconTransformation(extent = {{-120, -70}, {-80, -30}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{80, -20}, {120, 20}}, rotation = 0), iconTransformation(extent = {{80, -68}, {120, -28}}, rotation = 0)));
equation
//Уравнения для потока газов
  if DynamicEnergyBalance then
    deltaVGas * Medium.density(state) * Medium.heatCapacity_cp(state) * der(T_out) = gasIn.m_flow * (inStream(gasIn.h_outflow) - gasOut.h_outflow) + heat.Q_flow;
  else
    0 = gasIn.m_flow * (inStream(gasIn.h_outflow) - gasOut.h_outflow) + heat.Q_flow;
  end if;
  heat.Q_flow = -alfa_gas * H_fin * (0.5 * (T_out + T_in) - heat.T);
//Уравнения состояния
  state = Medium.setState_pTX(gasOut.p, T_out, actualStream(gasIn.Xi_outflow));
  gasOut.h_outflow = Medium.specificEnthalpy(state);
  drdp = Medium.density_derp_T(state);
  drdT = Medium.density_derT_p(state);
  T_in = Medium.T_hX(inStream(gasIn.h_outflow), inStream(gasIn.Xi_outflow));
  if DynamicMassBalance then
    gasOut.m_flow + gasIn.m_flow - deltaVGas * (drdT * der(T_out) + drdp * der(gasIn.p)) = 0 "Уравнение сплошности";
  else
    gasOut.m_flow + gasIn.m_flow = 0;
  end if;
//Коэффициент теплоотдачи
  mu = Medium.dynamicViscosity(state);
  k = Medium.thermalConductivity(state);
  Pr = Medium.prandtlNumber(state);
  Re = abs(gasIn.m_flow * (Din + 2 * delta) / (f_gas * mu));
  alfa_gas = k_gamma_gas * 0.113 * Cs * Cz * k / (Din + 2 * delta) * Re ^ n_fin * Pr ^ 0.33;
  deltaP = deltaPg_lite(deltaDGas = -gasOut.m_flow, Kaer = Kaer, f_gas = f_gas, state = state) / numberOfFlueSections;
//Граничные условия
  gasIn.h_outflow = inStream(gasOut.h_outflow);
  gasIn.Xi_outflow = inStream(gasOut.Xi_outflow);
  inStream(gasIn.Xi_outflow) = gasOut.Xi_outflow;
  gasOut.p = gasIn.p - deltaP;
initial equation
  if DynamicMassBalance then
    der(T_out) = 0;
    der(gasIn.p) = 0;
  end if;
  if DynamicEnergyBalance == true and DynamicMassBalance == false then
    der(T_out) = 0;
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
end GasSideHE;