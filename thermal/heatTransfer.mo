within TPPSim.thermal;
model heatTransfer
  constant Medium.AbsolutePressure pc = Medium.fluidConstants[1].criticalPressure;
  constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
  constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
  replaceable package Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  input Medium.SpecificEnthalpy h_n[2];
  input Medium.MassFlowRate D_flow_v;
  input Medium.Density rho_n[2];
  input Medium.Density rho_v;
  input Medium.Density rhov;
  input Medium.Density rhol;
  input Medium.SpecificEnthalpy hl;
  input Medium.SpecificEnthalpy hv;
  input Medium.AbsolutePressure p_v;
  input Medium.SpecificEnthalpy h_v;
  parameter Modelica.SIunits.Diameter Din;
  parameter Modelica.SIunits.Area f_flow;
  Real Re_flow_eco;
  Real Re_flow_sh;
  Medium.ThermalConductivity k_flow_eco;
  Medium.ThermalConductivity k_flow_sh;
  Real Pr_flow_eco;
  Real Pr_flow_sh;
  Medium.DynamicViscosity mu_flow_eco;
  Medium.DynamicViscosity mu_flow_sh;
  Modelica.SIunits.Velocity w_flow_v_eco;
  Modelica.SIunits.Velocity w_flow_v_sh;
  Real A_alfa;
  Real C_alfa;
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_eco "Коэффициент теплопередачи со стороны потока вода/пар";
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_sh "Коэффициент теплопередачи со стороны потока вода/пар";
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
equation
  if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
// 1-phase or almost uniform properties
    k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
    k_flow_sh = k_flow_eco;
    Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
    Pr_flow_sh = Pr_flow_eco;
    mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
    mu_flow_sh = mu_flow_eco;
    w_flow_v_eco = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    w_flow_v_sh = w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
    Re_flow_eco = abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
    Re_flow_sh = Re_flow_eco;
  elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
// 2-phase
    k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
    k_flow_sh = k_flow_eco;
    Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
    Pr_flow_sh = Pr_flow_eco;
    mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
    mu_flow_sh = mu_flow_eco;
    w_flow_v_eco = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    w_flow_v_sh = w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
    Re_flow_eco = abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
    Re_flow_sh = Re_flow_eco;
  elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
// liquid/2-phase
    k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
    k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
    Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
    Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
    mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
    mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
    w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
    Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
  elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
// 2-phase/vapour
    k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
    k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
    Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
    Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
    mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
    mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
    w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
    Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
  elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
// liquid/2-phase/vapour
    k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
    k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
    Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
    Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
    mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
    mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
    w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
    Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
  elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
// 2-phase/liquid
    k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
    k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
    Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
    Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
    mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
    mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
    w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
    Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
  elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
// vapour/2-phase/liquid
    k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
    k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
    Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
    Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
    mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
    mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
    w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
    Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
  else
// vapour/2-phase
    k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
    k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
    Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
    Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
    mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
    mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
    w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
    Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
    Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
  end if;
  A_alfa = min(max((hl - h_n[1]) / max(h_n[2] - h_n[1], 0.01), 0), 1);
  C_alfa = min(max((h_n[2] - hv) / max(h_n[2] - h_n[1], 0.01), 0), 1);
  alfa_flow_eco = 0.023 * k_flow_eco / Din * Re_flow_eco ^ 0.8 * Pr_flow_eco ^ 0.4;
  alfa_flow_sh = 0.023 * k_flow_sh / Din * Re_flow_sh ^ 0.8 * Pr_flow_sh ^ 0.4;
  alfa_flow = ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) * alfa_flow_eco + ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2) * alfa_flow_sh + (1 - ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) - ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2)) * 20000;
end heatTransfer;