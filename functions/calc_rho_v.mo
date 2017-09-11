within TPPSim.functions;
function calc_rho_v
  input Medium.SpecificEnthalpy h_n[2];
  input Medium.AbsolutePressure p_v;
  output Medium.Density rho_v;
protected
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  constant Medium.AbsolutePressure pc = 22.06e6;
  constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3;
  constant Modelica.SIunits.Pressure pzero = 10;
  Medium.SaturationProperties sat;
  Medium.SpecificEnthalpy hl;
  Medium.SpecificEnthalpy hv;
  Medium.Density rhov;
  Medium.Density rhol;
  Medium.Density rho_n[2];
  Real AA;
algorithm
  sat := Medium.setSat_p(p_v);
  hl := Medium.bubbleEnthalpy(sat);
  hv := Medium.dewEnthalpy(sat);
  rhol := Medium.bubbleDensity(sat);
  rhov := Medium.dewDensity(sat);
  AA := (hv - hl) / (1 / rhov - 1 / rhol);
  for i in 1:2 loop
    rho_n[i] := Medium.density(Medium.setState_ph(p_v, h_n[i]));
  end for;
  if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
    rho_v := (rho_n[1] + rho_n[2]) / 2;
  elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
    rho_v := AA * log(rho_n[1] / rho_n[2]) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
    rho_v := ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rho_n[2])) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
    rho_v := (AA * log(rho_n[1] / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
    rho_v := ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
    rho_v := (AA * log(rho_n[1] / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
    rho_v := ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
  else
    rho_v := ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rho_n[2])) / (h_n[2] - h_n[1]);
  end if;
end calc_rho_v;