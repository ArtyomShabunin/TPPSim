within TPPSim.thermal;
function alpha_sat "Коэффициент теплоотдачи при конденсации водяного пара"
  input Medium.SpecificEnthalpy[2] h "Энтальпия потока на входе и выходе участка";
  input Medium.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
  input Medium.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";   
  input Medium.MassFlowRate D_flow_v;
  input Modelica.SIunits.Area f_flow;  
  input Modelica.SIunits.Diameter Din;
  input Medium.Density rho "Плотность среды";  
  output Modelica.SIunits.CoefficientOfHeatTransfer alfa_sat "Коэффициент теплопередачи со стороны потока вода/пар";
protected
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  Real x_eco "Влажность пара";
  Medium.Density rho_bubble "Плотность воды на линии насыщения";
  Medium.ThermalConductivity k_l "Теплопроводность вода";
  Medium.DynamicViscosity mu_l "Динамическая вязкость воды";
  Real Pr_l "Число Прандтля для воды";  
  Modelica.SIunits.Velocity w_l "Скорость воды";
  Real Re_l "Число Рейнольдса для воды";
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_l "Коэффициент теплопередачи для воды"; 
algorithm
  x_eco := if noEvent(h[1] < hl) then 1 elseif noEvent(h[2] > hl) then 0 else (hl - h[1]) / (h[2] - h[1]);     
  rho_bubble := Medium.bubbleDensity(sat_v);
  k_l := Modelica.Media.Water.IF97_Utilities.thermalConductivity(rho_bubble, sat_v.Tsat, sat_v.psat, 1);
  mu_l := Modelica.Media.Water.IF97_Utilities.dynamicViscosity(rho_bubble, sat_v.Tsat, sat_v.psat, 1);
  Pr_l := mu_l * Modelica.Media.Water.IF97_Utilities.cp_ph(sat_v.psat, hl, region = 1) / k_l;
  w_l := abs(D_flow_v) / rho_bubble / f_flow;
  Re_l := w_l * Din * rho_bubble / mu_l;
  alfa_l := (0.023 * k_l / Din * Re_l ^ 0.8 * Pr_l ^ 0.4);
  alfa_sat :=  0.5 * (1 - x_eco) * alfa_l * (rho_bubble / rho) ^ 0.5;
  annotation(
    Documentation(info = "<html><head></head><body>
      Расчет коэффициента теплоотдачи при конденсации водяного пара по формуле 4.32 из книги 'Основы теплопередачи' М.А. Михеев, И.М. Михеева.
      </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>Match 15, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end alpha_sat;
