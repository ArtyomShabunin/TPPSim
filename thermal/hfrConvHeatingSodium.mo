within TPPSim.thermal;

model hfrConvHeatingSodium
  package Medium = TPPSim.Media.Sodium_ph;
  outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр трубок теплообменника";
  outer parameter Modelica.SIunits.Area f_flow "Площадь для прохода теплоносителя";
  outer parameter Modelica.SIunits.Area deltaSFlow "Внутренняя площадь одного участка ряда труб";
  outer Modelica.SIunits.Temperature t_m "Температура металла на участках трубопровода";
  outer Medium.MassFlowRate D_flow_v "Массовый расход (глобальная переменная)";
  outer Medium.ThermodynamicState stateFlow;
  Modelica.SIunits.CoefficientOfHeatTransfer alpha_conv "Коэффициент теплопередачи при конвективном теплообмене";  
  outer Modelica.SIunits.HeatFlowRate Q "Тепло переданное стенкой паропровода потоку пара";  
equation
  alpha_conv = TPPSim.thermal.alphaForSodiumInside(stateFlow, D_flow_v, f_flow, Din); 
  Q = deltaSFlow * alpha_conv * (t_m - stateFlow.T);
  annotation(
    Documentation(info = "<html><head></head><body>
      Модель для расчета теплового потока к внутренней стенке паропровода при прогреве. Модель учитывает только конвективный теплообмен.<br>Используются глобальные переменные, из-за чего модель может использоваться только совместно с моделью ElementarySteamPipe или ElementaryPipe.
      </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>Match 15, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end hfrConvHeatingSodium;
