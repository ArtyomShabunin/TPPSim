within TPPSim.thermal;

function alphaForSodiumInside
  input Medium.ThermodynamicState stateFlow "Термодинамическое состояние потока натрия на участках трубопровода";
  input Medium.MassFlowRate D_flow_v;
  input Modelica.SIunits.Area f_flow;  
  input Modelica.SIunits.Diameter Din;
  output Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока натрия";
protected
  package Medium = TPPSim.Media.Sodium_ph;
  Medium.ThermalConductivity k_flow "Теплопроводность вода";
  Modelica.SIunits.SpecificHeatCapacity Cp;
  Modelica.SIunits.Velocity w;
  Modelica.SIunits.PecletNumber Pe;
algorithm
 
  k := Medium.thermalConductivity(stateFlow);
  Cp := Medium.specificHeatCapacityCp(stateFlow);
  w := abs(D_flow_v) / stateFlow.d / f_flow;
  Pe := w *Cp * Din / k;
  alfa_flow := k / Din *(4.36 + 0.025 * Pe ^ 0.8);

end alphaForSodiumInside;
