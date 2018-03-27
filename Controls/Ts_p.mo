within TPPSim.Controls;
block Ts_p "Блок расчета температуры насыщения по давлению"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput p "Connector of Boolean input signal"
    annotation (Placement(visible = true, transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0), iconTransformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput ts "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  package Medium = Modelica.Media.Water.StandardWater;
equation
    ts = Medium.saturationTemperature_sat(Medium.setSat_p(p));
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
        graphics={Text(lineColor = {0, 0, 127}, extent = {{-96, 28}, {94, -24}}, textString = "Ts_p")}));
end Ts_p;
