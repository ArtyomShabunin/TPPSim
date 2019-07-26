within TPPSim.Nuclear;

package BaseClases
  package Icons
    model IconSodiumSideHE
      annotation(
        Icon(graphics = {Rectangle(origin = {0, 21}, lineColor = {0, 255, 0}, fillColor = {255, 255, 127}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 0, extent = {{-100, 79}, {100, -121}}), Rectangle(origin = {0, 55}, lineColor = {81, 81, 81}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 45}, {100, -35}}), Polygon(origin = {-30, -15.11}, lineColor = {255, 0, 0}, fillColor = {255, 85, 0}, lineThickness = 2, points = {{-6.0012, 51.1053}, {-8.0012, 41.1053}, {-8.0012, 23.1053}, {-6.0012, 11.1053}, {-2.00116, 1.10532}, {3.99884, -8.89468}, {7.99884, -20.8947}, {5.99884, -34.8947}, {-4.00116, -52.8947}, {-8.0012, -62.8947}, {-10.0012, -72.8947}, {-0.00116419, -72.8947}, {1.99884, -60.8947}, {7.99884, -46.8947}, {13.9988, -34.8947}, {15.9988, -18.8947}, {9.9988, -2.89468}, {3.99884, 7.10532}, {-0.00115991, 23.1053}, {-0.00115991, 39.1053}, {1.99884, 49.1053}, {3.99884, 59.1053}, {9.99884, 57.1053}, {1.99884, 75.1053}, {-12.0012, 57.1053}, {-4.0012, 59.1053}, {-6.0012, 51.1053}}), Polygon(origin = {2, 12.89}, lineColor = {255, 0, 0}, fillColor = {255, 85, 0}, lineThickness = 2, points = {{-6.0012, 51.1053}, {-8.0012, 41.1053}, {-8.0012, 23.1053}, {-6.0012, 11.1053}, {-2.00116, 1.10532}, {3.99884, -8.89468}, {7.99884, -20.8947}, {5.99884, -34.8947}, {-4.00116, -52.8947}, {-8.0012, -62.8947}, {-10.0012, -72.8947}, {-0.00116419, -72.8947}, {1.99884, -60.8947}, {7.99884, -46.8947}, {13.9988, -34.8947}, {15.9988, -18.8947}, {9.9988, -2.89468}, {3.99884, 7.10532}, {-0.00115991, 23.1053}, {-0.00115991, 39.1053}, {1.99884, 49.1053}, {3.99884, 59.1053}, {9.99884, 57.1053}, {1.99884, 75.1053}, {-12.0012, 57.1053}, {-4.0012, 59.1053}, {-6.0012, 51.1053}}), Polygon(origin = {34, -15.11}, lineColor = {255, 0, 0}, fillColor = {255, 85, 0}, lineThickness = 2, points = {{-6.0012, 51.1053}, {-8.0012, 41.1053}, {-8.0012, 23.1053}, {-6.0012, 11.1053}, {-2.00116, 1.10532}, {3.99884, -8.89468}, {7.99884, -20.8947}, {5.99884, -34.8947}, {-4.00116, -52.8947}, {-8.0012, -62.8947}, {-10.0012, -72.8947}, {-0.00116419, -72.8947}, {1.99884, -60.8947}, {7.99884, -46.8947}, {13.9988, -34.8947}, {15.9988, -18.8947}, {9.9988, -2.89468}, {3.99884, 7.10532}, {-0.00115991, 23.1053}, {-0.00115991, 39.1053}, {1.99884, 49.1053}, {3.99884, 59.1053}, {9.99884, 57.1053}, {1.99884, 75.1053}, {-12.0012, 57.1053}, {-4.0012, 59.1053}, {-6.0012, 51.1053}}), Text(origin = {2, -42}, extent = {{-62, 70}, {58, -50}}, textString = "Q")}, coordinateSystem(initialScale = 0.1)),
        Diagram,
        __OpenModelica_commandLineOptions = "");
    end IconSodiumSideHE;

    model IconSodiumHE
    equation

      annotation(
        Icon(graphics = {Rectangle(lineColor = {90, 90, 90}, fillColor = {207, 207, 207}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, borderPattern = BorderPattern.Raised, extent = {{-40, 98}, {40, -100}}), Rectangle(origin = {-2, -89}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, extent = {{-48, -11}, {52, 5}}), Rectangle(origin = {-2, 95}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, extent = {{-48, -11}, {52, 5}}), Text(origin = {1, 3}, extent = {{-35, 21}, {35, -21}}, textString = "%name")}, coordinateSystem(extent = {{-50, -100}, {50, 100}}, initialScale = 0.1)),
        Diagram(coordinateSystem(extent = {{-50, -100}, {50, 100}})),
        version = "",
        uses,
        __OpenModelica_commandLineOptions = "");
    end IconSodiumHE;

    partial model IconSteamGenerator
      annotation(
        Icon(graphics = {Rectangle(origin = {-71, 87}, lineColor = {163, 163, 163}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-29, 13}, {51, -17}}), Rectangle(origin = {49, 87}, lineColor = {163, 163, 163}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-29, 13}, {51, -17}}), Rectangle(origin = {-71, -83}, lineColor = {163, 163, 163}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-29, 13}, {51, -17}}), Rectangle(origin = {49, -23}, lineColor = {163, 163, 163}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-29, 13}, {51, -17}}), Polygon(origin = {-60, 65}, lineColor = {163, 163, 163}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, points = {{-40, 5}, {40, 5}, {30, -5}, {-30, -5}, {-40, 5}}), Polygon(origin = {60, 65}, lineColor = {163, 163, 163}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, points = {{-40, 5}, {40, 5}, {30, -5}, {-30, -5}, {-40, 5}}), Polygon(origin = {-60, -65}, rotation = 180, lineColor = {163, 163, 163}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, points = {{-40, 5}, {40, 5}, {30, -5}, {-30, -5}, {-40, 5}}), Polygon(origin = {60, -5}, rotation = 180, lineColor = {163, 163, 163}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, points = {{-40, 5}, {40, 5}, {30, -5}, {-30, -5}, {-40, 5}}), Rectangle(origin = {-60, 0}, lineColor = {163, 163, 163}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-30, 60}, {30, -60}}), Rectangle(origin = {60, 30}, lineColor = {163, 163, 163}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-30, 30}, {30, -30}}), Rectangle(origin = {0, 47}, lineColor = {163, 163, 163}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-30, 7}, {30, -7}}), Rectangle(origin = {0, 89}, lineColor = {163, 163, 163}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-20, 3}, {20, -3}})}, coordinateSystem(initialScale = 0.1)));
    end IconSteamGenerator;

    partial model IconReactor
      annotation(
        Icon(graphics = {Polygon(lineColor = {85, 170, 0}, fillColor = {213, 255, 167}, fillPattern = FillPattern.VerticalCylinder, lineThickness = 1, points = {{-100, 0}, {-100, -60}, {-92, -72}, {-76, -82}, {-54, -92}, {-34, -98}, {-12, -100}, {0, -100}, {12, -100}, {34, -98}, {54, -92}, {70, -86}, {82, -80}, {92, -72}, {100, -60}, {100, 0}, {96, 6}, {60, 6}, {56, 12}, {56, 34}, {60, 40}, {64, 42}, {68, 46}, {68, 94}, {64, 98}, {56, 100}, {-58, 100}, {-66, 96}, {-68, 92}, {-68, 46}, {-64, 42}, {-58, 40}, {-56, 34}, {-56, 12}, {-60, 6}, {-96, 6}, {-100, 0}}, smooth = Smooth.Bezier), Rectangle(origin = {2, -28}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Vertical, extent = {{-42, 16}, {38, -32}})}));
    end IconReactor;
  end Icons;

  model BaseSteamGenerator
    import Modelica.Fluid.Types;
    //Геометрия пучка
    inner parameter Integer z = 473 "Кол-во теплообменных трубок" annotation(
      Dialog(group = "Геометрия пучка"));
    parameter Modelica.SIunits.Length Lpipe = 17.7 "Длина теплообменной трубки" annotation(
      Dialog(group = "Геометрия пучка"));
    //Конструктивные характеристики труб
    inner parameter Modelica.SIunits.Diameter Din = 0.011 "Внутренний диаметр трубок теплообменника" annotation(
      Dialog(group = "Конструктивные характеристики труб"));
    inner parameter Modelica.SIunits.Length delta = 0.0025 "Толщина стенки трубки теплообменника" annotation(
      Dialog(group = "Конструктивные характеристики труб"));
    inner parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость" annotation(
      Dialog(group = "Конструктивные характеристики труб"));
    //Конструктивные характеристики корпуса теплообменника
    inner parameter Modelica.SIunits.Diameter Dcase = 0.680 "Внутренний диаметр корпуса теплообменника" annotation(
      Dialog(group = "Конструктивные характеристики теплообменника"));
    //Характеристики металла
    inner parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(
      Dialog(group = "Характеристики металла"));
    inner parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(
      Dialog(group = "Характеристики металла"));
    parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(
      Dialog(group = "Характеристики металла"));
    //Поправки
    inner parameter Real k_gamma_sodium = 1 "Поправка к коэффициенту теплоотдачи со стороны натрия" annotation(
      Dialog(group = "Поправки"));
    parameter Real k_weight_metal = 1 "Поправка к массе металла поверхности нагрева" annotation(
      Dialog(group = "Поправки"));
    parameter Real k_volume = 1 "Поправка к внутреннему объему трубок поверхности нагрева" annotation(
      Dialog(group = "Поправки"));
    parameter Real k_volume_sodium = 1 "Поправка к объему натрия поверхности нагрева" annotation(
      Dialog(group = "Поправки"));
    //Параметры уравнений динамики
    inner parameter Types.Dynamics flowEnergyDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения энергии вода/пар" annotation(
      Evaluate = true,
      Dialog(tab = "Assumptions", group = "Dynamics"));
    inner parameter Types.Dynamics flowMassDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения массы вода/пар" annotation(
      Evaluate = true,
      Dialog(tab = "Assumptions", group = "Dynamics"));
    inner parameter Modelica.Fluid.Types.Dynamics flowMomentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyState "Параметры уравнения сохранения момента вода/пар" annotation(
      Evaluate = true,
      Dialog(tab = "Assumptions", group = "Dynamics"));
    inner parameter Types.Dynamics metalDynamics = Types.Dynamics.FixedInitial "Параметры уравнения динамики прогрева металла" annotation(
      Evaluate = true,
      Dialog(tab = "Assumptions", group = "Dynamics"));
    inner parameter Types.Dynamics sodiumEnergyDynamics = Types.Dynamics.FixedInitial "Параметры уравнения сохранения энергии натрия" annotation(
      Evaluate = true,
      Dialog(tab = "Assumptions", group = "Dynamics"));
    //Начальные значения
    inner parameter Modelica.SIunits.SpecificEnthalpy h_flow_start = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(p_flow_start) + 100 "Начальная энтальпия вода/пар" annotation(
      Dialog(tab = "Initialization"));
    inner parameter Modelica.SIunits.AbsolutePressure p_flow_start = system.p_start "Начальное давление вода/пар" annotation(
      Dialog(tab = "Initialization"));
    inner parameter Modelica.SIunits.MassFlowRate m_flow_start = system.m_flow_start "Начальный массовый расход вода/пар" annotation(
      Dialog(tab = "Initialization"));
    inner parameter Modelica.SIunits.Temperature T_m_start = system.T_start "Начальная температура металла вода/пар" annotation(
      Dialog(tab = "Initialization"));
    inner parameter Modelica.SIunits.Temperature T_sodium_start = system.T_start "Начальная температура натрия" annotation(
      Dialog(tab = "Initialization"));
    inner parameter Modelica.SIunits.AbsolutePressure p_sodium_start = system.p_start "Начальное давление натрия" annotation(
      Dialog(tab = "Initialization"));
    //Интерфейс
    outer Modelica.Fluid.System system;
  end BaseSteamGenerator;
end BaseClases;
