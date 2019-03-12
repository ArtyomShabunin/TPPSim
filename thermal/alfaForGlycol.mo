within TPPSim.thermal;

model alfaForGlycol
  package Medium = TPPSim.Media.Glycol_ph;
//  package Medium = Modelica.Media.Water.StandardWater;
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
annotation(
    experiment(StartTime = 0, StopTime = 3000, Tolerance = 0.001, Interval = 10));end alfaForGlycol;
