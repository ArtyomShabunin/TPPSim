within TPPSim.functions;
function calc_rho_drdh_drdp
  input Medium.SpecificEnthalpy h_n[2];
  input Medium.AbsolutePressure p_v;
  output Medium.Density rho_v;
  output Modelica.SIunits.DerDensityByPressure drdp_v;
  output Modelica.SIunits.DerDensityByEnthalpy drdh_v1, drdh_v2;
protected
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  constant Medium.AbsolutePressure pc = 22.06e6;
  constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3;
  constant Modelica.SIunits.Pressure pzero = 10;
  Medium.ThermodynamicState stateFlow[2];
  Medium.SaturationProperties sat;
  Medium.SpecificEnthalpy hl;
  Medium.SpecificEnthalpy hv;
  Medium.Density rhov;
  Medium.Density rhol;
  Medium.Density rho_n[2];
  Modelica.SIunits.DerDensityByPressure drdp_n[2];
  Modelica.SIunits.DerDensityByPressure drdh_n[2];
  Modelica.SIunits.DerDensityByPressure drldp;
  Modelica.SIunits.DerDensityByPressure drvdp;
  Modelica.SIunits.DerEnthalpyByPressure dhldp;
  Modelica.SIunits.DerEnthalpyByPressure dhvdp;
  Real AA;
  Real AA1;
algorithm
  sat := Medium.setSat_p(p_v);
  hl := Medium.bubbleEnthalpy(sat);
  hv := Medium.dewEnthalpy(sat);
  rhol := Medium.bubbleDensity(sat);
  rhov := Medium.dewDensity(sat);
  drldp := Medium.dBubbleDensity_dPressure(sat);
  drvdp := Medium.dDewDensity_dPressure(sat);
  dhldp := Medium.dBubbleEnthalpy_dPressure(sat);
  dhvdp := Medium.dDewEnthalpy_dPressure(sat);
  AA := (hv - hl) / (1 / rhov - 1 / rhol);
  AA1 := ((dhvdp - dhldp) * (rhol - rhov) * rhol * rhov - (hv - hl) * (rhov ^ 2 * drldp - rhol ^ 2 * drvdp)) / (rhol - rhov) ^ 2;
  for i in 1:2 loop
    stateFlow[i] := Medium.setState_ph(p_v, h_n[i]);
    rho_n[i] := Medium.density(stateFlow[i]);
    drdp_n[i] := Medium.density_derp_h(stateFlow[i]);
    drdh_n[i] := Medium.density_derh_p(stateFlow[i]);
  end for;
  if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
    rho_v := (rho_n[1] + rho_n[2]) / 2;
    drdp_v := (drdp_n[1] + drdp_n[2]) / 2;
    drdh_v1 := drdh_n[1] / 2;
    drdh_v2 := drdh_n[2] / 2;
  elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
    rho_v := AA * log(rho_n[1] / rho_n[2]) / (h_n[2] - h_n[1]);
    drdp_v := (AA1 * log(rho_n[1] / rho_n[2]) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
    drdh_v1 := (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
    drdh_v2 := (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
    rho_v := ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rho_n[2])) / (h_n[2] - h_n[1]);
    drdp_v := ((drdp_n[1] + drldp) * (hl - h_n[1]) / 2 + (rho_n[1] + rhol) / 2 * dhldp + AA1 * log(rhol / rho_n[2]) + AA * (1 / rhol * drldp - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
    drdh_v1 := (rho_v - (rho_n[1] + rhol) / 2 + drdh_n[1] * (hl - h_n[1]) / 2) / (h_n[2] - h_n[1]);
    drdh_v2 := (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
    rho_v := (AA * log(rho_n[1] / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
    drdp_v := (AA1 * log(rho_n[1] / rhov) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rhov * drvdp) + (drvdp + drdp_n[2]) * (h_n[2] - hv) / 2 - (rhov + rho_n[2]) / 2 * dhvdp) / (h_n[2] - h_n[1]);
    drdh_v1 := (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
    drdh_v2 := ((rhov + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
    rho_v := ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
    drdp_v := ((drdp_n[1] + drldp) * (hl - h_n[1]) / 2 + (rho_n[1] + rhol) / 2 * dhldp + AA1 * log(rhol / rhov) + AA * (1 / rhol * drldp - 1 / rhov * drvdp) + (drvdp + drdp_n[2]) * (h_n[2] - hv) / 2 - (rhov + rho_n[2]) / 2 * dhvdp) / (h_n[2] - h_n[1]);
    drdh_v1 := (rho_v - (rho_n[1] + rhol) / 2 + drdh_n[1] * (hl - h_n[1]) / 2) / (h_n[2] - h_n[1]);
    drdh_v2 := ((rhov + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
    rho_v := (AA * log(rho_n[1] / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
    drdp_v := (AA1 * log(rho_n[1] / rhol) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rhol * drldp) + (drldp + drdp_n[2]) * (h_n[2] - hl) / 2 - (rhol + rho_n[2]) / 2 * dhldp) / (h_n[2] - h_n[1]);
    drdh_v1 := (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
    drdh_v2 := ((rhol + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
    rho_v := ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
    drdp_v := ((drdp_n[1] + drvdp) * (hv - h_n[1]) / 2 + (rho_n[1] + rhov) / 2 * dhvdp + AA1 * log(rhov / rhol) + AA * (1 / rhov * drvdp - 1 / rhol * drldp) + (drldp + drdp_n[2]) * (h_n[2] - hl) / 2 - (rhol + rho_n[2]) / 2 * dhldp) / (h_n[2] - h_n[1]);
    drdh_v1 := (rho_v - (rho_n[1] + rhov) / 2 + drdh_n[1] * (hv - h_n[1]) / 2) / (h_n[2] - h_n[1]);
    drdh_v2 := ((rhol + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
  else
    rho_v := ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rho_n[2])) / (h_n[2] - h_n[1]);
    drdp_v := ((drdp_n[1] + drvdp) * (hv - h_n[1]) / 2 + (rho_n[1] + rhov) / 2 * dhvdp + AA1 * log(rhov / rho_n[2]) + AA * (1 / rhov * drvdp - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
    drdh_v1 := (rho_v - (rho_n[1] + rhov) / 2 + drdh_n[1] * (hv - h_n[1]) / 2) / (drdp_n[1] - h_n[1]);
    drdh_v2 := (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
  end if;
end calc_rho_drdh_drdp;