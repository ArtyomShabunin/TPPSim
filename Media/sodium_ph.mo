within TPPSim.Media;

model Sodium_ph "теплофизические свойства жидкого натрия"

  extends Modelica.Media.Interfaces.PartialMedium(
    final ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
    final mediumName="Sodium",
    final substanceNames={mediumName},
    final singleState=true,
    final reducedX=true,
    final fixedX=true,
    Temperature(
      min=373.15,
      max=1473.15,
      start=673.15));

  redeclare model extends BaseProperties(final standardOrderComponents=true)
    "Base properties of medium"
  equation
    d = density(state);
    state.d = d;
    T = temperature(state);
    state.T = T;
    u = h - p/d;
    MM = 0.024;
    R = 8.3144/MM;
    state.p = p;
    state.h = h;
  end BaseProperties;

  redeclare replaceable record ThermodynamicState
    "A selection of variables that uniquely defines the thermodynamic state"
    extends Modelica.Icons.Record;
    AbsolutePressure p "Absolute pressure of medium";
    SpecificEnthalpy h "Enthalpy of medium";
    Temperature T "Temperature of medium";
    Density d "Density of medium";
    annotation (Documentation(info="<html>

</html>"));
  end ThermodynamicState;

  redeclare function extends setState_phX
    "Return thermodynamic state of glycol as function of p, h"
  algorithm
    state := ThermodynamicState(p, h, temperature_ph(p, h), density_ph(p, h));
    annotation (Inline=true);
  end setState_phX;
  
  redeclare function extends setState_pTX
    "Return thermodynamic state of glycol as function of p, T"
  algorithm
    state := ThermodynamicState(p, specificEnthalpy_pT(p, T), T, density_pT(p, T));
    annotation (Inline=true);
  end setState_pTX;  

  redeclare function extends dynamicViscosity "Return dynamic viscosity"
  algorithm
    eta := 1.2162e-5 * (state.d^(1/3)) * exp(0.6976*state.d/state.T);
    annotation (Documentation(info="<html>

</html>"));
  end dynamicViscosity;
  
  redeclare function extends temperature "Return temperature"
  algorithm
    T := temperature_ph(state.p, state.h);
    annotation (Documentation(info="<html>

</html>"));
  end temperature;
  
  function temperature_ph
    "Computes temperature as a function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    output Temperature T "Temperature";
  algorithm
    T := 0.0007745257754441447*h + 369.7377458495829;
    annotation (Inline=true);
  end temperature_ph;
  
  redeclare function extends pressure "Return pressure"
  algorithm
    p := state.p;
    annotation (Documentation(info="<html>

</html>"));
  end pressure;

  redeclare function extends thermalConductivity
    "Return thermal conductivity"
  algorithm
    lambda := 90.6-0.04852*(state.T-273.15);
    annotation (Documentation(info="<html>

</html>"));
  end thermalConductivity;
  
  redeclare function extends density "Return density"
  algorithm
    d := density_ph(state.p, state.h);
  end density;
  
  function density_ph
    "Computes density as a function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    output Density d "Density";
  algorithm
    d := density_pT(p, temperature_ph(p, h));
    annotation (Inline=true);
  end density_ph;
  
  function density_pT
    "Computes density as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy T "Temperature";
    output Density d "Density";
  algorithm
    d := 949-0.223*(T-273.15)-(1.75e-5)*(T-273.15)^2;
    annotation (Inline=true);
  end density_pT;

  redeclare function extends specificHeatCapacityCp
    "Return specific heat capacity at constant pressure"
  algorithm
    cp := 1436-0.580*(state.T-273.15)+4.62e-4*(state.T-273.15)^2;
    annotation (Documentation(info="<html>

</html>"));
  end specificHeatCapacityCp;
  
  redeclare function extends specificEnthalpy
    "Return specific enthalpy"
  algorithm
    h := state.h;
    annotation (Documentation(info="<html>

</html>"));
  end specificEnthalpy;
  
  function specificEnthalpy_pT
    "Computes specific enthalpy as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    output SpecificEnthalpy h "Specific enthalpy";
  algorithm
    h := -140954+1437*(T-273.15)-0.29*(T-273.15)^2+1.54e-4*(T-273.15)^3;
    annotation (Inline=true);
  end specificEnthalpy_pT;
    

  annotation (Documentation(info="<html>
<p>
This package is a <b>template</b> for <b>new medium</b> models. For a new
medium model just make a copy of this package, remove the
\"partial\" keyword from the package and provide
the information that is requested in the comments of the
Modelica source.
</p>
</html>"));
end Sodium_ph;
