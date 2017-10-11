within TPPSim.thermal;
model alfaForEVO
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  final outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр трубок теплообменника";
  final outer parameter Modelica.SIunits.Area f_flow "Площадь для прохода теплоносителя";
  parameter Integer[2] section "Координаты участка";  
 
  outer Medium.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
 
  outer Medium.MassFlowRate D_gl "Массовый расход (глобальная переменная)";
  outer Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
  Medium.DynamicViscosity mu;
  Modelica.SIunits.Velocity w;
  Real Re;
  Medium.ThermalConductivity k;
  Real Pr;
  
  Medium.SpecificHeatCapacity cp;
  Medium.Density rho "Плотность на экономайзерном участке";  
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_eco "Коэффициент теплопередачи на экономайзерном участке"; 
  outer Medium.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
  outer Medium.SpecificEnthalpy h_gl "Энтальпия (глобальная переменная)";
algorithm
  rho := max(stateFlow.d, Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.rhol_p(stateFlow.p));
  k := Modelica.Media.Water.IF97_Utilities.BaseIF97.Transport.cond_dTp(rho, stateFlow.T, stateFlow.p);
  mu := Modelica.Media.Water.IF97_Utilities.BaseIF97.Transport.visc_dTp(rho, stateFlow.T, stateFlow.p);
  cp := Modelica.Media.Water.IF97_Utilities.cp_ph(stateFlow.p, min(stateFlow.h, hl));  
  Pr := mu * cp / k;
  w := max(D_gl[section[1], section[2]], 0) / rho / f_flow;
  Re := w * Din * rho / mu;
  alfa_eco := max(0.023 * k / Din * Re ^ 0.8 * Pr ^ 0.4, 0.1);

  if noEvent(h_gl[section[1], section[2] + 1] < hl) then
    alfa_flow := alfa_eco; 
  elseif noEvent(h_gl[section[1], section[2]] >= hl) then
    alfa_flow := 20000;  
  else
    alfa_flow := 
    ((hl - h_gl[section[1], section[2]]) * alfa_eco +
    (h_gl[section[1], section[2] + 1] - hl) * 20000) / (h_gl[section[1], section[2] + 1] - h_gl[section[1], section[2]]);
  end if;
  


  /*if noEvent(h_gl[section[1], section[2] + 1] - h_gl[section[1], section[2]] > 10) then
    alfa_flow = min(max(1, (hl - h_gl[section[1], section[2]])/(h_gl[section[1], section[2] + 1] - h_gl[section[1], section[2]])), 0) * alfa_eco +
                 min(max(1, (h_gl[section[1], section[2] + 1] - hl)/(h_gl[section[1], section[2] + 1] - h_gl[section[1], section[2]])), 0) * 20000;
  else
    alfa_flow = alfa_eco;
  end if;*/
end alfaForEVO;
