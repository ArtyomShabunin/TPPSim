within TPPSim.thermal;
model hfrForDrum "Тепловой поток (HeatFlowRate) к внутренней стенке барабана."

  function drumWaterHFArea "Площадь стенки металла барабана, которая контактирует с водой/паром"
    extends Modelica.Icons.Function;
    input Real R "внутренний радиус барабана";
    input Real L "длина барабана";
    input Real Hw "уровень воды в барабане";
    input String area "верх или низ барабана";
    output Real S "площадь поверхности теплообмена";
  protected
    Real alpha;
    Real H;
  algorithm
    if Hw < R then
      H := Hw;
    else
      H := 2 * R - Hw;
    end if;
    //alpha := 2 * acos((R - H) / R) "Угол сектора барабана заполненного водой";
    alpha := 0.76;
    S := L * alpha * R + 2 * (alpha * R ^ 2 / 2 - (R - H) * R * sin(alpha / 2)) "Площадь теплообмена с водяной частью барабана";
    if (Hw < R and area == "top") or (Hw >= R and area <> "top") then
      S := L * Modelica.Constants.pi * R + 2 * Modelica.Constants.pi * R ^ 2 - S "Площадь теплообмена с паровой частью барабана";
    end if;
  end drumWaterHFArea;

  package Medium = Modelica.Media.Water.WaterIF97_ph;
  final outer parameter Modelica.SIunits.Diameter Din "Внутренний диаметр барабана";
  final outer parameter Modelica.SIunits.Length L "Длина барабана";
  outer Modelica.SIunits.Length Hw "Уровень воды в барабане";    
  Modelica.SIunits.Area S_top "Площадь поверхности теплообмена в верхней части барабана";
  Modelica.SIunits.Area S_bot "Площадь поверхности теплообмена в нижней части барабана";         
  outer Medium.Temperature t_m_steam "Температура металла паровой части барабана";
  outer Medium.Temperature t_m_water "Температура металла водяной части барабана";
  outer Medium.Temperature ts "Температура насыщения в барабане (пар)";
  //outer Medium.Temperature tw "Температура воды в барабане";    
  outer Modelica.SIunits.HeatFlowRate Q_top "Тепловой поток к металлу верхней части барабана";
  outer Modelica.SIunits.HeatFlowRate Q_bot "Тепловой поток к металлу нижней части барабана";
  outer Medium.MassFlowRate D_st_circ "Пар поступающий в паровое пространство барабана из циркуляционных контуров ";
  outer Medium.MassFlowRate D_st_eco "Расход пара из питательной воды или необходимый для нагрева до h' недогретой питательной воды";
  outer Medium.MassFlowRate Dvipar "Выпар в паровой объем";
  outer Medium.SpecificEnthalpy h_dew "Энтальпия пара на линии насыщения при давлении в барабане";
  outer Medium.SpecificEnthalpy h_bubble "Энтальпия воды на линии насыщения при давлении в барабане";
  outer Medium.ThermodynamicState state_w "Термодинамическое состояние воды в водяном объеме"; 
algorithm
  S_top := drumWaterHFArea(Din / 2, L, Hw, "top");
  S_bot := drumWaterHFArea(Din / 2, L, Hw, "bottom");
  Q_top := 2000 * S_top * max((ts - t_m_steam), 0);
  Q_top := min(Q_top, max((D_st_circ + D_st_eco + Dvipar) * (h_dew - h_bubble), 0));
  Q_bot := 1000 * S_bot * max((state_w.T - t_m_water), 0);
  annotation(
    Documentation(info = "<html><head></head><body>
      Модель для расчета теплового потока к внутренней стенке барабана. Расчитавается два тепловых потока: для части барабана, которая заполнена водой и для остального барабана. Модель учитавает только прогрев барабана, не учитывает остывание. Коэффициенты теплоотдачи приняты постоянными и составляют: для паровой части - 2000 Вт/м2К; для водяной части - 1000 Вт/м2К.
      </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>Match 20, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end hfrForDrum;
