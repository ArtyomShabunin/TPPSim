within TPPSim;

package Furnaces
  package BaseClases
    package Icons
      model IconFurnace
      equation

        annotation(
          Icon(graphics = {Polygon(fillColor = {255, 170, 0}, fillPattern = FillPattern.Vertical, points = {{-60, 100}, {-60, -60}, {0, -100}, {60, -60}, {60, 40}, {26, 70}, {60, 100}, {-60, 100}}), Polygon(origin = {-16, 18}, fillColor = {255, 97, 97}, fillPattern = FillPattern.Solid, points = {{-44, -48}, {-24, -44}, {-16, -34}, {-8, -14}, {-4, 14}, {0, 26}, {2, 8}, {12, 44}, {18, 54}, {28, 34}, {38, 12}, {44, -10}, {42, -30}, {24, -46}, {4, -54}, {-24, -52}, {-34, -50}, {-44, -48}}), Polygon(origin = {-10, -7}, fillColor = {170, 0, 0}, fillPattern = FillPattern.Solid, points = {{-14, -11}, {-2, -1}, {4, 13}, {8, 15}, {10, 7}, {14, 1}, {12, -11}, {8, -1}, {2, -3}, {-2, -7}, {-14, -11}})}, coordinateSystem(extent = {{-60, -100}, {60, 100}})),
          Diagram(coordinateSystem(extent = {{-60, -100}, {60, 100}})),
          __OpenModelica_commandLineOptions = "");
      end IconFurnace;

      model IconFlameZone
        annotation(
          Icon(graphics = {Rectangle(fillColor = {255, 170, 0}, fillPattern = FillPattern.Vertical, extent = {{-100, 40}, {100, -40}}), Polygon(origin = {-21, 1}, fillColor = {255, 97, 97}, fillPattern = FillPattern.Solid, points = {{-79, -19}, {-41, -15}, {5, -1}, {43, 27}, {51, 35}, {49, 17}, {61, 23}, {79, 35}, {79, 7}, {75, -15}, {41, -33}, {-7, -37}, {-57, -31}, {-79, -19}}), Polygon(origin = {2, -15}, fillColor = {170, 0, 0}, fillPattern = FillPattern.Solid, points = {{-14, 3}, {-4, 13}, {-4, 3}, {4, -1}, {14, 1}, {28, 7}, {16, -5}, {-6, -9}, {-20, -5}, {-14, 3}})}, coordinateSystem(extent = {{-100, -40}, {100, 40}}, initialScale = 0.1)),
          Diagram(coordinateSystem(extent = {{-100, -40}, {100, 40}})),
          __OpenModelica_commandLineOptions = "");
      end IconFlameZone;

      model IconFurnaceZone
        annotation(
          Icon(graphics = {Rectangle(fillColor = {255, 170, 0}, fillPattern = FillPattern.Vertical, extent = {{-100, 40}, {100, -40}})}, coordinateSystem(extent = {{-100, -40}, {100, 40}}, initialScale = 0.1)),
          Diagram(coordinateSystem(extent = {{-100, -40}, {100, 40}})),
          __OpenModelica_commandLineOptions = "");
      end IconFurnaceZone;
    end Icons;
  end BaseClases;

  model Furnace "Модель топки энергетического котла"
    extends TPPSim.Furnaces.BaseClases.Icons.IconFurnaceZone;
    replaceable package Medium_G = TPPSim.Media.ExhaustGas_Furnance constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Real betta = 0.995 "Степень выгорания топлива";
    //Переменные
    Real V_O2t "Теоретическое количество сухого воздуха, необходимого для полного сгорания топлива, м3/кг";
    Real V_CO2f "Объем диоксида углерода в выхлопных газах полученный в результате горения топлива";
    Real V_SO2f "Объем диоксида серы в выхлопных газах полученный в результате горения топлива";
    Real V_N2f "Объем азота в выхлопных газах полученный в результате горения топлива";
    Real V_H2Of "Объем воды в выхлопных газах полученный в результате горения топлива";
    Real V_O2a "Объем кислорода в выхлопных газах, полученный из воздуха";
    Real V_CO2a "Объем диоксида углерода в выхлопных газах, полученный из воздуха";
    Real V_SO2a "Объем диоксида серы в выхлопных газах, полученный из воздуха";
    Real V_H2Oa "Объем воды в выхлопных газах, полученный из воздуха";
    Real V_N2a "Объем азота в выхлопных газах, полученный из воздуха";
    Real V_Ara "Объем аргона в выхлопных газах, полученный из воздуха";
    Real V_O2 "Объем кислорода в выхлопных газах";
    Real V_CO2 "Объем диоксида углерода в выхлопных газах";
    Real V_SO2 "Объем диоксида серы в выхлопных газах";
    Real V_H2O "Объем воды в выхлопных газах";
    Real V_N2 "Объем азота в выхлопных газах";
    Real V_Ar "Объем аргона в выхлопных газах";
    Real r_O2 "Объемное содержание кислорода в продуктах сгорания";
    Real r_CO2 "Объемное содержание диоксида углерода в продуктах сгорания";
    Real r_SO2 "Объемное содержание диоксида серы в продуктах сгорания";
    Real r_H2O "Объемное содержание воды в продуктах сгорания";
    Real r_N2 "Объемное содержание азота в продуктах сгорания";
    Real r_Ar "Объемное содержание аргона в продуктах сгорания";
    Real D_cp "Массовый расход продуктов сгорания";
    Real H_cp "Энтальпия продуктов сгорания";
    //  Real
    Real alpha_air "Избыток воздуха";
    Medium_G.ThermodynamicState state_air;
    Medium_G.ThermodynamicState state_cp "Продукты сгорания (combustion products)";
    Modelica.Fluid.Interfaces.FluidPort_a airIn(redeclare package Medium = Medium_G) annotation(
      Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(
      Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    TPPSim.Fuel.Interfaces.CoalPort_a fuelIn annotation(
      Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    TPPSim.Fuel.Interfaces.CoalPort_b fuelOut if betta < 1 annotation(
      Placement(visible = true, transformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  protected
    constant Real amC = 12.01115 "Carbon atomic mass";
    constant Real amH = 1.00797 "Hydrogen atomic mass";
    constant Real amO = 15.9994 "Oxygen atomic mass";
    constant Real amS = 32.064 "Sulfur atomic mass";
    constant Real amCO2 = amC + 2 * amO "CO2 molecular mass";
    constant Real amH2O = 2 * amH + amO "H2O molecular mass";
    constant Real amSO2 = amS + 2 * amO "SO2 molecular mass";
    constant Real dO2 = 1.429 "Плотность кислорода";
    constant Real dCO2 = 1.9768 "Плотность диоксида углерода";
    constant Real dSO2 = 2.026 "Плотность диоксида серы";
    constant Real dN2 = 1.2506 "Плотность азота";
    constant Real dH2O = 0.768 "Плотность воды";
  equation
    state_air = Medium_G.setState_phX(1.013e5, inStream(airIn.h_outflow), airIn.Xi_outflow);
    V_O2t = 1 / dO2 * (2 * amO / amC * fuelIn.Xi[5] + 2 * amO / (4 * amH) * fuelIn.Xi[6] + 2 * amO / amS * (fuelIn.Xi[3] + fuelIn.Xi[4]) - fuelIn.Xi[8]);
    alpha_air = inStream(airIn.Xi_outflow[1]) * airIn.m_flow / Medium_G.density(state_air) / (V_O2t * fuelIn.m_flow);
    V_CO2f = (amC + 2 * amO) / amC / dCO2 * fuelIn.Xi[5] * fuelIn.m_flow;
    V_SO2f = (amS + 2 * amO) / amS / dSO2 * (fuelIn.Xi[3] + fuelIn.Xi[4]) * fuelIn.m_flow;
    V_N2f = 1 / dN2 * fuelIn.Xi[7] * fuelIn.m_flow;
    V_H2Of = 1 / dH2O * (fuelIn.Xi[1] + 0.5 * (2 * amH + amO) / amH * fuelIn.Xi[6]) * fuelIn.m_flow;
    V_O2a = (alpha_air - 1) * V_O2t;
    V_CO2a = inStream(airIn.Xi_outflow[2]) * airIn.m_flow / Medium_G.density(state_air);
    V_H2Oa = inStream(airIn.Xi_outflow[3]) * airIn.m_flow / Medium_G.density(state_air);
    V_N2a = inStream(airIn.Xi_outflow[4]) * airIn.m_flow / Medium_G.density(state_air);
    V_Ara = inStream(airIn.Xi_outflow[5]) * airIn.m_flow / Medium_G.density(state_air);
    V_SO2a = inStream(airIn.Xi_outflow[6]) * airIn.m_flow / Medium_G.density(state_air);
    V_O2 = V_O2a;
    V_CO2 = V_CO2f + V_CO2a;
    V_H2O = V_H2Of + V_H2Oa;
    V_N2 = V_N2f + V_N2a;
    V_Ar = V_Ara;
    V_SO2 = V_SO2f + V_SO2a;
    r_O2 = V_O2 / (V_O2 + V_CO2 + V_H2O + V_N2 + V_Ar + V_SO2);
    r_CO2 = V_CO2 / (V_O2 + V_CO2 + V_H2O + V_N2 + V_Ar + V_SO2);
    r_H2O = V_H2O / (V_O2 + V_CO2 + V_H2O + V_N2 + V_Ar + V_SO2);
    r_N2 = V_N2 / (V_O2 + V_CO2 + V_H2O + V_N2 + V_Ar + V_SO2);
    r_Ar = V_Ar / (V_O2 + V_CO2 + V_H2O + V_N2 + V_Ar + V_SO2);
    r_SO2 = V_SO2 / (V_O2 + V_CO2 + V_H2O + V_N2 + V_Ar + V_SO2);
    D_cp = (fuelIn.Xi[1] + fuelIn.Xi[3] + fuelIn.Xi[4] + fuelIn.Xi[5] + fuelIn.Xi[6] + fuelIn.Xi[7] + fuelIn.Xi[8]) * fuelIn.m_flow + airIn.m_flow;
    D_cp * H_cp = airIn.m_flow * inStream(airIn.h_outflow) + betta * fuelIn.m_flow * fuelIn.calorific_value + heat.Q_flow;
    heat.Q_flow = -0.0001 * heat.T;
    
    
    
    state_cp = Medium_G.setState_phX(1.013e5, H_cp, {r_O2, r_CO2, r_H2O, r_N2, r_Ar, r_SO2});
    airIn.h_outflow = H_cp;
    airIn.Xi_outflow = state_cp.X;
    airIn.p = 1.013;
    gasOut.h_outflow = H_cp;
    gasOut.Xi_outflow = state_cp.X;
    gasOut.m_flow = -D_cp;
    if betta < 1 then
      fuelOut.Xi = fuelIn.Xi;
      fuelOut.calorific_value = fuelIn.calorific_value;
      fuelOut.m_flow = (betta - 1) * fuelIn.m_flow;
    end if;
    annotation(
      Documentation(info = "<html>
  <style>
  p {
    text-indent: 20px;
    text-align: 'justify';
   }
  </style>
  <p>...</p>
  </html>", revisions = "<html>
  <ul>
  <li><i>23 May 2019</i>
  by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
     Создан.</li>
  </ul>
  </html>"),
      Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
      Icon(coordinateSystem(extent = {{-100, -40}, {100, 40}})),
      __OpenModelica_commandLineOptions = "");
  end Furnace;




  package Tests
    model Furnace_Test
      replaceable package Medium_G = TPPSim.Media.ExhaustGas_Furnance constrainedby Modelica.Media.Interfaces.PartialMedium;
      replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
      TPPSim.Furnaces.Furnace furnace1(redeclare package Medium_G = Medium_G) annotation(
        Placement(visible = true, transformation(origin = {0, -14}, extent = {{-10, -4}, {10, 4}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T airSource(redeclare package Medium = Medium_G, m_flow = 100, nPorts = 1) annotation(
        Placement(visible = true, transformation(origin = {-70, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TPPSim.Fuel.Sources.MassFlowSource coilSource annotation(
        Placement(visible = true, transformation(origin = {-70, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, nPorts = 1) annotation(
        Placement(visible = true, transformation(origin = {50, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      TPPSim.Furnaces.Furnace zone1(redeclare package Medium_G = Medium_G, betta = 1) annotation(
        Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -4}, {10, 4}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T = 573.15)  annotation(
        Placement(visible = true, transformation(origin = {44, -2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    equation
      connect(zone1.heat, fixedTemperature1.port) annotation(
        Line(points = {{10, 10}, {20, 10}, {20, -2}, {34, -2}, {34, -2}}, color = {191, 0, 0}));
      connect(furnace1.heat, fixedTemperature1.port) annotation(
        Line(points = {{10, -14}, {20, -14}, {20, -2}, {34, -2}, {34, -2}}, color = {191, 0, 0}));
      connect(zone1.gasOut, gasSink.ports[1]) annotation(
        Line(points = {{0, 14}, {0, 14}, {0, 30}, {40, 30}, {40, 30}}, color = {0, 127, 255}));
      connect(furnace1.gasOut, zone1.airIn) annotation(
        Line(points = {{0, -10}, {0, -10}, {0, -2}, {-20, -2}, {-20, 8}, {-10, 8}, {-10, 8}}, color = {0, 127, 255}));
      connect(furnace1.fuelOut, zone1.fuelIn) annotation(
        Line(points = {{-2, -10}, {-2, -10}, {-2, -4}, {-26, -4}, {-26, 10}, {-10, 10}, {-10, 10}}, color = {170, 85, 0}));
      connect(coilSource.port_b, furnace1.fuelIn) annotation(
        Line(points = {{-60, -14}, {-10, -14}, {-10, -15}}, color = {170, 85, 0}));
      connect(airSource.ports[1], furnace1.airIn) annotation(
        Line(points = {{-60, -44}, {-20, -44}, {-20, -17}, {-10, -17}}, color = {0, 127, 255}, thickness = 0.5));
    end Furnace_Test;
  end Tests;

  model TopFurnaceZone
    extends TPPSim.Furnaces.BaseClases.Icons.IconFurnaceZone;
    replaceable package Medium_G = TPPSim.Media.ExhaustGas_Furnance constrainedby Modelica.Media.Interfaces.PartialMedium;
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(
      Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(
      Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium_F) annotation(
      Placement(visible = true, transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium_F) annotation(
      Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(flowIn, flowOut) annotation(
      Line(points = {{100, -60}, {60, -60}, {60, 60}, {100, 60}, {100, 60}}));
    connect(gasIn, gasOut) annotation(
      Line(points = {{0, -100}, {0, -100}, {0, 100}, {0, 100}}));
    annotation(
      Documentation(info = "<html>
  <style>
  p {
    text-indent: 20px;
    text-align: 'justify';
   }
  </style>
  <p>...</p>
  </html>", revisions = "<html>
  <ul>
  <li><i>09 June 2019</i>
  by <a href=\"mailto:shabunin_a@mail.ru\">Artyom Shabunin</a>:<br>
     Создан.</li>
  </ul>
  </html>"),
      Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
      Icon(coordinateSystem(extent = {{-100, -40}, {100, 40}})),
      __OpenModelica_commandLineOptions = "");
  end TopFurnaceZone;
end Furnaces;
