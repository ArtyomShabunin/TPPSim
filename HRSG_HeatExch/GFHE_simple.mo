within TPPSim.HRSG_HeatExch;
model GFHE_simple
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseGFHE_simple;
  extends TPPSim.HRSG_HeatExch.BaseClases.GFHE_interface;  
  import TPPSim.functions.coorSecGen;
  //Переменные
  TPPSim.HRSG_HeatExch.GasSideHE gasHE[numberOfVolumes, 1](redeclare package Medium = Medium_G, section = coorSecGen(numberOfVolumes, 1)) annotation(
    Placement(visible = true, transformation(origin = {0, -36}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  replaceable TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE[1, numberOfVolumes](redeclare package Medium = Medium_F, section = coorSecGen(1, numberOfVolumes)) annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
equation
  for i in 1:numberOfVolumes loop
    connect(flowHE[1, i].heat, gasHE[numberOfVolumes + 1 - i, 1].heat);
  end for;
  h_gl[1, 1] = inStream(flowIn.h_outflow);
  flowIn.h_outflow = inStream(flowOut.h_outflow);
  D_gl[1, 1] = flowIn.m_flow;
  p_gl[1, 1] = flowIn.p;
  h_gl[1, numberOfVolumes + 1] = flowOut.h_outflow;
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
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    version = "",
    uses);
end GFHE_simple;
