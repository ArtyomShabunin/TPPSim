within TPPSim.HRSG_HeatExch;
model CollectorMix2
  import TPPSim.functions.alfaFor2ph;
  import TPPSim.functions.drdh_drdp;
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Integer zahod = 2;
  parameter Modelica.SIunits.Diameter Din = 0.1 "Внутренний диаметр коллектора" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Length delta = 0.01 "Толщина стенки коллектора" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Length L = 5 "Длина коллектора" annotation(
    Dialog(group = "Конструктивные характеристики"));
  parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
    Dialog(group = "Металл"));
  parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
    Dialog(group = "Металл"));
  Modelica.SIunits.Temperature t_m "Температура металла на участках трубопровода";
protected
  parameter Modelica.SIunits.Area SFlow = L * Modelica.Constants.pi * Din "Внутренняя площадь коллектора";
  parameter Modelica.SIunits.Volume VFlow = L * Modelica.Constants.pi * Din ^ 2 / 4 "Внутренний объем коллектора";
  parameter Modelica.SIunits.Mass MMetal = rho_m * L * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) / 4 "Масса металла коллектора";
  parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 / 4 "Площадь для прохода теплоносителя";
  Medium.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
  Medium.AbsolutePressure p_v;
  Medium.SpecificEnthalpy h_v;
  Medium.Temperature t_flow "Температура потока вода/пар";
  Medium.Density rho;
  Modelica.SIunits.DerDensityByEnthalpy drdh;
  Modelica.SIunits.DerDensityByPressure drdp;
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a flowIn[zahod](redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  flowIn.p = fill(p_v, zahod);
  stateFlow = Medium.setState_ph(p_v, flowOut.h_outflow);
  rho = Medium.density(stateFlow);
  t_flow = Medium.temperature(stateFlow);
  (drdh, drdp) = drdh_drdp(h_v, {sum(inStream(flowIn[i].h_outflow) for i in 1:zahod) / zahod, h_v}, p_v, {sum(flowIn[i].p for i in 1:zahod) / zahod, p_v});
//drdp = Medium.density_derp_h(stateFlow);
//drdh = Medium.density_derh_p(stateFlow);
  alfa_flow = alfaFor2ph(h_n = {sum(inStream(flowIn[i].h_outflow) for i in 1:zahod) / zahod, h_v}, D_flow_v = -flowOut.m_flow, p_v = p_v, Din = Din, f_flow = f_flow);
  VFlow * rho * der(h_v) = sum(flowIn[i].m_flow * inStream(flowIn[i].h_outflow) for i in 1:zahod) + flowOut.m_flow * h_v "Уравнение баланса тепла";
  flowOut.m_flow + sum(flowIn[i].m_flow for i in 1:zahod) = VFlow * (drdh * der(h_v) + drdp * der(p_v));
  MMetal * C_m * der(t_m) = -alfa_flow * SFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
  flowOut.p = p_v;
  flowOut.h_outflow = h_v;
  for i in 1:zahod loop
    flowIn[i].h_outflow = inStream(flowOut.h_outflow);
    flowIn[i].Xi_outflow = inStream(flowOut.Xi_outflow);
  end for;
  flowOut.Xi_outflow = inStream(flowIn[1].Xi_outflow);
initial equation
  der(t_m) = 0;
  der(p_v) = 0;
  der(h_v) = 0;
  annotation(
    Documentation(info = "<HTML>Аналогично collectorMix с добавлением производных по энтальпии и давлению.</html>"));
end CollectorMix2;