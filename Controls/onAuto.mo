within TPPSim.Controls;
block onAuto
  extends Modelica.Blocks.Interfaces.SI2SO;
  Boolean auto(start = false, fixed = true);
algorithm
  when not auto and u2 > u1 then
    auto := true;
  end when;
equation
  if auto then
    y = u2;
  else
    y = u1;
  end if;
end onAuto;
