within TPPSim.Media;
model ExhaustGas "Выхлопные газы ГТУ"
  import Modelica.Media.IdealGases.Common;
  extends Modelica.Media.IdealGases.Common.MixtureGasNasa(mediumName = "ExhaustGas", data = {Common.SingleGasesData.O2, Common.SingleGasesData.CO2, Common.SingleGasesData.H2O, Common.SingleGasesData.N2, Common.SingleGasesData.Ar, Common.SingleGasesData.SO2}, fluidConstants = {Common.FluidData.O2, Common.FluidData.CO2, Common.FluidData.H2O, Common.FluidData.N2, Common.FluidData.Ar, Common.FluidData.SO2}, substanceNames = {"Oxygen", "Carbondioxide", "Water", "Nitrogen", "Argon", "Sulfurdioxide"}, reference_X = {0.1383, 0.032, 0.0688, 1 - 0.1383 - 0.032 - 0.0688 - 0.0000000001 - 0.0000000001, 0.0000000001, 0.0000000001});
  annotation(
    Documentation(info = "<html>
    <p>Смесь идеальных газов из следующих компонентов:</p>
    <ul>
      <li>O2 - кислород;</li>
      <li>CO2 - углекислый газ;</li>
      <li>H2O - вода;</li>
      <li>N2 - азот;</li>
      <li>Ar - аргон;</li>
      <li>SO2 - оксид серы.</li>      
    </ul>
  </html>"));
end ExhaustGas;