within TPPSim.thermal;
model alfaForSHandECO
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  final outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр трубок теплообменника";
  final outer parameter Modelica.SIunits.Area f_flow "Площадь для прохода теплоносителя";
  outer Medium.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
  outer Medium.MassFlowRate D_flow_v;
  outer Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
  Medium.DynamicViscosity mu_flow;
  Modelica.SIunits.Velocity w_flow;
  Real Re_flow;
  Medium.ThermalConductivity k_flow;
  Real Pr_flow;
algorithm
  k_flow := Medium.thermalConductivity(stateFlow);
  mu_flow := Medium.dynamicViscosity(stateFlow);
  Pr_flow := Medium.prandtlNumber(stateFlow);
  w_flow := max(D_flow_v, 0) / stateFlow.d / f_flow;
  Re_flow := w_flow * Din * stateFlow.d / mu_flow;
  alfa_flow := max(0.023 * k_flow / Din * Re_flow ^ 0.8 * Pr_flow ^ 0.4, 0.1);
end alfaForSHandECO;
