within TPPSim.thermal;
model hfrForPipeHeating "Тепловой поток (HeatFlowRate) к внутренней стенке паропровода при прогреве."
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  final outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр трубок теплообменника";
  final outer parameter Modelica.SIunits.Area f_flow "Площадь для прохода теплоносителя";
  final outer parameter Modelica.SIunits.Area deltaSFlow "Внутренняя площадь одного участка ряда труб";
  parameter Integer[2] section "Координаты участка";    
  outer Modelica.SIunits.Temperature t_m "Температура металла на участках трубопровода";
  outer Medium.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";   
  outer Medium.MassFlowRate D "Массовый расход (глобальная переменная)";
  outer Medium.SpecificEnthalpy h "Энтальпия (глобальная переменная)";
  outer Medium.AbsolutePressure p "Давление (глобальная переменная)"; 
  outer Medium.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
  outer Medium.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";  
  outer Medium.ThermodynamicState stateFlow;
  Modelica.SIunits.CoefficientOfHeatTransfer alpha_sat "Коэффициент теплопередачи при конденсации пара";
  Modelica.SIunits.CoefficientOfHeatTransfer alpha_conv "Коэфициент теплопередачи при конвективном теплообмене";  
  outer Modelica.SIunits.HeatFlowRate Q "Тепло переданное стенкой паропровода потоку пара";
  
  Modelica.SIunits.HeatFlowRate Q_cond;
  Modelica.SIunits.HeatFlowRate Q_cond_max;
  Modelica.SIunits.HeatFlowRate Q_conv;
algorithm
  alpha_sat :=  TPPSim.thermal.alpha_sat(p[section[1], section[2] + 1], D[section[1], section[2] + 1], f_flow, Din, stateFlow.d);
  alpha_conv := TPPSim.thermal.falfaForSHandECO(stateFlow, D[section[1], section[2] + 1], f_flow, Din); 
  Q_cond := deltaSFlow * alpha_sat * max((min(sat_v.Tsat, stateFlow.T) - t_m), 0);
  Q_cond_max := max(D[section[1], section[2] + 1] * (h[section[1], section[2]] - hl), 0);
  Q_conv := deltaSFlow * alpha_conv * (stateFlow.T - t_m);
  Q := -max(Q_conv,min(Q_cond, Q_cond_max));
  //Q := -(Q_conv + min(Q_cond, Q_cond_max));
  annotation(
    Documentation(info = "<html><head></head><body>
      Модель для расчета теплового потока к внутренней стенке паропровода при прогреве. Модель учитывает конвективный теплообмен и теплообмен при конденсации пара.<br>Используются глобальные переменные, из-за чего модель может использоваться только совместно с моделью ElementarySteamPipe.
      </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>Match 15, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end hfrForPipeHeating;
