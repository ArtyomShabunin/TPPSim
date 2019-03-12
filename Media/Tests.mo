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
    stateFlow = Medium_F.setState_pTX(1e5, 100+273.15);
    Cp = Medium_F.specificHeatCapacityCp(stateFlow);
    h = Medium_F.specificEnthalpy(stateFlow);
    d = Medium_F.density(stateFlow);
  annotation(
      experiment(StartTime = 0, StopTime = 1, Tolerance = 0.001, Interval = 0.02));end Glycol_Test;






















end Tests;
