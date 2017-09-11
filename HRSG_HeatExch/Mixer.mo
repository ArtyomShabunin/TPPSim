within TPPSim.HRSG_HeatExch;
model Mixer "Смеситель потоков"
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconMixer;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching);
  final parameter Integer zahod;
  final parameter Integer numberOfTubeSections;
  final parameter Integer numberOfFlueSections;
  outer Medium.AbsolutePressure p_gl "Давление (глобальная переменная)";
  outer Medium.SpecificEnthalpy h_gl "Энтальпия (глобальная переменная)";
  outer Medium.MassFlowRate D_gl "Массовый расход (глобальная переменная)";
  outer Modelica.Fluid.Interfaces.FluidPort_b flowOut;
  Medium.MassFlowRate D_temp[zahod];
  Medium.SpecificEnthalpy h_temp[zahod];
equation
  D_temp = D_gl[numberOfFlueSections - (zahod - 1):numberOfFlueSections, numberOfTubeSections + 1];
  h_temp = h_gl[numberOfFlueSections - (zahod - 1):numberOfFlueSections, numberOfTubeSections + 1];
  flowOut.h_outflow * flowOut.m_flow + sum(h_temp[i] * D_temp[i] for i in 1:zahod) = 0;
  flowOut.m_flow + sum(D_temp) = 0;
  for i in numberOfFlueSections - (zahod - 1):numberOfFlueSections loop
    p_gl[i, numberOfTubeSections + 1] = flowOut.p;
  end for;
  annotation(
    Documentation(info = "<html><head></head><body>Модель смесителя потоков. Работает с глобальными переменными, поэтому может использоваться только внутри модели 'GFHE'.</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>August 29, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end Mixer;