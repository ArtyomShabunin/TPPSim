within TPPSim.thermal;
function alpha_sat "Коэффициент теплоотдачи при конденсации водяного пара"
  input Medium.AbsolutePressure p "Давление";    
  input Medium.MassFlowRate D_flow_v;
  input Modelica.SIunits.Area f_flow;  
  input Modelica.SIunits.Diameter Din;
  input Medium.Density rho "Плотность среды";  
  output Modelica.SIunits.CoefficientOfHeatTransfer alfa_sat "Коэффициент теплопередачи со стороны потока вода/пар";
protected
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  Medium.ThermodynamicState stateLiquid;
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_l "Коэффициент теплопередачи для воды"; 
algorithm
  stateLiquid := Medium.setState_px(p, 0);
  alfa_l := TPPSim.thermal.falfaForSHandECO(stateLiquid, D_flow_v, f_flow, Din);
  alfa_sat :=  alfa_l * (stateLiquid.d / rho) ^ 0.5;
  //alfa_sat := 15000;
  annotation(
    Documentation(info = "<html><head></head><body>
      Расчет коэффициента теплоотдачи при конденсации водяного пара по формуле 4.32 из книги 'Основы теплопередачи' М.А. Михеев, И.М. Михеева.
      </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>Match 15, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end alpha_sat;
