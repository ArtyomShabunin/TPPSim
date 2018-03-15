within TPPSim.thermal;
function falfaForSHandECO "Коэффициент теплопередачи при конвективном теплообмене"
  input Medium.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
  input Medium.MassFlowRate D_flow_v;
  input Modelica.SIunits.Area f_flow;  
  input Modelica.SIunits.Diameter Din;
  output Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
protected
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  Medium.ThermalConductivity k_flow "Теплопроводность вода";
  Medium.DynamicViscosity mu_flow "Динамическая вязкость воды";
  Real Pr_flow "Число Прандтля для воды";  
  Modelica.SIunits.Velocity w_flow "Скорость воды";
  Real Re_flow "Число Рейнольдса для воды";
algorithm
  k_flow := Medium.thermalConductivity(stateFlow);
  mu_flow := Medium.dynamicViscosity(stateFlow);
  Pr_flow := Medium.prandtlNumber(stateFlow);
  w_flow := max(D_flow_v, 0) / stateFlow.d / f_flow;
  Re_flow := w_flow * Din * stateFlow.d / mu_flow;
  alfa_flow := max(0.023 * k_flow / Din * Re_flow ^ 0.8 * Pr_flow ^ 0.4, 0.1);
end falfaForSHandECO;
