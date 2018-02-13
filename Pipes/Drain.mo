within TPPSim.Pipes;
model Drain
  extends TPPSim.Pipes.BaseClases.Icons.IconDrain;
  replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  Medium.SaturationProperties sat "State vector to compute saturation properties для парового объема";
  Medium.SpecificEnthalpy h_dew "Энтальпия пара на линии насыщения при давлении в сепараторе";
  Medium.SpecificEnthalpy h_bubble "Энтальпия воды на линии насыщения при давлении в сепараторе";
  Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-40, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  sat = Medium.setSat_p(flowOut.p);
  h_dew = Medium.dewEnthalpy(sat);
  h_bubble = Medium.bubbleEnthalpy(sat);
  flowOut.m_flow = -(if noEvent(inStream(flowIn.h_outflow) > h_dew) then flowIn.m_flow else max(flowIn.m_flow * (inStream(flowIn.h_outflow) - h_bubble) / (h_dew - h_bubble), 0.0001));
  flowIn.h_outflow = h_bubble;
  flowIn.p = flowOut.p;
  flowOut.h_outflow = if noEvent(inStream(flowIn.h_outflow) > h_dew) then inStream(flowIn.h_outflow) else h_dew;
  annotation(
    Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"),
    Diagram(graphics),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end Drain;
