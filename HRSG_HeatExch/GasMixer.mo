within TPPSim.HRSG_HeatExch;
model GasMixer
  extends TPPSim.HRSG_HeatExch.BaseClases.Icons.IconGasMixer;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching);
  final parameter Integer numberOfTubeSections;
  final parameter Integer numberOfFlueSections;
  outer Medium.AbsolutePressure pgas_gl "Давление (глобальная переменная)";
  outer Medium.SpecificEnthalpy hgas_gl "Энтальпия (глобальная переменная)";
  outer Medium.MassFlowRate Dgas_gl "Массовый расход (глобальная переменная)";
  outer Modelica.Fluid.Interfaces.FluidPort_b gasOut;
  Medium.MassFlowRate D_temp[numberOfTubeSections];
  Medium.SpecificEnthalpy h_temp[numberOfTubeSections];
equation
  D_temp = Dgas_gl[numberOfFlueSections + 1, 1:numberOfTubeSections];
  h_temp = hgas_gl[numberOfFlueSections + 1, 1:numberOfTubeSections];
  gasOut.h_outflow * gasOut.m_flow + sum(h_temp[i] * D_temp[i] for i in 1:numberOfTubeSections) = 0;
  gasOut.m_flow + sum(D_temp) = 0;
  for i in 1:numberOfTubeSections loop
    pgas_gl[numberOfFlueSections + 1, i] = gasOut.p;
  end for;
end GasMixer;