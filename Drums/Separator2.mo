within TPPSim.Drums;
model Separator2 "Упрощенная модель сепаратора пара котла"
  //Вспомогательные функции
  extends TPPSim.Drums.BaseClases.Icons.Separator_Icon;
  //***Исходные данные
  replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  parameter Medium.AbsolutePressure ps_start = 1.013e5 "Стартовое давление насыщения в сепараторе";
  parameter Medium.MassFlowRate Dsteam_start = m_flow_small "Стартовый расход пара из сепаратора";
  parameter Medium.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
  //**
  //Переменные
  //**
  Medium.SaturationProperties sat "State vector to compute saturation properties для парового объема";
  Medium.MassFlowRate D_fw "Расход питательной воды";
  Medium.MassFlowRate Dsteam(start = Dsteam_start) "Расход пара из сепаратора";
  Medium.AbsolutePressure ps(start = ps_start) "Давление насыщения в сепараторе";
  Medium.SpecificEnthalpy h_dew "Энтальпия пара на линии насыщения при давлении в сепараторе";
  Medium.SpecificEnthalpy h_bubble "Энтальпия воды на линии насыщения при давлении в сепараторе";
  //***Интерфейс
  Modelica.Fluid.Interfaces.FluidPort_a fedWater(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-104, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b steam(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  sat = Medium.setSat_p(ps);
  h_dew = Medium.dewEnthalpy(sat);
  h_bubble = Medium.bubbleEnthalpy(sat);
  Dsteam = if noEvent(inStream(fedWater.h_outflow) > h_dew) then D_fw elseif noEvent(inStream(fedWater.h_outflow) < h_bubble) then 0 else D_fw * (inStream(fedWater.h_outflow) - h_bubble) / (h_dew - h_bubble);
//Питательная вода
  fedWater.h_outflow = h_bubble;
  fedWater.p = ps;
  fedWater.m_flow = D_fw;
//Выход насыщенного пара
  ps = steam.p;
  steam.h_outflow = if noEvent(inStream(fedWater.h_outflow) > h_dew) then inStream(fedWater.h_outflow) else h_dew;
  steam.m_flow = -Dsteam;
  annotation(
    Documentation(info = "<html>
  <p>
  Модель сепаратора без измерения уровня воды. Медель имеет одиин вход среды (пар, воды, паро-водяная смесь) и один выход (пар). Отвод конденсата не моделируется.
  </html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>May 16, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"),
    uses(Modelica(version = "3.2.1")));
end Separator2;
