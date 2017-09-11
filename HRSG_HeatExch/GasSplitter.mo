within TPPSim.HRSG_HeatExch;
model GasSplitter
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconGasSplitter;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching);
  final parameter Integer numberOfTubeSections;
  outer Medium.AbsolutePressure pgas_gl "Давление (глобальная переменная)";
  outer Medium.SpecificEnthalpy hgas_gl "Энтальпия (глобальная переменная)";
  outer Medium.MassFlowRate Dgas_gl "Массовый расход (глобальная переменная)";
  outer Modelica.Fluid.Interfaces.FluidPort_a gasIn;
equation
  for i in 1:numberOfTubeSections loop
    Dgas_gl[1, i] = gasIn.m_flow / numberOfTubeSections;
    hgas_gl[1, i] = inStream(gasIn.h_outflow);
  end for;
  gasIn.p = pgas_gl[1, 1];
end GasSplitter;