within TPPSim;

package Fuel
  package Interfaces
    connector CoalPort "Интерфейс для передачи характеристик топлива"
      flow Modelica.SIunits.MassFlowRate m_flow "Mass flow rate from the connection point into the component";
      Modelica.SIunits.SpecificEnergy calorific_value "Низшая теплота сгорания топлива";
      Modelica.SIunits.MassFraction Xi[8] "Состав рабочей массы топлива (W_p, A_p, Sk_p, Sop_p, C_p, H_p, N_p, O_p), %";
    end CoalPort;

    connector CoalPort_a
      extends CoalPort;
      annotation(
        defaultComponentName = "port_a",
        Diagram(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Ellipse(fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}, endAngle = 360), Text(extent = {{-150, 110}, {150, 50}}, textString = "%name")}),
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Ellipse(lineColor = {0, 127, 255}, fillColor = {0, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Ellipse(fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, endAngle = 360)}));
    end CoalPort_a;

    connector CoalPort_b
      extends TPPSim.Fuel.Interfaces.CoalPort;
      annotation(
        defaultComponentName = "port_b",
        Diagram(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Ellipse(fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}, endAngle = 360), Ellipse(lineColor = {0, 127, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Text(extent = {{-150, 110}, {150, 50}}, textString = "%name")}),
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Ellipse(lineColor = {170, 85, 0}, fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Ellipse(fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Ellipse(lineColor = {170, 85, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}, endAngle = 360)}));
    end CoalPort_b;
  end Interfaces;

  package Sources
    model MassFlowSource
      "Ideal flow source that produces a prescribed mass flow with prescribed temperature, mass fraction and trace substances"
    
      parameter Boolean use_m_flow_in = false
        "Get the mass flow rate from the input connector"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Boolean use_calorific_value_in= false
        "Получать значения низшей теплоты сгорания из входного коннектора"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Boolean use_X_in = false
        "Get the composition from the input connector"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.MassFlowRate m_flow = 10
        "Fixed mass flow rate going out of the fluid port"
        annotation (Dialog(enable = not use_m_flow_in));
      parameter Modelica.SIunits.SpecificEnergy calorific_value = 18.5e6
        "Низшая теплота сгорания топлива"
        annotation (Dialog(enable = not use_calorific_value_in));
      parameter Modelica.SIunits.MassFraction Xi[8] = {0.13, 0.244, 0.018, 0.013, 0.47, 0.034, 0.01, 0.081}
        "Состав рабочей массы топлива (W_p, A_p, Sk_p, Sop_p, C_p, H_p, N_p, O_p)"
        annotation (Dialog(enable = (not use_X_in) and Medium.nXi > 0));
      Modelica.Blocks.Interfaces.RealInput m_flow_in if     use_m_flow_in
        "Prescribed mass flow rate"
        annotation (Placement(visible = true,transformation(extent = {{-120, 60}, {-80, 100}}, rotation = 0), iconTransformation(extent = {{-120, 60}, {-80, 100}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput calorific_value_in if         use_calorific_value_in
        "Низшая теплота сгорания"
        annotation (Placement(transformation(extent={{-140,20},{-100,60}}), iconTransformation(extent={{-140,20},{-100,60}})));
      Modelica.Blocks.Interfaces.RealInput X_in[8] if
                                                            use_X_in
        "Prescribed fluid composition"
        annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Interfaces.CoalPort_b port_b annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    protected
      Modelica.Blocks.Interfaces.RealInput m_flow_in_internal
        "Needed to connect to conditional connector";
      Modelica.Blocks.Interfaces.RealInput calorific_value_in_internal
        "Needed to connect to conditional connector";
      Modelica.Blocks.Interfaces.RealInput X_in_internal[8]
        "Needed to connect to conditional connector";
    equation
      connect(m_flow_in, m_flow_in_internal);
      connect(calorific_value_in, calorific_value_in_internal);
      connect(X_in, X_in_internal);
      if not use_m_flow_in then
        m_flow_in_internal = m_flow;
      end if;
      if not use_calorific_value_in then
        calorific_value_in_internal = calorific_value;
      end if;
      if not use_X_in then
        X_in_internal = Xi;
      end if;
    //  if Medium.ThermoStates == IndependentVariables.ph or
    //     Medium.ThermoStates == IndependentVariables.phX then
    //     medium.h = Medium.specificEnthalpy(Medium.setState_pTX(medium.p, T_in_internal, X_in_internal));
    //  else
    //     medium.T = T_in_internal;
    //  end if;
      port_b.m_flow = -m_flow_in_internal;
      port_b.Xi = X_in_internal;
      port_b.calorific_value = calorific_value_in_internal;
      annotation (defaultComponentName="boundary",
        Icon(coordinateSystem(
            initialScale = 0.1), graphics={Rectangle(fillColor = {170, 85, 0}, fillPattern = FillPattern.HorizontalCylinder, extent = {{35, 45}, {100, -45}}), Ellipse(lineColor = {170, 85, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 80}, {60, -80}}, endAngle = 360), Polygon(lineColor = {170, 85, 0}, fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, points = {{-60, 70}, {60, 0}, {-60, -68}, {-60, 70}}), Text(extent = {{-54, 32}, {16, -30}}, textString = "m"), Text(lineColor = {0, 0, 255}, extent = {{-150, 130}, {150, 170}}, textString = "%name"), Ellipse( fillPattern = FillPattern.Solid, extent = {{-26, 30}, {-18, 22}}, endAngle = 360), Text(visible = false, extent = {{-185, 132}, {-45, 100}}, textString = "m_flow"), Text(visible = false, extent = {{-111, 71}, {-71, 37}}, textString = "T"), Text(visible = false, extent = {{-153, -44}, {-33, -72}}, textString = "X"), Text(visible = false, extent = {{-155, -98}, {-35, -126}}, textString = "C")}),
        Documentation(info="<html>
    <p>
    Models an ideal flow source, with prescribed values of flow rate, temperature, composition and trace substances:
    </p>
    <ul>
    <li> Prescribed mass flow rate.</li>
    <li> Prescribed temperature.</li>
    <li> Boundary composition (only for multi-substance or trace-substance flow).</li>
    </ul>
    <p>If <code>use_m_flow_in</code> is false (default option), the <code>m_flow</code> parameter
    is used as boundary pressure, and the <code>m_flow_in</code> input connector is disabled; if <code>use_m_flow_in</code> is true, then the <code>m_flow</code> parameter is ignored, and the value provided by the input connector is used instead.</p>
    <p>The same thing goes for the temperature and composition</p>
    <p>
    Note, that boundary temperature,
    mass fractions and trace substances have only an effect if the mass flow
    is from the boundary into the port. If mass is flowing from
    the port into the boundary, the boundary definitions,
    with exception of boundary flow rate, do not have an effect.
    </p>
    </html>"));
    end MassFlowSource;

  end Sources;


end Fuel;
