within TPPSim.HRSG_HeatExch;
model FlowSideSH
  import TPPSim.functions.alfaForSH;
  extends BaseClases.flowSideHE(redeclare replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model");
  Medium.ThermodynamicState stateFlow_n[2] "Термодинамическое состояние потока вода/пар на участках трубопровода";
  Real der_h_n[2] "Производняа энтальпии потока вода/пар";
  Medium.Density rho_n[2] "Плотность потока по участкам трубы в конечных объемах";
  Modelica.SIunits.DerDensityByEnthalpy drdh_v1 "Производная плотности потока по энтальпии на участках ряда труб";
  Modelica.SIunits.DerDensityByEnthalpy drdh_v2 "Производная плотности потока по энтальпии на участках ряда труб";
  Modelica.SIunits.DerDensityByEnthalpy drdh_n[2] "Производная плотности потока по энтальпии на участках ряда труб";
  Modelica.SIunits.DerDensityByPressure drdp_v "Производная плотности потока по давлению на участках ряда труб";
  Modelica.SIunits.DerDensityByPressure drdp_n[2] "Производная плотности потока по давлению на участках ряда труб";
  Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
  Medium.DynamicViscosity mu_flow "Динамическая вязкость для потока вода/пар";
  Modelica.SIunits.HeatFlowRate Q_flow "тепло переданное стенке трубы";
  Modelica.SIunits.Temperature t_m(start = t_startM) "Температура металла на участках трубопровода";
  Medium.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
  Medium.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
  Medium.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
  Real C1 "Показатель в числителе уравнения сплошности";
  Real C2 "Показатель в знаменателе уравнения сплошности";
  //Интерфейс
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat annotation(
    Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_n[1] * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
  0.5 * deltaVFlow * rho_v * der_h_n[2] = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
  deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
  heat.Q_flow = Q_flow;
  heat.T = t_m;
//Уравнения состояния
  stateFlow = Medium.setState_ph(p_v, h_v);
  t_flow = Medium.temperature(stateFlow);
  mu_flow = if Medium.dynamicViscosity(stateFlow) < 1.503e-004 then 1.503e-004 else Medium.dynamicViscosity(stateFlow);
  w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
  alfa_flow = alfaForSH(h_v = h_v, D_flow_n1 = D_flow_n[1], p_v = p_v, Din = Din, f_flow = f_flow);
  D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
  D_flow_n[2] = D_flow_n[1] - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
  C1 = deltaVFlow * ((-1e-7) * der_h_n[1] + (-1e-7) * der_h_n[2]);
  C2 = deltaVFlow * 1e-8 * der(p_v);
  rho_v = (rho_n[1] + rho_n[2]) / 2;
  drdp_v = (drdp_n[1] + drdp_n[2]) / 2;
  drdh_v1 = drdh_n[1] / 2;
  drdh_v2 = drdh_n[2] / 2;
  for i in 1:2 loop
    stateFlow_n[i] = Medium.setState_ph(p_v, h_n[i]);
    drdp_n[i] = Medium.density_derp_h(stateFlow_n[i]);
    drdh_n[i] = Medium.density_derh_p(stateFlow_n[i]);
    rho_n[i] = Medium.density(stateFlow_n[i]);
  end for;
  der_h_n[1] = der(h_n[2]);
  der_h_n[2] = der(h_n[2]);
  sat_v = Medium.setSat_p(p_v);
  hl = Medium.bubbleEnthalpy(sat_v);
  hv = Medium.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
  p_v = p_n[1];
//Основное уравнение гидравлики
  lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
  Xi_flow = lambda_tr * Lpipe * z2 / zahod / Din;
  dp_fric = w_flow_v ^ 2 * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
  p_n[1] - p_n[2] = dp_fric "Формула 2-1 из книги Рудомино, Ремжин";
initial equation
  der(h_v) = 0;
  der(t_m) = 0;
  der(p_v) = 0;
  der(h_n[1]) = 0;
  der(h_n[2]) = 0;
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
end FlowSideSH;