within TPPSim.HRSG_HeatExch;
model MixCollector "Смешивающий коллектор"
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconMixer;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching);
  final parameter Integer zahod;
  final parameter Integer numberOfTubeSections;
  final parameter Integer numberOfFlueSections;
  parameter Modelica.SIunits.Diameter Din = 0.1 "Внутренний диаметр коллектора" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Length delta = 0.01 "Толщина стенки коллектора" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Length L = 5 "Длина коллектора" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
    Dialog(group = "Металл"));
  parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
    Dialog(group = "Металл"));
  Modelica.SIunits.Temperature t_m "Температура металла на участках трубопровода";
protected
  parameter Modelica.SIunits.Area SFlow = L * Modelica.Constants.pi * Din "Внутренняя площадь коллектора";
  parameter Modelica.SIunits.Volume VFlow = L * Modelica.Constants.pi * Din ^ 2 / 4 "Внутренний объем коллектора";
  parameter Modelica.SIunits.Mass MMetal = rho_m * L * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) / 4 "Масса металла коллектора";
  parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 / 4 "Площадь для прохода теплоносителя";
  Medium.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
  Medium.AbsolutePressure p_v;
  Medium.SpecificEnthalpy h_v;
  Medium.Temperature t_flow "Температура потока вода/пар";
  Medium.Density rho;
  Modelica.SIunits.DerDensityByEnthalpy drdh;
  Modelica.SIunits.DerDensityByPressure drdp;
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
  outer Medium.AbsolutePressure p_gl "Давление (глобальная переменная)";
  outer Medium.SpecificEnthalpy h_gl "Энтальпия (глобальная переменная)";
  outer Medium.MassFlowRate D_gl "Массовый расход (глобальная переменная)";
  outer Modelica.Fluid.Interfaces.FluidPort_b flowOut;
  Medium.MassFlowRate D_temp[zahod];
  Medium.SpecificEnthalpy h_temp[zahod];
equation
  D_temp = D_gl[numberOfFlueSections - (zahod - 1):numberOfFlueSections, numberOfTubeSections + 1];
  h_temp = h_gl[numberOfFlueSections - (zahod - 1):numberOfFlueSections, numberOfTubeSections + 1];
  stateFlow = Medium.setState_ph(p_v, h_v);
  rho = Medium.density(stateFlow);
  t_flow = Medium.temperature(stateFlow);
  drdp = min(0.0005, Medium.density_derp_h(stateFlow));
  drdh = max(-0.002, Medium.density_derh_p(stateFlow));
  alfa_flow = 20000;
  VFlow * rho * der(h_v) = flowOut.h_outflow * flowOut.m_flow + sum(h_temp[i] * D_temp[i] for i in 1:zahod) "Уравнение баланса тепла";
  flowOut.m_flow + sum(D_temp) = VFlow * (drdh * der(h_v) + drdp * der(p_v));
  MMetal * C_m * der(t_m) = -alfa_flow * SFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
  for i in numberOfFlueSections - (zahod - 1):numberOfFlueSections loop
    p_gl[i, numberOfTubeSections + 1] = p_v;
  end for;
  flowOut.p = p_v;
  h_v = flowOut.h_outflow;
initial equation
  der(t_m) = 0;
  der(p_v) = 0;
  der(h_v) = 0;
  annotation(
    Documentation(info = "<html><head></head><body>Модель смешивающего коллектора. Отличается от модели смесителя наличием в системе дифференциальных уравнений. Работает с глобальными переменными, поэтому может использоваться только внутри модели 'GFHE'.</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>August 31, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end MixCollector;