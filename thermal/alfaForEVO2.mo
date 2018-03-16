within TPPSim.thermal;
model alfaForEVO2
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  final outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр трубок теплообменника";
  final outer parameter Modelica.SIunits.Area f_flow "Площадь для прохода теплоносителя";
  parameter Integer[2] section "Координаты участка";  
 
 
  outer Medium.MassFlowRate D_gl "Массовый расход (глобальная переменная)";
  outer Medium.SpecificEnthalpy h_gl "Энтальпия (глобальная переменная)";
  outer Medium.AbsolutePressure p_gl "Давление (глобальная переменная)"; 
  outer Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
  outer Medium.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
  outer Medium.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";  

  Real x_eco;
  Medium.ThermalConductivity k_l;
  Medium.DynamicViscosity mu_l;
  Real Pr_l;  
  Modelica.SIunits.Velocity w_l;
  Real Re_l;
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_l "Коэффициент теплопередачи на экономайзерном участке";   

  Real x_sh;
  Medium.ThermalConductivity k_v;
  Medium.DynamicViscosity mu_v;
  Real Pr_v;  
  Modelica.SIunits.Velocity w_v;
  Real Re_v;
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_v "Коэффициент теплопередачи на пароперегревательном участке"; 
  
  Medium.ThermodynamicState state_l; 
  Medium.ThermodynamicState state_v;   

equation  
  state_l = Medium.setState_ph(p_gl[section[1], section[2]], h_gl[section[1], section[2]]);
  state_v = Medium.setState_ph(p_gl[section[1], section[2] + 1], h_gl[section[1], section[2]] + 1);  
algorithm
  x_eco := if noEvent(h_gl[section[1], section[2] + 1] < hl) then 1 elseif noEvent(h_gl[section[1], section[2]] > hl) then 0 else (hl - h_gl[section[1], section[2]]) / (h_gl[section[1], section[2] + 1] - h_gl[section[1], section[2]]);
  k_l := Medium.thermalConductivity(state_l);
  mu_l := Medium.dynamicViscosity(state_l);
  Pr_l := Medium.prandtlNumber(state_l);
  w_l := abs(D_gl[section[1], section[2]]) / state_l.d / f_flow;
  Re_l := w_l * Din * state_l.d / mu_l;
  alfa_l := 0.023 * k_l / Din * Re_l ^ 0.8 * Pr_l ^ 0.4;
  
  x_sh := if noEvent(h_gl[section[1], section[2] + 1]) < hv then 0 elseif noEvent(h_gl[section[1], section[2]] > hv) then 1 else (h_gl[section[1], section[2] + 1] - hv) / (h_gl[section[1], section[2] + 1] - h_gl[section[1], section[2]]);      
  k_v := Medium.thermalConductivity(state_v);
  mu_v := Medium.dynamicViscosity(state_v);
  Pr_v := Medium.prandtlNumber(state_v);
  w_v := abs(D_gl[section[1], section[2] + 1]) / state_v.d / f_flow;
  Re_v := w_v * Din * state_v.d / mu_v;
  alfa_v := 0.023 * k_v / Din * Re_v ^ 0.8 * Pr_v ^ 0.4;
   
  alfa_flow := max((1 - x_eco - x_sh) * 20000 + x_eco * alfa_l + x_sh * alfa_v, 0.0001);  
end alfaForEVO2;
