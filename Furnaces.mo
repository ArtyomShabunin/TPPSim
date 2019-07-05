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

      model IconTubeFlowSide
      equation

        annotation(
          Icon(graphics = {Rectangle(origin = {0, 90}, fillColor = {176, 176, 176}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 10}, {100, -10}}), Rectangle(origin = {0, -90}, fillColor = {176, 176, 176}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 10}, {100, -10}}), Rectangle(origin = {-60, -20}, rotation = -90, fillColor = {176, 176, 176}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 10}, {60, -10}}), Rectangle(origin = {-90, -20}, rotation = -90, fillColor = {176, 176, 176}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 10}, {60, -10}}), Rectangle(origin = {-30, -20}, rotation = -90, fillColor = {176, 176, 176}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 10}, {60, -10}}), Rectangle(origin = {0, -20}, rotation = -90, fillColor = {176, 176, 176}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 10}, {60, -10}}), Rectangle(origin = {30, -20}, rotation = -90, fillColor = {176, 176, 176}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 10}, {60, -10}}), Rectangle(origin = {60, -20}, rotation = -90, fillColor = {176, 176, 176}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 10}, {60, -10}}), Rectangle(origin = {90, -20}, rotation = -90, fillColor = {176, 176, 176}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 10}, {60, -10}})}));
      end IconTubeFlowSide;
    end Icons;
  end BaseClases;

  model Furnace "Модель топки энергетического котла"
    extends TPPSim.Furnaces.BaseClases.Icons.IconFurnaceZone;
    replaceable package Medium_G = TPPSim.Media.ExhaustGas_Furnance constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Real betta = 0.995 "Степень выгорания топлива";
    parameter Boolean use_fuel_port = true "В зону поступает топливо" annotation(
      Evaluate = true,
      HideResult = true,
      choices(checkBox = true));
    //Переменные
    Real V_O2t "Теоретическое количество сухого воздуха, необходимого для полного сгорания топлива, м3/кг";
    Real V_O2f "Объем кислорода, необходимого для сгорания топлива";
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
    Modelica.SIunits.MassFlowRate D_fuel_gas "Массовый расход продуктов сгорания выделившихся из топлива";
    Real Q_fuel "Тепло полученное в результате горения топлива";
    Real D_cp "Массовый расход продуктов сгорания";
    Real H_cp(max = 5e6, min = 1e5, nominal = 2e6) "Энтальпия продуктов сгорания";
    Real H_out(max = 5e6, min = 1e5, nominal = 2e6) "Энтальпия продуктов сгорания на выходе из зоны";
    Real epsilon "Степень черноты топки";
    Real alpha_air "Избыток воздуха";
    Medium_G.ThermodynamicState state_air;
    Medium_G.ThermodynamicState state_cp "Продукты сгорания (combustion products)";
    Medium_G.ThermodynamicState state_gas_out "Продукты сгорания на выходе из зоны";
    Modelica.Fluid.Interfaces.FluidPort_a airIn(redeclare package Medium = Medium_G) annotation(
      Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(
      Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    TPPSim.Fuel.Interfaces.CoalPort_a fuelIn if use_fuel_port annotation(
      Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    TPPSim.Fuel.Interfaces.CoalPort_b fuelOut if betta < 1 and use_fuel_port annotation(
      Placement(visible = true, transformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Interface.RadiantHeatPort_a heat annotation(
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
    if use_fuel_port then
      V_O2t = 1 / dO2 * (2 * amO / amC * fuelIn.Xi[5] + 2 * amO / (4 * amH) * fuelIn.Xi[6] + 2 * amO / amS * (fuelIn.Xi[3] + fuelIn.Xi[4]) - fuelIn.Xi[8]);
      alpha_air = inStream(airIn.Xi_outflow[1]) * airIn.m_flow / Medium_G.density(state_air) / (V_O2t * fuelIn.m_flow);
      V_O2f = -V_O2t * fuelIn.m_flow;
      V_CO2f = (amC + 2 * amO) / amC / dCO2 * fuelIn.Xi[5] * fuelIn.m_flow;
      V_SO2f = (amS + 2 * amO) / amS / dSO2 * (fuelIn.Xi[3] + fuelIn.Xi[4]) * fuelIn.m_flow;
      V_N2f = 1 / dN2 * fuelIn.Xi[7] * fuelIn.m_flow;
      V_H2Of = 1 / dH2O * (fuelIn.Xi[1] + 0.5 * (2 * amH + amO) / amH * fuelIn.Xi[6]) * fuelIn.m_flow;
      D_fuel_gas = (fuelIn.Xi[1] + fuelIn.Xi[3] + fuelIn.Xi[4] + fuelIn.Xi[5] + fuelIn.Xi[6] + fuelIn.Xi[7] + fuelIn.Xi[8]) * fuelIn.m_flow;
      Q_fuel = betta * fuelIn.m_flow * fuelIn.calorific_value;
    else
      V_O2t = 0;
      alpha_air = 0;
      V_O2f = 0;
      V_CO2f = 0;
      V_SO2f = 0;
      V_N2f = 0;
      V_H2Of = 0;
      D_fuel_gas = 0;
      Q_fuel = 0;
    end if;
    V_O2a = inStream(airIn.Xi_outflow[1]) * airIn.m_flow / Medium_G.density(state_air);
    V_CO2a = inStream(airIn.Xi_outflow[2]) * airIn.m_flow / Medium_G.density(state_air);
    V_H2Oa = inStream(airIn.Xi_outflow[3]) * airIn.m_flow / Medium_G.density(state_air);
    V_N2a = inStream(airIn.Xi_outflow[4]) * airIn.m_flow / Medium_G.density(state_air);
    V_Ara = inStream(airIn.Xi_outflow[5]) * airIn.m_flow / Medium_G.density(state_air);
    V_SO2a = inStream(airIn.Xi_outflow[6]) * airIn.m_flow / Medium_G.density(state_air);
    V_O2 = V_O2f + V_O2a;
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
//Тепловой баланс
    D_cp = D_fuel_gas + airIn.m_flow;
    D_cp * H_cp = airIn.m_flow * inStream(airIn.h_outflow) + Q_fuel + heat.Q_flow;
    heat.Q_flow = D_cp * (H_out - H_cp);
    heat.T = 0.5 * (state_cp.T + state_gas_out.T);
    heat.epsilon = epsilon;
    epsilon = 0.5;
    state_air = Medium_G.setState_phX(1.013e5, inStream(airIn.h_outflow), airIn.Xi_outflow);
    state_cp = Medium_G.setState_phX(1.013e5, H_cp, {r_O2, r_CO2, r_H2O, r_N2, r_Ar, r_SO2});
    state_gas_out = Medium_G.setState_phX(1.013e5, H_out, state_cp.X);
//Граничные условия
    airIn.h_outflow = H_cp;
    airIn.Xi_outflow = state_cp.X;
    airIn.p = 1.013;
    gasOut.h_outflow = H_cp;
    gasOut.Xi_outflow = state_cp.X;
    gasOut.m_flow = -D_cp;
    if betta < 1 and use_fuel_port then
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
      input Real input_1(start = 100);
    
      replaceable package Medium_G = TPPSim.Media.ExhaustGas_Furnance constrainedby Modelica.Media.Interfaces.PartialMedium;
      replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
      TPPSim.Furnaces.Furnace furnace1(redeclare package Medium_G = Medium_G, betta = 1, use_fuel_port = true) annotation(
        Placement(visible = true, transformation(origin = {0, -14}, extent = {{-10, -4}, {10, 4}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T airSource(redeclare package Medium = Medium_G, m_flow = 1000, nPorts = 1) annotation(
        Placement(visible = true, transformation(origin = {-70, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TPPSim.Fuel.Sources.MassFlowSource coilSource(m_flow = 100, use_m_flow_in = true) annotation(
        Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, nPorts = 1) annotation(
        Placement(visible = true, transformation(origin = {70, 90}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      TPPSim.Furnaces.TubeFlowSide tubeFlowSide1(redeclare package Medium = Medium_F) annotation(
        Placement(visible = true, transformation(origin = {30, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T waterSource(redeclare package Medium = Medium_F, T = 100 + 273.15, m_flow = 10, nPorts = 1) annotation(
        Placement(visible = true, transformation(origin = {-70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary waterSink(redeclare package Medium = Medium_F, nPorts = 1, p = 1e6) annotation(
        Placement(visible = true, transformation(origin = {70, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    
    equation
      connect(input_1, coilSource.m_flow_in);
      connect(furnace1.gasOut, gasSink.ports[1]) annotation(
        Line(points = {{0, -10}, {0, -10}, {0, 90}, {60, 90}, {60, 90}}, color = {0, 127, 255}));
      connect(tubeFlowSide1.waterOut, waterSink.ports[1]) annotation(
        Line(points = {{30, -4}, {30, -4}, {30, 60}, {60, 60}, {60, 60}}, color = {0, 127, 255}));
      connect(waterSource.ports[1], tubeFlowSide1.waterIn) annotation(
        Line(points = {{-60, -70}, {30, -70}, {30, -24}, {30, -24}}, color = {0, 127, 255}));
      connect(furnace1.heat, tubeFlowSide1.heat) annotation(
        Line(points = {{10, -14}, {20, -14}}, color = {191, 0, 0}));
      connect(coilSource.port_b, furnace1.fuelIn) annotation(
        Line(points = {{-60, -10}, {-10, -10}, {-10, -15}}, color = {170, 85, 0}));
      connect(airSource.ports[1], furnace1.airIn) annotation(
        Line(points = {{-60, -40}, {-20, -40}, {-20, -17}, {-10, -17}}, color = {0, 127, 255}, thickness = 0.5));
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

  package Interface
    connector RadiantHeatPort_a
      extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a;
      Real epsilon "Степень черноты топки";
    end RadiantHeatPort_a;

    connector RadiantHeatPort_b
      extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b;
      Real epsilon "Степень черноты топки";
    end RadiantHeatPort_b;
  end Interface;

  model TubeFlowSide
    extends TPPSim.Furnaces.BaseClases.Icons.IconTubeFlowSide;
    replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Modelica.SIunits.Area F_g = 1 "Площадь поверхности теплообмена со стороны газов";
    parameter Modelica.SIunits.Area deltaSFlow = 1 "Внутренняя площадь одного участка ряда труб";
    parameter Real psi = 0.9 "Коэффициент тепловой эффективности экранов в зоне";
    //Переменные
    Medium.MassFlowRate D_flow_v "Массовый расход потока вода/пар";
    Modelica.SIunits.Temperature t_m(min = 10 + 273.15, max = 700 + 273.15) "Температура металла на участках трубопровода";
    Medium.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Real alfa_flow "Коэффициент теплоотдачи";
    TPPSim.Furnaces.Interface.RadiantHeatPort_b heat annotation(
      Placement(visible = true, transformation(origin = {-98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium) annotation(
      Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium) annotation(
      Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    alfa_flow = 10000;
    D_flow_v = waterIn.m_flow;
    D_flow_v * (stateFlow.h - inStream(waterIn.h_outflow)) = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T);
    D_flow_v * (waterOut.h_outflow - stateFlow.h) = 0.5 * alfa_flow * deltaSFlow * (t_m - stateFlow.T);
    heat.Q_flow = Modelica.Constants.sigma * psi * heat.epsilon * F_g * (heat.T ^ 4 - t_m ^ 4);
    0 = heat.Q_flow - alfa_flow * deltaSFlow * (t_m - stateFlow.T);
    stateFlow.p = waterOut.p;
    stateFlow.d = Medium.density_ph(stateFlow.p, stateFlow.h);
    stateFlow.T = Medium.temperature_ph(stateFlow.p, stateFlow.h);
    stateFlow.phase = Modelica.Media.Water.IF97_Utilities.phase_ph.phase_ph(stateFlow.p, stateFlow.h);
//Граничные условия
    waterIn.p = waterOut.p;
    waterIn.h_outflow = waterOut.h_outflow;
    waterOut.m_flow = -waterIn.m_flow;
  end TubeFlowSide;
end Furnaces;
