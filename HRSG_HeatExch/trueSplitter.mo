within TPPSim.HRSG_HeatExch;
model trueSplitter "Разветвитель потоков"
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconSplitter;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching);
  outer Modelica.Fluid.System system;
  parameter Integer zahod;
  outer Medium.AbsolutePressure p_gl "Давление (глобальная переменная)";
  outer Medium.SpecificEnthalpy h_gl "Энтальпия (глобальная переменная)";
  outer Medium.MassFlowRate D_gl "Массовый расход (глобальная переменная)";
  outer Modelica.Fluid.Interfaces.FluidPort_a flowIn;
equation

  sum(D_gl[i, 1] for i in 1:zahod) = flowIn.m_flow;

  for i in 1:zahod loop
    flowIn.p = p_gl[i, 1];
    h_gl[i, 1] = inStream(flowIn.h_outflow);    
  end for;
  annotation(
    Documentation(info = "<html><head></head><body>Модель разветвителя потоков. Работает с глобальными переменными, поэтому может использоваться только внутри модели 'GFHE'.</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>August 29, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end trueSplitter;
