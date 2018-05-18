within TPPSim.Pipes;

model PDEPipe "Модель паропровода с на базе уравнений с частными производными"
  extends TPPSim.Pipes.BaseClases.Icons.IconPipe;
  import Modelica.Constants.pi;
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  final parameter DomainLineSegment1D pipe(L = 50, N = 50);
//  field Medium.ThermodynamicState state(domain = pipe);

  field Real h(start = 251000, domain = pipe);
  field Real p(domain = pipe);
  field Real T(domain = pipe);
  field Real d(domain = pipe);
  field Real q(domain = pipe, final unit="W/m") "Удельная тепловая нагрузка";
  field Real Tm(domain = pipe) "Температура металла трубопровода";
  
  parameter Real D_in(final unit="m") = 0.2 "Внутренний диаметр трубопровода";
  parameter Real delta(final unit="m") = 0.01 "Толщина стенки трубопровода";
  parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла";
  parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла";
  
  Modelica.SIunits.Mass deltaMMetal "Масса металла участка ряда труб";
  
  //Интерфейс
  outer Modelica.Fluid.System system;
  Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {121, 0}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
initial equation
  der(h) = 0 indomain pipe;
  der(Tm) = 0 indomain pipe;
equation
  deltaMMetal = rho_m * pipe.dx * pi * ((D_in + delta) ^ 2 - D_in ^ 2) / 4 "Масса металла участка ряда труб";
     
  waterIn.m_flow * pder(h, x) + 0.25 * pi * D_in ^2 * d * der(h) - q = 0 indomain pipe;
  deltaMMetal * C_m * der(Tm) + q * pipe.dx = 0 indomain pipe;
  q = pi * D_in * 3000 * (Tm - T) indomain pipe;
  
  
  h = inStream(waterIn.h_outflow) indomain pipe.left;
  h = extrapolateField(h)  indomain pipe.right;
  h = waterOut.h_outflow indomain pipe.right;
  
  p = waterOut.p indomain pipe;
  T = Medium.temperature_ph(p, h) indomain pipe;
  d = Medium.density_ph(p, h) indomain pipe;

  
  waterIn.m_flow + waterOut.m_flow = 0;
  waterIn.p = waterOut.p;
  waterIn.h_outflow = inStream(waterOut.h_outflow);
  annotation(
    Documentation(info = "<html>
  <p>
  Модель построена с использованием расширения PDEModelica
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>May 18, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    Icon(graphics = {Text(extent = {{-60, 40}, {60, -40}}, textString = "PDE")}));
end PDEPipe;
