within TPPSim.Boilers.TPE_223_pack;

model TPE_223_furnace "Модель топки котла ТПЕ-223"
  extends TPPSim.Furnaces.BaseClases.Icons.IconFurnace;
  import Modelica.Fluid.Types;
  
  // Конструктивные параметры
  parameter Modelica.SIunits.Length width_furnace = 12.24 "Ширина" annotation(
    Dialog(group = "Габариты топки"));
  parameter Modelica.SIunits.Length depth_furnace = 12.16 "Глубина" annotation(
    Dialog(group = "Габариты топки"));
  parameter Modelica.SIunits.Length d_out = 0.06 "Наружный диаметр труб" annotation(
    Dialog(group = "Характеристики экранов"));
  parameter Modelica.SIunits.Length delta_tube = 0.006 "Толщина труб" annotation(
    Dialog(group = "Характеристики экранов"));
  parameter Modelica.SIunits.Length s_tube = 0.08 "Шаг между трубами" annotation(
    Dialog(group = "Характеристики экранов"));
  parameter Modelica.SIunits.Length x_furnace = 1 "Угловой коэффициент экранов" annotation(
    Dialog(group = "Характеристики экранов"));
  parameter Real n_front_1 = 28 "Блоки фронтового экрана №1" annotation(
    Dialog(group = "Число труб одной стороны котла"));
  parameter Real n_front_2 = 24 "Блоки фронтового экрана №2" annotation(
    Dialog(group = "Число труб одной стороны котла"));
  parameter Real n_front_3 = 24 "Блоки фронтового экрана №3" annotation(
    Dialog(group = "Число труб одной стороны котла"));
  parameter Real n_back_1 = 28 "Блоки заднего экрана №1" annotation(
    Dialog(group = "Число труб одной стороны котла"));
  parameter Real n_back_2 = 24 "Блоки заднего экрана №2" annotation(
    Dialog(group = "Число труб одной стороны котла"));
  parameter Real n_back_3 = 24 "Блоки заднего экрана №3" annotation(
    Dialog(group = "Число труб одной стороны котла"));
  parameter Real n_side_1 = 32 "Блоки бокового экрана №1" annotation(
    Dialog(group = "Число труб одной стороны котла"));
  parameter Real n_side_2 = 30 "Блоки бокового экрана №2" annotation(
    Dialog(group = "Число труб одной стороны котла"));
  parameter Real n_side_3 = 28 "Блоки бокового экрана №3" annotation(
    Dialog(group = "Число труб одной стороны котла"));
  parameter Real n_side_4 = 30 "Блоки бокового экрана №4" annotation(
    Dialog(group = "Число труб одной стороны котла"));
  parameter Real n_side_5 = 32 "Блоки бокового экрана №5" annotation(
    Dialog(group = "Число труб одной стороны котла"));
  // Характеристики металла
  parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
    Dialog(group = "Характеристики металла"));
  parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(
    Dialog(group = "Характеристики металла"));  
  parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
    Dialog(group = "Характеристики металла"));
   
  // Расчетные конструктивные параметры
  final parameter Modelica.SIunits.Length length_front = s_tube * (n_front_1 + n_front_2 + n_front_3) "Длина фронтового экрана половины котла";
  final parameter Modelica.SIunits.Length length_back = s_tube * (n_back_1 + n_back_2 + n_back_3) "Длина заднего экрана половины котла";
  final parameter Modelica.SIunits.Length length_side = s_tube * (n_side_1 + n_side_2 + n_side_3 + n_side_4 + n_side_5) "Длина бокового экрана половины котла";
  final parameter Modelica.SIunits.Area f_flow_front = Modelica.Constants.pi * (d_out - 2*delta_tube) ^ 2 / 4 * (n_front_1 + n_front_2 + n_front_3) "Площадь для прохода теплоносителя фронтового экрана половины котла";
  final parameter Modelica.SIunits.Area f_flow_back = Modelica.Constants.pi * (d_out - 2*delta_tube) ^ 2 / 4 * (n_back_1 + n_back_2 + n_back_3) "Площадь для прохода теплоносителя заднего экрана половины котла";
  final parameter Modelica.SIunits.Area f_flow_side = Modelica.Constants.pi * (d_out - 2*delta_tube) ^ 2 / 4 * (n_side_1 + n_side_2 + n_side_3 + n_side_4 + n_side_5) "Площадь для прохода теплоносителя бокового экрана половины котла";
  final parameter Modelica.SIunits.Mass metall_mass_front = Modelica.Constants.pi * (d_out ^ 2 - (d_out - 2*delta_tube) ^ 2) / 4 * rho_m * (n_front_1 + n_front_2 + n_front_3) "Масса одного метра фронтового экрана половины котла";
  final parameter Modelica.SIunits.Mass metall_mass_back = Modelica.Constants.pi * (d_out ^ 2 - (d_out - 2*delta_tube) ^ 2) / 4 * rho_m * (n_back_1 + n_back_2 + n_back_3) "Масса одного метра заднего экрана половины котла";
  final parameter Modelica.SIunits.Mass metall_mass_side = Modelica.Constants.pi * (d_out ^ 2 - (d_out - 2*delta_tube) ^ 2) / 4 * rho_m * (n_side_1 + n_side_2 + n_side_3 + n_side_4 + n_side_5) "Масса одного метра бокового экрана половины котла";  
  
  // Параметры уравнений динамики
  inner parameter Types.Dynamics flowEnergyDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения энергии вода/пар" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  inner parameter Types.Dynamics flowMassDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения массы вода/пар" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  inner parameter Modelica.Fluid.Types.Dynamics flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState "Параметры уравнения сохранения момента вода/пар" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  inner parameter Types.Dynamics metalDynamics = Types.Dynamics.FixedInitial "Параметры уравнения динамики прогрева металла" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics")); 
  inner parameter Types.Dynamics gasEnergyDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения энергии газов" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  inner parameter Types.Dynamics gasMassDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения массы газов" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics")); 
  
  replaceable package Medium_G = TPPSim.Media.ExhaustGas_Furnance constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  TPPSim.Furnaces.Furnace furnace1(redeclare package Medium_G = Medium_G, betta = 1, use_fuel_port = true) annotation(
    Placement(visible = true, transformation(origin = {-16,0}, extent = {{-10, -4}, {10, 4}}, rotation = 0)));
  TPPSim.Fuel.Interfaces.CoalPort_a fuelIn annotation(
    Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a airIn(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(
    Placement(visible = true, transformation(origin = {20, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(
    Placement(visible = true, transformation(origin = {-20, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TPPSim.Furnaces.FurnaceFlowSide FlowSide1 annotation(
    Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(furnace1.heat, FlowSide1.heat) annotation(
    Line(points = {{-6, 0}, {10, 0}, {10, 0}, {10, 0}}, color = {191, 0, 0}));
  connect(FlowSide1.waterOut, waterOut) annotation(
    Line(points = {{20, 10}, {20, 10}, {20, 100}, {20, 100}}, color = {0, 127, 255}));
  connect(waterIn, FlowSide1.waterIn) annotation(
    Line(points = {{0, -100}, {0, -100}, {0, -40}, {20, -40}, {20, -10}, {20, -10}}, color = {0, 127, 255}));
  connect(furnace1.gasOut, gasOut) annotation(
    Line(points = {{-16, 4}, {-16, 4}, {-16, 84}, {-20, 84}, {-20, 100}, {-20, 100}}, color = {0, 127, 255}));
  connect(airIn, furnace1.airIn) annotation(
    Line(points = {{-100, -20}, {-66, -20}, {-66, -2}, {-26, -2}, {-26, -2}}));
  connect(fuelIn, furnace1.fuelIn) annotation(
    Line(points = {{-100, 20}, {-68, 20}, {-68, 0}, {-26, 0}, {-26, 0}}));
  annotation(
    Documentation(info = "<html>
<style>
p {
  text-indent: 20px;
  text-align: 'justify';
 }
</style>
<p>...</p>
</html>", revisions = "<html>
<ul>
<li><i>14 July 2019</i>
by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
   Создан.</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(extent = {{-60, -100}, {60, 100}})),
    __OpenModelica_commandLineOptions = "");


end TPE_223_furnace;
