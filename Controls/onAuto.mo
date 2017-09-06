within TPPSim.Controls;
block onAuto
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Real trigger;
  Boolean auto(start = false, fixed = true);
algorithm
  when u > trigger and not auto then
    auto := true;
  end when;
equation
  if auto then
    y = u;
  else
    y = 0;
  end if;
end onAuto;