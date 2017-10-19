within TPPSim.Controls;
block onAuto
  extends Modelica.Blocks.Interfaces.BooleanSISO;
  Boolean auto(start = false, fixed = true);
algorithm
  when not auto and u then
    auto := true;
  end when;
equation
    y = auto;
end onAuto;
