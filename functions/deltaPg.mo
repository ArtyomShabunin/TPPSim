within TPPSim.functions;
function deltaPg
  import Modelica.SIunits.Conversions.to_degF;
  input Medium.MassFlowRate deltaDGas "Расход дымовых газов";
  input Integer z1 "Число труб по ширине газохода";
  input Integer z2 "Число труб по ходу газов в данной поверхности нагрева";
  input Modelica.SIunits.Diameter Dout "Диаметр теплообменной трубки";
  input Modelica.SIunits.Length Lpipe "Длина теплообменной трубки";
  input Modelica.SIunits.Length s1 "Поперечный шаг";
  input Modelica.SIunits.Length s2 "Продольный шаг";
  input Medium.ThermodynamicState state;
  output Medium.AbsolutePressure deltaPg;
protected
  package Medium = TPPSim.ExhaustGas;
  Medium.MolarMass MM;
  Medium.DynamicViscosity mu "Динамическая вязкость газов";
  Medium.MassFlowRate Gg "Gas mass velocity";
algorithm
  mu := Medium.dynamicViscosity(state);
  MM := Medium.molarMass(state);
  Gg := deltaDGas / z1 / Lpipe / (s1 - Dout);
  deltaPg := Gg ^ 1.684 * Dout ^ 0.611 * mu ^ 0.216 * (460 + to_degF(state.T)) * z2 / s1 ^ 0.412 / s2 ^ 0.515 / (MM * 10 ^ 3);
end deltaPg;