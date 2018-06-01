within TPPSim.HRSG_HeatExch;
model GFHE_simple
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseGFHE_simple;
  extends TPPSim.HRSG_HeatExch.BaseClases.GFHE_interface;  
  import TPPSim.functions.coorSecGen;
  //Переменные
  replaceable TPPSim.HRSG_HeatExch.GasSideHE_simple gasHE[numberOfVolumes, 1](redeclare package Medium = Medium_G, section = coorSecGen(numberOfVolumes, 1)) annotation(
    Placement(visible = true, transformation(origin = {0, -36}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  replaceable TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE[1, numberOfVolumes](redeclare package Medium = Medium_F, section = coorSecGen(1, numberOfVolumes)) annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
equation
  for i in 1:numberOfVolumes loop
    connect(flowHE[1, i].heat, gasHE[numberOfVolumes + 1 - i, 1].heat);
  end for;
  h_gl[1, 1] = inStream(flowIn.h_outflow);
  flowIn.h_outflow = h_gl[1, 1];
  D_gl[1, 1] = flowIn.m_flow;
  p_gl[1, 1] = flowIn.p;
  h_gl[1, numberOfVolumes + 1] = actualStream(flowOut.h_outflow);
  D_gl[1, numberOfVolumes + 1] = -flowOut.m_flow;
  p_gl[1, numberOfVolumes + 1] = flowOut.p;
  hgas_gl[1, 1] = inStream(gasIn.h_outflow);
  gasIn.h_outflow = inStream(gasOut.h_outflow);
  Dgas_gl[1, 1] = gasIn.m_flow;
  pgas_gl[1, 1] = gasIn.p;
  hgas_gl[numberOfVolumes + 1, 1] = gasOut.h_outflow;
  Dgas_gl[numberOfVolumes + 1, 1] = -gasOut.m_flow;
  pgas_gl[numberOfVolumes + 1, 1] = gasOut.p;
  gasIn.Xi_outflow = inStream(gasOut.Xi_outflow);
  inStream(gasIn.Xi_outflow) = gasOut.Xi_outflow;
  annotation(
    Documentation(info = "<html>
<style>
p {
  text-indent: 20px;
  text-align: 'justify';
 }
</style>
Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).
</ul>  
</html>", revisions = "<html>
<ul>
<li><i>4 Apr 2017</i>
by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
   Создан.</li>
<li><i>01 June 2017</i>
by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
   Скорректирована строка 19. Используется ф-ия actualStreame()</li>
</ul>
</html>"));
end GFHE_simple;
