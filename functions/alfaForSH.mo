within TPPSim.functions;
function alfaForSH
  input Medium.SpecificEnthalpy h_v;
  input Medium.MassFlowRate D_flow_n1;
  input Medium.AbsolutePressure p_v;
  input Modelica.SIunits.Diameter Din;
  input Modelica.SIunits.Area f_flow;
  input Medium.MassFlowRate m_flow_small = 0;
  output Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
protected
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  Medium.Density rho_v;
  Medium.DynamicViscosity mu_flow;
  Modelica.SIunits.Velocity w_flow;
  Real Re_flow;
  Medium.ThermalConductivity k_flow;
  Real Pr_flow;
algorithm
  rho_v := Medium.density(Medium.setState_ph(p_v, h_v));
  k_flow := Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
  mu_flow := Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v));
  Pr_flow := Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
  w_flow := max(D_flow_n1 - m_flow_small, 0) / rho_v / f_flow;
  Re_flow := w_flow * Din * rho_v / mu_flow;
  alfa_flow := 0.023 * k_flow / Din * Re_flow ^ 0.8 * Pr_flow ^ 0.4;
end alfaForSH;