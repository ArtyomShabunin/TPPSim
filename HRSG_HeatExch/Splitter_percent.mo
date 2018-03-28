within TPPSim.HRSG_HeatExch;
model Splitter_percent "Разветвитель потоков c заданием доли общего расхода на каждый поток"
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconSplitter;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching);
  outer Modelica.Fluid.System system;
  parameter Integer zahod;
  outer parameter Real flow_circ;
  outer Medium.AbsolutePressure p_gl "Давление (глобальная переменная)";
  outer Medium.SpecificEnthalpy h_gl "Энтальпия (глобальная переменная)";
  outer Medium.MassFlowRate D_gl "Массовый расход (глобальная переменная)";
  outer Modelica.Fluid.Interfaces.FluidPort_a flowIn;
equation
  for i in 1:zahod loop
    D_gl[i, 1] = flow_circ[i] * flowIn.m_flow;
    h_gl[i, 1] = inStream(flowIn.h_outflow);
  end for;
  flowIn.p = p_gl[1, 1];
  annotation(
    Documentation(info = "<html><head></head><body>Модель разветвителя потоков. Работает с глобальными переменными, поэтому может использоваться только внутри модели 'GFHE'.</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>Match 27, 2018</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end Splitter_percent;
