within TPPSim.thermal;

model alfaSodium_inside "Коэфициент теплопередачи при течении натрия внутри труб"
  package Medium = TPPSim.Media.Sodium_ph;
  final outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр трубок теплообменника";
  final outer parameter Modelica.SIunits.Area f_flow "Площадь для прохода теплоносителя";
  parameter Integer[2] section "Координаты участка";  
 
  outer Medium.MassFlowRate D_flow_v "Массовый расход (глобальная переменная)";
  outer Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";

  outer Medium.ThermodynamicState stateFlow;
  Medium.ThermalConductivity k;
  Modelica.SIunits.SpecificHeatCapacity Cp;
  Modelica.SIunits.Velocity w;
  Modelica.SIunits.PecletNumber Pe;
  
algorithm
  k := Medium.thermalConductivity(stateFlow);
  Cp := Medium.specificHeatCapacityCp(stateFlow);
  w := abs(D_flow_v) / stateFlow.d / f_flow;
  Pe := w *Cp * Din / k;
  alfa_flow := k / Din *(4.36 + 0.025 * Pe ^ 0.8);

  annotation(
    Documentation(info = "<html>
<style>
p {
  text-indent: 20px;
  text-align: 'justify';
 }
</style>
<p>Формула из книги Исаченко В.П. Теплопередача (1975).</p>
</html>", revisions = "<html>
<ul>
<li><i>22 July 2019</i>
by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
   Создан.</li>
</ul>
</html>"));
end alfaSodium_inside;
