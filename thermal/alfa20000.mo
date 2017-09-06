within TPPSim.thermal;
model alfa20000
  outer Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
algorithm
  alfa_flow := 20000;
end alfa20000;