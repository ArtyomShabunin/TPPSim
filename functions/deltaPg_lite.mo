within TPPSim.functions;
function deltaPg_lite
  import Modelica.SIunits.Conversions.to_degF;
  input Medium.MassFlowRate deltaDGas "Расход дымовых газов";
  input Real Kaer "Коэффициент для расчета аэродинамического сопротивления";
  input Modelica.SIunits.Area f_gas "Площадь для прохода газов на одном участке разбиения";
  input Medium.ThermodynamicState state;
  output Medium.AbsolutePressure deltaPg;
protected
  package Medium = TPPSim.Media.ExhaustGas;
  Medium.MolarMass MM;
  Medium.DynamicViscosity mu "Динамическая вязкость газов";
algorithm
  mu := Medium.dynamicViscosity(state);
  MM := Medium.molarMass(state);
  deltaPg := Kaer * (deltaDGas / f_gas) ^ 1.684 * mu ^ 0.216 * (460 + to_degF(state.T)) / (MM * 10 ^ 3);
end deltaPg_lite;