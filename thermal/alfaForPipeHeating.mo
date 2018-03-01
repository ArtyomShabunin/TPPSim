within TPPSim.thermal;
model alfaForPipeHeating
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  final outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр трубок теплообменника";
  final outer parameter Modelica.SIunits.Area f_flow "Площадь для прохода теплоносителя";
  parameter Integer[2] section "Координаты участка"; 
   
  outer Modelica.SIunits.Temperature t_m "Температура металла на участках трубопровода";
  outer Medium.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";   
  outer Medium.MassFlowRate D "Массовый расход (глобальная переменная)";
  outer Medium.SpecificEnthalpy h "Энтальпия (глобальная переменная)";
  outer Medium.AbsolutePressure p "Давление (глобальная переменная)"; 
  outer Modelica.SIunits.CoefficientOfHeatTransfer alfa_sat;
  outer Medium.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
  outer Medium.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";  
  outer Medium.ThermodynamicState stateFlow;
  
  Real x_eco;  

  Medium.Density rho_bubble;
  Medium.ThermalConductivity k_v;
  Medium.DynamicViscosity mu_v;
  Real Pr_v;  
  Modelica.SIunits.Velocity w_v;
  Real Re_v;
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_v "Коэффициент теплопередачи на пароперегревательном участке"; 
  
  //Medium.ThermodynamicState state_v;   

//equation  
  //state_v = Medium.setState_ph(p[section[1], section[2] + 1], hl);
algorithm
//  x_eco := if noEvent(h[section[1], section[2] + 1] < hl) then 1 elseif noEvent(h[section[1], section[2]] > hl) then 0 else (hl - h[section[1], section[2]]) / (h[section[1], section[2] + 1] - h[section[1], section[2]]);

  x_eco := if noEvent(h[section[1], section[2]] < hl) then 1 elseif noEvent(h[section[1], section[2] + 1] > hl) then 0 else (hl - h[section[1], section[2]]) / (h[section[1], section[2] + 1] - h[section[1], section[2]]);
  
     
//  k_v := Medium.thermalConductivity(state_v);
  rho_bubble := Medium.bubbleDensity(sat_v);
  k_v := Modelica.Media.Water.IF97_Utilities.thermalConductivity(rho_bubble, sat_v.Tsat, sat_v.psat, 1);
  mu_v := Modelica.Media.Water.IF97_Utilities.dynamicViscosity(rho_bubble, sat_v.Tsat, sat_v.psat, 1);
//  Pr_v := Medium.prandtlNumber(state_v);
  Pr_v := mu_v * Modelica.Media.Water.IF97_Utilities.cp_ph(sat_v.psat, hl, region = 1) / k_v;
  w_v := abs(D[section[1], section[2] + 1]) / rho_bubble / f_flow;
  Re_v := w_v * Din * rho_bubble / mu_v;
  alfa_v := (0.023 * k_v / Din * Re_v ^ 0.8 * Pr_v ^ 0.4);
  alfa_sat :=  0.5 * (1 - x_eco) * alfa_v * (rho_bubble / stateFlow.d) ^ 0.5;

end alfaForPipeHeating;
