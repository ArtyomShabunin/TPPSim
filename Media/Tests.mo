within TPPSim.Media;

package Tests
  model Glycol_Test
    replaceable package Medium_F = TPPSim.Media.Glycol_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    inner Modelica.Fluid.System system annotation(
      Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Sources.MassFlowSource_T flow_source_1(redeclare package Medium = Medium_F, T = 100 + 273.15, m_flow = 400 / 3.6, nPorts = 1) annotation(
      Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Sources.FixedBoundary flow_sink_1(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = 120e5, use_T = true, use_p = true) annotation(
      Placement(visible = true, transformation(origin = {70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Medium_F.ThermodynamicState stateFlow;
    Real h;
    Real Cp;
    Real d;
  equation
    connect(flow_source_1.ports[1], flow_sink_1.ports[1]) annotation(
      Line(points = {{-60, 30}, {60, 30}, {60, 30}, {60, 30}}, color = {0, 127, 255}, thickness = 0.5));
    stateFlow = Medium_F.setState_pTX(1e5, 100 + 273.15);
    Cp = Medium_F.specificHeatCapacityCp(stateFlow);
    h = Medium_F.specificEnthalpy(stateFlow);
    d = Medium_F.density(stateFlow);
    annotation(
      experiment(StartTime = 0, StopTime = 1, Tolerance = 0.001, Interval = 0.02));
  end Glycol_Test;

  model Sodium_Test
  replaceable package Medium_F = TPPSim.Media.Sodium_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    inner Modelica.Fluid.System system annotation(
      Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Sources.MassFlowSource_T flow_source_1(redeclare package Medium = Medium_F, T = 500 + 273.15, m_flow = 400 / 3.6, nPorts = 1) annotation(
      Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Sources.FixedBoundary flow_sink_1(redeclare package Medium = Medium_F, T = 300 + 273.15, nPorts = 1, p = 120e5, use_T = true, use_p = true) annotation(
      Placement(visible = true, transformation(origin = {70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Medium_F.ThermodynamicState stateFlow;
    Real h;
    Real Cp;
    Real d;
    Real new_h;
  equation
    connect(flow_source_1.ports[1], flow_sink_1.ports[1]) annotation(
      Line(points = {{-60, 30}, {60, 30}, {60, 30}, {60, 30}}, color = {0, 127, 255}, thickness = 0.5));
    stateFlow = Medium_F.setState_pTX(1e5, 400 + 273.15);
    Cp = Medium_F.specificHeatCapacityCp(stateFlow);
    h = Medium_F.specificEnthalpy(stateFlow);
    d = Medium_F.density(stateFlow);
    new_h = Medium_F.specificEnthalpy_pT(120e5,400);
    
    annotation(
      experiment(StartTime = 0, StopTime = 1, Tolerance = 0.001, Interval = 0.02));
  end Sodium_Test;

  model ExhaustGas_Test
    import Modelica.Media.IdealGases.Common;
    replaceable package Medium_F = TPPSim.Media.ExhaustGas_Furnance;
    package Medium_F_2 = Modelica.Media.IdealGases.Common.MixtureGasNasa(mediumName = "ExhaustGas", data = {Common.SingleGasesData.O2, Common.SingleGasesData.CO2, Common.SingleGasesData.H2O, Common.SingleGasesData.N2, Common.SingleGasesData.Ar, Common.SingleGasesData.SO2}, fluidConstants = {Common.FluidData.O2, Common.FluidData.CO2, Common.FluidData.H2O, Common.FluidData.N2, Common.FluidData.Ar, Common.FluidData.SO2}, substanceNames = {"Oxygen", "Carbondioxide", "Water", "Nitrogen", "Argon", "Sulfurdioxide"}, reference_X = {0.1383, 0.032, 0.0688, 1 - 0.1383 - 0.032 - 0.0688 - 0.0000000001 - 0.0000000001, 0.0000000001, 0.0000000001});
  
    inner Modelica.Fluid.System system annotation(
      Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Sources.MassFlowSource_T flow_source_1(redeclare package Medium = Medium_F, T = 669.18 + 273.15, X = {0, 0.1, 0, 0.7, 0.2, 0}, m_flow = 400 / 3.6, nPorts = 1) annotation(
      Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Sources.FixedBoundary flow_sink_1(redeclare package Medium = Medium_F, T = 60 + 273.15, nPorts = 1, p = 120e5, use_T = true, use_p = true) annotation(
      Placement(visible = true, transformation(origin = {70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Medium_F.ThermodynamicState stateFlow;
    Medium_F.ThermodynamicState stateFlow_2;
    Real h;
    Real Cp;
    Real d;
    Real eta_1;
    Real eta_2;
    Real[6] eta_3;
    Real eta_4;
    Real eta_1_2;
    
    Real O2_eta;
    Real CO2_eta;
    Real H2O_eta;
    Real N2_eta;
    Real Ar_eta;
    Real SO2_eta;
    
    Real[6] MF;
      
  equation
    connect(flow_source_1.ports[1], flow_sink_1.ports[1]) annotation(
      Line(points = {{-60, 30}, {60, 30}, {60, 30}, {60, 30}}, color = {0, 127, 255}, thickness = 0.5));
    stateFlow = Medium_F.setState_pTX(1e5, 500 + 273.15, {0, 0.1, 0, 0.7, 0.2, 0});
    stateFlow_2 = Medium_F_2.setState_pTX(1e5, 500 + 273.15, {0, 0.1, 0, 0.7, 0.2, 0});
    Cp = Medium_F.specificHeatCapacityCp(stateFlow);
    h = Medium_F.specificEnthalpy(stateFlow);
    d = Medium_F.density(stateFlow);
    eta_1 = Medium_F.dynamicViscosity(stateFlow);
    eta_1_2 = Medium_F_2.dynamicViscosity(stateFlow_2);
    
    O2_eta = Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
              stateFlow.T,
              Common.FluidData.O2.criticalTemperature,
              Common.FluidData.O2.molarMass,
              Common.FluidData.O2.criticalMolarVolume,
              Common.FluidData.O2.acentricFactor,
              Common.FluidData.O2.dipoleMoment);
              
    CO2_eta = Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
              stateFlow.T,
              Common.FluidData.CO2.criticalTemperature,
              Common.FluidData.CO2.molarMass,
              Common.FluidData.CO2.criticalMolarVolume,
              Common.FluidData.CO2.acentricFactor,
              Common.FluidData.CO2.dipoleMoment);
  
    H2O_eta = Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
              stateFlow.T,
              Common.FluidData.H2O.criticalTemperature,
              Common.FluidData.H2O.molarMass,
              Common.FluidData.H2O.criticalMolarVolume,
              Common.FluidData.H2O.acentricFactor,
              Common.FluidData.H2O.dipoleMoment);
              
    N2_eta = Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
              stateFlow.T,
              Common.FluidData.N2.criticalTemperature,
              Common.FluidData.N2.molarMass,
              Common.FluidData.N2.criticalMolarVolume,
              Common.FluidData.N2.acentricFactor,
              Common.FluidData.N2.dipoleMoment);
              
    Ar_eta = Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
              stateFlow.T,
              Common.FluidData.Ar.criticalTemperature,
              Common.FluidData.Ar.molarMass,
              Common.FluidData.Ar.criticalMolarVolume,
              Common.FluidData.Ar.acentricFactor,
              Common.FluidData.Ar.dipoleMoment);  
    
    SO2_eta = Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
              stateFlow.T,
              Common.FluidData.SO2.criticalTemperature,
              Common.FluidData.SO2.molarMass,
              Common.FluidData.SO2.criticalMolarVolume,
              Common.FluidData.SO2.acentricFactor,
              Common.FluidData.SO2.dipoleMoment);
                
    MF = Modelica.Media.Interfaces.PartialMixtureMedium.massToMoleFractions(
          stateFlow.X,
          {Common.FluidData.O2.molarMass, Common.FluidData.CO2.molarMass, Common.FluidData.H2O.molarMass, Common.FluidData.N2.molarMass, Common.FluidData.Ar.molarMass, Common.FluidData.SO2.molarMass});
          
    eta_2 = temp_func.gasMixtureViscosity(MF, {Common.FluidData.O2.molarMass, Common.FluidData.CO2.molarMass, Common.FluidData.H2O.molarMass, Common.FluidData.N2.molarMass, Common.FluidData.Ar.molarMass, Common.FluidData.SO2.molarMass}, {O2_eta, CO2_eta, H2O_eta, N2_eta, Ar_eta, SO2_eta});
    
    eta_3 = temp_func.dynamicViscosity(stateFlow);
    
    eta_4 = temp_func.gasMixtureViscosity(MF, {Common.FluidData.O2.molarMass, Common.FluidData.CO2.molarMass, Common.FluidData.H2O.molarMass, Common.FluidData.N2.molarMass, Common.FluidData.Ar.molarMass, Common.FluidData.SO2.molarMass}, {O2_eta, O2_eta, O2_eta, O2_eta, O2_eta, O2_eta});
  end ExhaustGas_Test;






















end Tests;
