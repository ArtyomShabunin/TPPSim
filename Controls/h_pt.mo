within TPPSim.Controls;
block h_pt "Блок расчета энтальпии по давлению и температуре"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput p "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput T "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput h "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  package Medium = Modelica.Media.Water.StandardWater;
equation
    h = Medium.specificEnthalpy(Medium.setState_pTX(p, T));
    annotation (
  Documentation(info = "<html>
    <head></head>
    <body>
    ...
    </body>
    </html>", 
    revisions = "<html>
    <head></head>
    <body>
    <ul>
      <li><i>Match 27, 2017</i>
          by Artyom Shabunin:<br>
      </li>
    </ul>
    </body>
    </html>"),
  Icon(coordinateSystem(initialScale = 0.1),
        graphics={Text(lineColor = {0, 0, 127}, extent = {{-96, 28}, {94, -24}}, textString = "h_pt")}));
end h_pt;
