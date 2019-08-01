within TPPSim.Nuclear;

model SteamGenerator
extends TPPSim.Nuclear.BaseClases.Icons.IconSteamGenerator;
  package Medium_S = TPPSim.Media.Sodium_ph;
  package Medium_F = Modelica.Media.Water.WaterIF97_ph;
  outer Modelica.Fluid.System system;
  Modelica.Fluid.Interfaces.FluidPort_a sodiumIn(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {-60, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b sodiumOut(redeclare package Medium = Medium_S) annotation(
    Placement(visible = true, transformation(origin = {60, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {-60, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {60, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  TPPSim.Nuclear.SodiumHE EVO(redeclare TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE(redeclare TPPSim.thermal.alfaForEVO2 alpha(section = section)), redeclare package Medium_S = Medium_S, redeclare package Medium_F = Medium_F, T_m_start = 463.15, T_sodium_start = 463.15, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, k_gamma_sodium = 0.6, m_flow_start = 20 / n_sg, metalDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfVolumes = 20, p_flow_start = system.p_ambient, p_sodium_start = 250000, sodiumEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) annotation(
    Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Drums.Separator2 separator(redeclare package Medium = Medium_F, ps_start = 140e5) annotation(
    Placement(visible = true, transformation(origin = {22, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Nuclear.SodiumHE SH(redeclare TPPSim.HRSG_HeatExch.FlowSideSH flowHE(redeclare TPPSim.thermal.alfaForSHandECO alpha), redeclare package Medium_S = Medium_S, redeclare package Medium_F = Medium_F, Dcase = 0.745, Din = 0.016, Lpipe = 7.9, T_m_start = 463.15, T_sodium_start = 463.15, delta = 0.003, flowEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMassDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, k_gamma_sodium = 0.6, m_flow_start = 0.01, metalDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, numberOfVolumes = 10, p_flow_start = system.p_ambient, p_sodium_start = 250000, sodiumEnergyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, z = 349) annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0))); 
  parameter Integer n_sg = 1 "Число включенных параллельно секций парогенератора";
  SplitFlow splitSodium(redeclare package Medium = Medium_S, n =  n_sg) annotation(
    Placement(visible = true, transformation(origin = {-30, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Nuclear.SplitFlow mixSodium(redeclare package Medium = Medium_S, n = n_sg)  annotation(
    Placement(visible = true, transformation(origin = {28, 78}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  TPPSim.Nuclear.SplitFlow splitWater(redeclare package Medium = Medium_F, n = n_sg)  annotation(
    Placement(visible = true, transformation(origin = {-30, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Nuclear.SplitFlow mixWater(redeclare package Medium = Medium_F, n = n_sg)  annotation(
    Placement(visible = true, transformation(origin = {44, -70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(waterIn, splitWater.flowIn) annotation(
    Line(points = {{-60, -100}, {-60, -70}, {-40, -70}}, color = {0, 127, 255}));
  connect(splitWater.flowOut, EVO.flowIn) annotation(
    Line(points = {{-20, -70}, {4, -70}, {4, -8}, {6, -8}}, color = {0, 127, 255}));
  connect(mixWater.flowIn, waterOut) annotation(
    Line(points = {{54, -70}, {60, -70}, {60, -100}, {60, -100}}, color = {0, 127, 255}));
  connect(SH.flowOut, mixWater.flowOut) annotation(
    Line(points = {{6, 42}, {28, 42}, {28, -70}, {34, -70}, {34, -70}}, color = {0, 127, 255}));
  connect(mixSodium.flowIn, sodiumOut) annotation(
    Line(points = {{38, 78}, {60, 78}, {60, 100}, {60, 100}}, color = {0, 127, 255}));
  connect(EVO.sodiumOut, mixSodium.flowOut) annotation(
    Line(points = {{-4, -8}, {-4, -8}, {-4, -6}, {-30, -6}, {-30, 60}, {8, 60}, {8, 78}, {18, 78}, {18, 78}}, color = {0, 127, 255}));
  connect(splitSodium.flowOut, SH.sodiumIn) annotation(
    Line(points = {{-20, 78}, {-4, 78}, {-4, 42}, {-4, 42}}, color = {0, 127, 255}));
  connect(sodiumIn, splitSodium.flowIn) annotation(
    Line(points = {{-60, 100}, {-60, 100}, {-60, 78}, {-40, 78}, {-40, 78}}, color = {0, 127, 255}));
  connect(SH.sodiumOut, EVO.sodiumIn) annotation(
    Line(points = {{-4, 22}, {-6, 22}, {-6, 12}, {-4, 12}}, color = {0, 127, 255}));
  connect(separator.steam, SH.flowIn) annotation(
    Line(points = {{22, 26}, {10, 26}, {10, 22}, {6, 22}, {6, 22}}, color = {0, 127, 255}));
  connect(EVO.flowOut, separator.fedWater) annotation(
    Line(points = {{6, 12}, {16, 12}, {16, 22}, {16, 22}}, color = {0, 127, 255}));
//  actualStream(EVO.flowIn.h_outflow) = actualStream(waterIn.h_outflow);
//  EVO.flowIn.m_flow = waterIn.m_flow;
//  EVO.flowIn.p = waterIn.p;
//  actualStream(SH.flowOut.h_outflow) = actualStream(waterOut.h_outflow);
//  SH.flowOut.m_flow = -waterOut.m_flow;
//  SH.flowOut.p = waterOut.p;
//  SH.sodiumIn.h_outflow = inStream(sodiumIn.h_outflow);
//  sodiumIn.h_outflow = inStream(SH.sodiumIn.h_outflow);
//  SH.sodiumIn.m_flow = sodiumIn.m_flow;
//  SH.sodiumIn.p = sodiumIn.p;
//  actualStream(EVO.sodiumOut.h_outflow) = actualStream(sodiumOut.h_outflow);
//  EVO.sodiumOut.m_flow = -sodiumOut.m_flow;
//  EVO.sodiumOut.p = sodiumOut.p;
end SteamGenerator;
