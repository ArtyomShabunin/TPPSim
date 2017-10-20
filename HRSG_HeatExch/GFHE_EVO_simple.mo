within TPPSim.HRSG_HeatExch;
model GFHE_EVO_simple
  extends TPPSim.HRSG_HeatExch.BaseClases.BaseGFHE_simple;
  extends TPPSim.HRSG_HeatExch.BaseClases.GFHE_EVO_interface;
  import TPPSim.functions.coorSecGen;
  replaceable package Medium_G = TPPSim.Media.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  //Параметры циркуляции
  parameter TPPSim.Choices.circ_type circ_type_set = TPPSim.Choices.circ_type.forced "Тип механизма циркуляции в испарителе" annotation(
    Dialog(group = "Параметры циркуляции"));  
  parameter Modelica.SIunits.MassFlowRate flow_circ "Номинальный расход через каждый из рядов труб (массив из z2 элементов)" annotation(
    Dialog(group = "Параметры циркуляции"));
  parameter Modelica.SIunits.MassFlowRate start_flow_circ = 1 "Начальное значение расходя через ряд труб испарителя" annotation(
    Dialog(group = "Параметры циркуляции"));    
  parameter Modelica.SIunits.AbsolutePressure dp_circ "Номинальный перепад давления на подводящем трубопроводе ряда труб (массив из z2 элементов)" annotation(
    Dialog(group = "Параметры циркуляции"));
  final Boolean forced_circ(start = true, fixed = true);  
  //Переменные
  TPPSim.HRSG_HeatExch.GasSideHE gasHE[numberOfVolumes, 1](redeclare package Medium = Medium_G, section = coorSecGen(numberOfVolumes, 1)) annotation(
    Placement(visible = true, transformation(origin = {0, -36}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  replaceable TPPSim.HRSG_HeatExch.FlowSide2phHE flowHE[1, numberOfVolumes](redeclare package Medium = Medium_F, section = coorSecGen(1, numberOfVolumes), deltaHpipe = fill(Lpipe/numberOfVolumes, 1, numberOfVolumes)) annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
algorithm
  when flowIn.p - p_gl[1, 1] > dp_circ*(start_flow_circ / flow_circ)^2 and circ_type_set == TPPSim.Choices.circ_type.natural then 
    forced_circ := false;
  end when;
equation
  //Граничные условия
  //Поток вода/пар    
  h_gl[1, 1] = inStream(flowIn.h_outflow);
  h_gl[1, 1] = flowIn.h_outflow;
  D_gl[1, 1] = flowIn.m_flow;
  if circ_type_set == TPPSim.Choices.circ_type.natural then
    if initial() then
      D_gl[1, 1] = start_flow_circ;
    elseif noEvent(forced_circ) then
      D_gl[1, 1] = start_flow_circ;     
    else    
      D_gl[i, 1] = flow_circ[i] * sign(flowIn[i].p - p_gl[i, 1]) * sqrt(abs(flowIn[i].p - p_gl[i, 1]) / dp_circ[i]);
    end if;
  else
    D_gl[1, 1] = flow_circ;
  end if;  
  h_gl[1, numberOfVolumes + 1] = flowOut.h_outflow;    
  D_gl[1, numberOfVolumes + 1] = -flowOut.m_flow;
  p_gl[1, numberOfVolumes + 1] = flowOut.p;   
  //Тепловые потоки
  for i in 1:numberOfVolumes loop
    connect(flowHE[1, i].heat, gasHE[numberOfVolumes + 1 - i, 1].heat);
  end for;
  //Газы
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
    Documentation(info = "<html><head></head><body>Упрощенная модель испарителя - принимается, что в направлении движения газов испаритель состоит из одного элемента.</body></html>", revisions = "<html><head></head><body>
<ul>
  <li><i>October 18, 2017</i>
by Artyom Shabunin:<br></li>
</ul></body></html>"));
end GFHE_EVO_simple;
