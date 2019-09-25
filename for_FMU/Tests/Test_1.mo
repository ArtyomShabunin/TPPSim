within TPPSim.for_FMU.Tests;

model Test_1

  parameter Real param_1 = 100;
  parameter Real param_2 = 200;

  Real var_1;
  output Real output_1;
  input Real input_1(start = 100);

equation

  var_1 = param_1 + param_2;
  output_1 = input_1 * param_2;

end Test_1;
