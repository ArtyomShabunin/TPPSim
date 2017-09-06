within TPPSim.functions;
function drdh_drdp_NOGOOD "Вариант который мне не очень нравится, но кажется работает"
  input Medium.SpecificEnthalpy h_v;
  input Medium.SpecificEnthalpy h_n[2];
  input Medium.AbsolutePressure p_v;
  input Medium.AbsolutePressure p_n[2];
  output Modelica.SIunits.DerDensityByEnthalpy drdh;
  output Modelica.SIunits.DerDensityByPressure drdp;
protected
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  Modelica.SIunits.DerDensityByEnthalpy drdh_temp;
  Modelica.SIunits.DerDensityByPressure drdp_temp;
algorithm
  drdh_temp := if abs(h_n[2] - h_n[1]) > 0.01 then (Medium.density(Medium.setState_ph(p_v, h_n[2])) - Medium.density(Medium.setState_ph(p_v, h_n[1]))) / (h_n[2] - h_n[1]) else (Medium.density(Medium.setState_ph(p_v, h_n[2])) - Medium.density(Medium.setState_ph(p_v, h_n[2] - 0.01))) / 0.01;
  drdp_temp := if abs(p_n[2] - p_n[1]) > 0.01 then (Medium.density(Medium.setState_ph(p_n[2], h_v)) - Medium.density(Medium.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium.density(Medium.setState_ph(p_n[2], h_v)) - Medium.density(Medium.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
  if abs(drdh_temp) > 0.005 then
    if abs(0.005 * drdp_temp / drdh_temp) < 0.000153 then
      drdh := -0.005;
      drdp := -0.005 * drdp_temp / drdh_temp;
    else
      drdh := 0.000153 * drdh_temp / drdp_temp;
      drdp := 0.000153;
    end if;
  elseif abs(drdp_temp) > 0.000153 then
    if abs(0.000153 * drdh_temp / drdp_temp) < 0.005 then
      drdh := 0.000153 * drdh_temp / drdp_temp;
      drdp := 0.000153;
    else
      drdh := -0.005;
      drdp := -0.005 * drdp_temp / drdh_temp;
    end if;
  else
    drdh := drdh_temp;
    drdp := drdp_temp;
  end if;
end drdh_drdp_NOGOOD;