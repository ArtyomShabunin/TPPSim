within TPPSim.thermal;
model hfrForDrum "Тепловой поток (HeatFlowRate) к внутренней стенке барабана."
  package Medium = Modelica.Media.Water.WaterIF97_ph;
  outer Modelica.SIunits.Length Hw "Уровень воды в барабане";    
  outer Modelica.SIunits.Area S_top "Площадь поверхности теплообмена в верхней части барабана";
  outer Modelica.SIunits.Area S_bot "Площадь поверхности теплообмена в нижней части барабана";         
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
  Q_top := 2000 * S_top * max((ts - t_m_steam), 0);
  Q_top := min(Q_top, max((D_st_circ + D_st_eco + Dvipar) * (h_dew - h_bubble), 0));
  Q_bot := 1000 * S_bot * max((state_w.T - t_m_water), 0);
  annotation(
    Documentation(info = "<html><head></head><body>
      Модель для расчета теплового потока к внутренней стенке барабана. Расчитавается два тепловых потока: для части барабана, которая заполнена водой и для остального барабана. Модель учитавает только прогрев барабана, не учитывает остывание. Коэффициенты теплоотдачи приняты постоянными и составляют: для паровой части - 2000 Вт/м2К; для водяной части - 1000 Вт/м2К.
      </body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>Match 20, 2018</i>
      by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
      Создан.<br></li>
      <li><i>July 11, 2018</i>
      by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
      Исправлена функция расчета площади внутренней поверхности барабана. Функция перенесена в модель BaseDrum.<br></li>
</ul></body></html>"));
end hfrForDrum;
