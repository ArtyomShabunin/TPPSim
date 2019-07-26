within TPPSim.thermal;

model alfaSodium_outside
  package Medium = TPPSim.Media.Sodium_ph;
  final outer parameter Integer z "Кол-во теплообменных трубок";
  final outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр трубок теплообменника";
  final outer parameter Modelica.SIunits.Length delta "Толщина стенки трубки теплообменника";
  final outer parameter Modelica.SIunits.Diameter Dcase "Внутренний диаметр корпуса теплообменника";
  final outer parameter Modelica.SIunits.Area f_sodium "Площадь для прохода теплоносителя";
  parameter Integer[2] section "Координаты участка";  
 
  outer Medium.MassFlowRate Dsodium_gl "Массовый расход (глобальная переменная)";
  outer Modelica.SIunits.CoefficientOfHeatTransfer alfa_sodium "Коэффициент теплопередачи со стороны потока вода/пар";

  outer Medium.ThermodynamicState state;
  Modelica.SIunits.Length l_geom "Характерный геометрический размер";
  Medium.ThermalConductivity k;
  Modelica.SIunits.SpecificHeatCapacity Cp;
  Modelica.SIunits.Velocity w;
  Modelica.SIunits.PecletNumber Pe;
  
algorithm
  l_geom := (Dcase ^ 2 - z * (Din + 2 * delta) ^ 2) / z / (Din + 2 * delta);
  k := Medium.thermalConductivity(state);
  Cp := Medium.specificHeatCapacityCp(state);
  w := abs(Dsodium_gl[section[1], section[2]]) / state.d / f_sodium;
  Pe := w *Cp * l_geom / k;
  alfa_sodium := k / l_geom *(4.36 + 0.025 * Pe ^ 0.8);

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
end alfaSodium_outside;
