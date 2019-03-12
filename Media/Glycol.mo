within TPPSim.Media;

package Glycol
  /* For a new medium, make a copy of this package and remove
   the "partial" keyword from the package definition above.
   The statement below extends from PartialMedium and sets some
   package constants. Provide values for these constants
   that are appropriate for your medium model. Note that other
   constants (such as nX, nXi) are automatically defined by
   definitions given in the base class Interfaces.PartialMedium"
*/
  extends Modelica.Media.Interfaces.PartialMedium(
    final ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
    final mediumName="Glycol",
    final substanceNames={mediumName},
    final singleState=true,
    final reducedX=true,
    final fixedX=true,
    Temperature(
      min=273.15,
      max=468.15,
      start=373));

  // Provide medium constants here
//  constant SpecificHeatCapacity cp_const=123456
//    "Constant specific heat capacity at constant pressure";

  /* The vector substanceNames is mandatory, as the number of
       substances is determined based on its size. Here we assume
       a single-component medium.
       singleState is true if u and d do not depend on pressure, but only
       on a thermal variable (temperature or enthalpy). Otherwise, set it
       to false.
       For a single-substance medium, just set reducedX and fixedX to true, and there's
       no need to bother about medium compositions at all. Otherwise, set
       final reducedX = true if the medium model has nS-1 independent mass
       fraction, or reducedX = false if the medium model has nS independent
       mass fractions (nS = number of substances).
       If a mixture has a fixed composition set fixedX=true, otherwise false.
       The modifiers for reducedX and fixedX should normally be final
       since the other equations are based on these values.

       It is also possible to redeclare the min, max, and start attributes of
       Medium types, defined in the base class Interfaces.PartialMedium
       (the example of Temperature is shown here). Min and max attributes
       should be set in accordance to the limits of validity of the medium
       model, while the start attribute should be a reasonable default value
       for the initialization of nonlinear solver iterations */

  /* Provide an implementation of model BaseProperties,
   that is defined in PartialMedium. Select two independent
   variables from p, T, d, u, h. The other independent
   variables are the mass fractions "Xi", if there is more
   than one substance. Provide 3 equations to obtain the remaining
   variables as functions of the independent variables.
   It is also necessary to provide two additional equations to set
   the gas constant R and the molar mass MM of the medium.
   Finally, the thermodynamic state vector, defined in the base class
   Interfaces.PartialMedium.BaseProperties, should be set, according to
   its definition (see ThermodynamicState below).
   The computation of vector X[nX] from Xi[nXi] is already included in
   the base class Interfaces.PartialMedium.BaseProperties, so it should not
   be repeated here.
   The code fragment below is for a single-substance medium with
   p,T as independent variables.
*/

  redeclare model extends BaseProperties(final standardOrderComponents=true)
    "Base properties of medium"

  equation
    d = density(state);
    h = specificEnthalpy(state);
    u = h - p/d;
    MM = 0.024;
    R = 8.3144/MM;
    state.p = p;
    state.T = T;
  end BaseProperties;

  /* Provide implementations of the following optional properties.
   If not available, delete the corresponding function.
   The record "ThermodynamicState" contains the input arguments
   of all the function and is defined together with the used
   type definitions in PartialMedium. The record most often contains two of the
   variables "p, T, d, h" (e.g., medium.T)
*/
  redeclare replaceable record ThermodynamicState
    "A selection of variables that uniquely defines the thermodynamic state"
    extends Modelica.Icons.Record;
    AbsolutePressure p "Absolute pressure of medium";
    Temperature T "Temperature of medium";
    annotation (Documentation(info="<html>

</html>"));
  end ThermodynamicState;

  redeclare function extends setState_pTX
    "Return thermodynamic state of glycol as function of p, T"
  algorithm
    state := ThermodynamicState(p, T);
    annotation (Inline=true);
  end setState_pTX;

  redeclare function extends dynamicViscosity "Return dynamic viscosity"
  algorithm
    eta := (6.82872680e+01*(1/((state.T-273.15)+20)) + 1.10412457e+04*(1/((state.T-273.15)+20))^2 - 1.32115870e+05*(1/((state.T-273.15)+20))^3 - 0.11307952545012245)*1e+6;
    annotation (Documentation(info="<html>

</html>"));
  end dynamicViscosity;
  
  redeclare function extends temperature "Return temperature"
  algorithm
    T := state.T;
    annotation (Documentation(info="<html>

</html>"));
  end temperature;
  
  redeclare function extends pressure "Return pressure"
  algorithm
    p := state.p;
    annotation (Documentation(info="<html>

</html>"));
  end pressure;

  redeclare function extends thermalConductivity
    "Return thermal conductivity"
  algorithm
    lambda := -1.79739308e-04*(state.T-273.15) - 1.47776756e-06*(state.T-273.15)^2 + 0.38644659985081337;
    annotation (Documentation(info="<html>

</html>"));
  end thermalConductivity;
  
  redeclare function extends density "Return density"
  algorithm
    d := -0.68421656*(state.T-273.15) + 0.0009019*(state.T-273.15)^2 + 1115.8821150767992;
  end density;

  redeclare function extends specificHeatCapacityCp
    "Return specific heat capacity at constant pressure"
  algorithm
    cp := (0.004387747287811103*(state.T-273.15) + 3.016282918527973)*1e+3;
    annotation (Documentation(info="<html>

</html>"));
  end specificHeatCapacityCp;
  
  redeclare function extends specificEnthalpy
    "Return specific enthalpy"
  algorithm
    h := specificHeatCapacityCp(state)*state.T;
    annotation (Documentation(info="<html>

</html>"));
  end specificEnthalpy;

  annotation (Documentation(info="<html>
<p>
This package is a <b>template</b> for <b>new medium</b> models. For a new
medium model just make a copy of this package, remove the
\"partial\" keyword from the package and provide
the information that is requested in the comments of the
Modelica source.
</p>
</html>"));
end Glycol;
