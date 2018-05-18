within TPPSim.Drums;
model Separator "Сепаратор пара прямоточного котла"
  extends TPPSim.Drums.BaseClases.Icons.Separator_Icon;
  //Вспомогательные функции

  function separatorWaterMass "Функция расчета массы воды в сепараторе"
    extends Modelica.Icons.Function;
    input Real L "отметка уровня воды от нижней точки сливного коллектора";
    input Real Din_sep "Внутренний диаметр сепаратора";
    input Real Din_down_pipe "Внутренний диаметр сливного коллектора";
    input Real H_down_pipe "Высота сливного коллектора";
    output Real Gw "Масса воды в сепараторе";
  algorithm
    if L < H_down_pipe then
      Gw := 1000 * L * 0.25 * Modelica.Constants.pi * Din_down_pipe ^ 2;
    else
      Gw := 1000 * 0.25 * Modelica.Constants.pi * (H_down_pipe * Din_down_pipe ^ 2 + (L - H_down_pipe) * Din_sep ^ 2);
    end if;
  end separatorWaterMass;
  
  function separatorWaterLevel "Функция расчета уровня воды в сепараторе"
    input Real Gw "Масса воды в сепараторе";
    input Real Din_sep "Внутренний диаметр сепаратора";
    input Real Din_down_pipe "Внутренний диаметр сливного коллектора";
    input Real H_down_pipe "Высота сливного коллектора";
    output Real L "отметка уровня воды от нижней точки сливного коллектора";
  algorithm
    if (Gw / 1000) < (H_down_pipe * 0.25 * Modelica.Constants.pi * Din_down_pipe ^ 2) then
      L := (Gw / 1000) / (0.25 * Modelica.Constants.pi * Din_down_pipe ^ 2);
    else
      L := H_down_pipe + ((Gw / 1000) - (H_down_pipe * 0.25 * Modelica.Constants.pi * Din_down_pipe ^ 2)) / (0.25 * Modelica.Constants.pi * Din_sep ^ 2);
    end if;
  end separatorWaterLevel;

  //Исходные данные
  replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  //  parameter Medium.AbsolutePressure ps_start = 1.013e5 "Стартовое давление насыщения в сепараторе";
  parameter Medium.MassFlowRate Dsteam_start = m_flow_small "Стартовый расход пара из сепаратора";
  parameter Modelica.SIunits.Length L_start = 1 "Начальный уровень воды в барабане";
  parameter Medium.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
  //Геометрические характеристики сепаратора
  parameter Integer n_sep = 1 "Кол-во сепараторов" annotation(
    Dialog(group = "Геометрические характристики"));
  parameter Modelica.SIunits.Length Din_sep "Внутренний диаметр сепаратора" annotation(
    Dialog(group = "Геометрические характристики"));
  parameter Modelica.SIunits.Length Din_down_pipe "Внутренний диаметр сливного коллектора" annotation(
    Dialog(group = "Геометрические характристики"));
  parameter Modelica.SIunits.Length H_sep "Высота сепаратора" annotation(
    Dialog(group = "Геометрические характристики"));
  parameter Modelica.SIunits.Length H_down_pipe "Высота сливного коллектора" annotation(
    Dialog(group = "Геометрические характристики"));  
//Переменные
  Medium.SaturationProperties sat "State vector to compute saturation properties для парового объема";
  //  Medium.MassFlowRate D_fw "Расход питательной воды";
  //  Medium.MassFlowRate Dsteam "Расход пара из сепаратора";
  //  Medium.AbsolutePressure ps "Давление насыщения в сепараторе";
  Medium.SpecificEnthalpy h_dew "Энтальпия пара на линии насыщения при давлении в сепараторе";
  Medium.SpecificEnthalpy h_bubble "Энтальпия воды на линии насыщения при давлении в сепараторе";
  Modelica.SIunits.Mass Gw "Масса воды в сепараторе и сливном коллекторе";
  //Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a fedWater(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b steam(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b downWater(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput level "Уровень воды в сепараторе (отсчитывается от нижней точки сливного коллектора)" annotation(
    Placement(visible = true, transformation(origin = {-88, 52}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {50, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
algorithm
  sat := Medium.setSat_p(steam.p);
  h_dew := Medium.dewEnthalpy(sat);
  h_bubble := Medium.bubbleEnthalpy(sat);
  steam.m_flow := if noEvent(inStream(fedWater.h_outflow) > h_dew) then - fedWater.m_flow elseif noEvent(inStream(fedWater.h_outflow) < h_bubble) then 0 else - fedWater.m_flow * (inStream(fedWater.h_outflow) - h_bubble) / (h_dew - h_bubble);
  level := separatorWaterLevel(Gw, Din_sep, Din_down_pipe, H_down_pipe);
//Питательная вода
  fedWater.h_outflow := h_bubble;
  fedWater.p := steam.p;
//Выход насыщенного пара
  steam.h_outflow := if noEvent(inStream(fedWater.h_outflow) > h_dew) then inStream(fedWater.h_outflow) else h_dew;
//Слив дренажа
  downWater.p := steam.p;
//  downWater.h_outflow := if noEvent(inStream(fedWater.h_outflow) > h_bubble) then h_bubble else inStream(fedWater.h_outflow);
  downWater.h_outflow := 251000;
equation
  der(Gw) = fedWater.m_flow + steam.m_flow + downWater.m_flow "Баланс массы";
initial equation
  Gw = separatorWaterMass(L_start, Din_sep, Din_down_pipe, H_down_pipe);
  annotation(
    Documentation(info = "<html>
  <p>
  Модель сепаратора с измерением уровня и отводом конденсата.
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>May 16, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    uses(Modelica(version = "3.2.1")));
end Separator;
