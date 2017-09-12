within TPPSim.Valves;
model checkValve
  extends TPPSim.Valves.BaseClases.Icons.IconCheckValve;
  replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  //Параметры клапана
  parameter Modelica.SIunits.AbsolutePressure dp_nominal annotation(
    Dialog(group = "Параметры клапана"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal annotation(
    Dialog(group = "Параметры клапана"));
  parameter Modelica.SIunits.AbsolutePressure p_nominal annotation(
    Dialog(group = "Параметры клапана"));
  parameter Modelica.SIunits.Density rho_nominal annotation(
    Dialog(group = "Параметры клапана"));
  //Переменные
  //Integer position "Положение обратного клапана (1 - открыт, 0 - закрыт)";
  Modelica.SIunits.MassFlowRate m_flow(start = system.m_flow_small);
  Modelica.SIunits.MassFlowRate m_flow_check;
  //Интерфейс    
  outer Modelica.Fluid.System system;
  Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
algorithm
  m_flow := m_flow_nominal * sign(flowIn.p - flowOut.p) * sqrt(abs(flowIn.p - flowOut.p) * Medium.density_ph(flowIn.p, inStream(flowIn.h_outflow)) / dp_nominal / rho_nominal);
  if noEvent(time > 162) then
    //m_flow_check = max(m_flow, 0.95 * system.m_flow_small);
    m_flow_check := system.m_flow_small;   
  else
    m_flow_check := m_flow;    
  end if;
  flowIn.m_flow :=  m_flow_check;
  flowOut.m_flow := - m_flow_check;
  flowIn.h_outflow := inStream(flowOut.h_outflow);
  flowOut.h_outflow := inStream(flowIn.h_outflow);
end checkValve;
