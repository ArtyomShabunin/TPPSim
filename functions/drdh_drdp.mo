within TPPSim.functions;
function drdh_drdp
  input Medium.SpecificEnthalpy h_v;
  input Medium.SpecificEnthalpy h_n[2];
  input Medium.AbsolutePressure p_v;
  input Medium.AbsolutePressure p_n[2];
  //input Modelica.SIunits.DerDensityByEnthalpy drdh_last;
  //input Modelica.SIunits.DerDensityByPressure drdp_last;
  //input Real mytime;
  output Modelica.SIunits.DerDensityByEnthalpy drdh;
  output Modelica.SIunits.DerDensityByPressure drdp;
protected
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  Modelica.SIunits.DerDensityByEnthalpy drdh_temp;
  Modelica.SIunits.DerDensityByPressure drdp_temp;
  Modelica.SIunits.DerDensityByEnthalpy drdh_lim = -0.002 "Предельное значение производной плотности по энтальпии";
  Modelica.SIunits.DerDensityByPressure drdp_lim = 0.0005 "Предельное значение производной плотности по давлению";
algorithm
  drdh_temp := if abs(h_n[2] - h_n[1]) > 0.01 then (Medium.density(Medium.setState_ph(p_v, h_n[2])) - Medium.density(Medium.setState_ph(p_v, h_n[1]))) / (h_n[2] - h_n[1]) else (Medium.density(Medium.setState_ph(p_v, h_n[2])) - Medium.density(Medium.setState_ph(p_v, h_n[2] - 0.01))) / 0.01;
  drdp_temp := if abs(p_n[2] - p_n[1]) > 0.01 then (Medium.density(Medium.setState_ph(p_n[2], h_v)) - Medium.density(Medium.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium.density(Medium.setState_ph(p_n[2], h_v)) - Medium.density(Medium.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
  if abs(drdh_temp) > abs(drdh_lim) then
    drdh := drdh_lim;
    if abs(drdp_temp) < abs(drdp_lim) then
      drdp := drdp_temp;
    else
      drdp := drdp_lim;
    end if;
  elseif abs(drdp_temp) > abs(drdp_lim) then
    drdp := drdp_lim;
    if abs(drdh_temp) < abs(drdh_lim) then
      drdh := drdh_temp;
    else
      drdh := drdh_lim;
    end if;
  else
    drdh := drdh_temp;
    drdp := drdp_temp;
  end if;
end drdh_drdp;