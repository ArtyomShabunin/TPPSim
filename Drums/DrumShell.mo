within TPPSim.Drums;
model DrumShell "Оболочка барабана"
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла";
  parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла";
  parameter Modelica.SIunits.ThermalConductivity k_m = 47 "Удельная теплопроводность металла";
  
  final parameter DomainLineSegment1D omega(x0 = Din/2, L = 0.1, N = 10);





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
<p>Модель построенна на основе уравнений представленных в докторской диссертации Рубашкина А.С. С рядом дополнений которые позволяют использовать ее для моделирования пуска из состояния в котором парообразование в испарителе не происходит:</p>
<ul>
<li>принято что расход пара на догрев питательной воды до состояния насыщения не может быть больше паропроизводительности испарителя;</li>
</ul>
<p>Тепло передаваемое внутренней стенке барабана расчитывается в моделе <b>TPPSim.thermal.hfrForDrum</b>.</p>

</html>", revisions = "<html>
<ul>
<li><i>4 Apr 2017</i>
by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
   Создан.</li>
</ul>
</html>"));
end DrumShell;
