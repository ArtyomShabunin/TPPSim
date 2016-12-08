package MyHRSG_lite
  model ExhaustGas
    import Modelica.Media.IdealGases.Common;
    extends Common.MixtureGasNasa(mediumName = "ExhaustGas", data = {Common.SingleGasesData.O2, Common.SingleGasesData.CO2, Common.SingleGasesData.H2O, Common.SingleGasesData.N2, Common.SingleGasesData.Ar, Common.SingleGasesData.SO2}, fluidConstants = {Common.FluidData.O2, Common.FluidData.CO2, Common.FluidData.H2O, Common.FluidData.N2, Common.FluidData.Ar, Common.FluidData.SO2}, substanceNames = {"Oxygen", "Carbondioxide", "Water", "Nitrogen", "Argon", "Sulfurdioxide"}, reference_X = {0.1383, 0.032, 0.0688, 1 - 0.1383 - 0.032 - 0.0688 - 0.0000000001 - 0.0000000001, 0.0000000001, 0.0000000001});
    annotation(Documentation(info = "<html>
</html>"));
  end ExhaustGas;

  function phi_heatedPipe "Функция для расчета коэффициента phi к формуле расчета потерь трения при течении двухфазного потока в обогреваемой трубе (оцифровка номограммы 5а из гидравлического расчета котельных агрегатов)"
    extends Modelica.Icons.Function;
    input Real wrhop;
    input Real p "Давление в кгс/см2";
    input Real x;
    output Real phi;
  protected
    Real p_up;
    Real p_down;
    Real phi_up "phi расчитанное по ф-ле для wrhop_up для интерполяции";
    Real phi_down "phi расчитанное по ф-ле для wrop_down для интерполяции";
    Real wrhop_up "wrhop большее чем заданное, из номограммы 5";
    Real wrhop_down "wrhop меньшее чем заданное, из номограммы 5";
    Real phi_less180_up;
    Real phi_less180_down;
    Real phi_less180 "phi для давления меньше 180 кгс/см2";
  algorithm
//Оцифровка левой части (Р < 180) диаграммы 5а (Нормативный метод гидравлического расчета котельных агрегатов (1978))
    if wrhop >= 300 then
      wrhop_up := 400;
      phi_less180_up := if x >= 0.077 then 1.7326735348 * x ^ 4 - 4.2892926077 * x ^ 3 + 4.5140570635 * x ^ 2 - 2.6239534310 * x + 1.1783239733 else 1;
      wrhop_down := 300;
      phi_less180_down := if x >= 0.077 then 1.7326735348 * x ^ 4 - 4.2892926077 * x ^ 3 + 4.5140570635 * x ^ 2 - 2.6239534310 * x + 1.1783239733 else 1;
    elseif wrhop < 300 and wrhop >= 260 then
      wrhop_up := 300;
      phi_less180_up := if x >= 0.077 then 1.7326735348 * x ^ 4 - 4.2892926077 * x ^ 3 + 4.5140570635 * x ^ 2 - 2.6239534310 * x + 1.1783239733 else 1;
      wrhop_down := 260;
      phi_less180_down := if x >= 0.102 then 1.4513971826 * x ^ 4 - 3.5387206445 * x ^ 3 + 3.8180468410 * x ^ 2 - 2.3764538834 * x + 1.2059010954 else 1;
    elseif wrhop < 260 and wrhop >= 240 then
      wrhop_up := 260;
      phi_less180_up := if x >= 0.102 then 1.4513971826 * x ^ 4 - 3.5387206445 * x ^ 3 + 3.8180468410 * x ^ 2 - 2.3764538834 * x + 1.2059010954 else 1;
      wrhop_down := 240;
      phi_less180_down := if x >= 0.118 then 1.7337140333 * x ^ 4 - 4.1183545121 * x ^ 3 + 4.2222156937 * x ^ 2 - 2.4782615093 * x + 1.2384507739 else 1;
    elseif wrhop < 240 and wrhop >= 220 then
      wrhop_up := 240;
      phi_less180_up := if x >= 0.118 then 1.7337140333 * x ^ 4 - 4.1183545121 * x ^ 3 + 4.2222156937 * x ^ 2 - 2.4782615093 * x + 1.2384507739 else 1;
      wrhop_down := 220;
      phi_less180_down := if x >= 0.134 then 1.8386110496 * x ^ 4 - 4.3424422808 * x ^ 3 + 4.3999276658 * x ^ 2 - 2.5337516786 * x + 1.2690488813 else 1;
    elseif wrhop < 220 and wrhop >= 200 then
      wrhop_up := 220;
      phi_less180_up := if x >= 0.134 then 1.8386110496 * x ^ 4 - 4.3424422808 * x ^ 3 + 4.3999276658 * x ^ 2 - 2.5337516786 * x + 1.2690488813 else 1;
      wrhop_down := 200;
      phi_less180_down := if x >= 0.147 then 1.4219712545 * x ^ 4 - 3.3261748246 * x ^ 3 + 3.5532256217 * x ^ 2 - 2.2303203025 * x + 1.2605298510 else 1;
    elseif wrhop < 200 and wrhop >= 180 then
      wrhop_up := 200;
      phi_less180_up := if x >= 0.147 then 1.4219712545 * x ^ 4 - 3.3261748246 * x ^ 3 + 3.5532256217 * x ^ 2 - 2.2303203025 * x + 1.2605298510 else 1;
      wrhop_down := 180;
      phi_less180_down := if x >= 0.168 then 1.4930025266 * x ^ 4 - 3.6239432394 * x ^ 3 + 3.8621639609 * x ^ 2 - 2.2996291408 * x + 1.2931208181 else 1;
    elseif wrhop < 180 and wrhop >= 160 then
      wrhop_up := 180;
      phi_less180_up := if x >= 0.168 then 1.4930025266 * x ^ 4 - 3.6239432394 * x ^ 3 + 3.8621639609 * x ^ 2 - 2.2996291408 * x + 1.2931208181 else 1;
      wrhop_down := 160;
      phi_less180_down := if x >= 0.19 then 1.4298209842 * x ^ 4 - 3.4050752571 * x ^ 3 + 3.5399754890 * x ^ 2 - 2.0595533382 * x + 1.2840925182 else 1;
    elseif wrhop < 160 and wrhop >= 150 then
      wrhop_up := 160;
      phi_less180_up := if x >= 0.19 then 1.4298209842 * x ^ 4 - 3.4050752571 * x ^ 3 + 3.5399754890 * x ^ 2 - 2.0595533382 * x + 1.2840925182 else 1;
      wrhop_down := 150;
      phi_less180_down := if x >= 0.214 then 2.3694725716 * x ^ 4 - 5.3818366810 * x ^ 3 + 4.8445067447 * x ^ 2 - 2.3192050299 * x + 1.3216168513 else 1;
    elseif wrhop < 150 and wrhop >= 140 then
      wrhop_up := 150;
      phi_less180_up := if x >= 0.214 then 2.3694725716 * x ^ 4 - 5.3818366810 * x ^ 3 + 4.8445067447 * x ^ 2 - 2.3192050299 * x + 1.3216168513 else 1;
      wrhop_down := 140;
      phi_less180_down := if x >= 0.244 then 0.0853282028 * x ^ 4 + 0.07409610708 * x ^ 3 + 0.1991497509 * x ^ 2 - 0.6125891375 * x + 1.1361515441 else 1;
    elseif wrhop < 140 and wrhop >= 130 then
      wrhop_up := 140;
      phi_less180_up := if x >= 0.244 then 0.0853282028 * x ^ 4 + 0.07409610708 * x ^ 3 + 0.1991497509 * x ^ 2 - 0.6125891375 * x + 1.1361515441 else 1;
      wrhop_down := 130;
      phi_less180_down := if x >= 0.304 then 0.6797707858 * x ^ 4 - 1.7043172696 * x ^ 3 + 1.9464370756 * x ^ 2 - 1.2184246841 * x + 1.2322690806 else 1;
    elseif wrhop < 130 and wrhop >= 125 then
      wrhop_up := 130;
      phi_less180_up := if x >= 0.304 then 0.6797707858 * x ^ 4 - 1.7043172696 * x ^ 3 + 1.9464370756 * x ^ 2 - 1.2184246841 * x + 1.2322690806 else 1;
      wrhop_down := 125;
      phi_less180_down := if x >= 0.356 then 0.6148375351 * x ^ 4 - 1.5791519021 * x ^ 3 + 1.8400903024 * x ^ 2 - 1.1333788283 * x + 1.2316231629 else 1;
    elseif wrhop < 125 and wrhop >= 120 then
      wrhop_up := 125;
      phi_less180_up := if x >= 0.356 then 0.6148375351 * x ^ 4 - 1.5791519021 * x ^ 3 + 1.8400903024 * x ^ 2 - 1.1333788283 * x + 1.2316231629 else 1;
      wrhop_down := 120;
      phi_less180_down := 1;
    elseif wrhop < 120 and wrhop >= 110 then
      wrhop_up := 120;
      phi_less180_up := 1;
      wrhop_down := 110;
      phi_less180_down := (-0.0620371743 * x ^ 4) + 0.0143877246 * x ^ 3 + 0.0045396916 * x ^ 2 - 0.0041319291 * x + 1.1023521492;
    elseif wrhop < 110 and wrhop >= 100 then
      wrhop_up := 110;
      phi_less180_up := (-0.0620371743 * x ^ 4) + 0.0143877246 * x ^ 3 + 0.0045396916 * x ^ 2 - 0.0041319291 * x + 1.1023521492;
      wrhop_down := 100;
      phi_less180_down := (-0.2125876214 * x ^ 4) + 0.2310174677 * x ^ 3 - 0.0938761376 * x ^ 2 + 0.0171025286 * x + 1.1789805166;
    elseif wrhop < 100 and wrhop >= 90 then
      wrhop_up := 100;
      phi_less180_up := (-0.2125876214 * x ^ 4) + 0.2310174677 * x ^ 3 - 0.0938761376 * x ^ 2 + 0.0171025286 * x + 1.1789805166;
      wrhop_down := 90;
      phi_less180_down := (-0.3803668297 * x ^ 4) + 0.5649203234 * x ^ 3 - 0.2855069360 * x ^ 2 + 0.0465697023 * x + 1.2283165978;
    elseif wrhop < 90 and wrhop >= 80 then
      wrhop_up := 90;
      phi_less180_up := (-0.3803668297 * x ^ 4) + 0.5649203234 * x ^ 3 - 0.2855069360 * x ^ 2 + 0.0465697023 * x + 1.2283165978;
      wrhop_down := 80;
      phi_less180_down := (-0.4103774225 * x ^ 4) + 0.5791958019 * x ^ 3 - 0.2749076196 * x ^ 2 + 0.0390357265 * x + 1.30025436128;
    elseif wrhop < 80 and wrhop >= 70 then
      wrhop_up := 80;
      phi_less180_up := (-0.4103774225 * x ^ 4) + 0.5791958019 * x ^ 3 - 0.2749076196 * x ^ 2 + 0.0390357265 * x + 1.30025436128;
      wrhop_down := 70;
      phi_less180_down := (-0.4876399173 * x ^ 4) + 0.7254330563 * x ^ 3 - 0.3482365887 * x ^ 2 + 0.0491618028 * x + 1.3496682544;
    elseif wrhop < 70 and wrhop >= 60 then
      wrhop_up := 70;
      phi_less180_up := (-0.4876399173 * x ^ 4) + 0.7254330563 * x ^ 3 - 0.3482365887 * x ^ 2 + 0.0491618028 * x + 1.3496682544;
      wrhop_down := 60;
      phi_less180_down := (-0.4555512967 * x ^ 4) + 0.6412893137 * x ^ 3 - 0.2929308789 * x ^ 2 + 0.0392568200 * x + 1.3993462281;
    elseif wrhop < 60 and wrhop >= 50 then
      wrhop_up := 60;
      phi_less180_up := (-0.4555512967 * x ^ 4) + 0.6412893137 * x ^ 3 - 0.2929308789 * x ^ 2 + 0.0392568200 * x + 1.3993462281;
      wrhop_down := 50;
      phi_less180_down := (-0.6321126834 * x ^ 4) + 0.9668229999 * x ^ 3 - 0.4655184559 * x ^ 2 + 0.0654015637 * x + 1.4396176158;
    elseif wrhop < 50 and wrhop >= 40 then
      wrhop_up := 50;
      phi_less180_up := (-0.6321126834 * x ^ 4) + 0.9668229999 * x ^ 3 - 0.4655184559 * x ^ 2 + 0.0654015637 * x + 1.4396176158;
      wrhop_down := 40;
      phi_less180_down := (-0.4670410259 * x ^ 4) + 0.6443808260 * x ^ 3 - 0.2803329356 * x ^ 2 + 0.0367508367 * x + 1.4804057664;
    elseif wrhop < 40 and wrhop >= 30 then
      wrhop_up := 40;
      phi_less180_up := (-0.4670410259 * x ^ 4) + 0.6443808260 * x ^ 3 - 0.2803329356 * x ^ 2 + 0.0367508367 * x + 1.4804057664;
      wrhop_down := 30;
      phi_less180_down := (-0.4770593418 * x ^ 4) + 0.6707145924 * x ^ 3 - 0.2782995210 * x ^ 2 + 0.0343904964 * x + 1.4984705199;
    elseif wrhop < 30 then
      wrhop_up := 30;
      phi_less180_up := (-0.4770593418 * x ^ 4) + 0.6707145924 * x ^ 3 - 0.2782995210 * x ^ 2 + 0.0343904964 * x + 1.4984705199;
      wrhop_down := 20;
      phi_less180_down := (-0.4770593418 * x ^ 4) + 0.6707145924 * x ^ 3 - 0.2782995210 * x ^ 2 + 0.0343904964 * x + 1.4984705199;
    end if;
    phi_less180 := phi_less180_down + (wrhop - wrhop_down) * (phi_less180_up - phi_less180_down) / (wrhop_up - wrhop_down) "Расчет phi для давления меньше 180 кгс/см2";
//Оцифровка правой части (Р > 180) диаграммы 5а (Нормативный метод гидравлического расчета котельных агрегатов (1978))
    if p < 180 then
      p_up := 180;
      phi_up := phi_less180;
      p_down := 170;
      phi_down := phi_less180;
    elseif p >= 180 and p < 190 then
      p_up := 190;
      phi_up := 0.5519859872 * phi_less180 ^ 3 - 1.6482979996 * phi_less180 ^ 2 + 2.4385239509 * phi_less180 - 0.3418330801;
      p_down := 180;
      phi_down := 0.9971503617 * phi_less180 + 0.0042472870;
    elseif p >= 190 and p < 200 then
      p_up := 200;
      phi_up := 0.7054219388 * phi_less180 ^ 3 - 2.1155986359 * phi_less180 ^ 2 + 2.7218648407 * phi_less180 - 0.3075156641;
      p_down := 190;
      phi_down := 0.5519859872 * phi_less180 ^ 3 - 1.6482979996 * phi_less180 ^ 2 + 2.4385239509 * phi_less180 - 0.3418330801;
    elseif p >= 200 and p < 210 then
      p_up := 210;
      phi_up := 0.7525810088 * phi_less180 ^ 3 - 2.2381909015 * phi_less180 ^ 2 + 2.5724339224 * phi_less180 - 0.0848064371;
      p_down := 200;
      phi_down := 0.7054219388 * phi_less180 ^ 3 - 2.1155986359 * phi_less180 ^ 2 + 2.7218648407 * phi_less180 - 0.3075156641;
    elseif p >= 210 and p < 220 then
      p_up := 220;
      phi_up := 0.4488108026 * phi_less180 ^ 3 - 1.3484765978 * phi_less180 ^ 2 + 1.4418111541 * phi_less180 + 0.4601807173;
      p_down := 210;
      phi_down := 0.7525810088 * phi_less180 ^ 3 - 2.2381909015 * phi_less180 ^ 2 + 2.5724339224 * phi_less180 - 0.0848064371;
    elseif p >= 220 and p < 225 then
      p_up := 225;
      phi_up := 1;
      p_down := 220;
      phi_down := 0.4488108026 * phi_less180 ^ 3 - 1.3484765978 * phi_less180 ^ 2 + 1.4418111541 * phi_less180 + 0.4601807173;
    elseif p >= 225 then
      p_up := 230;
      phi_up := 1;
      p_down := 225;
      phi_down := 1;
    end if;
    phi := phi_down + (wrhop - wrhop_down) * (phi_up - phi_down) / (wrhop_up - wrhop_down) "Расчет phi для давления больше 180 кгс/см2 (итоговое phi)";
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end phi_heatedPipe;

  function phi_notHeatedPipe "Функция для расчета коэффициента phi к формуле расчета потерь трения при течении двухфазного потока в необогреваемой трубе (оцифровка номограммы 5б из гидравлического расчета котельных агрегатов)"
    extends Modelica.Icons.Function;
    input Real wrhop;
    input Real p "Давление в кгс/см2";
    input Real x;
    output Real phi;
  protected
    Real p_up;
    Real p_down;
    Real phi_up "phi расчитанное по ф-ле для wrhop_up для интерполяции";
    Real phi_down "phi расчитанное по ф-ле для wrop_down для интерполяции";
    Real wrhop_up "wrhop большее чем заданное, из номограммы 5";
    Real wrhop_down "wrhop меньшее чем заданное, из номограммы 5";
    Real phi_less180_up;
    Real phi_less180_down;
    Real phi_less180 "phi для давления меньше 180 кгс/см2";
  algorithm
//Оцифровка левой части (Р < 180) диаграммы 5а (Нормативный метод гидравлического расчета котельных агрегатов (1978))
    if wrhop >= 300 then
      wrhop_up := 400;
      phi_less180_up := if x >= 0.929 then (1.1160112 + 2.7703818 * x ^ 2 - 3.7359854 * x ^ 4) / (1 + 16.431491 * x ^ 2 - 27.563562 * x ^ 4 + 10.289915 * x ^ 6) else 1;
      wrhop_down := 300;
      phi_less180_down := if x >= 0.929 then (1.1160112 + 2.7703818 * x ^ 2 - 3.7359854 * x ^ 4) / (1 + 16.431491 * x ^ 2 - 27.563562 * x ^ 4 + 10.289915 * x ^ 6) else 1;
    elseif wrhop < 300 and wrhop >= 260 then
      wrhop_up := 300;
      phi_less180_up := if x >= 0.929 then (1.1160112 + 2.7703818 * x ^ 2 - 3.7359854 * x ^ 4) / (1 + 16.431491 * x ^ 2 - 27.563562 * x ^ 4 + 10.289915 * x ^ 6) else 1;
      wrhop_down := 260;
      phi_less180_down := if x >= 0.108 then (0.89708298 + 4.7982936 * x - 5.5133864 * x ^ 2 - 0.1447869 * x ^ 3) / (1 - 0.34467125 * x + 41.209031 * x ^ 2 - 75.500433 * x ^ 3 + 33.673279 * x ^ 4) else 1;
    elseif wrhop < 260 and wrhop >= 240 then
      wrhop_up := 260;
      phi_less180_up := if x >= 0.108 then (0.89708298 + 4.7982936 * x - 5.5133864 * x ^ 2 - 0.1447869 * x ^ 3) / (1 - 0.34467125 * x + 41.209031 * x ^ 2 - 75.500433 * x ^ 3 + 33.673279 * x ^ 4) else 1;
      wrhop_down := 240;
      phi_less180_down := if x >= 0.115 then (0.97663388 - 9.9736014 * x + 59.557372 * x ^ 2 - 125.45315 * x ^ 3 + 131.23507 * x ^ 4 - 55.657059 * x ^ 5) / (1 - 10.258929 * x + 55.422401 * x ^ 2 - 75.587534 * x ^ 3 + 61.763853 * x ^ 4 - 31.654485 * x ^ 5) else 1;
    elseif wrhop < 240 and wrhop >= 220 then
      wrhop_up := 240;
      phi_less180_up := if x >= 0.115 then (0.97663388 - 9.9736014 * x + 59.557372 * x ^ 2 - 125.45315 * x ^ 3 + 131.23507 * x ^ 4 - 55.657059 * x ^ 5) / (1 - 10.258929 * x + 55.422401 * x ^ 2 - 75.587534 * x ^ 3 + 61.763853 * x ^ 4 - 31.654485 * x ^ 5) else 1;
      wrhop_down := 220;
      phi_less180_down := if x >= 0.132 then ((-10.228577) + 4319.6549 * x ^ 2 + 24312.406 * x ^ 4 + 8579.2181 * x ^ 6 - 28234.741 * x ^ 8) / (1 + 2900.7944 * x ^ 2 + 69269.534 * x ^ 4 - 18788.349 * x ^ 6 - 44408.746 * x ^ 8) else 1;
    elseif wrhop < 220 and wrhop >= 200 then
      wrhop_up := 220;
      phi_less180_up := if x >= 0.132 then ((-10.228577) + 4319.6549 * x ^ 2 + 24312.406 * x ^ 4 + 8579.2181 * x ^ 6 - 28234.741 * x ^ 8) / (1 + 2900.7944 * x ^ 2 + 69269.534 * x ^ 4 - 18788.349 * x ^ 6 - 44408.746 * x ^ 8) else 1;
      wrhop_down := 200;
      phi_less180_down := if x >= 0.156 then (0.66843259 - 2.7713756 * x ^ 0.5 + 4.4386535 * x - 2.2781927 * x ^ 1.5) / (1 - 4.9010314 * x ^ 0.5 + 8.6644624 * x - 4.7063616 * x ^ 1.5) else 1;
    elseif wrhop < 200 and wrhop >= 180 then
      wrhop_up := 200;
      phi_less180_up := if x >= 0.156 then (0.66843259 - 2.7713756 * x ^ 0.5 + 4.4386535 * x - 2.2781927 * x ^ 1.5) / (1 - 4.9010314 * x ^ 0.5 + 8.6644624 * x - 4.7063616 * x ^ 1.5) else 1;
      wrhop_down := 180;
      phi_less180_down := if x >= 0.171 then ((-105.09791) + 1693.3173 * x - 4686.1774 * x ^ 2 + 5625.4262 * x ^ 3 - 2917.844 * x ^ 4 + 528.13081 * x ^ 5) / (1 + 4.3959294 * x + 4334.0874 * x ^ 2 - 13495.12 * x ^ 3 + 15239.466 * x ^ 4 - 5946.089 * x ^ 5) else 1;
    elseif wrhop < 180 and wrhop >= 160 then
      wrhop_up := 180;
      phi_less180_up := if x >= 0.171 then ((-105.09791) + 1693.3173 * x - 4686.1774 * x ^ 2 + 5625.4262 * x ^ 3 - 2917.844 * x ^ 4 + 528.13081 * x ^ 5) / (1 + 4.3959294 * x + 4334.0874 * x ^ 2 - 13495.12 * x ^ 3 + 15239.466 * x ^ 4 - 5946.089 * x ^ 5) else 1;
      wrhop_down := 160;
      phi_less180_down := if x >= 0.191 then (1.3019518 - 5.8689682 * x + 11.073734 * x ^ 2 - 9.6200996 * x ^ 3 + 3.1209569 * x ^ 4) / (1 - 3.1240685 * x + 3.1773507 * x ^ 2 + 1.2499544 * x ^ 3 - 4.3773472 * x ^ 4 + 2.0816853 * x ^ 5) else 1;
    elseif wrhop < 160 and wrhop >= 150 then
      wrhop_up := 160;
      phi_less180_up := if x >= 0.191 then (1.3019518 - 5.8689682 * x + 11.073734 * x ^ 2 - 9.6200996 * x ^ 3 + 3.1209569 * x ^ 4) / (1 - 3.1240685 * x + 3.1773507 * x ^ 2 + 1.2499544 * x ^ 3 - 4.3773472 * x ^ 4 + 2.0816853 * x ^ 5) else 1;
      wrhop_down := 150;
      phi_less180_down := if x >= 0.214 then 1.1679896 - 4.6977502 * x ^ 2 + 26.60315 * x ^ 4 - 112.12267 * x ^ 6 + 371.00488 * x ^ 8 - 891.73597 * x ^ 10 + 1472.4046 * x ^ 12 - 1608.2865 * x ^ 14 + 1103.7726 * x ^ 16 - 428.09003 * x ^ 18 + 70.97972 * x ^ 20 else 1;
    elseif wrhop < 150 and wrhop >= 140 then
      wrhop_up := 150;
      phi_less180_up := if x >= 0.214 then 1.1679896 - 4.6977502 * x ^ 2 + 26.60315 * x ^ 4 - 112.12267 * x ^ 6 + 371.00488 * x ^ 8 - 891.73597 * x ^ 10 + 1472.4046 * x ^ 12 - 1608.2865 * x ^ 14 + 1103.7726 * x ^ 16 - 428.09003 * x ^ 18 + 70.97972 * x ^ 20 else 1;
      wrhop_down := 140;
      phi_less180_down := if x >= 0.237 then 1.1802356 - 4.2276943 * x ^ 2 + 20.300278 * x ^ 4 - 45.089744 * x ^ 6 + 17.620965 * x ^ 8 + 137.10003 * x ^ 10 - 324.4792 * x ^ 12 + 329.13172 * x ^ 14 - 161.31303 * x ^ 16 + 30.776496 * x ^ 18 else 1;
    elseif wrhop < 140 and wrhop >= 130 then
      wrhop_up := 140;
      phi_less180_up := if x >= 0.237 then 1.1802356 - 4.2276943 * x ^ 2 + 20.300278 * x ^ 4 - 45.089744 * x ^ 6 + 17.620965 * x ^ 8 + 137.10003 * x ^ 10 - 324.4792 * x ^ 12 + 329.13172 * x ^ 14 - 161.31303 * x ^ 16 + 30.776496 * x ^ 18 else 1;
      wrhop_down := 130;
      phi_less180_down := if x >= 0.263 then 1.2828416 - 7.046377 * x ^ 2 + 58.757998 * x ^ 4 - 284.95031 * x ^ 6 + 857.02366 * x ^ 8 - 1635.9503 * x ^ 10 + 1978.2262 * x ^ 12 - 1464.9664 * x ^ 14 + 605.8126 * x ^ 16 - 107.18998 * x ^ 18 else 1;
    elseif wrhop < 130 and wrhop >= 125 then
      wrhop_up := 130;
      phi_less180_up := if x >= 0.263 then 1.2828416 - 7.046377 * x ^ 2 + 58.757998 * x ^ 4 - 284.95031 * x ^ 6 + 857.02366 * x ^ 8 - 1635.9503 * x ^ 10 + 1978.2262 * x ^ 12 - 1464.9664 * x ^ 14 + 605.8126 * x ^ 16 - 107.18998 * x ^ 18 else 1;
      wrhop_down := 125;
      phi_less180_down := if x >= 0.282 then 14.944683 - 239.05789 * x + 1811.9863 * x ^ 2 - 7974.3565 * x ^ 3 + 22512.542 * x ^ 4 - 42560.432 * x ^ 5 + 54537.298 * x ^ 6 - 46751.885 * x ^ 7 + 25647.917 * x ^ 8 - 8126.1591 * x ^ 9 + 1128.202 * x ^ 10 else 1;
    elseif wrhop < 125 and wrhop >= 120 then
      wrhop_up := 125;
      phi_less180_up := if x >= 0.282 then 14.944683 - 239.05789 * x + 1811.9863 * x ^ 2 - 7974.3565 * x ^ 3 + 22512.542 * x ^ 4 - 42560.432 * x ^ 5 + 54537.298 * x ^ 6 - 46751.885 * x ^ 7 + 25647.917 * x ^ 8 - 8126.1591 * x ^ 9 + 1128.202 * x ^ 10 else 1;
      wrhop_down := 120;
      phi_less180_down := 1;
    elseif wrhop < 120 and wrhop >= 110 then
      wrhop_up := 120;
      phi_less180_up := 1;
      wrhop_down := 110;
      phi_less180_down := 1.1000165 + 0.00035623019 * x ^ 2 - 0.068572729 * x ^ 4 + 0.92075497 * x ^ 6 - 3.9692 * x ^ 8 + 6.6865532 * x ^ 10 - 5.1926831 * x ^ 12 + 1.5227299 * x ^ 14;
    elseif wrhop < 110 and wrhop >= 100 then
      wrhop_up := 110;
      phi_less180_up := 1.1000165 + 0.00035623019 * x ^ 2 - 0.068572729 * x ^ 4 + 0.92075497 * x ^ 6 - 3.9692 * x ^ 8 + 6.6865532 * x ^ 10 - 5.1926831 * x ^ 12 + 1.5227299 * x ^ 14;
      wrhop_down := 100;
      phi_less180_down := (1.176932 - 7.7893552 * x ^ 2 + 21.118695 * x ^ 4 - 21.656887 * x ^ 6 + 7.5845347 * x ^ 8) / (1 - 6.6156743 * x ^ 2 + 17.919908 * x ^ 4 - 18.359876 * x ^ 6 + 6.4895739 * x ^ 8);
    elseif wrhop < 100 and wrhop >= 90 then
      wrhop_up := 100;
      phi_less180_up := (1.176932 - 7.7893552 * x ^ 2 + 21.118695 * x ^ 4 - 21.656887 * x ^ 6 + 7.5845347 * x ^ 8) / (1 - 6.6156743 * x ^ 2 + 17.919908 * x ^ 4 - 18.359876 * x ^ 6 + 6.4895739 * x ^ 8);
      wrhop_down := 90;
      phi_less180_down := (1.2311741 - 9.5633564 * x ^ 2 + 28.305015 * x ^ 4 - 39.306465 * x ^ 6 + 25.987068 * x ^ 8 - 6.6531902 * x ^ 10) / (1 - 7.7715677 * x ^ 2 + 23.02875 * x ^ 4 - 32.064249 * x ^ 6 + 21.319708 * x ^ 8 - 5.5123967 * x ^ 10);
    elseif wrhop < 90 and wrhop >= 80 then
      wrhop_up := 90;
      phi_less180_up := (1.2311741 - 9.5633564 * x ^ 2 + 28.305015 * x ^ 4 - 39.306465 * x ^ 6 + 25.987068 * x ^ 8 - 6.6531902 * x ^ 10) / (1 - 7.7715677 * x ^ 2 + 23.02875 * x ^ 4 - 32.064249 * x ^ 6 + 21.319708 * x ^ 8 - 5.5123967 * x ^ 10);
      wrhop_down := 80;
      phi_less180_down := (1.300727618 - 7.19037357 * x ^ 0.5 + 15.88632448 * x - 17.5216916 * x ^ 1.5 + 9.64255146 * x ^ 2 - 2.1175309 * x ^ 2.5) / (1 - 5.52752683 * x ^ 0.5 + 12.21139391 * x - 13.4672713 * x ^ 1.5 + 7.410713972 * x ^ 2 - 1.6273023 * x ^ 2.5);
    elseif wrhop < 80 and wrhop >= 70 then
      wrhop_up := 80;
      phi_less180_up := (1.300727618 - 7.19037357 * x ^ 0.5 + 15.88632448 * x - 17.5216916 * x ^ 1.5 + 9.64255146 * x ^ 2 - 2.1175309 * x ^ 2.5) / (1 - 5.52752683 * x ^ 0.5 + 12.21139391 * x - 13.4672713 * x ^ 1.5 + 7.410713972 * x ^ 2 - 1.6273023 * x ^ 2.5);
      wrhop_down := 70;
      phi_less180_down := (1.3511004 + 1.709817 * x - 6.8822576 * x ^ 2 + 3.8771043 * x ^ 3) / (1 + 1.2702537 * x - 5.1206003 * x ^ 2 + 2.9061398 * x ^ 3);
    elseif wrhop < 70 and wrhop >= 60 then
      wrhop_up := 70;
      phi_less180_up := (1.3511004 + 1.709817 * x - 6.8822576 * x ^ 2 + 3.8771043 * x ^ 3) / (1 + 1.2702537 * x - 5.1206003 * x ^ 2 + 2.9061398 * x ^ 3);
      wrhop_down := 60;
      phi_less180_down := 1.3991448 + 0.02911584 * x ^ 2 - 1.181137 * x ^ 4 + 17.50421 * x ^ 6 - 126.72684 * x ^ 8 + 513.32985 * x ^ 10 - 1242.665 * x ^ 12 + 1825.7391 * x ^ 14 - 1590.4492 * x ^ 16 + 752.87429 * x ^ 18 - 148.85355 * x ^ 20;
    elseif wrhop < 60 and wrhop >= 50 then
      wrhop_up := 60;
      phi_less180_up := 1.3991448 + 0.02911584 * x ^ 2 - 1.181137 * x ^ 4 + 17.50421 * x ^ 6 - 126.72684 * x ^ 8 + 513.32985 * x ^ 10 - 1242.665 * x ^ 12 + 1825.7391 * x ^ 14 - 1590.4492 * x ^ 16 + 752.87429 * x ^ 18 - 148.85355 * x ^ 20;
      wrhop_down := 50;
      phi_less180_down := (1.441734 - 6.4053556 * x + 10.566088 * x ^ 2 - 7.6647504 * x ^ 3 + 2.0641227 * x ^ 4) / (1 - 4.4371009 * x + 7.2911442 * x ^ 2 - 5.2248014 * x ^ 3 + 1.3339947 * x ^ 4 + 0.038603441 * x ^ 5);
    elseif wrhop < 50 and wrhop >= 40 then
      wrhop_up := 50;
      phi_less180_up := (1.441734 - 6.4053556 * x + 10.566088 * x ^ 2 - 7.6647504 * x ^ 3 + 2.0641227 * x ^ 4) / (1 - 4.4371009 * x + 7.2911442 * x ^ 2 - 5.2248014 * x ^ 3 + 1.3339947 * x ^ 4 + 0.038603441 * x ^ 5);
      wrhop_down := 40;
      phi_less180_down := (1.4795265 - 7.1692594 * x ^ 2 + 12.697645 * x ^ 4 - 9.6627311 * x ^ 6 + 2.6719018 * x ^ 8) / (1 - 4.8441344 * x ^ 2 + 8.5640741 * x ^ 4 - 6.4576876 * x ^ 6 + 1.6869312 * x ^ 8 + 0.067906062 * x ^ 10);
    elseif wrhop < 40 and wrhop >= 30 then
      wrhop_up := 40;
      phi_less180_up := (1.4795265 - 7.1692594 * x ^ 2 + 12.697645 * x ^ 4 - 9.6627311 * x ^ 6 + 2.6719018 * x ^ 8) / (1 - 4.8441344 * x ^ 2 + 8.5640741 * x ^ 4 - 6.4576876 * x ^ 6 + 1.6869312 * x ^ 8 + 0.067906062 * x ^ 10);
      wrhop_down := 30;
      phi_less180_down := (1.5002909 - 8.7863495 * x ^ 2 + 20.649298 * x ^ 4 - 24.343014 * x ^ 6 + 14.39313 * x ^ 8 - 3.4128172 * x ^ 10) / (1 - 5.853886 * x ^ 2 + 13.74732 * x ^ 4 - 16.187379 * x ^ 6 + 9.5541865 * x ^ 8 - 2.2597026 * x ^ 10);
    elseif wrhop < 30 then
      wrhop_up := 30;
      phi_less180_up := (1.5002909 - 8.7863495 * x ^ 2 + 20.649298 * x ^ 4 - 24.343014 * x ^ 6 + 14.39313 * x ^ 8 - 3.4128172 * x ^ 10) / (1 - 5.853886 * x ^ 2 + 13.74732 * x ^ 4 - 16.187379 * x ^ 6 + 9.5541865 * x ^ 8 - 2.2597026 * x ^ 10);
      wrhop_down := 20;
      phi_less180_down := (1.5002909 - 8.7863495 * x ^ 2 + 20.649298 * x ^ 4 - 24.343014 * x ^ 6 + 14.39313 * x ^ 8 - 3.4128172 * x ^ 10) / (1 - 5.853886 * x ^ 2 + 13.74732 * x ^ 4 - 16.187379 * x ^ 6 + 9.5541865 * x ^ 8 - 2.2597026 * x ^ 10);
    end if;
    phi_less180 := phi_less180_down + (wrhop - wrhop_down) * (phi_less180_up - phi_less180_down) / (wrhop_up - wrhop_down) "Расчет phi для давления меньше 180 кгс/см2";
//Оцифровка правой части (Р > 180) диаграммы 5б (Нормативный метод гидравлического расчета котельных агрегатов (1978))
    if p < 180 then
      p_up := 180;
      phi_up := phi_less180;
      p_down := 170;
      phi_down := phi_less180;
    elseif p >= 180 and p < 190 then
      p_up := 190;
      phi_up := ((-0.38727116) + 3.7172002 * phi_less180 ^ 2 - 5.7810724 * phi_less180 ^ 4 + 2.6277926 * phi_less180 ^ 6 - 0.0074910401 * phi_less180 ^ 8) / (1 + 0.35659014 * phi_less180 ^ 2 - 3.7227101 * phi_less180 ^ 4 + 3.2206161 * phi_less180 ^ 6 - 0.77120666 * phi_less180 ^ 8 + 0.085440751 * phi_less180 ^ 10);
      p_down := 180;
      phi_down := 1.6683 * phi_less180 - 0.6669;
    elseif p >= 190 and p < 200 then
      p_up := 200;
      phi_up := ((-0.56499308) + 3.8637496 * phi_less180 - 9.170028 * phi_less180 ^ 2 + 10.20122 * phi_less180 ^ 3 - 5.4998541 * phi_less180 ^ 4 + 1.1716854 * phi_less180 ^ 5) / (1 - 3.237545 * phi_less180 + 3.8132513 * phi_less180 ^ 2 - 1.771051 * phi_less180 ^ 3 + 0.076441418 * phi_less180 ^ 4 + 0.12067979 * phi_less180 ^ 5);
      p_down := 190;
      phi_down := ((-0.38727116) + 3.7172002 * phi_less180 ^ 2 - 5.7810724 * phi_less180 ^ 4 + 2.6277926 * phi_less180 ^ 6 - 0.0074910401 * phi_less180 ^ 8) / (1 + 0.35659014 * phi_less180 ^ 2 - 3.7227101 * phi_less180 ^ 4 + 3.2206161 * phi_less180 ^ 6 - 0.77120666 * phi_less180 ^ 8 + 0.085440751 * phi_less180 ^ 10);
    elseif p >= 200 and p < 210 then
      p_up := 210;
      phi_up := ((-0.23022792) + 1.8670365 * phi_less180 - 2.7284609 * phi_less180 ^ 2 + 1.1370724 * phi_less180 ^ 3 + 0.030002178 * phi_less180 ^ 4) / (1 - 2.3906129 * phi_less180 + 3.3062657 * phi_less180 ^ 2 - 3.4844912 * phi_less180 ^ 3 + 2.0905602 * phi_less180 ^ 4 - 0.44638264 * phi_less180 ^ 5);
      p_down := 200;
      phi_down := ((-0.56499308) + 3.8637496 * phi_less180 - 9.170028 * phi_less180 ^ 2 + 10.20122 * phi_less180 ^ 3 - 5.4998541 * phi_less180 ^ 4 + 1.1716854 * phi_less180 ^ 5) / (1 - 3.237545 * phi_less180 + 3.8132513 * phi_less180 ^ 2 - 1.771051 * phi_less180 ^ 3 + 0.076441418 * phi_less180 ^ 4 + 0.12067979 * phi_less180 ^ 5);
    elseif p >= 210 and p < 220 then
      p_up := 220;
      phi_up := 268.19561 - 2496.4334 * phi_less180 ^ 0.5 + 9729.2434 * phi_less180 - 19838.828 * phi_less180 ^ 1.5 + 19977.25 * phi_less180 ^ 2 - 977.21967 * phi_less180 ^ 2.5 - 23104.339 * phi_less180 ^ 3 + 29777.716 * phi_less180 ^ 3.5 - 18552.804 * phi_less180 ^ 4 + 6045.8435 * phi_less180 ^ 4.5 - 827.62478 * phi_less180 ^ 5;
      p_down := 210;
      phi_down := ((-0.23022792) + 1.8670365 * phi_less180 - 2.7284609 * phi_less180 ^ 2 + 1.1370724 * phi_less180 ^ 3 + 0.030002178 * phi_less180 ^ 4) / (1 - 2.3906129 * phi_less180 + 3.3062657 * phi_less180 ^ 2 - 3.4844912 * phi_less180 ^ 3 + 2.0905602 * phi_less180 ^ 4 - 0.44638264 * phi_less180 ^ 5);
    elseif p >= 220 and p < 225 then
      p_up := 225;
      phi_up := 1;
      p_down := 220;
      phi_down := 268.19561 - 2496.4334 * phi_less180 ^ 0.5 + 9729.2434 * phi_less180 - 19838.828 * phi_less180 ^ 1.5 + 19977.25 * phi_less180 ^ 2 - 977.21967 * phi_less180 ^ 2.5 - 23104.339 * phi_less180 ^ 3 + 29777.716 * phi_less180 ^ 3.5 - 18552.804 * phi_less180 ^ 4 + 6045.8435 * phi_less180 ^ 4.5 - 827.62478 * phi_less180 ^ 5;
    elseif p >= 225 then
      p_up := 230;
      phi_up := 1;
      p_down := 225;
      phi_down := 1;
    end if;
    phi := phi_down + (wrhop - wrhop_down) * (phi_up - phi_down) / (wrhop_up - wrhop_down) "Расчет phi для давления больше 180 кгс/см2 (итоговое phi)";
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end phi_notHeatedPipe;

  function lambda_tr "Функция для расчета коэффициента трения (лямбда)"
    extends Modelica.Icons.Function;

    function lambda_tr_lessReI "Функция для расчета коэффициента трения при Re меньше Re_I"
      input Real Re "Число Рейнольдса";
      output Real lambda_tr;
    algorithm
      if Re > 1 then
        lambda_tr := 64 / Re;
      else
        lambda_tr := 64;
      end if;
    end lambda_tr_lessReI;

    function lambda_tr_moreReII "Функция для расчета коэффициента трения при Re больше Re_II"
      input Modelica.SIunits.Length dn "расчетный внутренний диаметр трубы";
      input Modelica.SIunits.Length ke "абсолютная эквивалентная шероховатость";
      output Real lambda_tr;
    algorithm
      lambda_tr := 1 / (1.14 + 2 * log10(dn / ke)) ^ 2;
    end lambda_tr_moreReII;

    function lambda_polinom "Функция для расчеталямбда между Re = 4000 и ReII (оцифровка номограммы 11 Локшин В.А. (ред)-Гидравлический расчет котельных агрегатов (1978))"
      input Modelica.SIunits.Length dn "расчетный внутренний диаметр трубы";
      input Modelica.SIunits.Length ke "абсолютная эквивалентная шероховатость";
      input Real Re "Число Рейнольдса";
      output Real lambda;
    protected
      Real c[10] = {0.2587364420580208, -0.03516379584534394, -0.01845051721724587, 0.003140978795613697, 0.003982247918962438, -0.002620692312095342, -8.042305352946224E-05, -0.0001725422555343841, 5.317219412247827E-05, 5.169795621325457E-05};
    algorithm
      lambda := c[1] + c[2] * log(Re) + c[3] * log(dn / ke) + c[4] * log(Re) ^ 2 + c[5] * log(dn / ke) ^ 2 + c[6] * log(Re) * log(dn / ke) + c[7] * log(Re) ^ 3 + c[8] * log(dn / ke) ^ 3 + c[9] * log(Re) * log(dn / ke) ^ 2 + c[10] * log(Re) ^ 2 * log(dn / ke);
    end lambda_polinom;

    function lambda_tr_per "Функция для расчета коэффициента трения в зоне между ReI и Re = 4000"
      input Modelica.SIunits.Length dn "расчетный внутренний диаметр трубы";
      input Modelica.SIunits.Length ke "абсолютная эквивалентная шероховатость";
      input Real Re "Число Рейнольдса";
      output Real lambda_tr;
    protected
      Real Re_I "Нижняя граница переходной области (по числу Рейнольдса)";
      Real Re_II "Верхняя граница переходной области (по числу Рейнольдса)";
      Real lambda_tr_I "Нижняя граница переходной области (по коэффициенту трения)";
      Real lambda_tr_II "Верхняя граница переходной области (по коэффициенту трения)";
    algorithm
      Re_I := 2300;
      Re_II := 4000;
      lambda_tr_I := lambda_tr_lessReI(Re_I);
      lambda_tr_II := lambda_polinom(dn, ke, Re);
      lambda_tr := lambda_tr_I + (Re - Re_I) * (lambda_tr_II - lambda_tr_I) / (Re_II - Re_I);
    end lambda_tr_per;

    input Modelica.SIunits.Length dn "расчетный внутренний диаметр трубы";
    input Modelica.SIunits.Length ke "абсолютная эквивалентная шероховатость";
    input Real Re "Число Рейнольдса";
    output Real lambda_tr;
  protected
    Real Re_I "Нижняя граница переходной области (по числу Рейнольдса)";
    Real Re_II "Верхняя граница переходной области (по числу Рейнольдса)";
    Real Re4000 "Нижняя граница номограммы 11 Локшин В.А. (ред)-Гидравлический расчет котельных агрегатов (1978)";
  algorithm
    Re_I := 2300;
    Re_II := (120 * dn / ke) ^ 1.125;
    Re4000 := 4000;
    if Re < Re_I then
      lambda_tr := lambda_tr_lessReI(Re);
    elseif Re > Re_II then
      lambda_tr := lambda_tr_moreReII(dn, ke);
    elseif Re > Re_I and Re < Re4000 then
      lambda_tr := lambda_tr_per(dn, ke, Re);
    else
      lambda_tr := lambda_polinom(dn, ke, Re);
    end if;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end lambda_tr;

  model onlyGasHE "Используется аналогия с SiemensPower.Components.Junctions.SplitterMixer"
    function positiveMax
      extends Modelica.Icons.Function;
      input Real x;
      output Real y;
    algorithm
      y := max(x, 1e-10);
    end positiveMax;

    //**
    //***Исходные данные для газовой стороны
    //**
    replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Modelica.SIunits.MassFlowRate setD_gas = 509 "Номинальный (и начальный) массовый расход газов" annotation(Dialog(group = "Параметры стороны газов"));
    parameter Modelica.SIunits.Pressure setp_gas = 3e3 "Начальное давление газов" annotation(Dialog(group = "Параметры стороны газов"));
    parameter Modelica.SIunits.Temperature setT_inGas = 184 + 273.15 "Начальная входная температура газов" annotation(Dialog(group = "Параметры стороны газов"));
    parameter Modelica.SIunits.Temperature setT_outGas = 170 + 273.15 "Начальная выходная температура газов" annotation(Dialog(group = "Параметры стороны газов"));
    parameter Medium_G.MassFraction setX_gas[Medium_G.nXi] = Medium_G.reference_X;
    parameter Real k_alfaGas = 1 "Поправка к коэффициенту теплоотдачи со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
    //**
    //Конструктивные характеристики
    //**
    //Параметры
    parameter Integer numberOfTubeSections = 10 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Dout = Din + 2 * delta "Наружный диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer zahod = numberOfFlueSections "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z1 = 79 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Hpipe = Lpipe "Разность высотных отметов выхода и входа теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Real Xi_flow = 0.3 "Коэффициент гидравлического сопротивления участка трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length omega = Modelica.Constants.pi * Dout "Наружный периметр трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    //Поток газов
    parameter Modelica.SIunits.Volume deltaVGas = Lpipe * (s1 * s2 * z1 - Modelica.Constants.pi * Dout ^ 2 / 4) / numberOfTubeSections "Объем одного участка газового тракта";
    parameter Modelica.SIunits.Area deltaSGas = Lpipe * Modelica.Constants.pi * Dout * z1 / numberOfTubeSections "Наружная площадь одного участка ряда труб";
    parameter Modelica.SIunits.Area f_gas = (1 - Dout / s1 * (1 + 2 * hfin * delta_fin / sfin / Dout)) * Lpipe * s2 * z1 / numberOfTubeSections "Площадь для прохода газов на одном участке разбиения";
    //**
    //Характеристики оребрения
    //
    parameter Modelica.SIunits.Length delta_fin = 0.0009 "Средняя толщина ребра, м" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Modelica.SIunits.Length hfin = 0.014 "Высота ребра, м" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Modelica.SIunits.Length sfin = 0.004 "Шаг ребер, м" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Modelica.SIunits.Length Dfin = Dout + 2 * hfin "Диаметр ребер, м" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real psi_fin = 1 / (2 * Dout * sfin) * (Dfin ^ 2 - Dout ^ 2 + 2 * Dfin * delta_fin) + 1 - delta_fin / sfin "Коэффициент оребрения, равный отношению полной поверхности пучка к поверхности несущих труб на оребренном участке" annotation(Dialog(group = "Характеристики оребрения"));
    //формула 7.22а нормативного метода
    parameter Real sigma1 = s1 / Dout "Относительный поперечный шаг" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real sigma2 = s2 / Dout "Относительный продольный шаг" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real sigma3 = sqrt(0.25 * sigma1 ^ 2 + sigma2) "Средний относительный диагональный шаг труб" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real xfin = sigma1 / sigma2 - 1.26 / psi_fin - 2 "Параметр 'x' для шахматного пучка" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real phi_fin = Modelica.Math.tanh(xfin) "Некий параметр 'фи'" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real n_fin = 0.7 + 0.08 * phi_fin + 0.005 * psi_fin "Показатель степени 'n' в формуле коэффициента теплоотдачи" annotation(Dialog(group = "Характеристики оребрения"));
    parameter Real Cs = (1.36 - phi_fin) * (11 / (psi_fin + 8) - 0.14) "Коэффициент, определяемый в зависимости от от относительного поперечного и продольного шага труб в пучке, типа пучка и коэффициента оребрения";
    parameter Real Cz = if z2 < 8 and sigma1 / sigma2 < 2 then 3.15 * z2 ^ 0.05 - 2.5 elseif z2 < 8 and sigma1 / sigma2 >= 2 then 3.5 * z2 ^ 0.03 - 2.72 else 1 "Поправка на число рядов труб по ходу газов";
    parameter Real H_fin = (omega * Lpipe * (1 - delta_fin / sfin) + 2 * Modelica.Constants.pi * (Dfin ^ 2 - Dout ^ 2) / 4 + Modelica.Constants.pi * Dfin * delta_fin * (Lpipe / sfin)) * z1 "Площадь оребренной поверхности";
    //**
    //Начальные значения
    //**
    //Поток газов
    parameter Medium_G.MassFlowRate deltaDGasStart = setD_gas / numberOfTubeSections "Расход газов через один участок разбиения";
    parameter Medium_G.SpecificEnthalpy h_startTubeGas[numberOfFlueSections + 1] = linspace(Medium_G.specificEnthalpy_pTX(setp_gas, setT_inGas, setX_gas), Medium_G.specificEnthalpy_pTX(setp_gas, setT_outGas, setX_gas), numberOfFlueSections + 1) "Начальный вектор энальпии потока газов вдоль газохода" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_G.SpecificEnthalpy h_startGas[numberOfFlueSections + 1, numberOfTubeSections] = array(array(h_startTubeGas[i] for j in 1:numberOfTubeSections) for i in 1:numberOfFlueSections + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_G.AbsolutePressure p_startGas[numberOfFlueSections + 1, numberOfTubeSections] = fill(setp_gas, numberOfFlueSections + 1, numberOfTubeSections) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    //Поток газов
    Medium_G.BaseProperties gas[numberOfFlueSections, numberOfTubeSections];
    Medium_G.SpecificEnthalpy h_gas[numberOfFlueSections + 1, numberOfTubeSections](start = h_startGas) "Энтальпия потока вода/пар по участкам трубы";
    Medium_G.Temperature t_gas[numberOfFlueSections, numberOfTubeSections](start = setT_inGas) "Температура потока газов по участкам трубы";
    Medium_G.MassFlowRate deltaDGas[numberOfFlueSections + 1, numberOfTubeSections](start = fill(deltaDGasStart, numberOfFlueSections + 1, numberOfTubeSections)) "Расход газов через участок газохода";
    Medium_G.DynamicViscosity mu[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость газов";
    Medium_G.ThermalConductivity k[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности газов";
    Medium_G.SpecificHeatCapacity cp[numberOfFlueSections, numberOfTubeSections] "Изобарная теплоемкость газов";
    Modelica.SIunits.PerUnit Re[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Medium_G.PrandtlNumber Pr[numberOfFlueSections, numberOfTubeSections] "Число Прандтля";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_gas[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока газов";
    //**
    //Интерфейс
    //**
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = false, transformation(origin = {0, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0), iconTransformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(extent = {{80, -20}, {120, 20}}, rotation = 0), iconTransformation(extent = {{100, -20}, {140, 20}}, rotation = 0)));
  equation
//*****Уравнения для потока газов
    for j in 1:numberOfTubeSections loop
      for i in 1:numberOfFlueSections loop
        deltaVGas * gas[i, j].d * der(h_gas[i + 1, j]) = deltaDGas[i, j] * (h_gas[i, j] - h_gas[i + 1, j]) + heat[i, j].Q_flow "Уавнение теплового баланса газов (формула 3-15 диссертации Рубашкина)";
        heat[i, j].Q_flow = -alfa_gas[i, j] * H_fin * (t_gas[i, j] - heat[i, j].T);
//Уравнения состояния
        gas[i, j].h = h_gas[i + 1, j];
        gas[i, j].p = gasIn.p "Уравнение для давления";
        gas[i, j].X = setX_gas;
        gas[i, j].T = t_gas[i, j];
        deltaDGas[i, j] = deltaDGas[i + 1, j];
//Коэффициент теплоотдачи
        mu[i, j] = Medium_G.dynamicViscosity(gas[i, j].state);
        k[i, j] = Medium_G.thermalConductivity(gas[i, j].state);
        cp[i, j] = Medium_G.heatCapacity_cp(gas[i, j].state);
        Re[i, j] = abs(deltaDGas[i, j] * Dout / (f_gas * mu[i, j]));
        Pr[i, j] = Medium_G.prandtlNumber(gas[i, j].state);
        alfa_gas[i, j] = k_alfaGas * 0.113 * Cs * Cz * k[i, j] / Dout * Re[i, j] ^ n_fin * Pr[i, j] ^ 0.33;
      end for;
//Граничные условия
      h_gas[1, j] = inStream(gasIn.h_outflow);
    end for;
//Граничные условия
    for j in 1:numberOfTubeSections - 1 loop
      deltaDGas[1, j] = deltaDGas[1, j + 1];
    end for;
    gasIn.h_outflow = sum(array(positiveMax(deltaDGas[1, j]) * h_gas[1, j] for j in 1:numberOfTubeSections)) / sum(array(positiveMax(deltaDGas[1, j]) for j in 1:numberOfTubeSections));
    gasOut.h_outflow = sum(array(positiveMax(deltaDGas[i, j]) * h_gas[i, j] for i in numberOfFlueSections + 1:numberOfFlueSections + 1, j in 1:numberOfTubeSections)) / sum(array(positiveMax(deltaDGas[i, j]) for i in numberOfFlueSections + 1:numberOfFlueSections + 1, j in 1:numberOfTubeSections));
    gasIn.Xi_outflow = inStream(gasOut.Xi_outflow);
    inStream(gasIn.Xi_outflow) = gasOut.Xi_outflow;
    gasIn.m_flow - sum(deltaDGas[1, j] for j in 1:numberOfTubeSections) = 0;
    gasOut.m_flow + sum(deltaDGas[numberOfFlueSections + 1, j] for j in 1:numberOfTubeSections) = 0;
    gasOut.p = gasIn.p;
    annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-100, -115}, {100, -145}}, lineColor = {85, 170, 255}, textString = "%name")}));
  end onlyGasHE;

  model onlyFlowHEBoil
    function positiveMax
      extends Modelica.Icons.Function;
      input Real x;
      output Real y;
    algorithm
      y := max(x, 1e-10);
    end positiveMax;

    function HTtoMT "Функция перехода с участков труб для расчета теплообмена на участки расчета массообмена (осреднение)"
      input Real x[:] "Массив элементов по участком тубы разбитых для расчета теплообмена";
      input Integer numberPMCalcSections "Число участков разбиения трубы входящих в один участок расчета процессов массообмена";
      input Integer j "Текущий участок трубы по расчету массообмена";
      output Real y;
    algorithm
      y := sum(x[k] for k in 1 + (j - 1) * numberPMCalcSections:j * numberPMCalcSections) / numberPMCalcSections;
    end HTtoMT;

    function HTtoMT_n "Функция перехода с участков труб для расчета теплообмена на участки расчета массообмена (в узловой точке)"
      input Real x[:] "Массив элементов по участком тубы разбитых для расчета теплообмена";
      input Integer numberPMCalcSections "Число участков разбиения трубы входящих в один участок расчета процессов массообмена";
      input Integer j "Текущий участок трубы по расчету массообмена";
      output Real y;
    algorithm
      y := x[1 + (j - 1) * numberPMCalcSections];
    end HTtoMT_n;

    function HTtoMT_sum "Функция перехода с участков труб для расчета теплообмена на участки расчета массообмена (скммирование)"
      input Real x[:] "Массив элементов по участком тубы разбитых для расчета теплообмена";
      input Integer numberPMCalcSections "Число участков разбиения трубы входящих в один участок расчета процессов массообмена";
      input Integer j "Текущий участок трубы по расчету массообмена";
      output Real y;
    algorithm
      y := sum(x[k] for k in 1 + (j - 1) * numberPMCalcSections:j * numberPMCalcSections) / numberPMCalcSections;
    end HTtoMT_sum;

    function MTtoHT "Функция перехода с участков труб для расчета массообмена на участки расчета теплообмена"
      input Real x[:] "Массив элементов по участком тубы разбитых для расчета массообмена";
      input Integer numberPMCalcSections "Число участков разбиения трубы входящих в один участок расчета процессов массообмена";
      input Integer j "Текущий участок трубы по расчету теплообмена";
      output Real y;
    algorithm
      y := x[integer((j + numberPMCalcSections - 1) / numberPMCalcSections)];
    end MTtoHT;

    //import MyHRSG_lite.phi_heatedPipe;
    //import MyHRSG_lite.lambda_tr;
    //**
    //***Исходные данные для газовой стороны
    //**
    parameter Modelica.SIunits.Power setQ_gas = 100 "тепловой поток со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
    //**
    //***Исходные данные по стороне вода/пар
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    replaceable package Medium_F2 = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
    parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
    parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
    //**
    //***Характеристики металла
    parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
    //**
    //**
    //Конструктивные характеристики
    //**
    //Параметры
    parameter MyHRSG_lite.Choices.HRSG_type HRSG_type = MyHRSG_lite.Choices.HRSG_type.horizontalBottom "Тип КУ";
    parameter Integer numberOfTubeSections = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberPMCalcSections = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfTubeSectionsForMT = integer(numberOfTubeSections / numberPMCalcSections) "Число участков разбиения трубы для расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfTubeNodes = numberOfTubeSectionsForMT + 1 "Число узлов в одной трубе";
    parameter Integer numberFirstTubeInLastZahod = integer(numberOfFlueSections - zahod + 1) "Номер первой трубы в последнем заходе";
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer zahod = 2 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
    //Поток вода/пар
    parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 / numberOfTubeSections "Внутренняя площадь одного участка ряда труб";
    parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 / 4 / numberOfTubeSections "Внутренний объем одного участка ряда труб";
    parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 / numberOfTubeSections "Масса металла участка ряда труб";
    parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
    parameter Modelica.SIunits.Time Tstab "Интервал времени в начале расчета в течение которого все производные равны нулю";
    //**
    //Начальные значения
    //**
    //Поток вода/пар
    //parameter Medium_F.SpecificEnthalpy h_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = MyHRSG_lite.razbivka_n(seth_in, seth_out,zahod, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //parameter Medium_F.SpecificEnthalpy h_startFlow_v[numberOfFlueSections, numberOfTubeSections] = array(array((h_startFlow_n[i, j + 1] + h_startFlow_n[i, j]) / 2 for j in 1:numberOfTubeSections) for i in 1:numberOfFlueSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //parameter Medium_F.AbsolutePressure p_startFlow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1] = MyHRSG_lite.razbivka_n(setp_flow_in, setp_flow_out,zahod, numberOfFlueSections, numberOfTubeSectionsForMT + 1) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    //parameter Medium_F.AbsolutePressure p_startFlow_v[numberOfFlueSections, numberOfTubeSectionsForMT] = MyHRSG_lite.razbivka_v(setp_flow_in, setp_flow_out,zahod, numberOfFlueSections, numberOfTubeSectionsForMT) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(seth_in, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(seth_in, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_v[numberOfFlueSections, numberOfTubeSectionsForMT] = fill(setp_flow_in, numberOfFlueSections, numberOfTubeSectionsForMT) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1] = fill(setp_flow_in, numberOfFlueSections, numberOfTubeSectionsForMT + 1) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_v[numberOfFlueSections, numberOfTubeSectionsForMT] = fill(setD_flow / zahod, numberOfFlueSections, numberOfTubeSectionsForMT) "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1] = fill(setD_flow / zahod, numberOfFlueSections, numberOfTubeSectionsForMT + 1) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = fill(setTm, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    Modelica.SIunits.Length deltaHpipe "Разность высот на участке ряда труб";
    //Поток вода/пар
    Medium_F.ThermodynamicState stateFlow[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F2.ThermodynamicState stateFlowTwoPhase[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    Medium_F.AbsolutePressure p_flow_v[numberOfFlueSections, numberOfTubeSectionsForMT](start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.AbsolutePressure p_flow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
    Medium_F.SpecificEnthalpy h_flow_v[numberOfFlueSections, numberOfTubeSections](start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.SpecificEnthalpy h_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
    Real der_h_flow_v[numberOfFlueSections, numberOfTubeSections] "Производняа энтальпии потока вода/пар";
    Medium_F.Density rho_flow_v[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы в конечных объемах";
    Medium_F.Density rho_flow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1] "Плотность потока по участкам трубы в узловых точках";
    Modelica.SIunits.DerDensityByEnthalpy drdh_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow_v[numberOfFlueSections, numberOfTubeSectionsForMT](start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
    Medium_F.MassFlowRate D_flow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    Modelica.SIunits.HeatFlowRate Q_flow[numberOfFlueSections, numberOfTubeSections] "тепло переданное стенке трубы";
    Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
    Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    Real C1[numberOfFlueSections, numberOfTubeSectionsForMT] "Показатель в числителе уравнения сплошности";
    Real C2[numberOfFlueSections, numberOfTubeSectionsForMT] "Показатель в знаменателе уравнения сплошности";
    Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
    Modelica.SIunits.Length H_flow[numberOfFlueSections, numberOfTubeSectionsForMT + 1] "Высотная отметка каждого узла";
    Modelica.SIunits.Velocity w_flow_v[numberOfFlueSections, numberOfTubeSections] "Скорость потока вода/пар в конечных объемах";
    Modelica.SIunits.Velocity w_flow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1] "Скорость потока вода/пар в узловых точках";
    Real dp_fric[numberOfFlueSections, numberOfTubeSectionsForMT] "Потеря давления из-за сил трения";
    //Real dp_kin[numberOfFlueSections, numberOfTubeSectionsForMT] "Потеря давления из-за приращения кинетической энергии";
    Real dp_piez[numberOfFlueSections, numberOfTubeSectionsForMT] "Перепад давления из-за изменения пьезометрической высоты";
    Medium_F2.SaturationProperties sat_v[numberOfFlueSections, numberOfTubeSectionsForMT] "State vector to compute saturation properties внутри конечного объема";
    //Medium_F2.Temperature ts[numberOfFlueSections, numberOfTubeSectionsForMT] "Температура насыщения";
    Real wrhop[numberOfFlueSections, numberOfTubeSectionsForMT] "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
    Real phi[numberOfFlueSections, numberOfTubeSectionsForMT] "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
    Real Xi_flow[numberOfFlueSections, numberOfTubeSectionsForMT] "Коэффициент гидравлического сопротивления участка трубы";
    Real x_v[numberOfFlueSections, numberOfTubeSections] "Степень сухости";
    Medium_F.Density dew_rho_flow_v[numberOfFlueSections, numberOfTubeSectionsForMT] "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
    Medium_F.Density bubble_rho_flow_v[numberOfFlueSections, numberOfTubeSectionsForMT] "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
    //**
    //Интерфейс
    //**
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
      deltaHpipe = Lpipe / numberOfTubeSections * numberPMCalcSections "Разность высотных отметок элементов труб для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
      deltaHpipe = Lpipe / numberOfTubeSections * numberPMCalcSections "Разность высотных отметок элементов труб для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
      deltaHpipe = s2 "Разность высотных отметок элементов труб для вертикального КУ";
    else
      deltaHpipe = s2 "Разность высотных отметок элементов труб для вертикального КУ";
    end if;
//*****Уравнения для потока вода/пар и металла
    for i in 1:numberOfFlueSections loop
      hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева";
//Рачет скорости потока в узловых точках
      for j in 1:numberOfTubeSectionsForMT + 1 loop
        rho_flow_n[i, j] = Medium_F.density_ph(p_flow_n[i, j], HTtoMT_n(h_flow_n[i, :], numberPMCalcSections, j)) "Расчет плотности вода/пар в узловых точках";
        w_flow_n[i, j] = D_flow_n[i, j] / rho_flow_n[i, j] / f_flow "Расчет скорости потока вода/пар в узловых точках";
      end for;
//Уравнения для расчета процессов теплообмена
      for j in 1:numberOfTubeSections loop
//Осреднение по конечному объему
        der_h_flow_v[i, j] = der(h_flow_v[i, j]);
        deltaVFlow * rho_flow_v[i, j] * der_h_flow_v[i, j] = 0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - MTtoHT(D_flow_v[i, :], numberPMCalcSections, j) * (h_flow_v[i, j] - h_flow_n[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
        deltaVFlow * rho_flow_v[i, j] * der(h_flow_n[i, j + 1]) = 0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - MTtoHT(D_flow_v[i, :], numberPMCalcSections, j) * (h_flow_n[i, j + 1] - h_flow_v[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
        deltaMMetal * C_m * der(t_m[i, j]) = Q_flow[i, j] - alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
        if hod[i] < 0 then
          heat[i, j].Q_flow = Q_flow[i, j];
          heat[i, j].T = t_m[i, j];
        else
          heat[i, j].Q_flow = Q_flow[i, numberOfTubeSections - j + 1];
          heat[i, j].T = t_m[i, numberOfTubeSections - j + 1];
        end if;
//Уравнения состояния
        stateFlow[i, j] = Medium_F.setState_ph(MTtoHT(p_flow_v[i, :], numberPMCalcSections, j), h_flow_v[i, j]);
        t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
        rho_flow_v[i, j] = Medium_F.density(stateFlow[i, j]);
        drdp_flow[i, j] = max(min(Medium_F.density_derp_h(stateFlow[i, j]), 2.0394e-4), 3.0591e-6);
        drdh_flow[i, j] = max(Medium_F.density_derh_p(stateFlow[i, j]), -0.0191);
//Коэффициент теплоотдачи
        k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
        Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
        mu_flow[i, j] = if Medium_F.dynamicViscosity(stateFlow[i, j]) < 1.503e-004 then 1.503e-004 else Medium_F.dynamicViscosity(stateFlow[i, j]);
        w_flow_v[i, j] = MTtoHT(D_flow_v[i, :], numberPMCalcSections, j) / rho_flow_v[i, j] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow[i, j] = abs(w_flow_v[i, j] * Din * rho_flow_v[i, j] / mu_flow[i, j]);
        alfa_flow[i, j] = if MTtoHT(D_flow_v[i, :], numberPMCalcSections, j) > 0.001 then 0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4 else 0;
//and t_m[i, j] > MTtoHT(sat_v[i, :].Tsat, numberPMCalcSections, j)
//alfa_flow[i, j] = 0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4;
//assert(t_m[i, j] < t_flow[i, j], "Temperatura metalla nije temperaturi potoka", level = AssertionLevel.warning);
//Про две фазы
        stateFlowTwoPhase[i, j] = Medium_F2.setState_ph(MTtoHT(p_flow_v[i, :], numberPMCalcSections, j), h_flow_v[i, j]);
        x_v[i, j] = Medium_F2.vapourQuality(stateFlowTwoPhase[i, j]);
      end for;
//Уравнения для расчета процессов массообмена
      for j in 1:numberOfTubeSectionsForMT loop
        sat_v[i, j] = Medium_F2.setSat_p(p_flow_v[i, j]);
        dew_rho_flow_v[i, j] = Medium_F2.dewDensity(sat_v[i, j]);
        bubble_rho_flow_v[i, j] = Medium_F2.bubbleDensity(sat_v[i, j]);
//Осреднение по конечному объему
        p_flow_v[i, j] = (p_flow_n[i, j + 1] + p_flow_n[i, j]) / 2;
        D_flow_v[i, j] = (D_flow_n[i, j + 1] + D_flow_n[i, j]) / 2;
//Основное уравнение гидравлики
        wrhop[i, j] = HTtoMT(w_flow_v[i, :], numberPMCalcSections, j) * HTtoMT(rho_flow_v[i, :], numberPMCalcSections, j) * p_flow_v[i, j] * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
        Xi_flow[i, j] = lambda_tr(Din, ke, HTtoMT(Re_flow[i, :], numberPMCalcSections, j)) * Lpipe / Din / numberOfTubeSections * numberPMCalcSections;
        phi[i, j] = phi_heatedPipe(wrhop[i, j], p_flow_v[i, j] / 100000, HTtoMT(x_v[i, :], numberPMCalcSections, j)) "Расчет коэффициента phi";
/*dp_fric[i, j] = homotopy(if HTtoMT(x_v[i, :], numberPMCalcSections, j) < 1 then HTtoMT(w_flow_v[i, :], numberPMCalcSections, j) ^ 2 * Xi_flow[i, j] * max(bubble_rho_flow_v[i, j], HTtoMT(rho_flow_v[i, :], numberPMCalcSections, j)) / 2 / Modelica.Constants.g_n * (1 + HTtoMT(x_v[i, :], numberPMCalcSections, j) * phi[i, j] * (bubble_rho_flow_v[i, j] / dew_rho_flow_v[i, j] - 1)) else HTtoMT(w_flow_v[i, :], numberPMCalcSections, j) ^ 2 * Xi_flow[i, j] * HTtoMT(rho_flow_v[i, :], numberPMCalcSections, j) / 2 / Modelica.Constants.g_n, 10000) "Потеря давления от трения";*/
        if HTtoMT(x_v[i, :], numberPMCalcSections, j) < 1 and HTtoMT(x_v[i, :], numberPMCalcSections, j) > 0 then
          dp_fric[i, j] = HTtoMT(w_flow_v[i, :], numberPMCalcSections, j) ^ 2 * Xi_flow[i, j] * bubble_rho_flow_v[i, j] / 2 / Modelica.Constants.g_n * (1 + HTtoMT(x_v[i, :], numberPMCalcSections, j) * phi[i, j] * (bubble_rho_flow_v[i, j] / dew_rho_flow_v[i, j] - 1)) "Потеря давления от трения";
        else
          dp_fric[i, j] = HTtoMT(w_flow_v[i, :], numberPMCalcSections, j) ^ 2 * Xi_flow[i, j] * HTtoMT(rho_flow_v[i, :], numberPMCalcSections, j) / 2 / Modelica.Constants.g_n "Потеря давления от трения";
        end if;
//dp_kin[i, j] = HTtoMT(w_flow_v[i, :], numberPMCalcSections, j) * (w_flow_n[i, j + 1] - w_flow_n[i, j]) * HTtoMT(rho_flow_v[i, :], numberPMCalcSections, j) / Modelica.Constants.g_n "Потеря давления из-за приращения кинетической энергии";
        if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
          H_flow[i, j + 1] = H_flow[i, j] - hod[i] * deltaHpipe "Расчет высотных отметок для горизонтального КУ";
        elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
          H_flow[i, j + 1] = H_flow[i, j] + hod[i] * deltaHpipe "Расчет высотных отметок для горизонтального КУ";
        elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
          H_flow[i, j + 1] = H_flow[1, j] + (i - 1) * deltaHpipe "Расчет высотных отметок для вертикального КУ";
        else
          H_flow[i, j + 1] = H_flow[1, j] - (i - 1) * deltaHpipe "Расчет высотных отметок для вертикального КУ";
        end if;
        dp_piez[i, j] = (rho_flow_n[i, j + 1] * H_flow[i, j + 1] - rho_flow_n[i, j] * H_flow[i, j]) * Modelica.Constants.g_n "Расчет перепада давления из-за изменения пьезометрической высоты";
//p_flow_n[i, j] - p_flow_n[i, j + 1] = dp_fric[i, j] + dp_kin[i, j] + dp_piez[i, j] "Формула 2-1 из книги Рудомино, Ремжин";
        p_flow_n[i, j] - p_flow_n[i, j + 1] = dp_fric[i, j] + dp_piez[i, j] "Формула 2-1 из книги Рудомино, Ремжин";
        D_flow_n[i, j] - D_flow_n[i, j + 1] = C1[i, j] + C2[i, j] "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
        C1[i, j] = numberPMCalcSections * deltaVFlow * HTtoMT_sum(drdh_flow[i, :], numberPMCalcSections, j) * HTtoMT(der_h_flow_v[i, :], numberPMCalcSections, j);
//Возможно не верно указан объем (объем для расчета теплообмена а надо для массообмена)
        C2[i, j] = numberPMCalcSections * deltaVFlow * HTtoMT_sum(drdp_flow[i, :], numberPMCalcSections, j) * der(p_flow_v[i, j]);
      end for;
    end for;
    for i in 1:numberOfFlueSections - zahod loop
//Описание гибов
      D_flow_n[i, numberOfTubeSectionsForMT + 1] = D_flow_n[i + zahod, 1];
      p_flow_n[i, numberOfTubeSectionsForMT + 1] = p_flow_n[i + zahod, 1];
      h_flow_n[i, numberOfTubeSections + 1] = h_flow_n[i + zahod, 1];
      if HRSG_type == Choices.HRSG_type.horizontalBottom or HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        H_flow[i, numberOfTubeSectionsForMT + 1] = H_flow[i + zahod, 1];
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        H_flow[i, numberOfTubeSectionsForMT + 1] + 2 * s2 = H_flow[i + zahod, 1];
      else
        H_flow[i, numberOfTubeSectionsForMT + 1] - 2 * s2 = H_flow[i + zahod, 1];
      end if;
//Для горизонтальных КУ
    end for;
//Граничные условия
//Граничные условия для высотной отметки входного коллектора
    for i in 1:zahod loop
      if HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        H_flow[i, 1] = 0 + (i - 1) * s2 "Задание высотной отметки входного коллектора";
      elseif HRSG_type == Choices.HRSG_type.horizontalBottom then
        H_flow[i, 1] = 0 "Задание высотной отметки входного коллектора";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        H_flow[i, 1] = Lpipe "Задание высотной отметки входного коллектора";
      else
        H_flow[i, 1] = s2 * (z2 - 1) - (i - 1) * s2 "Задание высотной отметки входного коллектора";
      end if;
    end for;
    for i in 2:zahod loop
      D_flow_n[i - 1, 1] = D_flow_n[i, 1];
    end for;
    positiveMax(waterIn.m_flow) = sum(D_flow_n[i, 1] for i in 1:zahod);
    waterOut.m_flow = -sum(D_flow_n[i, j] for i in numberFirstTubeInLastZahod:numberOfFlueSections, j in numberOfTubeNodes:numberOfTubeNodes);
    if waterIn.m_flow >= 0 then
      for i in numberOfFlueSections - zahod + 1:numberOfFlueSections loop
        waterOut.p = p_flow_n[i, numberOfTubeSectionsForMT + 1];
      end for;
      waterIn.p = sum(p_flow_n[i, 1] for i in 1:zahod) / zahod;
    else
      for i in 1:zahod loop
        waterIn.p = p_flow_n[i, 1];
      end for;
      waterOut.p = sum(p_flow_n[i, j] for i in numberFirstTubeInLastZahod:numberOfFlueSections, j in numberOfTubeNodes:numberOfTubeNodes) / zahod;
    end if;
    if waterIn.m_flow >= 0 then
      for i in 1:zahod loop
        h_flow_n[i, 1] = inStream(waterIn.h_outflow);
      end for;
    else
      for i in numberOfFlueSections - zahod + 1:numberOfFlueSections loop
        h_flow_n[i, numberOfTubeSections + 1] = inStream(waterOut.h_outflow);
      end for;
    end if;
    waterOut.h_outflow = sum(array(positiveMax(D_flow_n[i, numberOfTubeSectionsForMT + 1]) * h_flow_n[i, numberOfTubeSections + 1] for i in numberFirstTubeInLastZahod:numberOfFlueSections)) / sum(array(positiveMax(D_flow_n[i, numberOfTubeSectionsForMT + 1]) for i in numberFirstTubeInLastZahod:numberOfFlueSections));
    waterIn.h_outflow = sum(array(positiveMax(D_flow_n[i, 1]) * h_flow_n[i, 1] for i in 1:zahod)) / sum(array(positiveMax(D_flow_n[i, 1]) for i in 1:zahod));
    annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
  end onlyFlowHEBoil;

  model GF_HE
    extends HE_Icon;
    parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
    //***Исходные данные для газовой стороны
    //**
    replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Modelica.SIunits.MassFlowRate wgas "Номинальный (и начальный) массовый расход газов";
    parameter Modelica.SIunits.Pressure pgas "Начальное давление газов";
    parameter Modelica.SIunits.Temperature Tingas "Начальная входная температура газов";
    parameter Modelica.SIunits.Temperature Toutgas "Начальная выходная температура газов";
    //parameter Modelica.SIunits.Temperature T2gas = (Tingas + Toutgas) / 2 "Промежуточная температура газов";
    parameter Real k_gamma_gas "Поправка к коэффициенту теплоотдачи со стороны газов";
    parameter Real Set_X[6] "Состав дымовых газов";
    //**
    //***Исходные данные для водяной стороны
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    parameter Modelica.SIunits.MassFlowRate wflow "Номинальный массовый расход воды/пар";
    parameter Modelica.SIunits.Pressure pflow_in "Начальное давление потока вода/пар на входе";
    parameter Modelica.SIunits.Pressure pflow_out "Начальное давление потока вода/пар на выходе";
    parameter Modelica.SIunits.Temperature Tinflow "Начальная входная температура потока воды/пар";
    parameter Modelica.SIunits.Temperature Toutflow "Начальная выходная температура потока воды/пар";
    parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
    parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
    parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
    //**
    //***Исходные данные по разбиению
    //**
    parameter Integer numberOfTubeSections = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberPMCalcSections = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    //**
    //***конструктивные характеристики
    //**
    parameter MyHRSG_lite.Choices.HRSG_type HRSG_type_set = Choices.HRSG_type.horizontalBottom "Выбор типа КУ (горизонтальный/вертикальный)";
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника";
    parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг";
    parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг";
    parameter Integer zahod = 1 "заходность труб теплообменника";
    parameter Integer z1 = 126 "Число труб по ширине газохода";
    parameter Integer z2 = 4 "Число труб по ходу газов в теплообменнике";
    parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки";
    ///Оребрение
    parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
    parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м";
    parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м";
    ////
    //////
    ////
    Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    onlyGasHE gasHE(redeclare package Medium_G = Medium_G, setD_gas = wgas, setp_gas = pgas, setT_inGas = Tingas, setT_outGas = Toutflow, k_alfaGas = k_gamma_gas, numberOfTubeSections = numberOfTubeSections, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe, delta_fin = delta_fin, hfin = hfin, sfin = sfin) annotation(Placement(visible = true, transformation(origin = {0, 50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    replaceable onlyFlowHEBoil flowHE(setD_flow = wflow, setp_flow_in = pflow_in, setp_flow_out = pflow_out, setT_inFlow = Tinflow, setT_outFlow = Toutflow, numberOfTubeSections = numberOfTubeSections, numberPMCalcSections = numberPMCalcSections, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe, seth_in = seth_in, seth_out = seth_out, HRSG_type = HRSG_type_set, setTm = setTm, m_flow_small = m_flow_small) annotation(Placement(visible = true, transformation(origin = {0, -50}, extent = {{-30, -30}, {30, 30}}, rotation = 90)));
  equation
    connect(gasHE.gasOut, gasOut) annotation(Line(points = {{36, 50}, {92, 50}, {92, 48}, {92, 48}}, color = {0, 127, 255}));
    connect(gasIn, gasHE.gasIn) annotation(Line(points = {{-90, 50}, {-34, 50}, {-34, 48}, {-34, 48}}));
    for j in 1:numberOfTubeSections loop
      for i in 1:numberOfFlueSections loop
        connect(flowHE.heat[i, j], gasHE.heat[i, j]);
      end for;
    end for;
    connect(flowHE.waterOut, flowOut) annotation(Line(points = {{36, -50}, {94, -50}, {94, -50}, {94, -50}}, color = {0, 127, 255}));
    connect(flowIn, flowHE.waterIn) annotation(Line(points = {{-90, -50}, {-34, -50}, {-34, -50}, {-34, -50}}));
    annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), version = "", uses);
  end GF_HE;

  model pipe
    //***Исходные данные
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    parameter Modelica.SIunits.MassFlowRate setD = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp = 10e5 "Начальное давление потока вода/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    //**
    //***Характеристики металла
    parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
    //**
    //Конструктивные характеристики
    //**
    //Параметры
    parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Hpipe_in = 0 "Высотная отметка входа трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Hpipe_out = 18.4 "Высотная отметка выхода трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din / numberOfTubeSections "Внутренняя площадь одного участка трубы";
    parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 / 4 / numberOfTubeSections "Внутренний объем одного участка трубы";
    parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) / 4 / numberOfTubeSections "Масса металла участка трубы";
    parameter Modelica.SIunits.Length deltaHpipe = (Hpipe_out - Hpipe_in) / numberOfTubeSections "Разность высот на участке трубы";
    parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 / 4 "Площадь для прохода теплоносителя";
    //**
    //Начальные значения
    //**
    //Поток вода/пар
    //parameter Medium_F.SpecificEnthalpy h_start_v[numberOfTubeSections] = fill(Medium_F.specificEnthalpy_pT(setp, setT), numberOfTubeSections) "Начальный вектор энальпии потока вода/пар вдоль трубы" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_start_v[numberOfTubeSections] = fill(Medium_F.bubbleEnthalpy(Medium_F.setSat_p(setp)), numberOfTubeSections) "Начальный вектор энальпии потока вода/пар вдоль трубы" annotation(Dialog(tab = "Инициализация"));
    /*!!!!!!!!!!!!
                                                                                                                                    !!!!!!!!!!!!
                                                                                                                                    !!!!!!!!!!!!
                                                                                                                                    ПОМЕНЯЙ СТРОКИ ВЫШЕ ДЛЯ ЭКО И ПЕ*/
    //parameter Medium_F.SpecificEnthalpy h_start_n[numberOfTubeSections + 1] = fill(Medium_F.specificEnthalpy_pT(setp, setT), numberOfTubeSections + 1) "Начальный вектор энальпии потока вода/пар вдоль трубы" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_start_n[numberOfTubeSections + 1] = fill(Medium_F.bubbleEnthalpy(Medium_F.setSat_p(setp)), numberOfTubeSections + 1) "Начальный вектор энальпии потока вода/пар вдоль трубы" annotation(Dialog(tab = "Инициализация"));
    /*!!!!!!!!!!!!
                                                                                                                                    !!!!!!!!!!!!
                                                                                                                                    !!!!!!!!!!!!
                                                                                                                                    ПОМЕНЯЙ СТРОКИ ВЫШЕ ДЛЯ ЭКО И ПЕ*/
    parameter Medium_F.AbsolutePressure p_start_v[numberOfTubeSections] = fill(setp, numberOfTubeSections) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_start_n[numberOfTubeSections + 1] = fill(setp, numberOfTubeSections + 1) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_start_v[numberOfTubeSections] = fill(setD, numberOfTubeSections) "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_start_n[numberOfTubeSections + 1] = fill(setD, numberOfTubeSections + 1) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startM[numberOfTubeSections] = fill(setT, numberOfTubeSections) "Начальный вектор температур металла" annotation(Dialog(tab = "Инициализация"));
    parameter Modelica.SIunits.Time Tstab "Интервал времени в начале расчета в течение которого все производные равны нулю";
    //**
    //Переменные
    //**
    Medium_F.ThermodynamicState stateFlow[numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.Temperature t_flow[numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    Medium_F.AbsolutePressure p_flow_v[numberOfTubeSections](start = p_start_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.AbsolutePressure p_flow_n[numberOfTubeSections + 1](start = p_start_n) "Давление потока вода/пар по участкам трубы в узловых точках";
    Medium_F.SpecificEnthalpy h_flow_v[numberOfTubeSections](start = h_start_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.SpecificEnthalpy h_flow_n[numberOfTubeSections + 1](start = h_start_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
    Medium_F.Density rho_flow_v[numberOfTubeSections] "Плотность потока по участкам трубы в конечных объемах";
    Medium_F.Density rho_flow_n[numberOfTubeSections + 1] "Плотность потока по участкам трубы в узловых точках";
    Modelica.SIunits.DerDensityByEnthalpy drdh_flow[numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_flow[numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow_v[numberOfTubeSections](start = D_start_v) "Массовый расход потока вода/пар по участкам ряда труб";
    Medium_F.MassFlowRate D_flow_n[numberOfTubeSections + 1](start = D_start_n) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    //Modelica.SIunits.HeatFlowRate Q_flow[numberOfTubeSections] "тепло переданное стенке трубы";
    Real Pr_flow[numberOfTubeSections] "Число Прандтля для потока вода/пар";
    Real Re_flow[numberOfTubeSections] "Число Рейнольдса";
    Modelica.SIunits.Temperature t_m[numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    Real C1[numberOfTubeSections] "Показатель в числителе уравнения сплошности";
    Real C2[numberOfTubeSections] "Показатель в знаменателе уравнения сплошности";
    Modelica.SIunits.Length H_flow[numberOfTubeSections + 1] "Высотная отметка каждого узла";
    Modelica.SIunits.Velocity w_flow_v[numberOfTubeSections] "Скорость потока вода/пар в конечных объемах";
    Modelica.SIunits.Velocity w_flow_n[numberOfTubeSections + 1] "Скорость потока вода/пар в узловых точках";
    Real dp_fric[numberOfTubeSections] "Потеря давления из-за сил трения";
    //Real dp_kin[numberOfTubeSections] "Потеря давления из-за приращения кинетической энергии";
    Real dp_piez[numberOfTubeSections] "Перепад давления из-за изменения пьезометрической высоты";
    Medium_F.SaturationProperties sat_v[numberOfTubeSections] "State vector to compute saturation properties внутри конечного объема";
    Real wrhop[numberOfTubeSections] "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
    Real phi[numberOfTubeSections] "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
    Real Xi_flow[numberOfTubeSections] "Коэффициент гидравлического сопротивления участка трубы";
    Real x_v[numberOfTubeSections] "Степень сухости";
    Medium_F.Density dew_rho_flow_v[numberOfTubeSections] "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
    Medium_F.Density bubble_rho_flow_v[numberOfTubeSections] "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
    //**
    //Интерфейс
    //**
    Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {112, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0), iconTransformation(origin = {130, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-112, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0), iconTransformation(origin = {-130, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  equation
//Рачет скорости потока в узловых точках
    for i in 1:numberOfTubeSections + 1 loop
      rho_flow_n[i] = Medium_F.density_ph(p_flow_n[i], h_flow_n[i]) "Расчет плотности вода/пар в узловых точках";
      w_flow_n[i] = D_flow_n[i] / rho_flow_n[i] / f_flow "Расчет скорости потока вода/пар в узловых точках";
    end for;
    for i in 1:numberOfTubeSections loop
//Уравнения состояния
      stateFlow[i] = Medium_F.setState_ph(p_flow_v[i], h_flow_v[i]);
      t_flow[i] = Medium_F.temperature(stateFlow[i]);
      rho_flow_v[i] = Medium_F.density(stateFlow[i]);
      drdp_flow[i] = if Medium_F.singleState then 0 else Medium_F.density_derp_h(stateFlow[i]);
      drdh_flow[i] = Medium_F.density_derh_p(stateFlow[i]);
//Коэффициент теплоотдачи
      k_flow[i] = Medium_F.thermalConductivity(stateFlow[i]);
      Pr_flow[i] = Medium_F.prandtlNumber(stateFlow[i]);
      mu_flow[i] = Medium_F.dynamicViscosity(stateFlow[i]);
      w_flow_v[i] = D_flow_v[i] / rho_flow_v[i] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
//Re_flow[i] = abs(w_flow_v[i] * Din * rho_flow_v[i] / mu_flow[i]);
      Re_flow[i] = 5000 "Упрощение для расчета циркуляции";
//alfa_flow[i] = 0.023 * k_flow[i] / Din * Re_flow[i] ^ 0.8 * Pr_flow[i] ^ 0.4;
      alfa_flow[i] = 6000 "Упрощение для расчета циркуляции";
//Про две фазы
      sat_v[i] = Medium_F.setSat_T(t_flow[i]);
      x_v[i] = Medium_F.vapourQuality(stateFlow[i]);
      dew_rho_flow_v[i] = Medium_F.dewDensity(sat_v[i]);
      bubble_rho_flow_v[i] = Medium_F.bubbleDensity(sat_v[i]);
//Уравнения для расчета процесса теплообмена
//Осреднение по конечному объему
//h_flow_v[i] = (h_flow_n[i + 1] + h_flow_n[i]) / 2;
      h_flow_v[i] = h_flow_n[i + 1];
//Уравнение баланса тепла теплоносителя (формула 3-1d диссертации Рубашкина)
      deltaVFlow * rho_flow_v[i] * der(h_flow_v[i]) = alfa_flow[i] * deltaSFlow * (t_m[i] - t_flow[i]) - D_flow_v[i] * (h_flow_n[i + 1] - h_flow_n[i]) "Уравнение баланса тепла теплоносителя для нечетных ходов";
      deltaMMetal * C_m * der(t_m[i]) = -alfa_flow[i] * deltaSFlow * (t_m[i] - t_flow[i]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина) при Q_flow = 0";
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
      p_flow_v[i] = (p_flow_n[i + 1] + p_flow_n[i]) / 2;
      D_flow_v[i] = (D_flow_n[i + 1] + D_flow_n[i]) / 2;
//Основное уравнение гидравлики
      wrhop[i] = w_flow_v[i] * rho_flow_v[i] * p_flow_v[i] * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
      Xi_flow[i] = lambda_tr(Din, ke, Re_flow[i]) * Lpipe / Din / numberOfTubeSections;
      phi[i] = phi_heatedPipe(wrhop[i], p_flow_v[i] / 100000, x_v[i]) "Расчет коэффициента phi";
      if x_v[i] < 1 and x_v[i] > 0 then
        dp_fric[i] = w_flow_v[i] ^ 2 * Xi_flow[i] * rho_flow_v[i] / 2 / Modelica.Constants.g_n * (1 + x_v[i] * phi[i] * (bubble_rho_flow_v[i] / dew_rho_flow_v[i] - 1)) "Потеря давления от трения";
      else
        dp_fric[i] = w_flow_v[i] ^ 2 * Xi_flow[i] * rho_flow_v[i] / 2 / Modelica.Constants.g_n "Потеря давления от трения";
      end if;
//dp_kin[i] = w_flow_v[i] * (w_flow_n[i + 1] - w_flow_n[i]) * rho_flow_v[i] / Modelica.Constants.g_n "Потеря давления из-за приращения кинетической энергии";
      H_flow[i + 1] = H_flow[i] + deltaHpipe;
//dp_piez[i] = rho_flow_v[i] * (H_flow[i + 1] - H_flow[i]) "Расчет перепада давления из-за изменения пьезометрической высоты";
      dp_piez[i] = (rho_flow_n[i + 1] * H_flow[i + 1] - rho_flow_n[i] * H_flow[i]) * Modelica.Constants.g_n "Расчет перепада давления из-за изменения пьезометрической высоты";
//p_flow_n[i] - p_flow_n[i + 1] = dp_fric[i] + dp_kin[i] + dp_piez[i] "Формула 2-1 из книги Рудомино, Ремжин";
      p_flow_n[i] - p_flow_n[i + 1] = dp_fric[i] + dp_piez[i] "Формула 2-1 из книги Рудомино, Ремжин";
//БЕЗ p_kin
//p_flow_n[i, j + 1] - p_flow_n[i, j] = 0 "Упрощение при расчете давления";
      D_flow_n[i] - D_flow_n[i + 1] = C1[i] + C2[i] "Уравнение сплошности (формула 3-6 диссертации Рубашкина) drdp_flow[i, j] - абсолютный ноль, смотри уравнения состояния";
//D_flow_n[i, j] - D_flow_n[i, j + 1] = 0 "Упрощение при расчете расходов";
      if time > Tstab then
        C1[i] = 0;
        C2[i] = 0;
      else
        C1[i] = deltaVFlow * drdh_flow[i] * der(h_flow_v[i]);
//C2[i, j] = if time < 200 then 0 else numberPMCalcSections * deltaVFlow * HTtoMT_sum(drdp_flow[i, :], numberPMCalcSections, j) * der(p_flow_v[i, j]);
        C2[i] = deltaVFlow * drdp_flow[i] * (p_flow_v[i] - delay(p_flow_v[i], 0.2)) / 0.2;
      end if;
    end for;
//Граничные условия
    H_flow[1] = Hpipe_in "Задание высотной отметки входного коллектора";
    waterIn.m_flow = D_flow_n[1];
    0 = waterOut.m_flow + D_flow_n[numberOfTubeSections + 1];
    waterOut.p = p_flow_n[numberOfTubeSections + 1];
    waterIn.p = p_flow_n[1];
    if waterIn.m_flow > 0 then
      h_flow_n[1] = inStream(waterIn.h_outflow);
    else
      h_flow_n[numberOfTubeSections + 1] = inStream(waterOut.h_outflow);
    end if;
    waterOut.h_outflow = h_flow_n[numberOfTubeSections + 1];
    waterIn.h_outflow = h_flow_n[1];
  initial equation
    for i in 1:numberOfTubeSections loop
      der(h_flow_v[i]) = 0;
      der(t_m[i]) = 0;
    end for;
    annotation(defaultComponentName = "pipe", Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 40}, {100, -40}}, fillPattern = FillPattern.Solid, fillColor = {95, 95, 95}, pattern = LinePattern.None), Rectangle(extent = {{-100, 44}, {100, -44}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {0, 127, 255})}), Documentation(info = "<html>

</html>"));
  end pipe;

  model simpleDrum "Модель барабана для моделирования циркуляции"
    //Вспомогательные функции
    extends Drum_Icon;

    function drumWaterVolume "Формула для расчета объема воды в барабане"
      extends Modelica.Icons.Function;
      input Real R "внутренний радиус барабана";
      input Real L "длина барабана";
      input Real Hw "уровень воды в барабане";
      output Real V "объем занимаемый водой в барабане";
    protected
      Real alfa;
      Real Ssec;
      Real Str;
      Real p;
      Real H;
    algorithm
      H := if Hw < R then Hw else 2 * R - Hw;
      alfa := 2 * acos((R - H) / R);
      Ssec := alfa * R ^ 2 / 2;
      Str := (R - H) * R * sin(alfa / 2);
      V := if Hw < R then (Ssec - Str) * L else (Modelica.Constants.pi * R ^ 2 - (Ssec - Str)) * L;
    end drumWaterVolume;

    function drumMetallVolume "Объем металла над и под уровнем воды в барабане"
      extends Modelica.Icons.Function;
      input Real R "внутренний радиус барабана";
      input Real delta "толщина стенки барабана";
      input Real L "длина барабана";
      input Real Hw "уровень воды в барабане";
      input String area "верх или низ барабана";
      output Real V "масса металла";
    protected
      Real alfa;
      Real H;
      Real Ssec_ext;
      Real Ssec_int;
      Real Smetall_ring;
      Real Str;
      Real Vbottom;
      Real Vtop;
    algorithm
      H := if Hw < R then Hw else 2 * R - Hw;
      alfa := 2 * acos((R - H) / R);
      Ssec_ext := alfa * (R + delta) ^ 2 / 2;
      Ssec_int := alfa * R ^ 2 / 2;
      Smetall_ring := Modelica.Constants.pi * ((R + delta) ^ 2 - R ^ 2);
      Str := (R - H) * R * sin(alfa / 2);
      Vbottom := if Hw < R then (Ssec_ext - Ssec_int) * L + 2 * (Ssec_int - Str) * delta else (Smetall_ring - (Ssec_ext - Ssec_int)) * L + 2 * (Modelica.Constants.pi * R ^ 2 - (Ssec_int - Str)) * delta;
      Vtop := if Hw > R then (Ssec_ext - Ssec_int) * L + 2 * (Ssec_int - Str) * delta else (Smetall_ring - (Ssec_ext - Ssec_int)) * L + 2 * (Modelica.Constants.pi * R ^ 2 - (Ssec_int - Str)) * delta;
      V := if area == "top" then Vtop else Vbottom;
    end drumMetallVolume;

    //***Исходные данные
    replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    parameter Real k = 0.9 "Доля пара, которая практически сразу выделяется из водяного объема";
    //***Геометрические характеристики барабана
    parameter Modelica.SIunits.Length Din "Внутренний диаметр барабана";
    parameter Modelica.SIunits.Length L "Длина барабана";
    parameter Modelica.SIunits.Length delta "Толщина стенки барабана";
    //**
    //***Характеристики металла
    parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
    //**
    //Начальные значения
    //**
    parameter Modelica.SIunits.Length Hw_start = 0.5 "Начальное значение уровня воды в барабане";
    parameter Medium.AbsolutePressure ps_start "Начальное значение давления пара в барабане";
    parameter Medium.Temperature t_start "Стартовая температура";
    parameter Medium.SaturationProperties sat_start "State vector to compute saturation properties для парового объема (стартовый)";
    parameter Medium.SpecificEnthalpy hout "Энтальпия на входе в опускной стояк";
    parameter Modelica.SIunits.Volume Vw_start = drumWaterVolume(Din / 2, L, Hw_start);
    parameter Modelica.SIunits.Mass Gw_start = Vw_start * Medium.bubbleDensity(Medium.setSat_p(ps_start));
    //**
    //Переменные
    //**
    Modelica.SIunits.Volume Vs "Объем парового пространства барабана";
    Medium.Temperature ts "Температура насыщения в барабане";
    Medium.ThermodynamicState state_eco "Термодинамическое состояние потока питательной воды";
    Real x_eco "Степень сухости питательной воды";
    Medium.ThermodynamicState state_upStr "Термодинамическое состояние потока в подъемных трубах испарительного контура";
    Real x_upStr "Степень сухости в подъемных трубах испарительного контура";
    Medium.SaturationProperties sat "State vector to compute saturation properties для парового объема";
    Medium.Temperature t_m_steam(start = t_start) "Температура металла паровой части барабана";
    Medium.Temperature t_m_water(start = t_start) "Температура металла водяной части барабана";
    Medium.MassFlowRate D_fw "Расход питательной воды";
    Medium.MassFlowRate D_st_circ "Пар поступающий в паровое пространство барабана из циркуляционных контуров ";
    Medium.MassFlowRate D_st_eco "Расход пара из питательной воды или необходимый для нагрева до h' недогретой питательной воды";
    Medium.MassFlowRate Dsteam(start = -1.44504, nominal = -1.44504) "Расход пара из барабана";
    Medium.MassFlowRate D_cond_dr "Пар конденсирующийся на стенках барабана";
    Modelica.SIunits.Mass G_m_steam(start = rho_m * drumMetallVolume(Din / 2, delta, L, Hw_start, "top")) "Масса металла паровой части барабана";
    Modelica.SIunits.Mass G_m_water(start = rho_m * drumMetallVolume(Din / 2, delta, L, Hw_start, "bottom")) "Масса металла водяной части барабана";
    Modelica.SIunits.DerDensityByPressure d_rhoDew_by_press "Производная плотности сухого пара от давления";
    //Проверить правильно ли то, что здесь bubble!!!
    Medium.MassFlowRate Dvipar "Выпар в паровой объем";
    Modelica.SIunits.Length Hw(start = Hw_start) "Уровень воды в барабане";
    Modelica.SIunits.Volume Vw(start = Vw_start, nominal = Vw_start, min = 0, max = drumWaterVolume(Din / 2, L, Din)) "Объем водяной части барабана";
    Medium.MassFlowRate D_downStr(min = -500, max = -10) "Расход воды в опускные трубы циркуляционных контуров";
    Medium.MassFlowRate D_upStr(min = 10, max = 500) "Расход пароводяной среды в подъемных трубах циркуляционных контуров";
    Medium.AbsolutePressure ps(start = ps_start) "Давление насыщения в барабане";
    Medium.SpecificEnthalpy h_dew(start = Medium.bubbleEnthalpy(sat_start)) "Энтальпия пара на линии насыщения при давлении в барабане";
    Medium.SpecificEnthalpy h_bubble(start = Medium.bubbleEnthalpy(sat_start)) "Энтальпия воды на линии насыщения при давлении в барабане";
    //Medium.AbsolutePressure pw(start = ps_start) "Давление воды в барабане";
    Medium.AbsolutePressure pw(start = ps_start + 0.5 * Hw_start * Medium.bubbleDensity(Medium.setSat_p(ps_start)) * Modelica.Constants.g_n) "Давление воды в барабане";
    Medium.Density rhow "Плотность воды в барабане";
    Medium.SpecificEnthalpy hw(start = Medium.bubbleEnthalpy(sat_start)) "Энтальпия воды в водяном объеме";
    Medium.ThermodynamicState state_w "Термодинамическое состояние воды в водяном объеме";
    Real x_w "Степень сухости воды в водяном объеме";
    Modelica.SIunits.Mass Gw(start = Gw_start, nominal = drumWaterVolume(Din / 2, L, Hw_start) * Medium.bubbleDensity(Medium.setSat_p(ps_start)), min = 0, fixed = true) "Масса воды в барабане";
    Medium.SaturationProperties sat_w "State vector to compute saturation properties для водяного объема";
    Medium.MassFlowRate D_w_circ "Вода поступающая в водяное пространство барабана из циркуляционных контуров ";
    Medium.MassFlowRate D_w_eco "Расход воды из экономайзера, с учетом выделившегося или дополнительно конденсировавшегося пара";
    Medium.Density rhow_dew "Плотность воды на линии насыщения в водяном объеме барабана";
    Medium.Density rhow_bubble "Плотность пара на линии насыщения в водяном объеме барабана";
    ///Новые
    Boolean Hysteresis;
    parameter Modelica.SIunits.Time Tstab "Интервал времени в начале расчета в течение которого все производные равны нулю";
    //***Интерфейс
    Modelica.Fluid.Interfaces.FluidPort_a fedWater(redeclare package Medium = Medium) annotation(Placement(visible = true, transformation(origin = {-104, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b steam(redeclare package Medium = Medium) annotation(Placement(visible = true, transformation(origin = {62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b downStr(redeclare package Medium = Medium) annotation(Placement(visible = true, transformation(origin = {-62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a upStr(redeclare package Medium = Medium) annotation(Placement(visible = true, transformation(origin = {104, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput waterLevel annotation(Placement(visible = true, transformation(origin = {112, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput FW_feedback annotation(Placement(visible = true, transformation(origin = {112, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
//Временные ур-я
//Hw = 0.5;
    fedWater.m_flow = D_fw;
//D_fw = FW_feedback; //ЗАМЕНА!!!!!!!!!!!!
    FW_feedback = -Dsteam;
    waterLevel = Hw;
//Паровое пространство барабана
    state_eco = Medium.setState_ph(ps, inStream(fedWater.h_outflow));
    x_eco = Medium.vapourQuality(state_eco);
    state_upStr = Medium.setState_ph(ps, inStream(upStr.h_outflow));
    x_upStr = Medium.vapourQuality(state_upStr);
    sat = Medium.setSat_p(ps);
    ts = Medium.saturationTemperature_sat(sat);
    h_dew = Medium.dewEnthalpy(sat);
    h_bubble = Medium.bubbleEnthalpy(sat);
    t_m_steam = ts "Принимаем, что верхняя стенка барабанна в каждый момент времени равна температуре насыщения в паровом пространстве барабана";
    D_st_circ = D_upStr * x_upStr;
    D_st_eco = D_fw * (inStream(fedWater.h_outflow) - h_bubble) / (h_dew - h_bubble);
    G_m_steam = rho_m * drumMetallVolume(Din / 2, delta, L, Hw, "top");
//G_m_steam = rho_m * 1000; //!!!!!!!!!!!ЗАМЕНА
    D_cond_dr * (h_dew - h_bubble) = G_m_steam * C_m * der(t_m_steam);
//D_cond_dr = 0; //Временная замена ур-я выше
    der(ps) = (D_st_circ + D_st_eco + Dvipar + Dsteam - D_cond_dr) / Vs / d_rhoDew_by_press "Уравнение определения давления в паровом пространстве";
//0 = (D_st_circ + D_st_eco + Dvipar + Dsteam - D_cond_dr) / Vs / d_rhoDew_by_press "Уравнение определения давления в паровом пространстве"; //Временная замена ур-я выше
    ps = steam.p;
    d_rhoDew_by_press = Medium.dDewDensity_dPressure(sat);
    Vs = 0.25 * Modelica.Constants.pi * Din ^ 2 * L - Vw;
//Водяное пространство барабана
    D_w_circ = D_upStr * (1 - x_upStr);
    D_w_eco = D_fw * (h_dew - inStream(fedWater.h_outflow)) / (h_dew - h_bubble);
    Dvipar = Gw * x_w * k;
    pw = ps + 0.5 * Hw * rhow * Modelica.Constants.g_n;
    sat_w = Medium.setSat_p(pw);
    rhow = Medium.density_ph(pw, hw);
    state_w = Medium.setState_ph(pw, hw);
    x_w = Medium.vapourQuality(state_w);
    t_m_water = Medium.saturationTemperature(pw) "Принимаем, что нижняя стенка барабанна в каждый момент времени равна температуре насыщения в водяном пространстве барабана";
    G_m_water = rho_m * drumMetallVolume(Din / 2, delta, L, Hw, "bottom");
//G_m_water = rho_m * 5000;//!!!!!!!!!!!!ЗАМЕНА
    D_w_circ + D_w_eco + D_cond_dr + D_downStr - Dvipar = der(Gw);
//D_w_circ * h_dew + D_w_eco * h_dew - D_downStr * hw - Dvipar * h_bubble = der(Gw * hw + G_m_water * C_m * t_m_water);
    D_w_circ * h_bubble + D_w_eco * h_bubble + D_downStr * hw - Dvipar * h_dew = Gw * der(hw);
//Упрощенная формула, не учитывается масса металла
    rhow_dew = Medium.dewDensity(sat_w);
    rhow_bubble = Medium.bubbleDensity(sat_w);
    Vw = Gw * (1 - x_w) / rhow_bubble + Gw * x_w * (1 - k) / rhow_dew;
    Vw = drumWaterVolume(Din / 2, L, Hw);
//Vw = 1000; //!!!!!!!!!ЗАМЕНА
//Уравнение циркуляции
    Hysteresis = inStream(upStr.h_outflow) > h_bubble + 1000 or pre(D_downStr) < (-10) and inStream(upStr.h_outflow) > h_bubble - 100;
    if initial() then
      D_downStr = -1;
    elseif time < 3500 then
//downStr.p > pre(pw) or pre(D_downStr) > -0.5  then
      D_downStr = -1;
    else
      pre(pw) = downStr.p;
    end if;
/*Hysteresis = inStream(upStr.h_outflow) > h_bubble + 1000 or pre(downStr.m_flow) < - 10 and inStream(upStr.h_outflow) > (h_bubble - 100);

if Hysteresis then
pw = downStr.p;
else
downStr.m_flow = -10;
end if;*/
//Питательная вода
    fedWater.h_outflow = hw;
    fedWater.p = ps;
//Выход насыщенного пара
    steam.h_outflow = h_dew;
//steam.h_outflow = Medium.dewEnthalpy(sat_start);//!!!!!ЗАМЕНА
    steam.m_flow = Dsteam;
//steam.m_flow = -1.44504; //!!!!!ЗАМЕНА
//Опускной стояк
    downStr.h_outflow = hw;
//downStr.h_outflow = Medium.bubbleEnthalpy(sat_start);//!!!!!ЗАМЕНА
    downStr.m_flow = D_downStr;
//Подъемные трубы
    upStr.h_outflow = hw;
    upStr.p = pw;
//upStr.p = ps_start; //!!!!!!!!ЗАМЕНА
    upStr.m_flow = D_upStr;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), uses(Modelica(version = "3.2.1")));
  end simpleDrum;

  model HE_Icon
    annotation(Icon(graphics = {Rectangle(lineColor = {255, 85, 0}, fillColor = {255, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, borderPattern = BorderPattern.Raised, extent = {{-52, 100}, {52, -100}}), Rectangle(origin = {-40, 0}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 84}, {5, -84}}), Rectangle(origin = {0, -89}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, extent = {{-52, -11}, {52, 5}}), Rectangle(lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 84}, {5, -84}}), Rectangle(origin = {-20, 0}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 84}, {5, -84}}), Rectangle(origin = {20, 0}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 84}, {5, -84}}), Rectangle(origin = {40, 0}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, extent = {{-5, 84}, {5, -84}}), Rectangle(origin = {0, 95}, lineColor = {162, 162, 162}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, extent = {{-52, -11}, {52, 5}}), Text(origin = {1, 3}, extent = {{-35, 21}, {35, -21}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)), Diagram(coordinateSystem(extent = {{-52, -130}, {52, 130}})), version = "", uses);
  end HE_Icon;

  model Drum_Icon
    annotation(Diagram(coordinateSystem(initialScale = 0.1)), Icon(graphics = {Ellipse(origin = {-92, 11}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8, 69}, {32, -91}}, endAngle = 360), Ellipse(origin = {68, 11}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8, 69}, {32, -91}}, endAngle = 360), Rectangle(fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Ellipse(origin = {-77, 0}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, extent = {{-17, 74}, {13, -74}}, endAngle = 360), Ellipse(origin = {81, 0}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, extent = {{-17, 74}, {13, -74}}, endAngle = 360), Rectangle(lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, extent = {{-80, 74}, {80, -74}}), Polygon(origin = {0, -33}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-80, -41}, {-84, -37}, {-88, -27}, {-90, -17}, {-92, -7}, {-94, 15}, {-94, 35}, {-88, 37}, {-78, 39}, {-70, 39}, {-62, 37}, {-54, 33}, {-44, 29}, {-34, 27}, {-22, 29}, {-14, 33}, {-4, 37}, {10, 37}, {20, 33}, {34, 29}, {42, 29}, {56, 31}, {64, 35}, {70, 39}, {76, 41}, {84, 41}, {92, 39}, {94, 37}, {94, 27}, {94, 13}, {92, -5}, {90, -17}, {88, -27}, {86, -33}, {84, -37}, {80, -41}, {-80, -41}}), Ellipse(origin = {-77, -27}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {5, -5}}, endAngle = 360), Ellipse(origin = {-67, -5}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {-67, -5}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {-3, -13}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {5, -5}}, endAngle = 360), Ellipse(origin = {19, -53}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {5, -5}}, endAngle = 360), Ellipse(origin = {-69, -61}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {-41, -23}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {45, -29}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {1, -43}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {-33, -55}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {5, -5}}, endAngle = 360), Ellipse(origin = {63, -45}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {5, -5}}, endAngle = 360), Ellipse(origin = {79, -13}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {45, -65}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
  end Drum_Icon;

  package Choices
    type HRSG_type = enumeration(verticalBottom "Вертикальный КУ входной коллектор внизу", verticalTop "Вертикальный КУ входной коллектор наверху", horizontalBottom "Гоизонтальный КУ входной коллектор внизу", horizontalTop "Гоизонтальный КУ входной коллектор наверху") "Тип котла-утилизатора (вертикальный/горизонтальный)";
  end Choices;

  model Separator_Icon
    annotation(Icon(graphics = {Ellipse(origin = {0, 95}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-40, 5}, {40, -7}}, endAngle = 360), Rectangle(origin = {0, 31}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-40, 63}, {40, -61}}), Ellipse(origin = {0, -29}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-40, 5}, {40, -7}}, endAngle = 360), Rectangle(origin = {0, -64}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-10, 34}, {10, -34}}), Ellipse(origin = {1, -99}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-11, -1}, {9, 3}}, endAngle = 360), Ellipse(origin = {-3, 91}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-35, 7}, {41, -5}}, endAngle = 360), Ellipse(origin = {0, -28}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-38, 4}, {38, -4}}, endAngle = 360), Rectangle(origin = {0, 32}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-38, 60}, {38, -60}}), Rectangle(origin = {0, -64}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8, 34}, {8, -32}}), Ellipse(origin = {0, -97}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8, 3}, {8, -1}}, endAngle = 360), Ellipse(origin = {-60, 70}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-1, 6}, {1, -4}}, endAngle = 360), Rectangle(extent = {{-68, 74}, {-68, 74}}), Polygon(origin = {-49, 68}, fillColor = {162, 162, 162}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{11, 2}, {-11, 8}, {-11, -2}, {11, -8}, {11, 2}}), Ellipse(extent = {{-60, 76}, {-60, 76}}, endAngle = 360), Ellipse(origin = {-59.2, 70.8}, lineColor = {255, 255, 255}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, extent = {{-1, 4.2}, {1, -4.2}}, endAngle = 360), Polygon(origin = {-48.2, 68}, lineColor = {255, 255, 255}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, points = {{-11, 7}, {-11, 7}, {11, 1}, {11, -7.4}, {-11, -1.4}, {-11, 7}}), Polygon(origin = {0, 57}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, points = {{-38, -35}, {-38, 35}, {-36, 37}, {-28, 39}, {-10, 41}, {10, 41}, {28, 39}, {36, 37}, {38, 35}, {38, -37}, {34, -35}, {26, -33}, {18, -33}, {12, -35}, {6, -39}, {-2, -41}, {-10, -41}, {-18, -39}, {-24, -37}, {-34, -35}, {-38, -35}, {-38, -35}}), Polygon(origin = {-11.28, 51.17}, lineColor = {255, 255, 255}, fillColor = {0, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.CrossDiag, points = {{-26.7236, 18}, {11.2764, 6.83018}, {27.2764, -1.16982}, {9.27639, 4.83018}, {23.2764, -7.16982}, {5.27639, 2.83018}, {19.2764, -9.16982}, {-0.723607, 2.83018}, {13.2764, -11.1698}, {-4.72361, 0.830179}, {5.27639, -13.1698}, {-2.72361, -5.16982}, {3.27639, -19.1698}, {-10.7236, -1.16982}, {-0.723607, -19.1698}, {-14.7236, -1.16982}, {-4.72361, -19.1698}, {-16.7236, -3.16982}, {-12.7236, -19.1698}, {-18.7236, -3.16982}, {-18.7236, -19.1698}, {-22.7236, -1.16982}, {-26.7236, 9.5}, {-26.7236, 18}}), Ellipse(origin = {-28, 8}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-4, 4}, {4, -4}}, endAngle = 360), Ellipse(origin = {24, 6}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-4, 4}, {4, -4}}, endAngle = 360), Ellipse(origin = {-25, -15}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {1, 5}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-3, 3}, {3, -3}}, endAngle = 360), Ellipse(origin = {10, -14}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-2, 2}, {2, -2}}, endAngle = 360), Ellipse(origin = {30, -24}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-4, 4}, {4, -4}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
  end Separator_Icon;

  model Separator
    function positiveMax
      extends Modelica.Icons.Function;
      input Real x;
      output Real y;
    algorithm
      y := max(x, 1e-3);
    end positiveMax;

    //Вспомогательные функции
    extends Separator_Icon;

    function separatorWaterVolume "Формула для расчета объема воды в сепараторе"
      extends Modelica.Icons.Function;
      input Real R "внутренний радиус сепаратора";
      input Real Hw "уровень воды в сепараторе";
      output Real V "объем занимаемый водой в сепараторе";
    algorithm
      V := Hw * Modelica.Constants.pi * R ^ 2;
    end separatorWaterVolume;

    function separatorMetallVolume "Объем металла над и под уровнем воды в сепараторе"
      extends Modelica.Icons.Function;
      input Real R "внутренний радиус барабана";
      input Real delta "толщина стенки барабана";
      input Real L "длина сепаратора";
      input Real Hw "уровень воды в сепараторе";
      input String area "верх или низ сепаратора";
      output Real V "объем металла";
    protected
      Real Vbottom;
      Real Vtop;
    algorithm
      Vbottom := Hw * Modelica.Constants.pi * ((R + delta) ^ 2 - R ^ 2) + delta * Modelica.Constants.pi * R ^ 2;
      Vtop := (L - Hw) * Modelica.Constants.pi * ((R + delta) ^ 2 - R ^ 2) + delta * Modelica.Constants.pi * R ^ 2;
      V := if area == "top" then Vtop else Vbottom;
    end separatorMetallVolume;

    //***Исходные данные
    replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    parameter Real k = 0.9 "Доля пара, которая практически сразу выделяется из водяного объема";
    //***Геометрические характеристики сепаратора
    parameter Integer n_sep = 1 "Количество сепараторов";
    parameter Modelica.SIunits.Length Din "Внутренний диаметр сепаратора";
    parameter Modelica.SIunits.Length L "Длина (высота) сепаратора";
    parameter Modelica.SIunits.Length delta "Толщина стенки сепаратора";
    //**
    //***Характеристики металла
    parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
    //**
    //Начальные значения
    //**
    parameter Modelica.SIunits.Length Hw_start = 2 "Начальное значение уровня воды в сепараторе";
    parameter Medium.AbsolutePressure ps_start "Начальное значение давления пара в барабане";
    parameter Medium.Temperature t_start "Стартовая температура";
    parameter Medium.SaturationProperties sat_start "State vector to compute saturation properties для парового объема (стартовый)";
    parameter Modelica.SIunits.Volume Vw_start = separatorWaterVolume(Din / 2, Hw_start);
    parameter Modelica.SIunits.Mass Gw_start = Vw_start * Medium.bubbleDensity(Medium.setSat_p(ps_start));
    //**
    //Переменные
    //**
    Modelica.SIunits.Volume Vs "Объем парового пространства сепаратора";
    Medium.Temperature ts "Температура насыщения в сепараторе";
    Medium.ThermodynamicState state_eco "Термодинамическое состояние потока питательной воды";
    Real x_eco "Степень сухости питательной воды";
    Medium.SaturationProperties sat "State vector to compute saturation properties для парового объема";
    Medium.Temperature t_m_steam(start = t_start) "Температура металла паровой части барабана";
    Medium.Temperature t_m_water(start = t_start) "Температура металла водяной части барабана";
    Medium.MassFlowRate D_fw "Расход питательной воды";
    Medium.MassFlowRate D_st_eco "Расход пара из питательной воды или необходимый для нагрева до h' недогретой питательной воды";
    Medium.MassFlowRate Dsteam(start = -1.44504, nominal = -1.44504) "Расход пара из сепаратора";
    Medium.MassFlowRate D_cond_dr "Пар конденсирующийся на стенках барабана";
    Modelica.SIunits.Mass G_m_steam(start = rho_m * separatorMetallVolume(Din / 2, delta, L, Hw_start, "top")) "Масса металла паровой части сепаратора";
    Modelica.SIunits.Mass G_m_water(start = rho_m * separatorMetallVolume(Din / 2, delta, L, Hw_start, "bottom")) "Масса металла водяной части сепараратора";
    Modelica.SIunits.DerDensityByPressure d_rhoDew_by_press "Производная плотности сухого пара от давления";
    Medium.MassFlowRate Dvipar "Выпар в паровой объем";
    Modelica.SIunits.Length Hw(start = Hw_start) "Уровень воды в сепараторе";
    Modelica.SIunits.Volume Vw(start = Vw_start, nominal = Vw_start, min = 0, max = separatorWaterVolume(Din / 2, L)) "Объем водяной части барабана";
    Medium.MassFlowRate D_downStr "Расход воды в сливную трубу";
    Medium.AbsolutePressure ps(start = ps_start) "Давление насыщения в сепараторе";
    Medium.SpecificEnthalpy h_dew(start = Medium.bubbleEnthalpy(sat_start)) "Энтальпия пара на линии насыщения при давлении в сепараторе";
    Medium.SpecificEnthalpy h_bubble(start = Medium.bubbleEnthalpy(sat_start)) "Энтальпия воды на линии насыщения при давлении в сепараторе";
    Medium.AbsolutePressure pw(start = ps_start + 0.5 * Hw_start * Medium.bubbleDensity(Medium.setSat_p(ps_start)) * Modelica.Constants.g_n) "Давление воды в барабане";
    Medium.Density rhow "Плотность воды в сепараторе";
    Medium.SpecificEnthalpy hw(start = Medium.bubbleEnthalpy(sat_start)) "Энтальпия воды в водяном объеме";
    Medium.ThermodynamicState state_w "Термодинамическое состояние воды в водяном объеме";
    Real x_w "Степень сухости воды в водяном объеме";
    Modelica.SIunits.Mass Gw(start = Gw_start, nominal = separatorWaterVolume(Din / 2, Hw_start) * Medium.bubbleDensity(Medium.setSat_p(ps_start)), min = 0, fixed = true) "Масса воды в барабане";
    Medium.SaturationProperties sat_w "State vector to compute saturation properties для водяного объема";
    Medium.MassFlowRate D_w_eco "Расход воды из экономайзера, с учетом выделившегося или дополнительно конденсировавшегося пара";
    Medium.Density rhow_dew "Плотность воды на линии насыщения в водяном объеме сепаратора";
    Medium.Density rhow_bubble "Плотность пара на линии насыщения в водяном объеме сепаратора";
    //***Интерфейс
    Modelica.Fluid.Interfaces.FluidPort_a fedWater(redeclare package Medium = Medium) annotation(Placement(visible = true, transformation(origin = {-104, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b steam(redeclare package Medium = Medium) annotation(Placement(visible = true, transformation(origin = {62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b downStr(redeclare package Medium = Medium) annotation(Placement(visible = true, transformation(origin = {-62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput waterLevel annotation(Placement(visible = true, transformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput steamFeedback annotation(Placement(visible = true, transformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput drainFeedback annotation(Placement(visible = true, transformation(origin = {110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
//Временные ур-я
    fedWater.m_flow = D_fw;
    steamFeedback = -Dsteam;
    drainFeedback = -(D_fw + Dsteam);
//С обратной связью надо что-то делать!!!
    waterLevel = Hw;
//Паровое пространство барабана
    state_eco = Medium.setState_ph(ps, inStream(fedWater.h_outflow));
    x_eco = Medium.vapourQuality(state_eco);
    sat = Medium.setSat_p(ps);
    ts = Medium.saturationTemperature_sat(sat);
    h_dew = Medium.dewEnthalpy(sat);
    h_bubble = Medium.bubbleEnthalpy(sat);
    t_m_steam = ts "Принимаем, что верхняя стенка барабанна в каждый момент времени равна температуре насыщения в паровом пространстве барабана";
    D_st_eco = D_fw * (if inStream(fedWater.h_outflow) > h_dew then 1 elseif inStream(fedWater.h_outflow) < h_bubble then 0 else (inStream(fedWater.h_outflow) - h_bubble) / (h_dew - h_bubble));
    G_m_steam = rho_m * n_sep * separatorMetallVolume(Din / 2, delta, L, Hw, "top");
    D_cond_dr * (h_dew - h_bubble) = G_m_steam * C_m * der(t_m_steam);
    der(ps) = (D_st_eco + Dvipar + Dsteam - D_cond_dr) / Vs / d_rhoDew_by_press "Уравнение определения давления в паровом пространстве";
    ps = steam.p;
    d_rhoDew_by_press = Medium.dDewDensity_dPressure(sat);
    Vs = n_sep * 0.25 * Modelica.Constants.pi * Din ^ 2 * L - Vw;
//Водяное пространство барабана
    D_w_eco = D_fw * (if inStream(fedWater.h_outflow) > h_dew then 0 elseif inStream(fedWater.h_outflow) < h_bubble then 1 else (h_dew - inStream(fedWater.h_outflow)) / (h_dew - h_bubble));
    Dvipar = Gw * x_w * k;
    pw = ps + 0.5 * Hw * rhow * Modelica.Constants.g_n;
    sat_w = Medium.setSat_p(pw);
    rhow = Medium.density_ph(pw, hw);
    state_w = Medium.setState_ph(pw, hw);
    x_w = Medium.vapourQuality(state_w);
    t_m_water = Medium.saturationTemperature(pw) "Принимаем, что нижняя стенка барабанна в каждый момент времени равна температуре насыщения в водяном пространстве барабана";
    G_m_water = rho_m * separatorMetallVolume(Din / 2, delta, L, Hw, "bottom");
    D_w_eco + D_cond_dr + D_downStr - Dvipar = der(Gw);
//D_w_circ * h_dew + D_w_eco * h_dew - D_downStr * hw - Dvipar * h_bubble = der(Gw * hw + G_m_water * C_m * t_m_water);
    D_w_eco * h_bubble + D_downStr * hw - Dvipar * h_dew = Gw * der(hw);
//Упрощенная формула, не учитывается масса металла
    rhow_dew = Medium.dewDensity(sat_w);
    rhow_bubble = Medium.bubbleDensity(sat_w);
    Vw = Gw * (1 - x_w) / rhow_bubble + Gw * x_w * (1 - k) / rhow_dew;
    Vw = n_sep * separatorWaterVolume(Din / 2, Hw);
//Питательная вода
    fedWater.h_outflow = hw;
    fedWater.p = ps;
//Выход насыщенного пара
    steam.h_outflow = if inStream(fedWater.h_outflow) > h_dew then inStream(fedWater.h_outflow) else h_dew;
    steam.m_flow = -positiveMax(-Dsteam);
//Опускной стояк
    downStr.h_outflow = if inStream(fedWater.h_outflow) < h_bubble then inStream(fedWater.h_outflow) else hw;
    downStr.m_flow = D_downStr;
    downStr.p = pw;
    annotation(uses(Modelica(version = "3.2.1")));
  end Separator;

  function razbivka_n
    input Real firstValue "первое значение";
    input Real endValue "последнее значение";
    input Integer zahod "число заходов";
    input Integer numberOfFlueSections;
    input Integer numberOfTubeSections;
    output Real x[numberOfFlueSections, numberOfTubeSections];
  protected
    Real delta "разность между значениями входящими в вектор";
  algorithm
    delta := (endValue - firstValue) / numberOfFlueSections / (numberOfTubeSections - 1);
    for j in 1:numberOfFlueSections loop
      for i in 1:numberOfTubeSections loop
        if j == 1 then
          x[j, i] := firstValue + (i - 1) * delta;
        else
          x[j, i] := x[j - 1, numberOfTubeSections] + (i - 1) * delta;
        end if;
      end for;
    end for;
  end razbivka_n;

  function razbivka_v
    input Real firstValue "первое значение";
    input Real endValue "последнее значение";
    input Integer zahod "число заходов";
    input Integer numberOfFlueSections;
    input Integer numberOfTubeSections;
    output Real x_v[numberOfFlueSections, numberOfTubeSections];
  protected
    Real delta "разность между значениями входящими в вектор";
    Real x_n[numberOfFlueSections, numberOfTubeSections + 1];
  algorithm
    delta := (endValue - firstValue) / (numberOfFlueSections - 1) / numberOfTubeSections;
    for j in 1:numberOfFlueSections loop
      for i in 1:numberOfTubeSections + 1 loop
        if j == 1 then
          x_n[j, i] := firstValue + (i - 1) * j * delta;
        else
          x_n[j, i] := x_n[j - 1, numberOfTubeSections + 1] + (i - 1) * j * delta;
        end if;
      end for;
    end for;
    for j in 1:numberOfFlueSections loop
      for i in 1:numberOfTubeSections loop
        x_v[j, i] := (x_n[j, i + 1] + x_n[j, i]) / 2;
      end for;
    end for;
  end razbivka_v;

  model onlyFlowHEBoilLite
    function HTtoMT "Функция перехода с участков труб для расчета теплообмена на участки расчета массообмена (осреднение)"
      input Real x[:] "Массив элементов по участком тубы разбитых для расчета теплообмена";
      input Integer numberPMCalcSections "Число участков разбиения трубы входящих в один участок расчета процессов массообмена";
      input Integer j "Текущий участок трубы по расчету массообмена";
      output Real y;
    algorithm
      y := sum(x[k] for k in 1 + (j - 1) * numberPMCalcSections:j * numberPMCalcSections) / numberPMCalcSections;
    end HTtoMT;

    function HTtoMT_n "Функция перехода с участков труб для расчета теплообмена на участки расчета массообмена (в узловой точке)"
      input Real x[:] "Массив элементов по участком тубы разбитых для расчета теплообмена";
      input Integer numberPMCalcSections "Число участков разбиения трубы входящих в один участок расчета процессов массообмена";
      input Integer j "Текущий участок трубы по расчету массообмена";
      output Real y;
    algorithm
      y := x[1 + (j - 1) * numberPMCalcSections];
    end HTtoMT_n;

    function HTtoMT_sum "Функция перехода с участков труб для расчета теплообмена на участки расчета массообмена (скммирование)"
      input Real x[:] "Массив элементов по участком тубы разбитых для расчета теплообмена";
      input Integer numberPMCalcSections "Число участков разбиения трубы входящих в один участок расчета процессов массообмена";
      input Integer j "Текущий участок трубы по расчету массообмена";
      output Real y;
    algorithm
      y := sum(x[k] for k in 1 + (j - 1) * numberPMCalcSections:j * numberPMCalcSections) / numberPMCalcSections;
    end HTtoMT_sum;

    function MTtoHT "Функция перехода с участков труб для расчета массообмена на участки расчета теплообмена"
      input Real x[:] "Массив элементов по участком тубы разбитых для расчета массообмена";
      input Integer numberPMCalcSections "Число участков разбиения трубы входящих в один участок расчета процессов массообмена";
      input Integer j "Текущий участок трубы по расчету теплообмена";
      output Real y;
    algorithm
      y := x[integer((j + numberPMCalcSections - 1) / numberPMCalcSections)];
    end MTtoHT;

    //import MyHRSG_lite.phi_heatedPipe;
    //import MyHRSG_lite.lambda_tr;
    //**
    //***Исходные данные для газовой стороны
    //**
    parameter Modelica.SIunits.Power setQ_gas = 100 "тепловой поток со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
    //**
    //***Исходные данные по стороне вода/пар
    //**
    parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    replaceable package Medium_F2 = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
    parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
    parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
    //**
    //***Характеристики металла
    parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
    //**
    //**
    //Конструктивные характеристики
    //**
    //Параметры
    parameter MyHRSG_lite.Choices.HRSG_type HRSG_type = MyHRSG_lite.Choices.HRSG_type.horizontalBottom "Тип КУ";
    parameter Integer numberOfTubeSections = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberPMCalcSections = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfTubeSectionsForMT = integer(numberOfTubeSections / numberPMCalcSections) "Число участков разбиения трубы для расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfTubeNodes = numberOfTubeSectionsForMT + 1 "Число узлов в одной трубе";
    parameter Integer numberFirstTubeInLastZahod = integer(numberOfFlueSections - zahod + 1) "Номер первой трубы в последнем заходе";
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer zahod = 2 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
    //Поток вода/пар
    parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 / numberOfTubeSections "Внутренняя площадь одного участка ряда труб";
    parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 / 4 / numberOfTubeSections "Внутренний объем одного участка ряда труб";
    parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 / numberOfTubeSections "Масса металла участка ряда труб";
    parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
    parameter Modelica.SIunits.Time Tstab "Интервал времени в начале расчета в течение которого все производные равны нулю";
    //**
    //Начальные значения
    //**
    //Поток вода/пар
    parameter Medium_F.SpecificEnthalpy h_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(seth_in, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(seth_in, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_v = setD_flow / zahod "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_n[2] = fill(setD_flow / zahod, 2) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = fill(setTm, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    //Поток вода/пар
    Medium_F.ThermodynamicState stateFlow[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F2.ThermodynamicState stateFlowTwoPhase[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    //Medium_F.Temperature ts "Температура насыщения";
    Medium_F.AbsolutePressure p_flow_v(start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.AbsolutePressure p_flow_n[2](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
    Medium_F.SpecificEnthalpy h_flow_v[numberOfFlueSections, numberOfTubeSections](start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.SpecificEnthalpy h_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
    Real der_h_flow_v[numberOfFlueSections, numberOfTubeSections] "Производняа энтальпии потока вода/пар";
    Medium_F.Density rho_flow_v[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы в конечных объемах";
    //Medium_F.Density rho_flow_n[2] "Плотность потока по участкам трубы в узловых точках";
    Modelica.SIunits.DerDensityByEnthalpy drdh_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow_v(start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
    Medium_F.MassFlowRate D_flow_n[2](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    Modelica.SIunits.HeatFlowRate Q_flow[numberOfFlueSections, numberOfTubeSections] "тепло переданное стенке трубы";
    Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
    Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    Real C1 "Показатель в числителе уравнения сплошности";
    Real C2 "Показатель в знаменателе уравнения сплошности";
    Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
    Modelica.SIunits.Velocity w_flow_v "Скорость потока вода/пар в конечных объемах";
    //Modelica.SIunits.Velocity w_flow_n[2] "Скорость потока вода/пар в узловых точках";
    Real dp_fric "Потеря давления из-за сил трения";
    //Real wrhop "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
    //Real phi "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
    Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
    Real lambda_tr "Коэффициент трения";
    Real x_v[numberOfFlueSections, numberOfTubeSections] "Степень сухости";
    //**
    //Интерфейс
    //**
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
//*****Уравнения для потока вода/пар и металла
//rho_flow_n[1] = Medium_F.density_ph(p_flow_n[1], h_flow_n[1, 1]) "Расчет плотности вода/пар в узловых точках";
//rho_flow_n[2] = Medium_F.density_ph(p_flow_n[2], waterOut.h_outflow) "Расчет плотности вода/пар в узловых точках";
//w_flow_n[1] = D_flow_n[1] / rho_flow_n[1] / f_flow "Расчет скорости потока вода/пар в узловых точках";
//w_flow_n[2] = D_flow_n[2] / rho_flow_n[2] / f_flow "Расчет скорости потока вода/пар в узловых точках";
    w_flow_v = D_flow_v / (sum(rho_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) / f_flow;
    for i in 1:numberOfFlueSections loop
      hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева";
//Рачет скорости потока в узловых точках
//Уравнения для расчета процессов теплообмена
      for j in 1:numberOfTubeSections loop
//Осреднение по конечному объему
        der_h_flow_v[i, j] = der(h_flow_v[i, j]);
        deltaVFlow * rho_flow_v[i, j] * der_h_flow_v[i, j] = max(0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]), 0) - D_flow_v * (h_flow_v[i, j] - h_flow_n[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
        deltaVFlow * rho_flow_v[i, j] * der(h_flow_n[i, j + 1]) = max(0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]), 0) - D_flow_v * (h_flow_n[i, j + 1] - h_flow_v[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
        deltaMMetal * C_m * der(t_m[i, j]) = Q_flow[i, j] - max(alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]), 0) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
        if hod[i] < 0 then
          heat[i, j].Q_flow = Q_flow[i, j];
          heat[i, j].T = t_m[i, j];
        else
          heat[i, j].Q_flow = Q_flow[i, numberOfTubeSections - j + 1];
          heat[i, j].T = t_m[i, numberOfTubeSections - j + 1];
        end if;
//Уравнения состояния
        stateFlow[i, j] = Medium_F.setState_ph(p_flow_v, h_flow_v[i, j]);
        t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
        rho_flow_v[i, j] = Medium_F.density(stateFlow[i, j]);
        drdp_flow[i, j] = Medium_F.density_derp_h(stateFlow[i, j]);
        drdh_flow[i, j] = Medium_F.density_derh_p(stateFlow[i, j]);
//Коэффициент теплоотдачи
        k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
        Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
        mu_flow[i, j] = if Medium_F.dynamicViscosity(stateFlow[i, j]) < 1.503e-004 then 1.503e-004 else Medium_F.dynamicViscosity(stateFlow[i, j]);
//w_flow_v[i, j] = D_flow_v / rho_flow_v[i, j] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow[i, j] = abs(w_flow_v * Din * rho_flow_v[i, j] / mu_flow[i, j]);
        alfa_flow[i, j] = max(0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4, 1);
//assert(t_m[i, j] < t_flow[i, j], "Temperatura metalla nije temperaturi potoka (SH)", level = AssertionLevel.warning);
//Про две фазы
        stateFlowTwoPhase[i, j] = Medium_F2.setState_ph(p_flow_v, h_flow_v[i, j]);
        x_v[i, j] = Medium_F2.vapourQuality(stateFlowTwoPhase[i, j]);
      end for;
    end for;
//ts = Medium_F2.saturationTemperature(p_flow_v);
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
    p_flow_v = (p_flow_n[1] + p_flow_n[2]) / 2;
    D_flow_v = (D_flow_n[1] + D_flow_n[2]) / 2;
//Основное уравнение гидравлики
//wrhop = sum(w_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections * (sum(rho_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) * p_flow_v * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
//Xi_flow = lambda_tr(Din, ke, sum(Re_flow[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) * Lpipe * z2 / Din;
//phi = phi_heatedPipe(wrhop, p_flow_v / 100000, sum(x_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) "Расчет коэффициента phi";
//dp_fric = (sum(w_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) ^ 2 * Xi_flow * (sum(rho_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) / 2 / Modelica.Constants.g_n "Потеря давления от трения";
    lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
    Xi_flow = lambda_tr * Lpipe * z2 / Din;
    dp_fric = w_flow_v ^ 2 * Xi_flow * (sum(rho_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) / 2 / Modelica.Constants.g_n;
    p_flow_n[1] - p_flow_n[2] = dp_fric;
    D_flow_n[1] - D_flow_n[2] = C1 + C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
//C1 = 0;
//C2 = 0;
    C1 = numberPMCalcSections * deltaVFlow * (sum(drdh_flow[i, j] * der_h_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections);
    C2 = numberPMCalcSections * deltaVFlow * numberOfTubeSections * numberOfFlueSections * (sum(drdp_flow[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) * der(p_flow_v);
    for i in 1:numberOfFlueSections - zahod loop
//Описание гибов
      h_flow_n[i, numberOfTubeSections + 1] = h_flow_n[i + zahod, 1];
    end for;
//Граничные условия
    waterIn.m_flow = D_flow_n[1] * zahod;
    waterOut.m_flow = -D_flow_n[2] * zahod;
    waterIn.p = p_flow_n[1];
    waterOut.p = p_flow_n[2];
    for i in 1:zahod loop
      h_flow_n[i, 1] = inStream(waterIn.h_outflow);
    end for;
    waterOut.h_outflow = sum(array(D_flow_n[2] * h_flow_n[i, numberOfTubeSections + 1] for i in numberFirstTubeInLastZahod:numberOfFlueSections)) / sum(array(D_flow_n[2] for i in numberFirstTubeInLastZahod:numberOfFlueSections));
    waterIn.h_outflow = sum(array(D_flow_n[1] * h_flow_n[i, 1] for i in 1:zahod)) / sum(array(D_flow_n[1] for i in 1:zahod));
    annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
  end onlyFlowHEBoilLite;

  package onceThrough
    model onceThrough_10
      package Medium_F = Modelica.Media.Water.WaterIF97_ph;
      parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
      parameter Modelica.SIunits.MassFlowRate wsteam = 4.23 "Расход пара на выходе из сепаратора";
      parameter Modelica.SIunits.Pressure patm = 1.013e5 "Начальное давление потока вода/пар за клапаном (турбиной)";
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas = 1276.6 / 3.6 "Номинальный (и начальный) массовый расход газов ";
      parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
      parameter Medium_F.SaturationProperties sat_start = Medium_F.setSat_p(pflow_ote2);
      //Исходные данные для сепаратора
      parameter Modelica.SIunits.Length Dsep = 0.348 "Внутренний диаметр сепаратор";
      parameter Modelica.SIunits.Length Lsep = 5 "Длина (высота) сепаратора";
      parameter Modelica.SIunits.Length deltaSep = 0.04 "Толщина стенки сепаратора";
      parameter Integer n_sep_set = 2 "Количество сепараторов";
      //Начальные значения для сепаратора
      parameter Modelica.SIunits.Length Hw_start_set = 2 "Начальное значение уровня воды в сепараторе";
      //Констуктивные характеристики поверхностей нагрева
      parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
      //Исходные данные для экономайзера
      parameter Modelica.SIunits.Diameter Din_eco = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
      parameter Integer zahod_eco = 1 "заходность труб теплообменника";
      parameter Integer z1_eco = 58 "Число труб по ширине газохода";
      parameter Integer z2_eco = 8 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб экономайзера
      parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
      //Исходные данные по разбиению экономайзера
      parameter Integer numberOfTubeSections_eco = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_eco = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_eco = 7.7e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_eco = 60 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_eco = 160 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_eco = Toutgas_ote1 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_eco = 161.4 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для прямоточного испарителя №1 (OTE1)
      parameter Modelica.SIunits.Diameter Din_ote1 = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_ote1 = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_ote1 = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_ote1 = 79e-3 "Продольный шаг";
      parameter Integer zahod_ote1 = 1 "заходность труб теплообменника";
      parameter Integer z1_ote1 = 58 "Число труб по ширине газохода";
      parameter Integer z2_ote1 = 10 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб прямоточного испарителя №1 (OTE1)
      parameter Modelica.SIunits.Length delta_fin_ote1 = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_ote1 = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_ote1 = 2.002e-3 "Шаг ребер, м";
      //Исходные данные по разбиению испарителя №1 (OTE1)
      parameter Integer numberOfTubeSections_ote1 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_ote1 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_ote1 = z2_ote1 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_ote1 = 7.7e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_ote1 = Toutflow_eco "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_ote1 = 158 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_in = hflow_eco_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_out = 0.97e6 "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_ote1 = Toutgas_ote2 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_ote1 = 179 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_ote1 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для прямоточного испарителя №2 (OTE2)
      parameter Modelica.SIunits.Diameter Din_ote2 = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_ote2 = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_ote2 = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_ote2 = 79e-3 "Продольный шаг";
      parameter Integer zahod_ote2 = 2 "заходность труб теплообменника";
      parameter Integer z1_ote2 = 58 "Число труб по ширине газохода";
      parameter Integer z2_ote2 = 6 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб прямоточного испарителя №2 (OTE2)
      parameter Modelica.SIunits.Length delta_fin_ote2 = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_ote2 = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_ote2 = 2.735e-3 "Шаг ребер, м";
      //Исходные данные по разбиению испарителя №2 (OTE2)
      parameter Integer numberOfTubeSections_ote2 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_ote2 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_ote2 = z2_ote2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для испарителя №2
      parameter Modelica.SIunits.Pressure pflow_ote2 = 5.5e5 "Начальное давление потока вода/пар перед OTE2";
      parameter Modelica.SIunits.Temperature Tinflow_ote2 = Toutflow_ote1 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_ote2 = 145 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_in = hflow_ote1_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_out = 1.15e6 "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны испарителя №2
      parameter Modelica.SIunits.Temperature Tingas_ote2 = Toutgas_sh "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
      parameter Modelica.SIunits.Temperature Toutgas_ote2 = 191 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_ote2 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для пароперегревателя (SH)
      parameter Modelica.SIunits.Diameter Dout_sh = 0.038 "Наружный диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_sh = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_sh = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_sh = 79e-3 "Продольный шаг";
      parameter Integer zahod_sh = 1 "заходность труб теплообменника";
      parameter Integer z1_sh = 58 "Число труб по ширине газохода";
      parameter Integer z2_sh = 8 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб пароперегревателя (SH)
      parameter Modelica.SIunits.Length delta_fin_sh = 0.001 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_sh = 0.012 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_sh = 5.102e-3 "Шаг ребер, м";
      //Исходные данные по разбиению пароперегревателя (SH)
      parameter Integer numberOfTubeSections_sh = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_sh = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_sh = z2_sh "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для пароперегревателя
      parameter Modelica.SIunits.Pressure pflow_sh = 3.7e5 "Начальное давление потока вода/пар перед SH";
      parameter Modelica.SIunits.Temperature Tinflow_sh = Toutflow_ote2 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_sh = 198 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_in = hflow_ote2_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_out = Medium_F.specificEnthalpy_pT(pflow_sh, Toutflow_sh) "Начальная энтальпия входного потока вода/пар";
      //Исходные данные для газовой стороны испарителя №2
      parameter Modelica.SIunits.Temperature Tingas_sh = 200 + 273.15 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_sh = 199 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_sh = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      inner Modelica.Fluid.System system(allowFlowReversal = false) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = Tinflow_eco, m_flow = wflow, nPorts = 1, use_T_in = true, use_m_flow_in = false) annotation(Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE ECO(redeclare onlyFlowHEBoil_2 flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, numberOfFlueSections = numberOfFlueSections_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out) annotation(Placement(visible = true, transformation(origin = {-46, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE OTE1(redeclare onlyFlowHEBoil_2 flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, numberOfTubeSections = numberOfTubeSections_ote1, numberPMCalcSections = numberPMCalcSections_ote1, numberOfFlueSections = numberOfFlueSections_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out) annotation(Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE OTE2(redeclare onlyFlowHEBoil_2 flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, numberOfTubeSections = numberOfTubeSections_ote2, numberPMCalcSections = numberPMCalcSections_ote2, numberOfFlueSections = numberOfFlueSections_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out) annotation(Placement(visible = true, transformation(origin = {2, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-38, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature2(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      MyHRSG_lite.Separator separator(redeclare package Medium = Medium_F, Din = Dsep, L = Lsep, n_sep = n_sep_set, ps_start = pflow_ote2, delta = deltaSep, Hw_start = Hw_start_set, sat_start = sat_start, t_start = Medium_F.saturationTemperature_sat(sat_start)) annotation(Placement(visible = true, transformation(origin = {20, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_h waterSink(redeclare package Medium = Medium_F, h = hflow_eco_in, nPorts = 1, use_m_flow_in = true) annotation(Placement(visible = true, transformation(origin = {70, 22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 0, height = 0, offset = wgas, startTime = 0) annotation(Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 110, height = -140, offset = Tingas_sh, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      GF_HE SH(redeclare onlyFlowHEBoilLite flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, numberOfTubeSections = numberOfTubeSections_sh, numberPMCalcSections = numberPMCalcSections_sh, numberOfFlueSections = numberOfFlueSections_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out) annotation(Placement(visible = true, transformation(origin = {34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveLinear CV1(redeclare package Medium = Medium_F, dp_nominal = 1000, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {23, 67}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(Placement(visible = true, transformation(origin = {-2, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveLinear CV2(redeclare package Medium = Medium_F, dp_nominal = pflow_sh - system.p_ambient, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {47, 57}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV2 annotation(Placement(visible = true, transformation(origin = {36, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp ramp1(duration = 0, height = 0, offset = Tinflow_eco, startTime = 0) annotation(Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(ramp1.y, flowSource.T_in) annotation(Line(points = {{-78, 92}, {-72, 92}, {-72, 72}, {-98, 72}, {-98, 54}, {-96, 54}}, color = {0, 0, 127}));
      connect(constCV2.y, CV2.opening) annotation(Line(points = {{48, 86}, {54, 86}, {54, 70}, {46, 70}, {46, 62}, {48, 62}}, color = {0, 0, 127}));
      connect(CV2.port_b, flowSink.ports[1]) annotation(Line(points = {{52, 57}, {56, 57}, {56, 56}, {60, 56}}, color = {0, 127, 255}));
      connect(SH.flowOut, CV2.port_a) annotation(Line(points = {{38, 24}, {38, 57}, {42, 57}}, color = {0, 127, 255}));
      connect(constCV1.y, CV1.opening) annotation(Line(points = {{10, 80}, {24, 80}, {24, 72}, {24, 72}}, color = {0, 0, 127}));
      connect(CV1.port_a, separator.steam) annotation(Line(points = {{18, 68}, {14, 68}, {14, 58}, {20, 58}, {20, 54}, {20, 54}, {20, 54}}, color = {0, 127, 255}));
      connect(CV1.port_b, SH.flowIn) annotation(Line(points = {{28, 68}, {32, 68}, {32, 38}, {30, 38}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
//separator.steam.p = pflow_eco;
//SH.flowIn.m_flow = wsteam;
//SH.flowIn.h_outflow = hflow_sh_in;
      connect(SH.gasOut, OTE2.gasIn) annotation(Line(points = {{28, 12}, {8, 12}, {8, 12}, {8, 12}}, color = {0, 127, 255}));
      connect(gasSource.ports[1], SH.gasIn) annotation(Line(points = {{60, -6}, {48, -6}, {48, 12}, {40, 12}, {40, 12}}, color = {0, 127, 255}));
      connect(separator.downStr, waterSink.ports[1]) annotation(Line(points = {{20, 32}, {48, 32}, {48, 22}, {60, 22}, {60, 22}}, color = {0, 127, 255}));
      connect(OTE2.flowOut, separator.fedWater) annotation(Line(points = {{6.2, 23}, {6.2, 49}, {13, 49}}, color = {0, 127, 255}));
      connect(separator.drainFeedback, waterSink.m_flow_in) annotation(Line(points = {{25, 45}, {89, 45}, {89, 28}, {84.5, 28}, {84.5, 30}, {80, 30}}, color = {0, 0, 127}));
      connect(gasSource.T_in, rampGasTemp.y) annotation(Line(points = {{82, -2}, {87, -2}, {87, -2}, {92, -2}, {92, -34}, {82, -34}, {82, -34}}, color = {0, 0, 127}));
      connect(rampGasFlow.y, gasSource.m_flow_in) annotation(Line(points = {{81, -66}, {89, -66}, {89, -66}, {97, -66}, {97, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}}, color = {0, 0, 127}));
      connect(OTE1.flowOut, temperature2.port_a) annotation(Line(points = {{-17.8, 23}, {-17.8, 26.5}, {-17.8, 26.5}, {-17.8, 30}, {-13.8, 30}}, color = {0, 127, 255}));
      connect(temperature2.port_b, OTE2.flowIn) annotation(Line(points = {{-6, 30}, {-2, 30}, {-2, 26}, {-2, 26}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
      connect(temperature1.port_b, OTE1.flowIn) annotation(Line(points = {{-34, 30}, {-26, 30}, {-26, 26.5}, {-26, 26.5}, {-26, 23}}, color = {0, 127, 255}));
      connect(ECO.flowOut, temperature1.port_a) annotation(Line(points = {{-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 31}, {-41.8, 31}, {-41.8, 29}, {-41.8, 29}}, color = {0, 127, 255}));
      connect(OTE1.gasIn, OTE2.gasOut) annotation(Line(points = {{-15.8, 12}, {-3.8, 12}}, color = {0, 127, 255}));
      connect(ECO.gasIn, OTE1.gasOut) annotation(Line(points = {{-39.8, 12}, {-27.8, 12}}, color = {0, 127, 255}));
      connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -6}, {-60, -6}, {-60, 12}, {-52, 12}}, color = {0, 127, 255}));
      connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-74, 50}, {-50, 50}, {-50, 23}}, color = {0, 127, 255}));
    initial equation
      for i in 1:numberOfFlueSections_eco loop
        for j in 1:numberOfTubeSections_eco loop
          der(ECO.flowHE.h_flow_n[i, j + 1]) = 0;
          der(ECO.flowHE.h_flow_v[i, j]) = 0;
          der(ECO.flowHE.t_m[i, j]) = 0;
          der(ECO.gasHE.h_gas[i + 1, j]) = 0;
        end for;
        for j in 1:integer(numberOfTubeSections_eco / numberPMCalcSections_eco) loop
//der(ECO.flowHE.p_flow_v[i, j]) = 0;
        end for;
//der(ECO.flowHE.p_flow_v) = 0;
      end for;
      for i in 1:numberOfFlueSections_ote1 loop
        for j in 1:numberOfTubeSections_ote1 loop
          der(OTE1.flowHE.h_flow_n[i, j + 1]) = 0;
          der(OTE1.flowHE.h_flow_v[i, j]) = 0;
          der(OTE1.flowHE.t_m[i, j]) = 0;
          der(OTE1.gasHE.h_gas[i + 1, j]) = 0;
        end for;
        for j in 1:integer(numberOfTubeSections_ote1 / numberPMCalcSections_ote1) loop
//der(OTE1.flowHE.p_flow_v[i, j]) = 0;
        end for;
//der(OTE1.flowHE.p_flow_v) = 0;
      end for;
      for i in 1:numberOfFlueSections_ote2 loop
        for j in 1:numberOfTubeSections_ote2 loop
          der(OTE2.flowHE.h_flow_n[i, j + 1]) = 0;
          der(OTE2.flowHE.h_flow_v[i, j]) = 0;
          der(OTE2.flowHE.t_m[i, j]) = 0;
          der(OTE2.gasHE.h_gas[i + 1, j]) = 0;
        end for;
        for j in 1:integer(numberOfTubeSections_ote2 / numberPMCalcSections_ote2) loop
//der(OTE2.flowHE.p_flow_v[i, j]) = 0;
        end for;
//der(OTE2.flowHE.p_flow_v) = 0;
      end for;
      for i in 1:numberOfFlueSections_sh loop
        for j in 1:numberOfTubeSections_sh loop
          der(SH.flowHE.h_flow_n[i, j + 1]) = 0;
          der(SH.flowHE.h_flow_v[i, j]) = 0;
          der(SH.flowHE.t_m[i, j]) = 0;
          der(SH.gasHE.h_gas[i + 1, j]) = 0;
        end for;
      end for;
//der(SH.flowHE.p_flow_v) = 0;
      der(separator.ps) = 0;
      der(separator.hw) = 0;
      annotation(uses(Modelica(version = "3.2.1")), Documentation(info = "<html>
    <p>
    Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
    </p>
    </html>"));
    end onceThrough_10;

    model onceThrough_11
      package Medium_F = Modelica.Media.Water.WaterIF97_ph;
      parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
      parameter Modelica.SIunits.MassFlowRate wsteam = 0 "Расход пара на выходе из сепаратора";
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas = 100 / 3.6 "Номинальный (и начальный) массовый расход газов ";
      parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
      parameter Medium_F.SaturationProperties sat_start = Medium_F.setSat_p(pflow_ote2);
      //Исходные данные для сепаратора
      parameter Modelica.SIunits.Length Dsep = 0.348 "Внутренний диаметр сепаратор";
      parameter Modelica.SIunits.Length Lsep = 5 "Длина (высота) сепаратора";
      parameter Modelica.SIunits.Length deltaSep = 0.04 "Толщина стенки сепаратора";
      parameter Integer n_sep_set = 2 "Количество сепараторов";
      //Начальные значения для сепаратора
      parameter Modelica.SIunits.Length Hw_start_set = 2 "Начальное значение уровня воды в сепараторе";
      //Констуктивные характеристики поверхностей нагрева
      parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
      //Исходные данные для экономайзера
      parameter Modelica.SIunits.Diameter Din_eco = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
      parameter Integer zahod_eco = 1 "заходность труб теплообменника";
      parameter Integer z1_eco = 58 "Число труб по ширине газохода";
      parameter Integer z2_eco = 8 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб экономайзера
      parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
      //Исходные данные по разбиению экономайзера
      parameter Integer numberOfTubeSections_eco = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_eco = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_eco = 1.013e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_eco = 60 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_eco = 60 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm_eco = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_eco = 60 + 273.15 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_eco = 60 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для прямоточного испарителя №1 (OTE1)
      parameter Modelica.SIunits.Diameter Din_ote1 = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_ote1 = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_ote1 = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_ote1 = 79e-3 "Продольный шаг";
      parameter Integer zahod_ote1 = 1 "заходность труб теплообменника";
      parameter Integer z1_ote1 = 58 "Число труб по ширине газохода";
      parameter Integer z2_ote1 = 10 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб прямоточного испарителя №1 (OTE1)
      parameter Modelica.SIunits.Length delta_fin_ote1 = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_ote1 = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_ote1 = 2.002e-3 "Шаг ребер, м";
      //Исходные данные по разбиению испарителя №1 (OTE1)
      parameter Integer numberOfTubeSections_ote1 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_ote1 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_ote1 = z2_ote1 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_ote1 = 1.013e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_ote1 = 60 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_ote1 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm_ote1 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_in = hflow_eco_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_out = hflow_ote1_in "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_ote1 = 60 + 273.15 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_ote1 = 60 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_ote1 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для прямоточного испарителя №2 (OTE2)
      parameter Modelica.SIunits.Diameter Din_ote2 = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_ote2 = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_ote2 = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_ote2 = 79e-3 "Продольный шаг";
      parameter Integer zahod_ote2 = 2 "заходность труб теплообменника";
      parameter Integer z1_ote2 = 58 "Число труб по ширине газохода";
      parameter Integer z2_ote2 = 6 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб прямоточного испарителя №2 (OTE2)
      parameter Modelica.SIunits.Length delta_fin_ote2 = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_ote2 = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_ote2 = 2.735e-3 "Шаг ребер, м";
      //Исходные данные по разбиению испарителя №2 (OTE2)
      parameter Integer numberOfTubeSections_ote2 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_ote2 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_ote2 = z2_ote2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для испарителя №2
      parameter Modelica.SIunits.Pressure pflow_ote2 = 1.013e5 "Начальное давление потока вода/пар перед OTE2";
      parameter Modelica.SIunits.Temperature Tinflow_ote2 = 60 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_ote2 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm_ote2 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_in = hflow_ote1_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_out = hflow_ote2_in "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны испарителя №2
      parameter Modelica.SIunits.Temperature Tingas_ote2 = 60 + 273.15 "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
      parameter Modelica.SIunits.Temperature Toutgas_ote2 = 60 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_ote2 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для пароперегревателя (SH)
      parameter Modelica.SIunits.Diameter Dout_sh = 0.038 "Наружный диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_sh = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_sh = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_sh = 79e-3 "Продольный шаг";
      parameter Integer zahod_sh = 1 "заходность труб теплообменника";
      parameter Integer z1_sh = 58 "Число труб по ширине газохода";
      parameter Integer z2_sh = 8 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб пароперегревателя (SH)
      parameter Modelica.SIunits.Length delta_fin_sh = 0.001 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_sh = 0.012 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_sh = 5.102e-3 "Шаг ребер, м";
      //Исходные данные по разбиению пароперегревателя (SH)
      parameter Integer numberOfTubeSections_sh = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_sh = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_sh = z2_sh "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для пароперегревателя
      parameter Modelica.SIunits.Pressure pflow_sh = 1.013e5 "Начальное давление потока вода/пар перед SH";
      parameter Modelica.SIunits.Temperature Tinflow_sh = 60 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_sh = 60 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm_sh = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_in = 2.676e6 "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_out = hflow_sh_in "Начальная энтальпия входного потока вода/пар";
      //Исходные данные для газовой стороны испарителя №2
      parameter Modelica.SIunits.Temperature Tingas_sh = 60 + 273.15 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_sh = 60 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_sh = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      inner Modelica.Fluid.System system(allowFlowReversal = false) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wflow, T = Tinflow_eco) annotation(Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE ECO(redeclare onlyFlowHEBoil_2 flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, numberOfFlueSections = numberOfFlueSections_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco) annotation(Placement(visible = true, transformation(origin = {-46, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE OTE1(redeclare onlyFlowHEBoil_2 flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, numberOfTubeSections = numberOfTubeSections_ote1, numberPMCalcSections = numberPMCalcSections_ote1, numberOfFlueSections = numberOfFlueSections_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, setTm = setTm_ote1) annotation(Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE OTE2(redeclare onlyFlowHEBoil_2 flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, numberOfTubeSections = numberOfTubeSections_ote2, numberPMCalcSections = numberPMCalcSections_ote2, numberOfFlueSections = numberOfFlueSections_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2) annotation(Placement(visible = true, transformation(origin = {2, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-38, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature2(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      MyHRSG_lite.Separator separator(redeclare package Medium = Medium_F, Din = Dsep, L = Lsep, n_sep = n_sep_set, ps_start = pflow_ote2, delta = deltaSep, Hw_start = Hw_start_set, sat_start = sat_start, t_start = Medium_F.saturationTemperature_sat(sat_start)) annotation(Placement(visible = true, transformation(origin = {20, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_h waterSink(redeclare package Medium = Medium_F, h = hflow_eco_in, nPorts = 1, use_m_flow_in = true) annotation(Placement(visible = true, transformation(origin = {70, 22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 600, height = 1000, offset = wgas, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 40, height = 200, offset = Tingas_sh, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      GF_HE SH(redeclare onlyFlowHEBoilLite flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, numberOfTubeSections = numberOfTubeSections_sh, numberPMCalcSections = numberPMCalcSections_sh, numberOfFlueSections = numberOfFlueSections_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2) annotation(Placement(visible = true, transformation(origin = {34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveLinear CV1(redeclare package Medium = Medium_F, dp_nominal = 1000, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {23, 67}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(Placement(visible = true, transformation(origin = {-2, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveLinear CV2(redeclare package Medium = Medium_F, dp_nominal = 10.01e5 - system.p_ambient, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {47, 57}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV2 annotation(Placement(visible = true, transformation(origin = {36, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(constCV2.y, CV2.opening) annotation(Line(points = {{48, 86}, {54, 86}, {54, 70}, {46, 70}, {46, 62}, {48, 62}}, color = {0, 0, 127}));
      connect(CV2.port_b, flowSink.ports[1]) annotation(Line(points = {{52, 57}, {56, 57}, {56, 56}, {60, 56}}, color = {0, 127, 255}));
      connect(SH.flowOut, CV2.port_a) annotation(Line(points = {{38, 24}, {38, 57}, {42, 57}}, color = {0, 127, 255}));
      connect(constCV1.y, CV1.opening) annotation(Line(points = {{10, 80}, {24, 80}, {24, 72}, {24, 72}}, color = {0, 0, 127}));
      connect(CV1.port_a, separator.steam) annotation(Line(points = {{18, 68}, {14, 68}, {14, 58}, {20, 58}, {20, 54}, {20, 54}, {20, 54}}, color = {0, 127, 255}));
      connect(CV1.port_b, SH.flowIn) annotation(Line(points = {{28, 68}, {32, 68}, {32, 38}, {30, 38}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
      connect(SH.gasOut, OTE2.gasIn) annotation(Line(points = {{28, 12}, {8, 12}, {8, 12}, {8, 12}}, color = {0, 127, 255}));
      connect(gasSource.ports[1], SH.gasIn) annotation(Line(points = {{60, -6}, {48, -6}, {48, 12}, {40, 12}, {40, 12}}, color = {0, 127, 255}));
      connect(separator.downStr, waterSink.ports[1]) annotation(Line(points = {{20, 32}, {48, 32}, {48, 22}, {60, 22}, {60, 22}}, color = {0, 127, 255}));
      connect(OTE2.flowOut, separator.fedWater) annotation(Line(points = {{6.2, 23}, {6.2, 49}, {13, 49}}, color = {0, 127, 255}));
      connect(separator.drainFeedback, waterSink.m_flow_in) annotation(Line(points = {{25, 45}, {89, 45}, {89, 28}, {84.5, 28}, {84.5, 30}, {80, 30}}, color = {0, 0, 127}));
      connect(gasSource.T_in, rampGasTemp.y) annotation(Line(points = {{82, -2}, {87, -2}, {87, -2}, {92, -2}, {92, -34}, {82, -34}, {82, -34}}, color = {0, 0, 127}));
      connect(rampGasFlow.y, gasSource.m_flow_in) annotation(Line(points = {{81, -66}, {89, -66}, {89, -66}, {97, -66}, {97, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}}, color = {0, 0, 127}));
      connect(OTE1.flowOut, temperature2.port_a) annotation(Line(points = {{-17.8, 23}, {-17.8, 26.5}, {-17.8, 26.5}, {-17.8, 30}, {-13.8, 30}}, color = {0, 127, 255}));
      connect(temperature2.port_b, OTE2.flowIn) annotation(Line(points = {{-6, 30}, {-2, 30}, {-2, 26}, {-2, 26}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
      connect(temperature1.port_b, OTE1.flowIn) annotation(Line(points = {{-34, 30}, {-26, 30}, {-26, 26.5}, {-26, 26.5}, {-26, 23}}, color = {0, 127, 255}));
      connect(ECO.flowOut, temperature1.port_a) annotation(Line(points = {{-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 31}, {-41.8, 31}, {-41.8, 29}, {-41.8, 29}}, color = {0, 127, 255}));
      connect(OTE1.gasIn, OTE2.gasOut) annotation(Line(points = {{-15.8, 12}, {-3.8, 12}}, color = {0, 127, 255}));
      connect(ECO.gasIn, OTE1.gasOut) annotation(Line(points = {{-39.8, 12}, {-27.8, 12}}, color = {0, 127, 255}));
      connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -6}, {-60, -6}, {-60, 12}, {-52, 12}}, color = {0, 127, 255}));
      connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-74, 50}, {-50, 50}, {-50, 23}}, color = {0, 127, 255}));
    initial equation
      for i in 1:numberOfFlueSections_eco loop
        for j in 1:numberOfTubeSections_eco loop
          der(ECO.flowHE.h_flow_n[i, j + 1]) = 0;
          der(ECO.flowHE.h_flow_v[i, j]) = 0;
          der(ECO.flowHE.t_m[i, j]) = 0;
          der(ECO.gasHE.h_gas[i + 1, j]) = 0;
        end for;
        for j in 1:integer(numberOfTubeSections_eco / numberPMCalcSections_eco) loop
          der(ECO.flowHE.p_flow_v[i, j]) = 0;
        end for;
      end for;
      for i in 1:numberOfFlueSections_ote1 loop
        for j in 1:numberOfTubeSections_ote1 loop
          der(OTE1.flowHE.h_flow_n[i, j + 1]) = 0;
          der(OTE1.flowHE.h_flow_v[i, j]) = 0;
          der(OTE1.flowHE.t_m[i, j]) = 0;
          der(OTE1.gasHE.h_gas[i + 1, j]) = 0;
        end for;
        for j in 1:integer(numberOfTubeSections_ote1 / numberPMCalcSections_ote1) loop
          der(OTE1.flowHE.p_flow_v[i, j]) = 0;
        end for;
      end for;
      for i in 1:numberOfFlueSections_ote2 loop
        for j in 1:numberOfTubeSections_ote2 loop
          der(OTE2.flowHE.h_flow_n[i, j + 1]) = 0;
          der(OTE2.flowHE.h_flow_v[i, j]) = 0;
          der(OTE2.flowHE.t_m[i, j]) = 0;
          der(OTE2.gasHE.h_gas[i + 1, j]) = 0;
        end for;
        for j in 1:integer(numberOfTubeSections_ote2 / numberPMCalcSections_ote2) loop
          der(OTE2.flowHE.p_flow_v[i, j]) = 0;
        end for;
      end for;
/*for i in 1:1 loop
        for j in 1:numberOfTubeSections_sh loop
          der(SH.gasHE.h_gas[i + 1, j]) = 0;
        end for;
        for j in 2:numberOfTubeSections_sh loop
          der(SH.flowHE.t_m[i, j]) = 0;
          der(SH.flowHE.h_flow_n[i, j + 1]) = 0;
          der(SH.flowHE.h_flow_v[i, j]) = 0;
         end for;
      end for;*/
      for i in 1:numberOfFlueSections_sh loop
        for j in 1:numberOfTubeSections_sh loop
          der(SH.flowHE.h_flow_n[i, j + 1]) = 0;
          der(SH.flowHE.h_flow_v[i, j]) = 0;
          der(SH.flowHE.t_m[i, j]) = 0;
          der(SH.gasHE.h_gas[i + 1, j]) = 0;
        end for;
      end for;
      der(SH.flowHE.p_flow_v) = 0;
      der(separator.ps) = 0;
      der(separator.hw) = 0;
      annotation(uses(Modelica(version = "3.2.1")), Documentation(info = "<html>
    <p>
    Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
    </p>
    </html>"));
    end onceThrough_11;

    model onceThrough_12
      parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      package Medium_F = Modelica.Media.Water.WaterIF97_ph;
      parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
      parameter Modelica.SIunits.MassFlowRate wsteam = 4.23 "Расход пара на выходе из сепаратора";
      parameter Modelica.SIunits.Pressure patm = 1.013e5 "Начальное давление потока вода/пар за клапаном (турбиной)";
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas = 1276.6 / 3.6 "Номинальный (и начальный) массовый расход газов ";
      parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
      parameter Medium_F.SaturationProperties sat_start = Medium_F.setSat_p(pflow_ote2);
      //Исходные данные для сепаратора
      parameter Modelica.SIunits.Length Dsep = 0.348 "Внутренний диаметр сепаратор";
      parameter Modelica.SIunits.Length Lsep = 5 "Длина (высота) сепаратора";
      parameter Modelica.SIunits.Length deltaSep = 0.04 "Толщина стенки сепаратора";
      parameter Integer n_sep_set = 2 "Количество сепараторов";
      //Начальные значения для сепаратора
      parameter Modelica.SIunits.Length Hw_start_set = 2 "Начальное значение уровня воды в сепараторе";
      //Констуктивные характеристики поверхностей нагрева
      parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
      //Исходные данные для экономайзера
      parameter Modelica.SIunits.Diameter Din_eco = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
      parameter Integer zahod_eco = 1 "заходность труб теплообменника";
      parameter Integer z1_eco = 58 "Число труб по ширине газохода";
      parameter Integer z2_eco = 8 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб экономайзера
      parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
      //Исходные данные по разбиению экономайзера
      parameter Integer numberOfTubeSections_eco = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_eco = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_eco = 7.7e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_eco = 60 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_eco = 160 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_eco = Toutgas_ote1 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_eco = 161.4 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для прямоточного испарителя №1 (OTE1)
      parameter Modelica.SIunits.Diameter Din_ote1 = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_ote1 = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_ote1 = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_ote1 = 79e-3 "Продольный шаг";
      parameter Integer zahod_ote1 = 1 "заходность труб теплообменника";
      parameter Integer z1_ote1 = 58 "Число труб по ширине газохода";
      parameter Integer z2_ote1 = 10 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб прямоточного испарителя №1 (OTE1)
      parameter Modelica.SIunits.Length delta_fin_ote1 = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_ote1 = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_ote1 = 2.002e-3 "Шаг ребер, м";
      //Исходные данные по разбиению испарителя №1 (OTE1)
      parameter Integer numberOfTubeSections_ote1 = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_ote1 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_ote1 = z2_ote1 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_ote1 = 7.7e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_ote1 = Toutflow_eco "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_ote1 = 158 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_in = hflow_eco_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_out = 0.97e6 "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_ote1 = Toutgas_ote2 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_ote1 = 179 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_ote1 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для прямоточного испарителя №2 (OTE2)
      parameter Modelica.SIunits.Diameter Din_ote2 = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_ote2 = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_ote2 = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_ote2 = 79e-3 "Продольный шаг";
      parameter Integer zahod_ote2 = 2 "заходность труб теплообменника";
      parameter Integer z1_ote2 = 58 "Число труб по ширине газохода";
      parameter Integer z2_ote2 = 6 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб прямоточного испарителя №2 (OTE2)
      parameter Modelica.SIunits.Length delta_fin_ote2 = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_ote2 = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_ote2 = 2.735e-3 "Шаг ребер, м";
      //Исходные данные по разбиению испарителя №2 (OTE2)
      parameter Integer numberOfTubeSections_ote2 = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_ote2 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_ote2 = z2_ote2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для испарителя №2
      parameter Modelica.SIunits.Pressure pflow_ote2 = 5.5e5 "Начальное давление потока вода/пар перед OTE2";
      parameter Modelica.SIunits.Temperature Tinflow_ote2 = Toutflow_ote1 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_ote2 = 145 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_in = hflow_ote1_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_out = 1.15e6 "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны испарителя №2
      parameter Modelica.SIunits.Temperature Tingas_ote2 = Toutgas_sh "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
      parameter Modelica.SIunits.Temperature Toutgas_ote2 = 191 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_ote2 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для пароперегревателя (SH)
      parameter Modelica.SIunits.Diameter Dout_sh = 0.038 "Наружный диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_sh = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_sh = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_sh = 79e-3 "Продольный шаг";
      parameter Integer zahod_sh = 1 "заходность труб теплообменника";
      parameter Integer z1_sh = 58 "Число труб по ширине газохода";
      parameter Integer z2_sh = 8 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб пароперегревателя (SH)
      parameter Modelica.SIunits.Length delta_fin_sh = 0.001 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_sh = 0.012 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_sh = 5.102e-3 "Шаг ребер, м";
      //Исходные данные по разбиению пароперегревателя (SH)
      parameter Integer numberOfTubeSections_sh = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_sh = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_sh = z2_sh "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для пароперегревателя
      parameter Modelica.SIunits.Pressure pflow_sh = 3.7e5 "Начальное давление потока вода/пар перед SH";
      parameter Modelica.SIunits.Temperature Tinflow_sh = Toutflow_ote2 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_sh = 198 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_in = hflow_ote2_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_out = Medium_F.specificEnthalpy_pT(pflow_sh, Toutflow_sh) "Начальная энтальпия входного потока вода/пар";
      //Исходные данные для газовой стороны испарителя №2
      parameter Modelica.SIunits.Temperature Tingas_sh = 200 + 273.15 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_sh = 199 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_sh = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      inner Modelica.Fluid.System system(allowFlowReversal = false, m_flow_small = m_flow_small) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = Tinflow_eco, m_flow = wflow, nPorts = 1, use_T_in = true, use_m_flow_in = false) annotation(Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE ECO(redeclare onlyFlowHEBoilLite_ECO flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, numberOfFlueSections = numberOfFlueSections_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, m_flow_small = system.m_flow_small) annotation(Placement(visible = true, transformation(origin = {-46, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE OTE1(redeclare onlyFlowHEBoil_9 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, numberOfTubeSections = numberOfTubeSections_ote1, numberPMCalcSections = numberPMCalcSections_ote1, numberOfFlueSections = numberOfFlueSections_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, m_flow_small = system.m_flow_small) annotation(Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE OTE2(redeclare onlyFlowHEBoil_9 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, numberOfTubeSections = numberOfTubeSections_ote2, numberPMCalcSections = numberPMCalcSections_ote2, numberOfFlueSections = numberOfFlueSections_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, m_flow_small = system.m_flow_small) annotation(Placement(visible = true, transformation(origin = {2, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-38, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature2(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 0, height = 0, offset = wgas, startTime = 0) annotation(Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 400, height = -140, offset = Tingas_sh, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      GF_HE SH(redeclare onlyFlowHEBoilLite flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, numberOfTubeSections = numberOfTubeSections_sh, numberPMCalcSections = numberPMCalcSections_sh, numberOfFlueSections = numberOfFlueSections_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, m_flow_small = system.m_flow_small) annotation(Placement(visible = true, transformation(origin = {34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveLinear CV1(redeclare package Medium = Medium_F, dp_nominal = 1000, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {23, 67}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(Placement(visible = true, transformation(origin = {-2, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveLinear CV2(redeclare package Medium = Medium_F, dp_nominal = pflow_sh - system.p_ambient, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {47, 57}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV2 annotation(Placement(visible = true, transformation(origin = {36, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp ramp1(duration = 0, height = 0, offset = Tinflow_eco, startTime = 0) annotation(Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Separator2 separator21(redeclare package Medium = Medium_F, Dsteam_start = wsteam, ps_start = pflow_ote2, m_flow_small = system.m_flow_small) annotation(Placement(visible = true, transformation(origin = {16, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(separator21.steam, CV1.port_a) annotation(Line(points = {{16, 55}, {16, 66}, {18, 66}, {18, 68}}, color = {0, 127, 255}));
      connect(OTE2.flowOut, separator21.fedWater) annotation(Line(points = {{6, 24}, {6, 51}, {9, 51}}, color = {0, 127, 255}));
      connect(ramp1.y, flowSource.T_in) annotation(Line(points = {{-78, 92}, {-72, 92}, {-72, 72}, {-98, 72}, {-98, 54}, {-96, 54}}, color = {0, 0, 127}));
      connect(constCV2.y, CV2.opening) annotation(Line(points = {{48, 86}, {54, 86}, {54, 70}, {46, 70}, {46, 62}, {48, 62}}, color = {0, 0, 127}));
      connect(CV2.port_b, flowSink.ports[1]) annotation(Line(points = {{52, 57}, {56, 57}, {56, 56}, {60, 56}}, color = {0, 127, 255}));
      connect(SH.flowOut, CV2.port_a) annotation(Line(points = {{38, 24}, {38, 57}, {42, 57}}, color = {0, 127, 255}));
      connect(constCV1.y, CV1.opening) annotation(Line(points = {{10, 80}, {24, 80}, {24, 72}, {24, 72}}, color = {0, 0, 127}));
      connect(CV1.port_b, SH.flowIn) annotation(Line(points = {{28, 68}, {32, 68}, {32, 38}, {30, 38}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
//separator.steam.p = pflow_eco;
//SH.flowIn.m_flow = wsteam;
//SH.flowIn.h_outflow = hflow_sh_in;
      connect(SH.gasOut, OTE2.gasIn) annotation(Line(points = {{28, 12}, {8, 12}, {8, 12}, {8, 12}}, color = {0, 127, 255}));
      connect(gasSource.ports[1], SH.gasIn) annotation(Line(points = {{60, -6}, {48, -6}, {48, 12}, {40, 12}, {40, 12}}, color = {0, 127, 255}));
      connect(gasSource.T_in, rampGasTemp.y) annotation(Line(points = {{82, -2}, {87, -2}, {87, -2}, {92, -2}, {92, -34}, {82, -34}, {82, -34}}, color = {0, 0, 127}));
      connect(rampGasFlow.y, gasSource.m_flow_in) annotation(Line(points = {{81, -66}, {89, -66}, {89, -66}, {97, -66}, {97, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}}, color = {0, 0, 127}));
      connect(OTE1.flowOut, temperature2.port_a) annotation(Line(points = {{-17.8, 23}, {-17.8, 26.5}, {-17.8, 26.5}, {-17.8, 30}, {-13.8, 30}}, color = {0, 127, 255}));
      connect(temperature2.port_b, OTE2.flowIn) annotation(Line(points = {{-6, 30}, {-2, 30}, {-2, 26}, {-2, 26}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
      connect(temperature1.port_b, OTE1.flowIn) annotation(Line(points = {{-34, 30}, {-26, 30}, {-26, 26.5}, {-26, 26.5}, {-26, 23}}, color = {0, 127, 255}));
      connect(ECO.flowOut, temperature1.port_a) annotation(Line(points = {{-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 31}, {-41.8, 31}, {-41.8, 29}, {-41.8, 29}}, color = {0, 127, 255}));
      connect(OTE1.gasIn, OTE2.gasOut) annotation(Line(points = {{-15.8, 12}, {-3.8, 12}}, color = {0, 127, 255}));
      connect(ECO.gasIn, OTE1.gasOut) annotation(Line(points = {{-39.8, 12}, {-27.8, 12}}, color = {0, 127, 255}));
      connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -6}, {-60, -6}, {-60, 12}, {-52, 12}}, color = {0, 127, 255}));
      connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-74, 50}, {-50, 50}, {-50, 23}}, color = {0, 127, 255}));
    initial equation
      for i in 1:numberOfFlueSections_eco loop
        for j in 1:numberOfTubeSections_eco loop
          der(ECO.flowHE.h_flow_n[i, j + 1]) = 0;
          der(ECO.flowHE.h_flow_v[i, j]) = 0;
          der(ECO.flowHE.t_m[i, j]) = 0;
          der(ECO.gasHE.h_gas[i + 1, j]) = 0;
        end for;
//for j in 1:integer(numberOfTubeSections_eco / numberPMCalcSections_eco) loop
//der(ECO.flowHE.p_flow_v[i, j]) = 0;
//end for;
      end for;
//(ECO.flowHE.p_flow_v) = 0;
      for i in 1:numberOfFlueSections_ote1 loop
        for j in 1:numberOfTubeSections_ote1 loop
//der(OTE1.flowHE.h_flow_n[i, j + 1]) = 0;
//der(OTE1.flowHE.h_flow_v[i, j]) = 0;
//der(OTE1.flowHE.t_m[i, j]) = 0;
          der(OTE1.gasHE.h_gas[i + 1, j]) = 0;
        end for;
//for j in 1:integer(numberOfTubeSections_ote1 / numberPMCalcSections_ote1) loop
//der(OTE1.flowHE.p_flow_v[i, j]) = 0;
//end for;
      end for;
//der(OTE1.flowHE.p_flow_v) = 0;
      for i in 1:numberOfFlueSections_ote2 loop
        for j in 1:numberOfTubeSections_ote2 loop
//der(OTE2.flowHE.h_flow_n[i, j + 1]) = 0;
//der(OTE2.flowHE.h_flow_v[i, j]) = 0;
//der(OTE2.flowHE.t_m[i, j]) = 0;
          der(OTE2.gasHE.h_gas[i + 1, j]) = 0;
        end for;
//for j in 1:integer(numberOfTubeSections_ote2 / numberPMCalcSections_ote2) loop
//der(OTE2.flowHE.p_flow_v[i, j]) = 0;
//end for;
      end for;
//der(OTE2.flowHE.p_flow_v) = 0;
//for i in 1:zahod_ote2 loop
//der(OTE2.flowHE.p_flow_v[i]) = 0;
//der(OTE2.flowHE.p_flow_v[i + integer(numberOfFlueSections_ote2 / 2) - integer(zahod_ote2 / 2), integer(integer(numberOfTubeSections_ote2 / numberPMCalcSections_ote2) / 2) + 1]) = 0;
//end for;
      for i in 1:numberOfFlueSections_sh loop
        for j in 1:numberOfTubeSections_sh loop
          der(SH.flowHE.h_flow_n[i, j + 1]) = 0;
          der(SH.flowHE.h_flow_v[i, j]) = 0;
          der(SH.flowHE.t_m[i, j]) = 0;
          der(SH.gasHE.h_gas[i + 1, j]) = 0;
        end for;
      end for;
      der(SH.flowHE.p_flow_v) = 0;
      annotation(uses(Modelica(version = "3.2.1")), Documentation(info = "<html>
    <p>
    Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
    </p>
    </html>"), experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-10, Interval = 0.005), __OpenModelica_simulationFlags(jacobian = "coloredNumerical", s = "dassl", lv = "LOG_STATS"));
    end onceThrough_12;

    model onceThrough_13
      package Medium_F = Modelica.Media.Water.WaterIF97_ph;
      parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
      parameter Modelica.SIunits.MassFlowRate wsteam = 0 "Расход пара на выходе из сепаратора";
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas = 100 / 3.6 "Номинальный (и начальный) массовый расход газов ";
      parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
      parameter Medium_F.SaturationProperties sat_start = Medium_F.setSat_p(pflow_ote2);
      //Исходные данные для сепаратора
      parameter Modelica.SIunits.Length Dsep = 0.348 "Внутренний диаметр сепаратор";
      parameter Modelica.SIunits.Length Lsep = 5 "Длина (высота) сепаратора";
      parameter Modelica.SIunits.Length deltaSep = 0.04 "Толщина стенки сепаратора";
      parameter Integer n_sep_set = 2 "Количество сепараторов";
      //Начальные значения для сепаратора
      parameter Modelica.SIunits.Length Hw_start_set = 2 "Начальное значение уровня воды в сепараторе";
      //Констуктивные характеристики поверхностей нагрева
      parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
      //Исходные данные для экономайзера
      parameter Modelica.SIunits.Diameter Din_eco = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
      parameter Integer zahod_eco = 1 "заходность труб теплообменника";
      parameter Integer z1_eco = 58 "Число труб по ширине газохода";
      parameter Integer z2_eco = 8 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб экономайзера
      parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
      //Исходные данные по разбиению экономайзера
      parameter Integer numberOfTubeSections_eco = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_eco = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_eco = 1.013e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_eco = 60 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_eco = 60 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm_eco = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_eco = 60 + 273.15 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_eco = 60 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для прямоточного испарителя №1 (OTE1)
      parameter Modelica.SIunits.Diameter Din_ote1 = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_ote1 = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_ote1 = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_ote1 = 79e-3 "Продольный шаг";
      parameter Integer zahod_ote1 = 1 "заходность труб теплообменника";
      parameter Integer z1_ote1 = 58 "Число труб по ширине газохода";
      parameter Integer z2_ote1 = 10 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб прямоточного испарителя №1 (OTE1)
      parameter Modelica.SIunits.Length delta_fin_ote1 = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_ote1 = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_ote1 = 2.002e-3 "Шаг ребер, м";
      //Исходные данные по разбиению испарителя №1 (OTE1)
      parameter Integer numberOfTubeSections_ote1 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_ote1 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_ote1 = z2_ote1 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_ote1 = 1.013e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_ote1 = 60 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_ote1 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm_ote1 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_in = hflow_eco_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_out = hflow_ote1_in "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_ote1 = 60 + 273.15 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_ote1 = 60 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_ote1 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для прямоточного испарителя №2 (OTE2)
      parameter Modelica.SIunits.Diameter Din_ote2 = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_ote2 = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_ote2 = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_ote2 = 79e-3 "Продольный шаг";
      parameter Integer zahod_ote2 = 2 "заходность труб теплообменника";
      parameter Integer z1_ote2 = 58 "Число труб по ширине газохода";
      parameter Integer z2_ote2 = 6 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб прямоточного испарителя №2 (OTE2)
      parameter Modelica.SIunits.Length delta_fin_ote2 = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_ote2 = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_ote2 = 2.735e-3 "Шаг ребер, м";
      //Исходные данные по разбиению испарителя №2 (OTE2)
      parameter Integer numberOfTubeSections_ote2 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_ote2 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_ote2 = z2_ote2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для испарителя №2
      parameter Modelica.SIunits.Pressure pflow_ote2 = 1.013e5 "Начальное давление потока вода/пар перед OTE2";
      parameter Modelica.SIunits.Temperature Tinflow_ote2 = 60 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_ote2 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm_ote2 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_in = hflow_ote1_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_out = hflow_ote2_in "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны испарителя №2
      parameter Modelica.SIunits.Temperature Tingas_ote2 = 60 + 273.15 "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
      parameter Modelica.SIunits.Temperature Toutgas_ote2 = 60 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_ote2 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для пароперегревателя (SH)
      parameter Modelica.SIunits.Diameter Dout_sh = 0.038 "Наружный диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_sh = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_sh = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_sh = 79e-3 "Продольный шаг";
      parameter Integer zahod_sh = 1 "заходность труб теплообменника";
      parameter Integer z1_sh = 58 "Число труб по ширине газохода";
      parameter Integer z2_sh = 8 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб пароперегревателя (SH)
      parameter Modelica.SIunits.Length delta_fin_sh = 0.001 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_sh = 0.012 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_sh = 5.102e-3 "Шаг ребер, м";
      //Исходные данные по разбиению пароперегревателя (SH)
      parameter Integer numberOfTubeSections_sh = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_sh = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_sh = z2_sh "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для пароперегревателя
      parameter Modelica.SIunits.Pressure pflow_sh = 1.013e5 "Начальное давление потока вода/пар перед SH";
      parameter Modelica.SIunits.Temperature Tinflow_sh = 60 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_sh = 60 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm_sh = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_in = 2.676e6 "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_out = hflow_sh_in "Начальная энтальпия входного потока вода/пар";
      //Исходные данные для газовой стороны испарителя №2
      parameter Modelica.SIunits.Temperature Tingas_sh = 60 + 273.15 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_sh = 60 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_sh = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      inner Modelica.Fluid.System system(allowFlowReversal = false) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wflow, T = Tinflow_eco) annotation(Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE ECO(redeclare onlyFlowHEBoil_7 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, numberOfFlueSections = numberOfFlueSections_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco) annotation(Placement(visible = true, transformation(origin = {-46, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE OTE1(redeclare onlyFlowHEBoil_7 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, numberOfTubeSections = numberOfTubeSections_ote1, numberPMCalcSections = numberPMCalcSections_ote1, numberOfFlueSections = numberOfFlueSections_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, setTm = setTm_ote1) annotation(Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE OTE2(redeclare onlyFlowHEBoil_7 flowHE, redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, numberOfTubeSections = numberOfTubeSections_ote2, numberPMCalcSections = numberPMCalcSections_ote2, numberOfFlueSections = numberOfFlueSections_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2) annotation(Placement(visible = true, transformation(origin = {2, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-38, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature2(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 600, height = 1000, offset = wgas, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 40, height = 200, offset = Tingas_sh, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      GF_HE SH(redeclare onlyFlowHEBoilLite flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, numberOfTubeSections = numberOfTubeSections_sh, numberPMCalcSections = numberPMCalcSections_sh, numberOfFlueSections = numberOfFlueSections_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2) annotation(Placement(visible = true, transformation(origin = {34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveLinear CV1(redeclare package Medium = Medium_F, dp_nominal = 1000, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {23, 67}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(Placement(visible = true, transformation(origin = {-2, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveLinear CV2(redeclare package Medium = Medium_F, dp_nominal = 10.01e5 - system.p_ambient, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {47, 57}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV2 annotation(Placement(visible = true, transformation(origin = {36, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      MyHRSG_lite.Separator2 separator21 annotation(Placement(visible = true, transformation(origin = {14, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(separator21.steam, CV1.port_a) annotation(Line(points = {{14, 51}, {14, 68}, {18, 68}}, color = {0, 127, 255}));
      connect(OTE2.flowOut, separator21.fedWater) annotation(Line(points = {{6, 24}, {6, 47}, {7, 47}}, color = {0, 127, 255}));
      connect(constCV2.y, CV2.opening) annotation(Line(points = {{48, 86}, {54, 86}, {54, 70}, {46, 70}, {46, 62}, {48, 62}}, color = {0, 0, 127}));
      connect(CV2.port_b, flowSink.ports[1]) annotation(Line(points = {{52, 57}, {56, 57}, {56, 56}, {60, 56}}, color = {0, 127, 255}));
      connect(SH.flowOut, CV2.port_a) annotation(Line(points = {{38, 24}, {38, 57}, {42, 57}}, color = {0, 127, 255}));
      connect(constCV1.y, CV1.opening) annotation(Line(points = {{10, 80}, {24, 80}, {24, 72}, {24, 72}}, color = {0, 0, 127}));
      connect(CV1.port_b, SH.flowIn) annotation(Line(points = {{28, 68}, {32, 68}, {32, 38}, {30, 38}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
      connect(SH.gasOut, OTE2.gasIn) annotation(Line(points = {{28, 12}, {8, 12}, {8, 12}, {8, 12}}, color = {0, 127, 255}));
      connect(gasSource.ports[1], SH.gasIn) annotation(Line(points = {{60, -6}, {48, -6}, {48, 12}, {40, 12}, {40, 12}}, color = {0, 127, 255}));
      connect(gasSource.T_in, rampGasTemp.y) annotation(Line(points = {{82, -2}, {87, -2}, {87, -2}, {92, -2}, {92, -34}, {82, -34}, {82, -34}}, color = {0, 0, 127}));
      connect(rampGasFlow.y, gasSource.m_flow_in) annotation(Line(points = {{81, -66}, {89, -66}, {89, -66}, {97, -66}, {97, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}}, color = {0, 0, 127}));
      connect(OTE1.flowOut, temperature2.port_a) annotation(Line(points = {{-17.8, 23}, {-17.8, 26.5}, {-17.8, 26.5}, {-17.8, 30}, {-13.8, 30}}, color = {0, 127, 255}));
      connect(temperature2.port_b, OTE2.flowIn) annotation(Line(points = {{-6, 30}, {-2, 30}, {-2, 26}, {-2, 26}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
      connect(temperature1.port_b, OTE1.flowIn) annotation(Line(points = {{-34, 30}, {-26, 30}, {-26, 26.5}, {-26, 26.5}, {-26, 23}}, color = {0, 127, 255}));
      connect(ECO.flowOut, temperature1.port_a) annotation(Line(points = {{-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 31}, {-41.8, 31}, {-41.8, 29}, {-41.8, 29}}, color = {0, 127, 255}));
      connect(OTE1.gasIn, OTE2.gasOut) annotation(Line(points = {{-15.8, 12}, {-3.8, 12}}, color = {0, 127, 255}));
      connect(ECO.gasIn, OTE1.gasOut) annotation(Line(points = {{-39.8, 12}, {-27.8, 12}}, color = {0, 127, 255}));
      connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -6}, {-60, -6}, {-60, 12}, {-52, 12}}, color = {0, 127, 255}));
      connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-74, 50}, {-50, 50}, {-50, 23}}, color = {0, 127, 255}));
    initial equation
      for i in 1:numberOfFlueSections_eco loop
        for j in 1:numberOfTubeSections_eco loop
          der(ECO.flowHE.h_flow_n[i, j + 1]) = 0;
          der(ECO.flowHE.h_flow_v[i, j]) = 0;
          der(ECO.flowHE.t_m[i, j]) = 0;
          der(ECO.gasHE.h_gas[i + 1, j]) = 0;
        end for;
//for j in 1:integer(numberOfTubeSections_eco / numberPMCalcSections_eco) loop
//der(ECO.flowHE.p_flow_v[i, j]) = 0;
//end for;
      end for;
      der(ECO.flowHE.p_flow_v) = 0;
      for i in 1:numberOfFlueSections_ote1 loop
        for j in 1:numberOfTubeSections_ote1 loop
//der(OTE1.flowHE.h_flow_n[i, j + 1]) = 0;
//der(OTE1.flowHE.h_flow_v[i, j]) = 0;
//der(OTE1.flowHE.t_m[i, j]) = 0;
          der(OTE1.gasHE.h_gas[i + 1, j]) = 0;
        end for;
//for j in 1:integer(numberOfTubeSections_ote1 / numberPMCalcSections_ote1) loop
//der(OTE1.flowHE.p_flow_v[i, j]) = 0;
//end for;
      end for;
//der(OTE1.flowHE.p_flow_v) = 0;
      for i in 1:numberOfFlueSections_ote2 loop
        for j in 1:numberOfTubeSections_ote2 loop
//der(OTE2.flowHE.h_flow_n[i, j + 1]) = 0;
//der(OTE2.flowHE.h_flow_v[i, j]) = 0;
//der(OTE2.flowHE.t_m[i, j]) = 0;
          der(OTE2.gasHE.h_gas[i + 1, j]) = 0;
        end for;
//for j in 1:integer(numberOfTubeSections_ote2 / numberPMCalcSections_ote2) loop
//der(OTE2.flowHE.p_flow_v[i, j]) = 0;
//end for;
      end for;
//der(OTE2.flowHE.p_flow_v) = 0;
/*for i in 1:1 loop
    for j in 1:numberOfTubeSections_sh loop
      der(SH.gasHE.h_gas[i + 1, j]) = 0;
    end for;
    for j in 2:numberOfTubeSections_sh loop
      der(SH.flowHE.t_m[i, j]) = 0;
      der(SH.flowHE.h_flow_n[i, j + 1]) = 0;
      der(SH.flowHE.h_flow_v[i, j]) = 0;
     end for;
  end for;*/
      for i in 1:numberOfFlueSections_sh loop
        for j in 1:numberOfTubeSections_sh loop
          der(SH.flowHE.h_flow_n[i, j + 1]) = 0;
          der(SH.flowHE.h_flow_v[i, j]) = 0;
          der(SH.flowHE.t_m[i, j]) = 0;
          der(SH.gasHE.h_gas[i + 1, j]) = 0;
        end for;
      end for;
      der(SH.flowHE.p_flow_v) = 0;
      annotation(uses(Modelica(version = "3.2.1")), Documentation(info = "<html>
<p>
Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
</p>
</html>"));
    end onceThrough_13;

    model onceThrough_12_lite
      parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      package Medium_F = Modelica.Media.Water.WaterIF97_ph;
      parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
      parameter Modelica.SIunits.MassFlowRate wsteam = 4.23 "Расход пара на выходе из сепаратора";
      parameter Modelica.SIunits.Pressure patm = 1.013e5 "Начальное давление потока вода/пар за клапаном (турбиной)";
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas = 1276.6 / 3.6 "Номинальный (и начальный) массовый расход газов ";
      parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
      parameter Medium_F.SaturationProperties sat_start = Medium_F.setSat_p(pflow_ote2);
      //Исходные данные для сепаратора
      parameter Modelica.SIunits.Length Dsep = 0.348 "Внутренний диаметр сепаратор";
      parameter Modelica.SIunits.Length Lsep = 5 "Длина (высота) сепаратора";
      parameter Modelica.SIunits.Length deltaSep = 0.04 "Толщина стенки сепаратора";
      parameter Integer n_sep_set = 2 "Количество сепараторов";
      //Начальные значения для сепаратора
      parameter Modelica.SIunits.Length Hw_start_set = 2 "Начальное значение уровня воды в сепараторе";
      //Констуктивные характеристики поверхностей нагрева
      parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
      //Исходные данные для экономайзера
      parameter Modelica.SIunits.Diameter Din_eco = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
      parameter Integer zahod_eco = 1 "заходность труб теплообменника";
      parameter Integer z1_eco = 58 "Число труб по ширине газохода";
      parameter Integer z2_eco = 8 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб экономайзера
      parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
      //Исходные данные по разбиению экономайзера
      parameter Integer numberOfTubeSections_eco = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_eco = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_eco = 7.7e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_eco = 60 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_eco = 160 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_eco = Toutgas_ote1 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_eco = 161.4 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для прямоточного испарителя №1 (OTE1)
      parameter Modelica.SIunits.Diameter Din_ote1 = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_ote1 = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_ote1 = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_ote1 = 79e-3 "Продольный шаг";
      parameter Integer zahod_ote1 = 1 "заходность труб теплообменника";
      parameter Integer z1_ote1 = 58 "Число труб по ширине газохода";
      parameter Integer z2_ote1 = 10 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб прямоточного испарителя №1 (OTE1)
      parameter Modelica.SIunits.Length delta_fin_ote1 = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_ote1 = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_ote1 = 2.002e-3 "Шаг ребер, м";
      //Исходные данные по разбиению испарителя №1 (OTE1)
      parameter Integer numberOfTubeSections_ote1 = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_ote1 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_ote1 = z2_ote1 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_ote1 = 7.7e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_ote1 = Toutflow_eco "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_ote1 = 158 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_in = hflow_eco_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_out = 0.97e6 "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_ote1 = Toutgas_ote2 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_ote1 = 179 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_ote1 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для прямоточного испарителя №2 (OTE2)
      parameter Modelica.SIunits.Diameter Din_ote2 = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_ote2 = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_ote2 = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_ote2 = 79e-3 "Продольный шаг";
      parameter Integer zahod_ote2 = 2 "заходность труб теплообменника";
      parameter Integer z1_ote2 = 58 "Число труб по ширине газохода";
      parameter Integer z2_ote2 = 6 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб прямоточного испарителя №2 (OTE2)
      parameter Modelica.SIunits.Length delta_fin_ote2 = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_ote2 = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_ote2 = 2.735e-3 "Шаг ребер, м";
      //Исходные данные по разбиению испарителя №2 (OTE2)
      parameter Integer numberOfTubeSections_ote2 = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_ote2 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_ote2 = z2_ote2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для испарителя №2
      parameter Modelica.SIunits.Pressure pflow_ote2 = 5.5e5 "Начальное давление потока вода/пар перед OTE2";
      parameter Modelica.SIunits.Temperature Tinflow_ote2 = Toutflow_ote1 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_ote2 = 145 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_in = hflow_ote1_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_out = 1.15e6 "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны испарителя №2
      parameter Modelica.SIunits.Temperature Tingas_ote2 = Toutgas_sh "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
      parameter Modelica.SIunits.Temperature Toutgas_ote2 = 191 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_ote2 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      //Исходные данные для пароперегревателя (SH)
      parameter Modelica.SIunits.Diameter Dout_sh = 0.038 "Наружный диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_sh = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_sh = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_sh = 79e-3 "Продольный шаг";
      parameter Integer zahod_sh = 1 "заходность труб теплообменника";
      parameter Integer z1_sh = 58 "Число труб по ширине газохода";
      parameter Integer z2_sh = 8 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб пароперегревателя (SH)
      parameter Modelica.SIunits.Length delta_fin_sh = 0.001 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_sh = 0.012 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_sh = 5.102e-3 "Шаг ребер, м";
      //Исходные данные по разбиению пароперегревателя (SH)
      parameter Integer numberOfTubeSections_sh = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_sh = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_sh = z2_sh "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для пароперегревателя
      parameter Modelica.SIunits.Pressure pflow_sh = 3.7e5 "Начальное давление потока вода/пар перед SH";
      parameter Modelica.SIunits.Temperature Tinflow_sh = Toutflow_ote2 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_sh = 198 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_in = hflow_ote2_out "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_out = Medium_F.specificEnthalpy_pT(pflow_sh, Toutflow_sh) "Начальная энтальпия входного потока вода/пар";
      //Исходные данные для газовой стороны испарителя №2
      parameter Modelica.SIunits.Temperature Tingas_sh = 200 + 273.15 "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas_sh = 199 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_sh = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      inner Modelica.Fluid.System system(allowFlowReversal = false, m_flow_small = m_flow_small) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = Tinflow_eco, m_flow = wflow, nPorts = 1, use_T_in = true, use_m_flow_in = false) annotation(Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      MyHRSG_lite.liteModels.GF_HE_lite ECO(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, numberOfFlueSections = numberOfFlueSections_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, m_flow_small = system.m_flow_small) annotation(Placement(visible = true, transformation(origin = {-46, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      MyHRSG_lite.liteModels.GF_HE_lite OTE1(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, numberOfTubeSections = numberOfTubeSections_ote1, numberPMCalcSections = numberPMCalcSections_ote1, numberOfFlueSections = numberOfFlueSections_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, m_flow_small = system.m_flow_small) annotation(Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      MyHRSG_lite.liteModels.GF_HE_lite OTE2(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, numberOfTubeSections = numberOfTubeSections_ote2, numberPMCalcSections = numberPMCalcSections_ote2, numberOfFlueSections = numberOfFlueSections_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, m_flow_small = system.m_flow_small) annotation(Placement(visible = true, transformation(origin = {2, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-38, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature2(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 0, height = 0, offset = wgas, startTime = 0) annotation(Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 400, height = -140, offset = Tingas_sh, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      GF_HE SH(redeclare onlyFlowHEBoilLite flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, numberOfTubeSections = numberOfTubeSections_sh, numberPMCalcSections = numberPMCalcSections_sh, numberOfFlueSections = numberOfFlueSections_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, m_flow_small = system.m_flow_small) annotation(Placement(visible = true, transformation(origin = {34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveLinear CV1(redeclare package Medium = Medium_F, dp_nominal = 1000, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {23, 67}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(Placement(visible = true, transformation(origin = {-2, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Valves.ValveLinear CV2(redeclare package Medium = Medium_F, dp_nominal = pflow_sh - system.p_ambient, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {47, 57}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constCV2 annotation(Placement(visible = true, transformation(origin = {36, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Ramp ramp1(duration = 0, height = 0, offset = Tinflow_eco, startTime = 0) annotation(Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Separator2 separator21(redeclare package Medium = Medium_F, Dsteam_start = wsteam, ps_start = pflow_ote2, m_flow_small = system.m_flow_small) annotation(Placement(visible = true, transformation(origin = {16, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(separator21.steam, CV1.port_a) annotation(Line(points = {{16, 55}, {16, 66}, {18, 66}, {18, 68}}, color = {0, 127, 255}));
      connect(OTE2.flowOut, separator21.fedWater) annotation(Line(points = {{6, 24}, {6, 51}, {9, 51}}, color = {0, 127, 255}));
      connect(ramp1.y, flowSource.T_in) annotation(Line(points = {{-78, 92}, {-72, 92}, {-72, 72}, {-98, 72}, {-98, 54}, {-96, 54}}, color = {0, 0, 127}));
      connect(constCV2.y, CV2.opening) annotation(Line(points = {{48, 86}, {54, 86}, {54, 70}, {46, 70}, {46, 62}, {48, 62}}, color = {0, 0, 127}));
      connect(CV2.port_b, flowSink.ports[1]) annotation(Line(points = {{52, 57}, {56, 57}, {56, 56}, {60, 56}}, color = {0, 127, 255}));
      connect(SH.flowOut, CV2.port_a) annotation(Line(points = {{38, 24}, {38, 57}, {42, 57}}, color = {0, 127, 255}));
      connect(constCV1.y, CV1.opening) annotation(Line(points = {{10, 80}, {24, 80}, {24, 72}, {24, 72}}, color = {0, 0, 127}));
      connect(CV1.port_b, SH.flowIn) annotation(Line(points = {{28, 68}, {32, 68}, {32, 38}, {30, 38}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
//separator.steam.p = pflow_eco;
//SH.flowIn.m_flow = wsteam;
//SH.flowIn.h_outflow = hflow_sh_in;
      connect(SH.gasOut, OTE2.gasIn) annotation(Line(points = {{28, 12}, {8, 12}, {8, 12}, {8, 12}}, color = {0, 127, 255}));
      connect(gasSource.ports[1], SH.gasIn) annotation(Line(points = {{60, -6}, {48, -6}, {48, 12}, {40, 12}, {40, 12}}, color = {0, 127, 255}));
      connect(gasSource.T_in, rampGasTemp.y) annotation(Line(points = {{82, -2}, {87, -2}, {87, -2}, {92, -2}, {92, -34}, {82, -34}, {82, -34}}, color = {0, 0, 127}));
      connect(rampGasFlow.y, gasSource.m_flow_in) annotation(Line(points = {{81, -66}, {89, -66}, {89, -66}, {97, -66}, {97, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}}, color = {0, 0, 127}));
      connect(OTE1.flowOut, temperature2.port_a) annotation(Line(points = {{-17.8, 23}, {-17.8, 26.5}, {-17.8, 26.5}, {-17.8, 30}, {-13.8, 30}}, color = {0, 127, 255}));
      connect(temperature2.port_b, OTE2.flowIn) annotation(Line(points = {{-6, 30}, {-2, 30}, {-2, 26}, {-2, 26}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
      connect(temperature1.port_b, OTE1.flowIn) annotation(Line(points = {{-34, 30}, {-26, 30}, {-26, 26.5}, {-26, 26.5}, {-26, 23}}, color = {0, 127, 255}));
      connect(ECO.flowOut, temperature1.port_a) annotation(Line(points = {{-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 31}, {-41.8, 31}, {-41.8, 29}, {-41.8, 29}}, color = {0, 127, 255}));
      connect(OTE1.gasIn, OTE2.gasOut) annotation(Line(points = {{-15.8, 12}, {-3.8, 12}}, color = {0, 127, 255}));
      connect(ECO.gasIn, OTE1.gasOut) annotation(Line(points = {{-39.8, 12}, {-27.8, 12}}, color = {0, 127, 255}));
      connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -6}, {-60, -6}, {-60, 12}, {-52, 12}}, color = {0, 127, 255}));
      connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-74, 50}, {-50, 50}, {-50, 23}}, color = {0, 127, 255}));
    initial equation
      for i in 1:numberOfFlueSections_eco loop
        for j in 1:numberOfTubeSections_eco loop
//der(ECO.flowHE.h_flow_n[i, j + 1]) = 0;
//der(ECO.flowHE.h_flow_v[i, j]) = 0;
//der(ECO.flowHE.t_m[i, j]) = 0;
//der(ECO.gasHE.h_gas[i + 1, j]) = 0;
        end for;
//for j in 1:integer(numberOfTubeSections_eco / numberPMCalcSections_eco) loop
//der(ECO.flowHE.p_flow_v[i, j]) = 0;
//end for;
      end for;
//(ECO.flowHE.p_flow_v) = 0;
      for i in 1:numberOfFlueSections_ote1 loop
        for j in 1:numberOfTubeSections_ote1 loop
//der(OTE1.flowHE.h_flow_n[i, j + 1]) = 0;
//der(OTE1.flowHE.h_flow_v[i, j]) = 0;
//der(OTE1.flowHE.t_m[i, j]) = 0;
//der(OTE1.gasHE.h_gas[i + 1, j]) = 0;
        end for;
//for j in 1:integer(numberOfTubeSections_ote1 / numberPMCalcSections_ote1) loop
//der(OTE1.flowHE.p_flow_v[i, j]) = 0;
//end for;
      end for;
//der(OTE1.flowHE.p_flow_v) = 0;
      for i in 1:numberOfFlueSections_ote2 loop
        for j in 1:numberOfTubeSections_ote2 loop
//der(OTE2.flowHE.h_flow_n[i, j + 1]) = 0;
//der(OTE2.flowHE.h_flow_v[i, j]) = 0;
//der(OTE2.flowHE.t_m[i, j]) = 0;
//der(OTE2.gasHE.h_gas[i + 1, j]) = 0;
        end for;
//for j in 1:integer(numberOfTubeSections_ote2 / numberPMCalcSections_ote2) loop
//der(OTE2.flowHE.p_flow_v[i, j]) = 0;
//end for;
      end for;
//der(OTE2.flowHE.p_flow_v) = 0;
//for i in 1:zahod_ote2 loop
//der(OTE2.flowHE.p_flow_v[i]) = 0;
//der(OTE2.flowHE.p_flow_v[i + integer(numberOfFlueSections_ote2 / 2) - integer(zahod_ote2 / 2), integer(integer(numberOfTubeSections_ote2 / numberPMCalcSections_ote2) / 2) + 1]) = 0;
//end for;
      for i in 1:numberOfFlueSections_sh loop
        for j in 1:numberOfTubeSections_sh loop
          der(SH.flowHE.h_flow_n[i, j + 1]) = 0;
          der(SH.flowHE.h_flow_v[i, j]) = 0;
          der(SH.flowHE.t_m[i, j]) = 0;
          der(SH.gasHE.h_gas[i + 1, j]) = 0;
        end for;
      end for;
      der(SH.flowHE.p_flow_v) = 0;
      annotation(uses(Modelica(version = "3.2.1")), Documentation(info = "<html>
    <p>
    Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
    </p>
    </html>"), experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-10, Interval = 0.005), __OpenModelica_simulationFlags(jacobian = "coloredNumerical", s = "dassl", lv = "LOG_STATS"));
    end onceThrough_12_lite;
  end onceThrough;

  model onlyFlowHEBoil_2 "C1 и С2 приравнены нулю"
    function positiveMax
      extends Modelica.Icons.Function;
      input Real x;
      output Real y;
    algorithm
      y := max(x, 1e-10);
    end positiveMax;

    function HTtoMT "Функция перехода с участков труб для расчета теплообмена на участки расчета массообмена (осреднение)"
      input Real x[:] "Массив элементов по участком тубы разбитых для расчета теплообмена";
      input Integer numberPMCalcSections "Число участков разбиения трубы входящих в один участок расчета процессов массообмена";
      input Integer j "Текущий участок трубы по расчету массообмена";
      output Real y;
    algorithm
      y := sum(x[k] for k in 1 + (j - 1) * numberPMCalcSections:j * numberPMCalcSections) / numberPMCalcSections;
    end HTtoMT;

    function HTtoMT_n "Функция перехода с участков труб для расчета теплообмена на участки расчета массообмена (в узловой точке)"
      input Real x[:] "Массив элементов по участком тубы разбитых для расчета теплообмена";
      input Integer numberPMCalcSections "Число участков разбиения трубы входящих в один участок расчета процессов массообмена";
      input Integer j "Текущий участок трубы по расчету массообмена";
      output Real y;
    algorithm
      y := x[1 + (j - 1) * numberPMCalcSections];
    end HTtoMT_n;

    function HTtoMT_sum "Функция перехода с участков труб для расчета теплообмена на участки расчета массообмена (скммирование)"
      input Real x[:] "Массив элементов по участком тубы разбитых для расчета теплообмена";
      input Integer numberPMCalcSections "Число участков разбиения трубы входящих в один участок расчета процессов массообмена";
      input Integer j "Текущий участок трубы по расчету массообмена";
      output Real y;
    algorithm
      y := sum(x[k] for k in 1 + (j - 1) * numberPMCalcSections:j * numberPMCalcSections) / numberPMCalcSections;
    end HTtoMT_sum;

    function MTtoHT "Функция перехода с участков труб для расчета массообмена на участки расчета теплообмена"
      input Real x[:] "Массив элементов по участком тубы разбитых для расчета массообмена";
      input Integer numberPMCalcSections "Число участков разбиения трубы входящих в один участок расчета процессов массообмена";
      input Integer j "Текущий участок трубы по расчету теплообмена";
      output Real y;
    algorithm
      y := x[integer((j + numberPMCalcSections - 1) / numberPMCalcSections)];
    end MTtoHT;

    import MyHRSG_lite.phi_heatedPipe;
    import MyHRSG_lite.lambda_tr;
    //**
    //***Исходные данные для газовой стороны
    //**
    parameter Modelica.SIunits.Power setQ_gas = 100 "тепловой поток со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
    //**
    //***Исходные данные по стороне вода/пар
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    replaceable package Medium_F2 = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
    parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
    parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
    //**
    //***Характеристики металла
    parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
    //**
    //**
    //Конструктивные характеристики
    //**
    //Параметры
    parameter MyHRSG_lite.Choices.HRSG_type HRSG_type = MyHRSG_lite.Choices.HRSG_type.horizontalBottom "Тип КУ";
    parameter Integer numberOfTubeSections = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberPMCalcSections = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfTubeSectionsForMT = integer(numberOfTubeSections / numberPMCalcSections) "Число участков разбиения трубы для расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfTubeNodes = numberOfTubeSectionsForMT + 1 "Число узлов в одной трубе";
    parameter Integer numberFirstTubeInLastZahod = integer(numberOfFlueSections - zahod + 1) "Номер первой трубы в последнем заходе";
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer zahod = 2 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
    //Поток вода/пар
    parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 / numberOfTubeSections "Внутренняя площадь одного участка ряда труб";
    parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 / 4 / numberOfTubeSections "Внутренний объем одного участка ряда труб";
    parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 / numberOfTubeSections "Масса металла участка ряда труб";
    parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
    parameter Modelica.SIunits.Time Tstab "Интервал времени в начале расчета в течение которого все производные равны нулю";
    //**
    //Начальные значения
    //**
    //Поток вода/пар
    parameter Medium_F.SpecificEnthalpy h_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(seth_in, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(seth_in, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_v[numberOfFlueSections, numberOfTubeSectionsForMT] = fill(setp_flow_in, numberOfFlueSections, numberOfTubeSectionsForMT) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1] = fill(setp_flow_in, numberOfFlueSections, numberOfTubeSectionsForMT + 1) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_v[numberOfFlueSections, numberOfTubeSectionsForMT] = fill(setD_flow / zahod, numberOfFlueSections, numberOfTubeSectionsForMT) "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1] = fill(setD_flow / zahod, numberOfFlueSections, numberOfTubeSectionsForMT + 1) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = fill(setTm, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    Modelica.SIunits.Length deltaHpipe "Разность высот на участке ряда труб";
    //Поток вода/пар
    Medium_F.ThermodynamicState stateFlow[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F2.ThermodynamicState stateFlowTwoPhase[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    Medium_F.AbsolutePressure p_flow_v[numberOfFlueSections, numberOfTubeSectionsForMT](start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.AbsolutePressure p_flow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
    Medium_F.SpecificEnthalpy h_flow_v[numberOfFlueSections, numberOfTubeSections](start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.SpecificEnthalpy h_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
    Real der_h_flow_v[numberOfFlueSections, numberOfTubeSections] "Производняа энтальпии потока вода/пар";
    Medium_F.Density rho_flow_v[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы в конечных объемах";
    Medium_F.Density rho_flow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1] "Плотность потока по участкам трубы в узловых точках";
    Modelica.SIunits.DerDensityByEnthalpy drdh_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow_v[numberOfFlueSections, numberOfTubeSectionsForMT](start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
    Medium_F.MassFlowRate D_flow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    Modelica.SIunits.HeatFlowRate Q_flow[numberOfFlueSections, numberOfTubeSections] "тепло переданное стенке трубы";
    Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
    Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    Real C1[numberOfFlueSections, numberOfTubeSectionsForMT] "Показатель в числителе уравнения сплошности";
    Real C2[numberOfFlueSections, numberOfTubeSectionsForMT] "Показатель в знаменателе уравнения сплошности";
    Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
    Modelica.SIunits.Length H_flow[numberOfFlueSections, numberOfTubeSectionsForMT + 1] "Высотная отметка каждого узла";
    Modelica.SIunits.Velocity w_flow_v[numberOfFlueSections, numberOfTubeSections] "Скорость потока вода/пар в конечных объемах";
    Modelica.SIunits.Velocity w_flow_n[numberOfFlueSections, numberOfTubeSectionsForMT + 1] "Скорость потока вода/пар в узловых точках";
    Real dp_fric[numberOfFlueSections, numberOfTubeSectionsForMT] "Потеря давления из-за сил трения";
    //Real dp_kin[numberOfFlueSections, numberOfTubeSectionsForMT] "Потеря давления из-за приращения кинетической энергии";
    Real dp_piez[numberOfFlueSections, numberOfTubeSectionsForMT] "Перепад давления из-за изменения пьезометрической высоты";
    Medium_F2.SaturationProperties sat_v[numberOfFlueSections, numberOfTubeSectionsForMT] "State vector to compute saturation properties внутри конечного объема";
    Real wrhop[numberOfFlueSections, numberOfTubeSectionsForMT] "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
    Real phi[numberOfFlueSections, numberOfTubeSectionsForMT] "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
    Real Xi_flow[numberOfFlueSections, numberOfTubeSectionsForMT] "Коэффициент гидравлического сопротивления участка трубы";
    Real x_v[numberOfFlueSections, numberOfTubeSections] "Степень сухости";
    Medium_F.Density dew_rho_flow_v[numberOfFlueSections, numberOfTubeSectionsForMT] "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
    Medium_F.Density bubble_rho_flow_v[numberOfFlueSections, numberOfTubeSectionsForMT] "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
    //**
    //Интерфейс
    //**
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
      deltaHpipe = Lpipe / numberOfTubeSections * numberPMCalcSections "Разность высотных отметок элементов труб для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
      deltaHpipe = Lpipe / numberOfTubeSections * numberPMCalcSections "Разность высотных отметок элементов труб для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
      deltaHpipe = s2 "Разность высотных отметок элементов труб для вертикального КУ";
    else
      deltaHpipe = s2 "Разность высотных отметок элементов труб для вертикального КУ";
    end if;
//*****Уравнения для потока вода/пар и металла
    for i in 1:numberOfFlueSections loop
      hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева";
//Рачет скорости потока в узловых точках
      for j in 1:numberOfTubeSectionsForMT + 1 loop
        rho_flow_n[i, j] = Medium_F.density_ph(p_flow_n[i, j], HTtoMT_n(h_flow_n[i, :], numberPMCalcSections, j)) "Расчет плотности вода/пар в узловых точках";
        w_flow_n[i, j] = D_flow_n[i, j] / rho_flow_n[i, j] / f_flow "Расчет скорости потока вода/пар в узловых точках";
      end for;
//Уравнения для расчета процессов теплообмена
      for j in 1:numberOfTubeSections loop
//Осреднение по конечному объему
        der_h_flow_v[i, j] = der(h_flow_v[i, j]);
        deltaVFlow * rho_flow_v[i, j] * der_h_flow_v[i, j] = 0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - MTtoHT(D_flow_v[i, :], numberPMCalcSections, j) * (h_flow_v[i, j] - h_flow_n[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
        deltaVFlow * rho_flow_v[i, j] * der(h_flow_n[i, j + 1]) = 0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - MTtoHT(D_flow_v[i, :], numberPMCalcSections, j) * (h_flow_n[i, j + 1] - h_flow_v[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
        deltaMMetal * C_m * der(t_m[i, j]) = Q_flow[i, j] - alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
        if hod[i] < 0 then
          heat[i, j].Q_flow = Q_flow[i, j];
          heat[i, j].T = t_m[i, j];
        else
          heat[i, j].Q_flow = Q_flow[i, numberOfTubeSections - j + 1];
          heat[i, j].T = t_m[i, numberOfTubeSections - j + 1];
        end if;
//Уравнения состояния
        stateFlow[i, j] = Medium_F.setState_ph(MTtoHT(p_flow_v[i, :], numberPMCalcSections, j), h_flow_v[i, j]);
        t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
        rho_flow_v[i, j] = Medium_F.density(stateFlow[i, j]);
        drdp_flow[i, j] = max(min(Medium_F.density_derp_h(stateFlow[i, j]), 2.0394e-4), 3.0591e-6);
        drdh_flow[i, j] = max(Medium_F.density_derh_p(stateFlow[i, j]), -0.0191);
//Коэффициент теплоотдачи
        k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
        Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
        mu_flow[i, j] = if Medium_F.dynamicViscosity(stateFlow[i, j]) < 1.503e-004 then 1.503e-004 else Medium_F.dynamicViscosity(stateFlow[i, j]);
        w_flow_v[i, j] = MTtoHT(D_flow_v[i, :], numberPMCalcSections, j) / rho_flow_v[i, j] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow[i, j] = abs(w_flow_v[i, j] * Din * rho_flow_v[i, j] / mu_flow[i, j]);
        alfa_flow[i, j] = max(0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4, 1);
        assert(t_m[i, j] < t_flow[i, j], "Temperatura metalla nije temperaturi potoka", level = AssertionLevel.warning);
//Про две фазы
        stateFlowTwoPhase[i, j] = Medium_F2.setState_ph(MTtoHT(p_flow_v[i, :], numberPMCalcSections, j), h_flow_v[i, j]);
        x_v[i, j] = Medium_F2.vapourQuality(stateFlowTwoPhase[i, j]);
      end for;
//Уравнения для расчета процессов массообмена
      for j in 1:numberOfTubeSectionsForMT loop
        sat_v[i, j] = Medium_F2.setSat_p(p_flow_v[i, j]);
        dew_rho_flow_v[i, j] = Medium_F2.dewDensity(sat_v[i, j]);
        bubble_rho_flow_v[i, j] = Medium_F2.bubbleDensity(sat_v[i, j]);
//Осреднение по конечному объему
        p_flow_v[i, j] = (p_flow_n[i, j + 1] + p_flow_n[i, j]) / 2;
        D_flow_v[i, j] = (D_flow_n[i, j + 1] + D_flow_n[i, j]) / 2;
//Основное уравнение гидравлики
        wrhop[i, j] = HTtoMT(w_flow_v[i, :], numberPMCalcSections, j) * HTtoMT(rho_flow_v[i, :], numberPMCalcSections, j) * p_flow_v[i, j] * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
        Xi_flow[i, j] = lambda_tr(Din, ke, HTtoMT(Re_flow[i, :], numberPMCalcSections, j)) * Lpipe / Din / numberOfTubeSections * numberPMCalcSections;
        phi[i, j] = phi_heatedPipe(wrhop[i, j], p_flow_v[i, j] / 100000, HTtoMT(x_v[i, :], numberPMCalcSections, j)) "Расчет коэффициента phi";
        dp_fric[i, j] = sum(w_flow_v[i, k] ^ 2 * Xi_flow[i, j] * max(bubble_rho_flow_v[i, j], rho_flow_v[i, k]) / 2 / Modelica.Constants.g_n * (1 + x_v[i, k] * phi[i, j] * (bubble_rho_flow_v[i, j] / dew_rho_flow_v[i, j] - 1)) for k in 1 + (j - 1) * numberPMCalcSections:j * numberPMCalcSections) "Потеря давления от трения";
        if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
          H_flow[i, j + 1] = H_flow[i, j] - hod[i] * deltaHpipe "Расчет высотных отметок для горизонтального КУ";
        elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
          H_flow[i, j + 1] = H_flow[i, j] + hod[i] * deltaHpipe "Расчет высотных отметок для горизонтального КУ";
        elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
          H_flow[i, j + 1] = H_flow[1, j] + (i - 1) * deltaHpipe "Расчет высотных отметок для вертикального КУ";
        else
          H_flow[i, j + 1] = H_flow[1, j] - (i - 1) * deltaHpipe "Расчет высотных отметок для вертикального КУ";
        end if;
        dp_piez[i, j] = (rho_flow_n[i, j + 1] * H_flow[i, j + 1] - rho_flow_n[i, j] * H_flow[i, j]) * Modelica.Constants.g_n "Расчет перепада давления из-за изменения пьезометрической высоты";
//p_flow_n[i, j] - p_flow_n[i, j + 1] = dp_fric[i, j] + dp_kin[i, j] + dp_piez[i, j] "Формула 2-1 из книги Рудомино, Ремжин";
        p_flow_n[i, j] - p_flow_n[i, j + 1] = max(dp_fric[i, j] + dp_piez[i, j], 0) "Формула 2-1 из книги Рудомино, Ремжин";
        D_flow_n[i, j] - D_flow_n[i, j + 1] = C1[i, j] + C2[i, j] "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
        C1[i, j] = 0;
        C2[i, j] = 0;
//C1[i, j] = sum(deltaVFlow * drdh_flow[i, k] * der_h_flow_v[i, k] for k in 1 + (j - 1) * numberPMCalcSections:j * numberPMCalcSections);
//Возможно не верно указан объем (объем для расчета теплообмена а надо для массообмена)
//C2[i, j] = sum(deltaVFlow * drdp_flow[i, k] for k in 1 + (j - 1) * numberPMCalcSections:j * numberPMCalcSections) * der(p_flow_v[i, j]);
      end for;
    end for;
//lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
//Xi_flow = lambda_tr * Lpipe / Din / numberOfTubeSections;
    for i in 1:numberOfFlueSections - zahod loop
//Описание гибов
      D_flow_n[i, numberOfTubeSectionsForMT + 1] = D_flow_n[i + zahod, 1];
      p_flow_n[i, numberOfTubeSectionsForMT + 1] = p_flow_n[i + zahod, 1];
      h_flow_n[i, numberOfTubeSections + 1] = h_flow_n[i + zahod, 1];
      if HRSG_type == Choices.HRSG_type.horizontalBottom or HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        H_flow[i, numberOfTubeSectionsForMT + 1] = H_flow[i + zahod, 1];
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        H_flow[i, numberOfTubeSectionsForMT + 1] + 2 * s2 = H_flow[i + zahod, 1];
      else
        H_flow[i, numberOfTubeSectionsForMT + 1] - 2 * s2 = H_flow[i + zahod, 1];
      end if;
//Для горизонтальных КУ
    end for;
//Граничные условия
//Граничные условия для высотной отметки входного коллектора
    for i in 1:zahod loop
      if HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        H_flow[i, 1] = 0 + (i - 1) * s2 "Задание высотной отметки входного коллектора";
      elseif HRSG_type == Choices.HRSG_type.horizontalBottom then
        H_flow[i, 1] = 0 "Задание высотной отметки входного коллектора";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        H_flow[i, 1] = Lpipe "Задание высотной отметки входного коллектора";
      else
        H_flow[i, 1] = s2 * (z2 - 1) - (i - 1) * s2 "Задание высотной отметки входного коллектора";
      end if;
    end for;
    for i in 2:zahod loop
      D_flow_n[i - 1, 1] = D_flow_n[i, 1];
    end for;
    positiveMax(waterIn.m_flow) = sum(D_flow_n[i, 1] for i in 1:zahod);
    waterOut.m_flow = -sum(D_flow_n[i, j] for i in numberFirstTubeInLastZahod:numberOfFlueSections, j in numberOfTubeNodes:numberOfTubeNodes);
    if waterIn.m_flow >= 0 then
      for i in numberOfFlueSections - zahod + 1:numberOfFlueSections loop
        waterOut.p = p_flow_n[i, numberOfTubeSectionsForMT + 1];
      end for;
      waterIn.p = sum(p_flow_n[i, 1] for i in 1:zahod) / zahod;
    else
      for i in 1:zahod loop
        waterIn.p = p_flow_n[i, 1];
      end for;
      waterOut.p = sum(p_flow_n[i, j] for i in numberFirstTubeInLastZahod:numberOfFlueSections, j in numberOfTubeNodes:numberOfTubeNodes) / zahod;
    end if;
    if waterIn.m_flow >= 0 then
      for i in 1:zahod loop
        h_flow_n[i, 1] = inStream(waterIn.h_outflow);
      end for;
    else
      for i in numberOfFlueSections - zahod + 1:numberOfFlueSections loop
        h_flow_n[i, numberOfTubeSections + 1] = inStream(waterOut.h_outflow);
      end for;
    end if;
    waterOut.h_outflow = sum(array(positiveMax(D_flow_n[i, numberOfTubeSectionsForMT + 1]) * h_flow_n[i, numberOfTubeSections + 1] for i in numberFirstTubeInLastZahod:numberOfFlueSections)) / sum(array(positiveMax(D_flow_n[i, numberOfTubeSectionsForMT + 1]) for i in numberFirstTubeInLastZahod:numberOfFlueSections));
    waterIn.h_outflow = sum(array(positiveMax(D_flow_n[i, 1]) * h_flow_n[i, 1] for i in 1:zahod)) / sum(array(positiveMax(D_flow_n[i, 1]) for i in 1:zahod));
    annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
  end onlyFlowHEBoil_2;

  model Separator2
    //Вспомогательные функции
    extends Separator_Icon;
    //***Исходные данные
    replaceable package Medium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    parameter Medium.AbsolutePressure ps_start = 1.013e5 "Стартовое давление насыщения в сепараторе";
    parameter Medium.MassFlowRate Dsteam_start = m_flow_small "Стартовый расход пара из сепаратора";
    parameter Medium.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
    //**
    //Переменные
    //**
    Medium.SaturationProperties sat "State vector to compute saturation properties для парового объема";
    Medium.MassFlowRate D_fw "Расход питательной воды";
    Medium.MassFlowRate Dsteam(start = Dsteam_start) "Расход пара из сепаратора";
    Medium.AbsolutePressure ps(start = ps_start) "Давление насыщения в сепараторе";
    Medium.SpecificEnthalpy h_dew "Энтальпия пара на линии насыщения при давлении в сепараторе";
    Medium.SpecificEnthalpy h_bubble "Энтальпия воды на линии насыщения при давлении в сепараторе";
    //***Интерфейс
    Modelica.Fluid.Interfaces.FluidPort_a fedWater(redeclare package Medium = Medium) annotation(Placement(visible = true, transformation(origin = {-104, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b steam(redeclare package Medium = Medium) annotation(Placement(visible = true, transformation(origin = {62, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    sat = Medium.setSat_p(ps);
    h_dew = Medium.dewEnthalpy(sat);
    h_bubble = Medium.bubbleEnthalpy(sat);
    Dsteam = if noEvent(inStream(fedWater.h_outflow)) > h_dew then D_fw else max(m_flow_small, D_fw * (inStream(fedWater.h_outflow) - h_bubble) / (h_dew - h_bubble));
//Питательная вода
    fedWater.h_outflow = h_bubble;
    fedWater.p = ps;
    fedWater.m_flow = D_fw;
//Выход насыщенного пара
    ps = steam.p;
    steam.h_outflow = if noEvent(inStream(fedWater.h_outflow)) > h_dew then inStream(fedWater.h_outflow) else h_dew;
    steam.m_flow = -Dsteam;
    annotation(uses(Modelica(version = "3.2.1")));
  end Separator2;

  package Tests
    model testGFHE_1
      package Medium_F = Modelica.Media.Water.WaterIF97_ph;
      parameter Modelica.SIunits.MassFlowRate wflow = 116 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
      parameter Modelica.SIunits.MassFlowRate wsteam = 23.66 "Расход пара на выходе из сепаратора";
      parameter Modelica.SIunits.Pressure patm = 1.013e5 "Начальное давление потока вода/пар за клапаном (турбиной)";
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas = 1276.6 / 3.6 "Номинальный (и начальный) массовый расход газов ";
      parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
      //Констуктивные характеристики поверхностей нагрева
      parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
      //Исходные данные для экономайзера
      parameter Modelica.SIunits.Diameter Dout_eco = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
      parameter Integer zahod_eco = 1 "заходность труб теплообменника";
      parameter Integer z1_eco = 58 "Число труб по ширине газохода";
      parameter Integer z2_eco = 16 "Число труб по ходу газов в теплообменнике";
      //Оребрение труб экономайзера
      parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
      //Исходные данные по разбиению экономайзера
      parameter Integer numberOfTubeSections_eco = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_eco = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_eco = 8e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_eco = 140 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_eco = 190 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия входного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_eco = 190.4 + 273.15 "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
      parameter Modelica.SIunits.Temperature Toutgas_eco = 180.7 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      inner Modelica.Fluid.System system(allowFlowReversal = false) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wflow, T = Tinflow_eco) annotation(Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_eco, nPorts = 1, p = pflow_eco, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {90, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE ECO(redeclare onlyFlowHEBoil_8 flowHE, Din = Dout_eco - 2 * delta_eco, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, Lpipe = Lpipe, Tinflow = Tinflow_eco, Tingas = Tingas_eco, Toutflow = Tinflow_eco, Toutgas = Tingas_eco, delta = delta_eco, delta_fin = delta_fin_eco, hfin = hfin_eco, k_gamma_gas = k_gamma_gas_eco, numberOfFlueSections = numberOfFlueSections_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, pflow_in = pflow_eco, pflow_out = pflow_eco, pgas = pgas, s1 = s1_eco, s2 = s2_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, sfin = sfin_eco, wflow = wflow, wgas = wgas, z1 = z1_eco, z2 = z2_eco, zahod = zahod_eco) annotation(Placement(visible = true, transformation(origin = {-14, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wgas, T = Tingas_eco) annotation(Placement(visible = true, transformation(origin = {70, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(flowSink.ports[1], ECO.flowOut) annotation(Line(points = {{80, 30}, {-10, 30}, {-10, 0}, {-10, 0}}, color = {0, 127, 255}));
      connect(gasSource.ports[1], ECO.gasIn) annotation(Line(points = {{60, -30}, {32, -30}, {32, -12}, {-8, -12}, {-8, -12}}, color = {0, 127, 255}));
      connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -30}, {-40, -30}, {-40, -12}, {-20, -12}}, color = {0, 127, 255}));
      connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-60, 30}, {-18, 30}, {-18, -1}}, color = {0, 127, 255}));
    initial equation
/*for i in 1:numberOfFlueSections_eco loop
        for j in 1:numberOfTubeSections_eco loop
          der(ECO.flowHE.h_flow_n[i, j + 1]) = 0;
          der(ECO.flowHE.h_flow_v[i, j]) = 0;
          der(ECO.flowHE.t_m[i, j]) = 0;
          der(ECO.gasHE.h_gas[i + 1, j]) = 0;
        end for;
      end for;
      der(ECO.flowHE.p_flow_v) = 0;*/
      for i in 1:numberOfFlueSections_eco loop
        for j in 1:numberOfTubeSections_eco loop
          der(ECO.gasHE.h_gas[i + 1, j]) = 0;
        end for;
      end for;
      annotation(uses(Modelica(version = "3.2.1")));
    end testGFHE_1;

    model testGFHE_2
      package Medium_F = Modelica.Media.Water.WaterIF97_ph;
      parameter Modelica.SIunits.MassFlowRate wflow = 0.001 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
      parameter Modelica.SIunits.MassFlowRate wsteam = 23.66 "Расход пара на выходе из сепаратора";
      parameter Modelica.SIunits.Pressure patm = 1.013e5 "Начальное давление потока вода/пар за клапаном (турбиной)";
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas = 100 / 3.6 "Номинальный (и начальный) массовый расход газов ";
      parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
      //Констуктивные характеристики поверхностей нагрева
      parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
      //Исходные данные для экономайзера
      parameter Modelica.SIunits.Diameter Dout_eco = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
      parameter Integer zahod_eco = 1 "заходность труб теплообменника";
      parameter Integer z1_eco = 58 "Число труб по ширине газохода";
      parameter Integer z2_eco = 8 "Число труб по ходу газов в теплообменнике";
      ///Оребрение труб экономайзера
      parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
      //Исходные данные по разбиению экономайзера
      parameter Integer numberOfTubeSections_eco = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_eco = 2 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_eco = 1.013e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_eco = 100 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_eco = 100 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm_eco = 90 + 273.15 "Начальная температура металла поверхностей нагрева";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия выходного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_eco = 90 + 273.15 "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
      parameter Modelica.SIunits.Temperature Toutgas_eco = 90 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      inner Modelica.Fluid.System system(allowFlowReversal = false) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wflow, T = Tinflow_eco) annotation(Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_eco, nPorts = 1, p = pflow_eco, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {90, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      MyHRSG_lite.GF_HE ECO(redeclare onlyFlowHEBoil_5 flowHE, Din = Dout_eco - 2 * delta_eco, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, Lpipe = Lpipe, Tinflow = Tinflow_eco, Tingas = Tingas_eco, Toutflow = Toutflow_eco, Toutgas = Toutgas_eco, delta = delta_eco, delta_fin = delta_fin_eco, hfin = hfin_eco, k_gamma_gas = k_gamma_gas_eco, numberOfFlueSections = numberOfFlueSections_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, pflow_in = pflow_eco, pflow_out = pflow_eco, pgas = pgas, s1 = s1_eco, s2 = s2_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, sfin = sfin_eco, wflow = wflow, wgas = wgas, z1 = z1_eco, z2 = z2_eco, zahod = zahod_eco, setTm = setTm_eco) annotation(Placement(visible = true, transformation(origin = {-14, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wgas, T = Tingas_eco) annotation(Placement(visible = true, transformation(origin = {70, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(flowSink.ports[1], ECO.flowOut) annotation(Line(points = {{80, 30}, {-10, 30}, {-10, 0}, {-10, 0}}, color = {0, 127, 255}));
      connect(gasSource.ports[1], ECO.gasIn) annotation(Line(points = {{60, -30}, {32, -30}, {32, -12}, {-8, -12}, {-8, -12}}, color = {0, 127, 255}));
      connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -30}, {-40, -30}, {-40, -12}, {-20, -12}}, color = {0, 127, 255}));
      connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-60, 30}, {-18, 30}, {-18, -1}}, color = {0, 127, 255}));
    initial equation
      for i in 1:numberOfFlueSections_eco loop
        for j in 1:numberOfTubeSections_eco loop
          der(ECO.flowHE.h_flow_n[i, j + 1]) = 0;
          der(ECO.flowHE.h_flow_v[i, j]) = 0;
          der(ECO.flowHE.t_m[i, j]) = 0;
          der(ECO.gasHE.h_gas[i + 1, j]) = 0;
        end for;
      end for;
//der(ECO.flowHE.p_flow_v) = 0;
      for i in 1:zahod_eco loop
        der(ECO.flowHE.p_flow_v[i]) = 0;
//der(ECO.flowHE.p_flow_v[i + integer(numberOfFlueSections_eco / 2) - integer(zahod_eco / 2), integer(integer(numberOfTubeSections_eco / numberPMCalcSections_eco) / 2) + 1]) = 0;
      end for;
      annotation(uses(Modelica(version = "3.2.1")));
    end testGFHE_2;

    model testGFHE_3
      package Medium_F = Modelica.Media.Water.WaterIF97_ph;
      parameter Modelica.SIunits.MassFlowRate wflow = 116 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
      parameter Modelica.SIunits.MassFlowRate wsteam = 23.66 "Расход пара на выходе из сепаратора";
      parameter Modelica.SIunits.Pressure patm = 1.013e5 "Начальное давление потока вода/пар за клапаном (турбиной)";
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas = 1276.6 / 3.6 "Номинальный (и начальный) массовый расход газов ";
      parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
      //Констуктивные характеристики поверхностей нагрева
      parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
      //Исходные данные для экономайзера
      parameter Modelica.SIunits.Diameter Dout_eco = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
      parameter Integer zahod_eco = 1 "заходность труб теплообменника";
      parameter Integer z1_eco = 58 "Число труб по ширине газохода";
      parameter Integer z2_eco = 16 "Число труб по ходу газов в теплообменнике";
      //Оребрение труб экономайзера
      parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
      //Исходные данные по разбиению экономайзера
      parameter Integer numberOfTubeSections_eco = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections_eco = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //Исходные данные вода/пар для экономайзера
      parameter Modelica.SIunits.Pressure pflow_eco = 8e5 "Начальное давление потока вода/пар перед ECO";
      parameter Modelica.SIunits.Temperature Tinflow_eco = 140 + 273.15 "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow_eco = 190 + 273.15 "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
      parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия входного потока вода/пар";
      //Исходные данные для газовой стороны экономайзера
      parameter Modelica.SIunits.Temperature Tingas_eco = 190.4 + 273.15 "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
      parameter Modelica.SIunits.Temperature Toutgas_eco = 180.7 + 273.15 "Начальная выходная температура газов";
      parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
      inner Modelica.Fluid.System system(allowFlowReversal = false) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wflow, T = Tinflow_eco) annotation(Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_eco, nPorts = 1, p = pflow_eco, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {90, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      MyHRSG_lite.liteModels.GF_HE_lite ECO(Din = Dout_eco - 2 * delta_eco, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, Lpipe = Lpipe, Tinflow = Tinflow_eco, Tingas = Tingas_eco, Toutflow = Tinflow_eco, Toutgas = Tingas_eco, delta = delta_eco, delta_fin = delta_fin_eco, hfin = hfin_eco, k_gamma_gas = k_gamma_gas_eco, numberOfFlueSections = numberOfFlueSections_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, pflow_in = pflow_eco, pflow_out = pflow_eco, pgas = pgas, s1 = s1_eco, s2 = s2_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, sfin = sfin_eco, wflow = wflow, wgas = wgas, z1 = z1_eco, z2 = z2_eco, zahod = zahod_eco) annotation(Placement(visible = true, transformation(origin = {-14, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wgas, T = Tingas_eco) annotation(Placement(visible = true, transformation(origin = {70, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(flowSink.ports[1], ECO.flowOut) annotation(Line(points = {{80, 30}, {-10, 30}, {-10, 0}, {-10, 0}}, color = {0, 127, 255}));
      connect(gasSource.ports[1], ECO.gasIn) annotation(Line(points = {{60, -30}, {32, -30}, {32, -12}, {-8, -12}, {-8, -12}}, color = {0, 127, 255}));
      connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -30}, {-40, -30}, {-40, -12}, {-20, -12}}, color = {0, 127, 255}));
      connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-60, 30}, {-18, 30}, {-18, -1}}, color = {0, 127, 255}));
      annotation(uses(Modelica(version = "3.2.1")));
    end testGFHE_3;
  end Tests;

  model onlyFlowHEBoil_7
    import MyHRSG_lite.phi_heatedPipe;
    import MyHRSG_lite.lambda_tr;
    //**
    //***Исходные данные для газовой стороны
    //**
    parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
    //**
    //***Исходные данные по стороне вода/пар
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    replaceable package Medium_F2 = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
    parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
    parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
    //**
    //***Характеристики металла
    parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
    //**
    //**
    //Конструктивные характеристики
    //**
    //Параметры
    parameter MyHRSG_lite.Choices.HRSG_type HRSG_type = MyHRSG_lite.Choices.HRSG_type.horizontalBottom "Тип КУ";
    parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberPMCalcSections = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberFirstTubeInLastZahod = integer(numberOfFlueSections - zahod + 1) "Номер первой трубы в последнем заходе";
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer zahod = 1 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 2 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
    //Поток вода/пар
    parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 / numberOfTubeSections "Внутренняя площадь одного участка ряда труб";
    parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 / 4 / numberOfTubeSections "Внутренний объем одного участка ряда труб";
    parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 / numberOfTubeSections "Масса металла участка ряда труб";
    parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
    //**
    //Начальные значения
    //**
    //Поток вода/пар
    parameter Medium_F.SpecificEnthalpy h_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(seth_in, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(seth_in, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(setD_flow / zahod, numberOfFlueSections, numberOfTubeSections) "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(setD_flow / zahod, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = fill(setTm, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    Modelica.SIunits.Length deltaHpipe "Разность высот на участке ряда труб";
    //Поток вода/пар
    Medium_F.ThermodynamicState stateFlow[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F2.ThermodynamicState stateFlowTwoPhase[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    Medium_F.AbsolutePressure p_flow_v(start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
    //Real der_p_flow_v[zahod] "Производная давления";
    Medium_F.AbsolutePressure p_flow_n[2](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
    Medium_F.SpecificEnthalpy h_flow_v[numberOfFlueSections, numberOfTubeSections](start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.SpecificEnthalpy h_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
    Real der_h_flow_v[numberOfFlueSections, numberOfTubeSections] "Производняа энтальпии потока вода/пар";
    Medium_F.Density rho_flow_v[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы в конечных объемах";
    Medium_F.Density rho_flow_v_av "Осредненная по заходу плотность потока по участкам трубы в конечных объемах";
    Medium_F.Density rho_flow_n[2] "Плотность потока по участкам трубы в узловых точках";
    Modelica.SIunits.DerDensityByEnthalpy drdh_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow_v[numberOfFlueSections, numberOfTubeSections](start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
    Medium_F.MassFlowRate D_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    Modelica.SIunits.HeatFlowRate Q_flow[numberOfFlueSections, numberOfTubeSections] "тепло переданное стенке трубы";
    Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
    Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Real Re_flow_av "Число Рейнольдса осредненное по заходу";
    Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    Real C1[numberOfFlueSections, numberOfTubeSections] "Показатель в числителе уравнения сплошности";
    Real C2[numberOfFlueSections, numberOfTubeSections] "Показатель в знаменателе уравнения сплошности";
    Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
    Modelica.SIunits.Length H_flow[2] "Высотная отметка каждого узла";
    Modelica.SIunits.Velocity w_flow_v[numberOfFlueSections, numberOfTubeSections] "Скорость потока вода/пар в конечных объемах";
    Modelica.SIunits.Velocity w_flow_v_av "Средняя по заходу скорость потока вода/пар в конечных объемах";
    Real dp_fric "Потеря давления из-за сил трения";
    Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
    Medium_F2.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
    Real wrhop "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
    Real phi "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
    Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
    Real x_v[numberOfFlueSections, numberOfTubeSections] "Степень сухости";
    Real x_v_av "Степень сухости осредненная по заходу";
    Medium_F.Density dew_rho_flow_v "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
    Medium_F.Density bubble_rho_flow_v "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
    //**
    //Интерфейс
    //**
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
      deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
      deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
      deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
    else
      deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
    end if;
//*****Уравнения для потока вода/пар и металла
    rho_flow_n[1] = Medium_F.density_ph(waterIn.p, inStream(waterIn.h_outflow)) "Расчет плотности вода/пар в узловых точках";
    rho_flow_n[2] = Medium_F.density_ph(waterOut.p, waterOut.h_outflow) "Расчет плотности вода/пар в узловых точках";
    for i in 1:numberOfFlueSections loop
      hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева";
//Уравнения для расчета процессов теплообмена
      for j in 1:numberOfTubeSections loop
//Осреднение по конечному объему
        der_h_flow_v[i, j] = der(h_flow_v[i, j]);
        deltaVFlow * rho_flow_v[i, j] * der_h_flow_v[i, j] = 0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - D_flow_v[i, j] * (h_flow_v[i, j] - h_flow_n[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
        deltaVFlow * rho_flow_v[i, j] * der(h_flow_n[i, j + 1]) = 0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - D_flow_v[i, j] * (h_flow_n[i, j + 1] - h_flow_v[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
        deltaMMetal * C_m * der(t_m[i, j]) = Q_flow[i, j] - alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
        if hod[i] < 0 then
          heat[i, j].Q_flow = Q_flow[i, j];
          heat[i, j].T = t_m[i, j];
        else
          heat[i, j].Q_flow = Q_flow[i, numberOfTubeSections - j + 1];
          heat[i, j].T = t_m[i, numberOfTubeSections - j + 1];
        end if;
//Уравнения состояния
        stateFlow[i, j] = Medium_F.setState_ph(p_flow_v, h_flow_v[i, j]);
        t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
        rho_flow_v[i, j] = Medium_F.density(stateFlow[i, j]);
        drdp_flow[i, j] = max(min(Medium_F.density_derp_h(stateFlow[i, j]), 2.0394e-4), 3.0591e-6);
        drdh_flow[i, j] = max(Medium_F.density_derh_p(stateFlow[i, j]), -0.0191);
//Коэффициент теплоотдачи
        k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
        Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
        mu_flow[i, j] = if Medium_F.dynamicViscosity(stateFlow[i, j]) < 1.503e-004 then 1.503e-004 else Medium_F.dynamicViscosity(stateFlow[i, j]);
        w_flow_v[i, j] = D_flow_v[i, j] / rho_flow_v[i, j] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow[i, j] = abs(w_flow_v[i, j] * Din * rho_flow_v[i, j] / mu_flow[i, j]);
        alfa_flow[i, j] = if D_flow_v[i, j] > 0.001 then 0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4 else 0;
//Про две фазы
        stateFlowTwoPhase[i, j] = Medium_F2.setState_ph(p_flow_v, h_flow_v[i, j]);
        x_v[i, j] = Medium_F2.vapourQuality(stateFlowTwoPhase[i, j]);
        D_flow_v[i, j] = (D_flow_n[i, j + 1] + D_flow_n[i, j]) / 2;
//D_flow_n[i, j + 1] = homotopy(D_flow_n[i, j] - C1[i, j] - C2[i, j], max(waterIn.m_flow, m_flow_small) / zahod) "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
        D_flow_n[i, j + 1] = max(D_flow_n[i, j] - C1[i, j] - C2[i, j], m_flow_small) "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
        C1[i, j] = deltaVFlow * drdh_flow[i, j] * der_h_flow_v[i, j];
//Возможно не верно указан объем (объем для расчета теплообмена а надо для массообмена)
        C2[i, j] = deltaVFlow * drdp_flow[i, j] * der(p_flow_v);
      end for;
    end for;
//Уравнения для расчета процессов массообмена
    sat_v = Medium_F2.setSat_p(p_flow_v);
    dew_rho_flow_v = Medium_F2.dewDensity(sat_v);
    bubble_rho_flow_v = Medium_F2.bubbleDensity(sat_v);
//Осреднение по конечному объему
    p_flow_v = (p_flow_n[1] + p_flow_n[2]) / 2;
//Основное уравнение гидравлики
    w_flow_v_av = sum(w_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
    rho_flow_v_av = sum(rho_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
    Re_flow_av = sum(Re_flow[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
    x_v_av = sum(x_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
    wrhop = w_flow_v_av * rho_flow_v_av * p_flow_v * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
    Xi_flow = lambda_tr(Din, ke, Re_flow_av) * Lpipe * numberOfFlueSections / zahod / Din;
    phi = phi_heatedPipe(wrhop, p_flow_v / 100000, x_v_av) "Расчет коэффициента phi";
    dp_fric = homotopy(if x_v_av < 1 then w_flow_v_av ^ 2 * Xi_flow * max(bubble_rho_flow_v, rho_flow_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * phi * (bubble_rho_flow_v / dew_rho_flow_v - 1)) else w_flow_v_av ^ 2 * Xi_flow * rho_flow_v_av / 2 / Modelica.Constants.g_n, 100000 * waterIn.m_flow / setD_flow) "Потеря давления от трения";
    p_flow_n[1] - p_flow_n[2] = dp_fric + dp_piez "Формула 2-1 из книги Рудомино, Ремжин";
    if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
      H_flow[2] = H_flow[1] - sum(hod[i] * deltaHpipe for i in 1:numberOfFlueSections / zahod) "Расчет высотных отметок для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
      H_flow[2] = H_flow[1] + sum(hod[i] * deltaHpipe for i in 1:numberOfFlueSections / zahod) "Расчет высотных отметок для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
      H_flow[2] = H_flow[1] + deltaHpipe * (numberOfFlueSections - 1) "Расчет высотных отметок для вертикального КУ";
    else
      H_flow[2] = H_flow[1] - deltaHpipe * (numberOfFlueSections - 1) "Расчет высотных отметок для вертикального КУ";
    end if;
    dp_piez = (rho_flow_n[2] * H_flow[2] - rho_flow_n[1] * H_flow[1]) * Modelica.Constants.g_n "Расчет перепада давления из-за изменения пьезометрической высоты";
    for i in 1:numberOfFlueSections - zahod loop
//Описание гибов
      D_flow_n[i, numberOfTubeSections + 1] = D_flow_n[i + zahod, 1];
      h_flow_n[i, numberOfTubeSections + 1] = h_flow_n[i + zahod, 1];
//Для горизонтальных КУ
    end for;
//Граничные условия
//Граничные условия для высотной отметки входного коллектора
    if HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
      H_flow[1] = 0 "Задание высотной отметки входного коллектора";
    elseif HRSG_type == Choices.HRSG_type.horizontalBottom then
      H_flow[1] = 0 "Задание высотной отметки входного коллектора";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
      H_flow[1] = Lpipe "Задание высотной отметки входного коллектора";
    else
      H_flow[1] = deltaHpipe * (numberOfFlueSections - 1) "Задание высотной отметки входного коллектора";
    end if;
    for i in 1:zahod loop
      max(waterIn.m_flow, m_flow_small) / zahod = D_flow_n[i, 1];
    end for;
    waterOut.m_flow = -sum(D_flow_n[i, numberOfTubeSections + 1] for i in numberFirstTubeInLastZahod:numberOfFlueSections);
    waterOut.p = p_flow_n[2];
    waterIn.p = p_flow_n[1];
    for i in 1:zahod loop
      h_flow_n[i, 1] = inStream(waterIn.h_outflow);
    end for;
    waterOut.h_outflow = sum(array(max(D_flow_n[i, numberOfTubeSections + 1], m_flow_small) * h_flow_n[i, numberOfTubeSections + 1] for i in numberFirstTubeInLastZahod:numberOfFlueSections)) / sum(array(max(D_flow_n[i, numberOfTubeSections + 1], m_flow_small) for i in numberFirstTubeInLastZahod:numberOfFlueSections));
    waterIn.h_outflow = sum(array(max(D_flow_n[i, 1], m_flow_small) * h_flow_n[i, 1] for i in 1:zahod)) / sum(array(max(D_flow_n[i, 1], m_flow_small) for i in 1:zahod));
    annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
  end onlyFlowHEBoil_7;

  model onlyFlowHEBoil_8 "По аналогии с ThermoPower.Water.Flow1DFEM2ph"
    import MyHRSG_lite.phi_heatedPipe;
    import MyHRSG_lite.lambda_tr;
    //**
    //***Исходные данные для газовой стороны
    //**
    parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
    //**
    //***Исходные данные по стороне вода/пар
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    replaceable package Medium_F2 = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
    constant Medium_F.AbsolutePressure pc = Medium_F.fluidConstants[1].criticalPressure;
    constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
    parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
    parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
    parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
    //**
    //***Характеристики металла
    parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
    //**
    //**
    //Конструктивные характеристики
    //**
    //Параметры
    parameter MyHRSG_lite.Choices.HRSG_type HRSG_type = MyHRSG_lite.Choices.HRSG_type.horizontalBottom "Тип КУ";
    parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberPMCalcSections = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberFirstTubeInLastZahod = integer(numberOfFlueSections - zahod + 1) "Номер первой трубы в последнем заходе";
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer zahod = 1 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 2 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
    //Поток вода/пар
    parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 / numberOfTubeSections "Внутренняя площадь одного участка ряда труб";
    parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 / 4 / numberOfTubeSections "Внутренний объем одного участка ряда труб";
    parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 / numberOfTubeSections "Масса металла участка ряда труб";
    parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
    parameter Boolean avoidInletEnthalpyDerivative = true "Avoid inlet enthalpy derivative";
    //**
    //Начальные значения
    //**
    //Поток вода/пар
    parameter Medium_F.SpecificEnthalpy h_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(seth_in, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(seth_in, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(setD_flow / zahod, numberOfFlueSections, numberOfTubeSections) "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(setD_flow / zahod, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = fill(setTm, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    Modelica.SIunits.Length deltaHpipe "Разность высот на участке ряда труб";
    //Поток вода/пар
    Medium_F.ThermodynamicState stateFlow[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.ThermodynamicState stateFlow_n[numberOfFlueSections, numberOfTubeSections + 1] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    //Medium_F2.ThermodynamicState stateFlowTwoPhase[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    Medium_F.AbsolutePressure p_v(start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.AbsolutePressure p_n[2](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
    Medium_F.SpecificEnthalpy h_v[numberOfFlueSections, numberOfTubeSections](start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.SpecificEnthalpy h_n[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
    Real der_h_n[numberOfFlueSections, numberOfTubeSections + 1] "Производняа энтальпии потока вода/пар";
    Medium_F.Density rho_v[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы в конечных объемах";
    Medium_F.Density rho_n[numberOfFlueSections, numberOfTubeSections + 1] "Плотность потока по участкам трубы в конечных объемах";
    Medium_F.Density rho_v_av "Осредненная по заходу плотность потока по участкам трубы в конечных объемах";
    //Medium_F.Density rho_n[2] "Плотность потока по участкам трубы в узловых точках";
    Modelica.SIunits.DerDensityByEnthalpy drdh_v1[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByEnthalpy drdh_v2[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByEnthalpy drdh_n[numberOfFlueSections, numberOfTubeSections + 1] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_v[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_n[numberOfFlueSections, numberOfTubeSections + 1] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow_v[numberOfFlueSections, numberOfTubeSections](start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
    Medium_F.MassFlowRate D_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    Modelica.SIunits.HeatFlowRate Q_flow[numberOfFlueSections, numberOfTubeSections] "тепло переданное стенке трубы";
    Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
    Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Real Re_flow_av "Число Рейнольдса осредненное по заходу";
    Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    Real C1[numberOfFlueSections, numberOfTubeSections] "Показатель в числителе уравнения сплошности";
    Real C2[numberOfFlueSections, numberOfTubeSections] "Показатель в знаменателе уравнения сплошности";
    Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
    Modelica.SIunits.Length H_flow[2] "Высотная отметка каждого узла";
    Modelica.SIunits.Velocity w_flow_v[numberOfFlueSections, numberOfTubeSections] "Скорость потока вода/пар в конечных объемах";
    Modelica.SIunits.Velocity w_flow_v_av "Средняя по заходу скорость потока вода/пар в конечных объемах";
    Real dp_fric "Потеря давления из-за сил трения";
    Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
    Medium_F2.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
    Real wrhop "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
    Real phi "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
    Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
    Real x_v[numberOfFlueSections, numberOfTubeSections] "Степень сухости";
    Real x_v_av "Степень сухости осредненная по заходу";
    Medium_F.Density rhov "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
    Medium_F.Density rhol "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
    //Medium_F.Temperature Ts "Температура на линии насыщения";
    Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
    Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
    Modelica.SIunits.DerDensityByPressure drldp;
    Modelica.SIunits.DerDensityByPressure drvdp;
    Modelica.SIunits.DerDensityByEnthalpy dhldp;
    Modelica.SIunits.DerDensityByEnthalpy dhvdp;
    Real AA;
    Real AA1;
    //**
    //Интерфейс
    //**
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
      deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
      deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
      deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
    else
      deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
    end if;
//*****Уравнения для потока вода/пар и металла
    for i in 1:numberOfFlueSections loop
      hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева";
//Уравнения для расчета процессов теплообмена
      for j in 1:numberOfTubeSections loop
//Осреднение по конечному объему
        deltaVFlow * rho_v[i, j] * der(h_v[i, j]) = 0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - D_flow_v[i, j] * (h_v[i, j] - h_n[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
        deltaVFlow * rho_v[i, j] * der_h_n[i, j + 1] = 0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - D_flow_v[i, j] * (h_n[i, j + 1] - h_v[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
        deltaMMetal * C_m * der(t_m[i, j]) = Q_flow[i, j] - alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
        if hod[i] < 0 then
          heat[i, j].Q_flow = Q_flow[i, j];
          heat[i, j].T = t_m[i, j];
        else
          heat[i, j].Q_flow = Q_flow[i, numberOfTubeSections - j + 1];
          heat[i, j].T = t_m[i, numberOfTubeSections - j + 1];
        end if;
//Уравнения состояния
        stateFlow[i, j] = Medium_F.setState_ph(p_v, h_v[i, j]);
        t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
        k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
        Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
        mu_flow[i, j] = if Medium_F.dynamicViscosity(stateFlow[i, j]) < 1.503e-004 then 1.503e-004 else Medium_F.dynamicViscosity(stateFlow[i, j]);
        w_flow_v[i, j] = D_flow_v[i, j] / rho_v[i, j] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow[i, j] = abs(w_flow_v[i, j] * Din * rho_v[i, j] / mu_flow[i, j]);
        alfa_flow[i, j] = if D_flow_v[i, j] > 0.001 then 0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4 else 0;
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium_F2.setState_ph(p_v, h_v[i, j]);
        x_v[i, j] = if h_v[i, j] < hl then 0 elseif h_v[i, j] > hv then 1 else (h_v[i, j] - hl) / (hv - hl);
        D_flow_v[i, j] = (D_flow_n[i, j + 1] + D_flow_n[i, j]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
        D_flow_n[i, j + 1] = max(D_flow_n[i, j] - C1[i, j] - C2[i, j], m_flow_small) "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
        C1[i, j] = deltaVFlow * (drdh_v1[i, j] * der_h_n[i, j] + drdh_v2[i, j] * der_h_n[i, j + 1]);
        C2[i, j] = deltaVFlow * drdp_v[i, j] * der(p_v);
        if avoidInletEnthalpyDerivative and i == 1 and j == zahod then
// first volume properties computed by the outlet properties
          rho_v[i, j] = rho_n[i, j + 1];
          drdp_v[i, j] = drdp_n[i, j + 1];
          drdh_v1[i, j] = 0;
          drdh_v2[i, j] = drdh_n[i, j + 1];
        elseif noEvent(h_n[i, j] < hl and h_n[i, j + 1] < hl or h_n[i, j] > hv and h_n[i, j + 1] > hv or p_v >= pc - pzero or abs(h_n[i, j + 1] - h_n[i, j]) < hzero) then
// 1-phase or almost uniform properties
          rho_v[i, j] = (rho_n[i, j] + rho_n[i, j + 1]) / 2;
          drdp_v[i, j] = (drdp_n[i, j] + drdp_n[i, j + 1]) / 2;
          drdh_v1[i, j] = drdh_n[i, j] / 2;
          drdh_v2[i, j] = drdh_n[i, j + 1] / 2;
        elseif noEvent(h_n[i, j] >= hl and h_n[i, j] <= hv and h_n[i, j + 1] >= hl and h_n[i, j + 1] <= hv) then
// 2-phase
          rho_v[i, j] = AA * log(rho_n[i, j] / rho_n[i, j + 1]) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = (AA1 * log(rho_n[i, j] / rho_n[i, j + 1]) + AA * (1 / rho_n[i, j] * drdp_n[i, j] - 1 / rho_n[i, j + 1] * drdp_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - rho_n[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v2[i, j] = (rho_n[i, j + 1] - rho_v[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
        elseif noEvent(h_n[i, j] < hl and h_n[i, j + 1] >= hl and h_n[i, j + 1] <= hv) then
// liquid/2-phase
          rho_v[i, j] = ((rho_n[i, j] + rhol) * (hl - h_n[i, j]) / 2 + AA * log(rhol / rho_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = ((drdp_n[i, j] + drldp) * (hl - h_n[i, j]) / 2 + (rho_n[i, j] + rhol) / 2 * dhldp + AA1 * log(rhol / rho_n[i, j + 1]) + AA * (1 / rhol * drldp - 1 / rho_n[i, j + 1] * drdp_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - (rho_n[i, j] + rhol) / 2 + drdh_n[i, j] * (hl - h_n[i, j]) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v2[i, j] = (rho_n[i, j + 1] - rho_v[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
        elseif noEvent(h_n[i, j] >= hl and h_n[i, j] <= hv and h_n[i, j + 1] > hv) then
// 2-phase/vapour
          rho_v[i, j] = (AA * log(rho_n[i, j] / rhov) + (rhov + rho_n[i, j + 1]) * (h_n[i, j + 1] - hv) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = (AA1 * log(rho_n[i, j] / rhov) + AA * (1 / rho_n[i, j] * drdp_n[i, j] - 1 / rhov * drvdp) + (drvdp + drdp_n[i, j + 1]) * (h_n[i, j + 1] - hv) / 2 - (rhov + rho_n[i, j + 1]) / 2 * dhvdp) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - rho_n[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v2[i, j] = ((rhov + rho_n[i, j + 1]) / 2 - rho_v[i, j] + drdh_n[i, j + 1] * (h_n[i, j + 1] - hv) / 2) / (h_n[i, j + 1] - h_n[i, j]);
        elseif noEvent(h_n[i, j] < hl and h_n[i, j + 1] > hv) then
// liquid/2-phase/vapour
          rho_v[i, j] = ((rho_n[i, j] + rhol) * (hl - h_n[i, j]) / 2 + AA * log(rhol / rhov) + (rhov + rho_n[i, j + 1]) * (h_n[i, j + 1] - hv) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = ((drdp_n[i, j] + drldp) * (hl - h_n[i, j]) / 2 + (rho_n[i, j] + rhol) / 2 * dhldp + AA1 * log(rhol / rhov) + AA * (1 / rhol * drldp - 1 / rhov * drvdp) + (drvdp + drdp_n[i, j + 1]) * (h_n[i, j + 1] - hv) / 2 - (rhov + rho_n[i, j + 1]) / 2 * dhvdp) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - (rho_n[i, j] + rhol) / 2 + drdh_n[i, j] * (hl - h_n[i, j]) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v2[i, j] = ((rhov + rho_n[i, j + 1]) / 2 - rho_v[i, j] + drdh_n[i, j + 1] * (h_n[i, j + 1] - hv) / 2) / (h_n[i, j + 1] - h_n[i, j]);
        elseif noEvent(h_n[i, j] >= hl and h_n[i, j] <= hv and h_n[i, j + 1] < hl) then
// 2-phase/liquid
          rho_v[i, j] = (AA * log(rho_n[i, j] / rhol) + (rhol + rho_n[i, j + 1]) * (h_n[i, j + 1] - hl) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = (AA1 * log(rho_n[i, j] / rhol) + AA * (1 / rho_n[i, j] * drdp_n[i, j] - 1 / rhol * drldp) + (drldp + drdp_n[i, j + 1]) * (h_n[i, j + 1] - hl) / 2 - (rhol + rho_n[i, j + 1]) / 2 * dhldp) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - rho_n[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v2[i, j] = ((rhol + rho_n[i, j + 1]) / 2 - rho_v[i, j] + drdh_n[i, j + 1] * (h_n[i, j + 1] - hl) / 2) / (h_n[i, j + 1] - h_n[i, j]);
        elseif noEvent(h_n[i, j] > hv and h_n[i, j + 1] < hl) then
// vapour/2-phase/liquid
          rho_v[i, j] = ((rho_n[i, j] + rhov) * (hv - h_n[i, j]) / 2 + AA * log(rhov / rhol) + (rhol + rho_n[i, j + 1]) * (h_n[i, j + 1] - hl) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = ((drdp_n[i, j] + drvdp) * (hv - h_n[i, j]) / 2 + (rho_n[i, j] + rhov) / 2 * dhvdp + AA1 * log(rhov / rhol) + AA * (1 / rhov * drvdp - 1 / rhol * drldp) + (drldp + drdp_n[i, j + 1]) * (h_n[i, j + 1] - hl) / 2 - (rhol + rho_n[i, j + 1]) / 2 * dhldp) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - (rho_n[i, j] + rhov) / 2 + drdh_n[i, j] * (hv - h_n[i, j]) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v2[i, j] = ((rhol + rho_n[i, j + 1]) / 2 - rho_v[i, j] + drdh_n[i, j + 1] * (h_n[i, j + 1] - hl) / 2) / (h_n[i, j + 1] - h_n[i, j]);
        else
// vapour/2-phase
          rho_v[i, j] = ((rho_n[i, j] + rhov) * (hv - h_n[i, j]) / 2 + AA * log(rhov / rho_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = ((drdp_n[i, j] + drvdp) * (hv - h_n[i, j]) / 2 + (rho_n[i, j] + rhov) / 2 * dhvdp + AA1 * log(rhov / rho_n[i, j + 1]) + AA * (1 / rhov * drvdp - 1 / rho_n[i, j + 1] * drdp_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - (rho_n[i, j] + rhov) / 2 + drdh_n[i, j] * (hv - h_n[i, j]) / 2) / (drdp_n[i, j] - h_n[i, j]);
          drdh_v2[i, j] = (rho_n[i, j + 1] - rho_v[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
        end if;
      end for;
      for j in 1:numberOfTubeSections + 1 loop
        stateFlow_n[i, j] = Medium_F.setState_ph(p_v, h_n[i, j]);
        drdp_n[i, j] = Medium_F.density_derp_h(stateFlow_n[i, j]);
        drdh_n[i, j] = Medium_F.density_derh_p(stateFlow_n[i, j]);
        rho_n[i, j] = Medium_F.density(stateFlow_n[i, j]);
        der_h_n[i, j] = der(h_n[i, j]);
      end for;
    end for;
    sat_v = Medium_F2.setSat_p(p_v);
//Ts = sat_v.Tsat;
    rhol = Medium_F2.bubbleDensity(sat_v);
    rhov = Medium_F2.dewDensity(sat_v);
    hl = Medium_F2.bubbleEnthalpy(sat_v);
    hv = Medium_F2.dewEnthalpy(sat_v);
    drldp = Medium_F2.dBubbleDensity_dPressure(sat_v);
    drvdp = Medium_F2.dDewDensity_dPressure(sat_v);
    dhldp = Medium_F2.dBubbleEnthalpy_dPressure(sat_v);
    dhvdp = Medium_F2.dDewEnthalpy_dPressure(sat_v);
    AA = (hv - hl) / (1 / rhov - 1 / rhol);
    AA1 = ((dhvdp - dhldp) * (rhol - rhov) * rhol * rhov - (hv - hl) * (rhov ^ 2 * drldp - rhol ^ 2 * drvdp)) / (rhol - rhov) ^ 2;
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
    p_v = (p_n[1] + p_n[2]) / 2;
//Основное уравнение гидравлики
    w_flow_v_av = sum(w_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
    rho_v_av = sum(rho_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
    Re_flow_av = sum(Re_flow[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
    x_v_av = sum(x_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
    wrhop = w_flow_v_av * rho_v_av * p_v * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
    Xi_flow = lambda_tr(Din, ke, Re_flow_av) * Lpipe * numberOfFlueSections / zahod / Din;
    phi = phi_heatedPipe(wrhop, p_v / 100000, x_v_av) "Расчет коэффициента phi";
    dp_fric = homotopy(if x_v_av < 1 then w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * phi * (rhol / rhov - 1)) else w_flow_v_av ^ 2 * Xi_flow * rho_v_av / 2 / Modelica.Constants.g_n, 100000 * waterIn.m_flow / setD_flow) "Потеря давления от трения";
    p_n[1] - p_n[2] = dp_fric + dp_piez "Формула 2-1 из книги Рудомино, Ремжин";
    if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
      H_flow[2] = H_flow[1] - sum(hod[i] * deltaHpipe for i in 1:numberOfFlueSections / zahod) "Расчет высотных отметок для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
      H_flow[2] = H_flow[1] + sum(hod[i] * deltaHpipe for i in 1:numberOfFlueSections / zahod) "Расчет высотных отметок для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
      H_flow[2] = H_flow[1] + deltaHpipe * (numberOfFlueSections - 1) "Расчет высотных отметок для вертикального КУ";
    else
      H_flow[2] = H_flow[1] - deltaHpipe * (numberOfFlueSections - 1) "Расчет высотных отметок для вертикального КУ";
    end if;
    dp_piez = (rho_n[numberOfFlueSections, numberOfTubeSections + 1] * H_flow[2] - rho_n[1, 1] * H_flow[1]) * Modelica.Constants.g_n "Расчет перепада давления из-за изменения пьезометрической высоты";
    for i in 1:numberOfFlueSections - zahod loop
//Описание гибов
      D_flow_n[i, numberOfTubeSections + 1] = D_flow_n[i + zahod, 1];
      h_n[i, numberOfTubeSections + 1] = h_n[i + zahod, 1];
//Для горизонтальных КУ
    end for;
//Граничные условия
//Граничные условия для высотной отметки входного коллектора
    if HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
      H_flow[1] = 0 "Задание высотной отметки входного коллектора";
    elseif HRSG_type == Choices.HRSG_type.horizontalBottom then
      H_flow[1] = 0 "Задание высотной отметки входного коллектора";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
      H_flow[1] = Lpipe "Задание высотной отметки входного коллектора";
    else
      H_flow[1] = deltaHpipe * (numberOfFlueSections - 1) "Задание высотной отметки входного коллектора";
    end if;
    for i in 1:zahod loop
      max(waterIn.m_flow, m_flow_small) / zahod = D_flow_n[i, 1];
    end for;
    waterOut.m_flow = -sum(D_flow_n[i, numberOfTubeSections + 1] for i in numberFirstTubeInLastZahod:numberOfFlueSections);
    waterOut.p = p_n[2];
    waterIn.p = p_n[1];
    for i in 1:zahod loop
      h_n[i, 1] = inStream(waterIn.h_outflow);
    end for;
    waterOut.h_outflow = sum(array(max(D_flow_n[i, numberOfTubeSections + 1], m_flow_small) * h_n[i, numberOfTubeSections + 1] for i in numberFirstTubeInLastZahod:numberOfFlueSections)) / sum(array(max(D_flow_n[i, numberOfTubeSections + 1], m_flow_small) for i in numberFirstTubeInLastZahod:numberOfFlueSections));
    waterIn.h_outflow = sum(array(max(D_flow_n[i, 1], m_flow_small) * h_n[i, 1] for i in 1:zahod)) / sum(array(max(D_flow_n[i, 1], m_flow_small) for i in 1:zahod));
  initial equation
    for i in 1:numberOfFlueSections loop
      for j in 1:numberOfTubeSections loop
        der(h_v[i, j]) = 0;
        der(t_m[i, j]) = 0;
        der(h_n[i, j + 1]) = 0;
      end for;
      for j in 1:numberOfTubeSections + 1 loop
      end for;
    end for;
    der(p_v) = 0;
    annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
  end onlyFlowHEBoil_8;

  model onlyFlowHEBoilLite_ECO
    //import MyHRSG_lite.phi_heatedPipe;
    //import MyHRSG_lite.lambda_tr;
    //**
    //***Исходные данные для газовой стороны
    //**
    parameter Modelica.SIunits.Power setQ_gas = 100 "тепловой поток со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
    //**
    //***Исходные данные по стороне вода/пар
    //**
    parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    replaceable package Medium_F2 = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
    constant Medium_F.AbsolutePressure pc = Medium_F.fluidConstants[1].criticalPressure;
    constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
    parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
    parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
    parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
    //**
    //***Характеристики металла
    parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
    //**
    //**
    //Конструктивные характеристики
    //**
    //Параметры
    parameter MyHRSG_lite.Choices.HRSG_type HRSG_type = MyHRSG_lite.Choices.HRSG_type.horizontalBottom "Тип КУ";
    parameter Integer numberOfTubeSections = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberPMCalcSections = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfTubeSectionsForMT = integer(numberOfTubeSections / numberPMCalcSections) "Число участков разбиения трубы для расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberOfTubeNodes = numberOfTubeSectionsForMT + 1 "Число узлов в одной трубе";
    parameter Integer numberFirstTubeInLastZahod = integer(numberOfFlueSections - zahod + 1) "Номер первой трубы в последнем заходе";
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer zahod = 2 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
    //Поток вода/пар
    parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 / numberOfTubeSections "Внутренняя площадь одного участка ряда труб";
    parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 / 4 / numberOfTubeSections "Внутренний объем одного участка ряда труб";
    parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 / numberOfTubeSections "Масса металла участка ряда труб";
    parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 / 4 "Площадь для прохода теплоносителя";
    parameter Modelica.SIunits.Time Tstab "Интервал времени в начале расчета в течение которого все производные равны нулю";
    parameter Boolean avoidInletEnthalpyDerivative = false "Avoid inlet enthalpy derivative";
    //**
    //Начальные значения
    //**
    //Поток вода/пар
    parameter Medium_F.SpecificEnthalpy h_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(seth_in, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(seth_in, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_v = setD_flow / zahod "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_n[2] = fill(setD_flow / zahod, 2) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = fill(setTm, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    //Поток вода/пар
    Medium_F.ThermodynamicState stateFlow[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    //Medium_F2.ThermodynamicState stateFlowTwoPhase[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.ThermodynamicState stateFlow_n[numberOfFlueSections, numberOfTubeSections + 1];
    Medium_F.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    //Medium_F.Temperature ts "Температура насыщения";
    Medium_F.AbsolutePressure p_flow_v(start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.AbsolutePressure p_flow_n[2](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
    Medium_F.SpecificEnthalpy h_flow_v[numberOfFlueSections, numberOfTubeSections](start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.SpecificEnthalpy h_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
    Real der_h_flow_v[numberOfFlueSections, numberOfTubeSections] "Производняа энтальпии потока вода/пар";
    Medium_F.Density rho_flow_v[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы в конечных объемах";
    Medium_F.Density rho_n[numberOfFlueSections, numberOfTubeSections + 1] "Плотность потока по участкам трубы в конечных объемах";
    //Medium_F.Density rho_flow_n[2] "Плотность потока по участкам трубы в узловых точках";
    Modelica.SIunits.DerDensityByEnthalpy drdh_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_flow[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow_v(start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
    Medium_F.MassFlowRate D_flow_n[2](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    Modelica.SIunits.HeatFlowRate Q_flow[numberOfFlueSections, numberOfTubeSections] "тепло переданное стенке трубы";
    Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
    Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    Real C1 "Показатель в числителе уравнения сплошности";
    Real C2 "Показатель в знаменателе уравнения сплошности";
    Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
    Modelica.SIunits.Velocity w_flow_v "Скорость потока вода/пар в конечных объемах";
    //Modelica.SIunits.Velocity w_flow_n[2] "Скорость потока вода/пар в узловых точках";
    Real dp_fric "Потеря давления из-за сил трения";
    //Real wrhop "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
    //Real phi "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
    Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
    Real lambda_tr "Коэффициент трения";
    Real x_v[numberOfFlueSections, numberOfTubeSections] "Степень сухости";
    Medium_F2.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
    Medium_F.Density rhov "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
    Medium_F.Density rhol "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
    Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
    Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
    Real AA;
    //**
    //Интерфейс
    //**
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
//*****Уравнения для потока вода/пар и металла
//rho_flow_n[1] = Medium_F.density_ph(p_flow_n[1], h_flow_n[1, 1]) "Расчет плотности вода/пар в узловых точках";
//rho_flow_n[2] = Medium_F.density_ph(p_flow_n[2], waterOut.h_outflow) "Расчет плотности вода/пар в узловых точках";
//w_flow_n[1] = D_flow_n[1] / rho_flow_n[1] / f_flow "Расчет скорости потока вода/пар в узловых точках";
//w_flow_n[2] = D_flow_n[2] / rho_flow_n[2] / f_flow "Расчет скорости потока вода/пар в узловых точках";
    w_flow_v = D_flow_v / (sum(rho_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) / f_flow;
    for i in 1:numberOfFlueSections loop
      hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева";
//Рачет скорости потока в узловых точках
//Уравнения для расчета процессов теплообмена
      for j in 1:numberOfTubeSections loop
//Осреднение по конечному объему
        der_h_flow_v[i, j] = der(h_flow_v[i, j]);
        deltaVFlow * rho_flow_v[i, j] * der_h_flow_v[i, j] = max(0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]), 0) - D_flow_v * (h_flow_v[i, j] - h_flow_n[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
        deltaVFlow * rho_flow_v[i, j] * der(h_flow_n[i, j + 1]) = max(0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]), 0) - D_flow_v * (h_flow_n[i, j + 1] - h_flow_v[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
        deltaMMetal * C_m * der(t_m[i, j]) = Q_flow[i, j] - max(alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]), 0) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
        if hod[i] < 0 then
          heat[i, j].Q_flow = Q_flow[i, j];
          heat[i, j].T = t_m[i, j];
        else
          heat[i, j].Q_flow = Q_flow[i, numberOfTubeSections - j + 1];
          heat[i, j].T = t_m[i, numberOfTubeSections - j + 1];
        end if;
//Уравнения состояния
        stateFlow[i, j] = Medium_F2.setState_ph(p_flow_v, h_flow_v[i, j]);
        t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
//rho_flow_v[i, j] = Medium_F.density(stateFlow[i, j]);
        drdp_flow[i, j] = Medium_F.density_derp_h(stateFlow[i, j]);
        drdh_flow[i, j] = Medium_F.density_derh_p(stateFlow[i, j]);
//Коэффициент теплоотдачи
        k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
        Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
        mu_flow[i, j] = if Medium_F.dynamicViscosity(stateFlow[i, j]) < 1.503e-004 then 1.503e-004 else Medium_F.dynamicViscosity(stateFlow[i, j]);
//w_flow_v[i, j] = D_flow_v / rho_flow_v[i, j] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow[i, j] = abs(w_flow_v * Din * rho_flow_v[i, j] / mu_flow[i, j]);
//alfa_flow[i, j] = max(0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4, 1);
        alfa_flow[i, j] = 1600;
//assert(t_m[i, j] < t_flow[i, j], "Temperatura metalla nije temperaturi potoka (SH)", level = AssertionLevel.warning);
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium_F2.setState_ph(p_flow_v, h_flow_v[i, j]);
        x_v[i, j] = if h_flow_v[i, j] < hl then 0 elseif h_flow_v[i, j] > hv then 1 else (h_flow_v[i, j] - hl) / (hv - hl);
        if avoidInletEnthalpyDerivative and i == 1 and j == zahod then
// first volume properties computed by the outlet properties
          rho_flow_v[i, j] = rho_n[i, j + 1];
        elseif noEvent(h_flow_n[i, j] < hl and h_flow_n[i, j + 1] < hl or h_flow_n[i, j] > hv and h_flow_n[i, j + 1] > hv or p_flow_v >= pc - pzero or abs(h_flow_n[i, j + 1] - h_flow_n[i, j]) < hzero) then
// 1-phase or almost uniform properties
          rho_flow_v[i, j] = (rho_n[i, j] + rho_n[i, j + 1]) / 2;
        elseif noEvent(h_flow_n[i, j] >= hl and h_flow_n[i, j] <= hv and h_flow_n[i, j + 1] >= hl and h_flow_n[i, j + 1] <= hv) then
// 2-phase
          rho_flow_v[i, j] = AA * log(rho_n[i, j] / rho_n[i, j + 1]) / (h_flow_n[i, j + 1] - h_flow_n[i, j]);
        elseif noEvent(h_flow_n[i, j] < hl and h_flow_n[i, j + 1] >= hl and h_flow_n[i, j + 1] <= hv) then
// liquid/2-phase
          rho_flow_v[i, j] = ((rho_n[i, j] + rhol) * (hl - h_flow_n[i, j]) / 2 + AA * log(rhol / rho_n[i, j + 1])) / (h_flow_n[i, j + 1] - h_flow_n[i, j]);
        elseif noEvent(h_flow_n[i, j] >= hl and h_flow_n[i, j] <= hv and h_flow_n[i, j + 1] > hv) then
// 2-phase/vapour
          rho_flow_v[i, j] = (AA * log(rho_n[i, j] / rhov) + (rhov + rho_n[i, j + 1]) * (h_flow_n[i, j + 1] - hv) / 2) / (h_flow_n[i, j + 1] - h_flow_n[i, j]);
        elseif noEvent(h_flow_n[i, j] < hl and h_flow_n[i, j + 1] > hv) then
// liquid/2-phase/vapour
          rho_flow_v[i, j] = ((rho_n[i, j] + rhol) * (hl - h_flow_n[i, j]) / 2 + AA * log(rhol / rhov) + (rhov + rho_n[i, j + 1]) * (h_flow_n[i, j + 1] - hv) / 2) / (h_flow_n[i, j + 1] - h_flow_n[i, j]);
        elseif noEvent(h_flow_n[i, j] >= hl and h_flow_n[i, j] <= hv and h_flow_n[i, j + 1] < hl) then
// 2-phase/liquid
          rho_flow_v[i, j] = (AA * log(rho_n[i, j] / rhol) + (rhol + rho_n[i, j + 1]) * (h_flow_n[i, j + 1] - hl) / 2) / (h_flow_n[i, j + 1] - h_flow_n[i, j]);
        elseif noEvent(h_flow_n[i, j] > hv and h_flow_n[i, j + 1] < hl) then
// vapour/2-phase/liquid
          rho_flow_v[i, j] = ((rho_n[i, j] + rhov) * (hv - h_flow_n[i, j]) / 2 + AA * log(rhov / rhol) + (rhol + rho_n[i, j + 1]) * (h_flow_n[i, j + 1] - hl) / 2) / (h_flow_n[i, j + 1] - h_flow_n[i, j]);
        else
// vapour/2-phase
          rho_flow_v[i, j] = ((rho_n[i, j] + rhov) * (hv - h_flow_n[i, j]) / 2 + AA * log(rhov / rho_n[i, j + 1])) / (h_flow_n[i, j + 1] - h_flow_n[i, j]);
        end if;
      end for;
      for j in 1:numberOfTubeSections + 1 loop
        stateFlow_n[i, j] = Medium_F.setState_ph(p_flow_v, h_flow_n[i, j]);
        rho_n[i, j] = Medium_F.density(stateFlow_n[i, j]);
      end for;
    end for;
    sat_v = Medium_F2.setSat_p(p_flow_v);
    rhol = Medium_F2.bubbleDensity(sat_v);
    rhov = Medium_F2.dewDensity(sat_v);
    hl = Medium_F2.bubbleEnthalpy(sat_v);
    hv = Medium_F2.dewEnthalpy(sat_v);
    AA = (hv - hl) / (1 / rhov - 1 / rhol);
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
    p_flow_v = (p_flow_n[1] + p_flow_n[2]) / 2;
    D_flow_v = (D_flow_n[1] + D_flow_n[2]) / 2;
//Основное уравнение гидравлики
//wrhop = sum(w_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections * (sum(rho_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) * p_flow_v * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
//Xi_flow = lambda_tr(Din, ke, sum(Re_flow[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) * Lpipe * z2 / Din;
//phi = phi_heatedPipe(wrhop, p_flow_v / 100000, sum(x_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) "Расчет коэффициента phi";
//dp_fric = (sum(w_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) ^ 2 * Xi_flow * (sum(rho_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) / 2 / Modelica.Constants.g_n "Потеря давления от трения";
    lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
    Xi_flow = lambda_tr * Lpipe * z2 / Din;
    dp_fric = w_flow_v ^ 2 * Xi_flow * (sum(rho_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) / 2 / Modelica.Constants.g_n;
//p_flow_n[1] - p_flow_n[2] = dp_fric;
    p_flow_n[1] - p_flow_n[2] = 0;
    D_flow_n[1] - D_flow_n[2] = C1 + C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
    C1 = 0;
    C2 = 0;
//C1 = numberPMCalcSections * deltaVFlow * (sum(drdh_flow[i, j] * der_h_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections);
//C2 = numberPMCalcSections * deltaVFlow * numberOfTubeSections * numberOfFlueSections * (sum(drdp_flow[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections) * der(p_flow_v);
    for i in 1:numberOfFlueSections - zahod loop
//Описание гибов
      h_flow_n[i, numberOfTubeSections + 1] = h_flow_n[i + zahod, 1];
    end for;
//Граничные условия
    max(waterIn.m_flow, m_flow_small) = D_flow_n[1] * zahod;
    waterOut.m_flow = -D_flow_n[2] * zahod;
    waterIn.p = p_flow_n[1];
    waterOut.p = p_flow_n[2];
    for i in 1:zahod loop
      h_flow_n[i, 1] = inStream(waterIn.h_outflow);
    end for;
    waterOut.h_outflow = sum(array(max(D_flow_n[2], m_flow_small) * h_flow_n[i, numberOfTubeSections + 1] for i in numberFirstTubeInLastZahod:numberOfFlueSections)) / sum(array(max(D_flow_n[2], m_flow_small) for i in numberFirstTubeInLastZahod:numberOfFlueSections));
    waterIn.h_outflow = sum(array(max(D_flow_n[1], m_flow_small) * h_flow_n[i, 1] for i in 1:zahod)) / sum(array(max(D_flow_n[1], m_flow_small) for i in 1:zahod));
    annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
  end onlyFlowHEBoilLite_ECO;

  model onlyFlowHEBoil_9
    import MyHRSG_lite.phi_heatedPipe;
    import MyHRSG_lite.lambda_tr;
    //**
    //***Исходные данные для газовой стороны
    //**
    parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
    //**
    //***Исходные данные по стороне вода/пар
    //**
    replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
    replaceable package Medium_F2 = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
    constant Medium_F.AbsolutePressure pc = Medium_F.fluidConstants[1].criticalPressure;
    constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
    parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
    parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
    parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
    parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
    //**
    //***Характеристики металла
    parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
    parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
    //**
    //**
    //Конструктивные характеристики
    //**
    //Параметры
    parameter MyHRSG_lite.Choices.HRSG_type HRSG_type = MyHRSG_lite.Choices.HRSG_type.horizontalBottom "Тип КУ";
    parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberPMCalcSections = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer numberFirstTubeInLastZahod = integer(numberOfFlueSections - zahod + 1) "Номер первой трубы в последнем заходе";
    parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer zahod = 1 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Integer z2 = 2 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
    parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
    //Поток вода/пар
    parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 / numberOfTubeSections "Внутренняя площадь одного участка ряда труб";
    parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 / 4 / numberOfTubeSections "Внутренний объем одного участка ряда труб";
    parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 / 4 / numberOfTubeSections "Масса металла участка ряда труб";
    parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 * zahod / 4 "Площадь для прохода теплоносителя";
    parameter Boolean avoidInletEnthalpyDerivative = true "Avoid inlet enthalpy derivative";
    //**
    //Начальные значения
    //**
    //Поток вода/пар
    parameter Medium_F.SpecificEnthalpy h_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(seth_in, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.SpecificEnthalpy h_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(seth_in, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.AbsolutePressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_v[numberOfFlueSections, numberOfTubeSections] = fill(setD_flow / zahod, numberOfFlueSections, numberOfTubeSections) "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
    parameter Medium_F.MassFlowRate D_startFlow_n[numberOfFlueSections, numberOfTubeSections + 1] = fill(setD_flow / zahod, numberOfFlueSections, numberOfTubeSections + 1) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
    //Металл
    parameter Modelica.SIunits.Temperature t_startM[numberOfFlueSections, numberOfTubeSections] = fill(setTm, numberOfFlueSections, numberOfTubeSections) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
    //**
    //Переменные
    //**
    Modelica.SIunits.Length deltaHpipe "Разность высот на участке ряда труб";
    //Поток вода/пар
    Medium_F.ThermodynamicState stateFlow[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.ThermodynamicState stateFlow_n[numberOfFlueSections, numberOfTubeSections + 1] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    //Medium_F2.ThermodynamicState stateFlowTwoPhase[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
    Medium_F.Temperature t_flow[numberOfFlueSections, numberOfTubeSections] "Температура потока вода/пар по участкам трубы";
    Medium_F.AbsolutePressure p_v(start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.AbsolutePressure p_n[2](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
    //Medium_F.AbsolutePressure p_n_lin[numberOfFlueSections, numberOfTubeSections + 1];
    //Medium_F.AbsolutePressure p_v_lin[numberOfFlueSections, numberOfTubeSections];
    Medium_F.SpecificEnthalpy h_v[numberOfFlueSections, numberOfTubeSections](start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
    Medium_F.SpecificEnthalpy h_n[numberOfFlueSections, numberOfTubeSections + 1](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
    Real der_h_n[numberOfFlueSections, numberOfTubeSections + 1] "Производняа энтальпии потока вода/пар";
    Medium_F.Density rho_v[numberOfFlueSections, numberOfTubeSections] "Плотность потока по участкам трубы в конечных объемах";
    Medium_F.Density rho_n[numberOfFlueSections, numberOfTubeSections + 1] "Плотность потока по участкам трубы в конечных объемах";
    Medium_F.Density rho_v_av "Осредненная по заходу плотность потока по участкам трубы в конечных объемах";
    //Medium_F.Density rho_n[2] "Плотность потока по участкам трубы в узловых точках";
    Modelica.SIunits.DerDensityByEnthalpy drdh_v1[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByEnthalpy drdh_v2[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByEnthalpy drdh_n[numberOfFlueSections, numberOfTubeSections + 1] "Производная плотности потока по энтальпии на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_v[numberOfFlueSections, numberOfTubeSections] "Производная плотности потока по давлению на участках ряда труб";
    Modelica.SIunits.DerDensityByPressure drdp_n[numberOfFlueSections, numberOfTubeSections + 1] "Производная плотности потока по давлению на участках ряда труб";
    Medium_F.MassFlowRate D_flow_v[numberOfFlueSections, numberOfTubeSections](start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
    Medium_F.MassFlowRate D_flow_n[numberOfFlueSections, numberOfTubeSections + 1](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
    Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопередачи со стороны потока вода/пар";
    Medium_F.ThermalConductivity k_flow[numberOfFlueSections, numberOfTubeSections] "Коэффициент теплопроводности для потока вода/пар";
    Medium_F.DynamicViscosity mu_flow[numberOfFlueSections, numberOfTubeSections] "Динамическая вязкость для потока вода/пар";
    Modelica.SIunits.HeatFlowRate Q_flow[numberOfFlueSections, numberOfTubeSections] "тепло переданное стенке трубы";
    Real Pr_flow[numberOfFlueSections, numberOfTubeSections] "Число Прандтля для потока вода/пар";
    Real Re_flow[numberOfFlueSections, numberOfTubeSections] "Число Рейнольдса";
    Real Re_flow_av "Число Рейнольдса осредненное по заходу";
    Modelica.SIunits.Temperature t_m[numberOfFlueSections, numberOfTubeSections](start = t_startM) "Температура металла на участках трубопровода";
    Real C1[numberOfFlueSections, numberOfTubeSections] "Показатель в числителе уравнения сплошности";
    Real C2[numberOfFlueSections, numberOfTubeSections] "Показатель в знаменателе уравнения сплошности";
    Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
    Modelica.SIunits.Length H_flow[2] "Высотная отметка каждого узла";
    Modelica.SIunits.Velocity w_flow_v[numberOfFlueSections, numberOfTubeSections] "Скорость потока вода/пар в конечных объемах";
    Modelica.SIunits.Velocity w_flow_v_av "Средняя по заходу скорость потока вода/пар в конечных объемах";
    Real dp_fric "Потеря давления из-за сил трения";
    Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
    Medium_F2.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
    //Real wrhop "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
    //Real phi "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
    Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
    Real lambda_tr "Коэффициент трения";
    Real x_v[numberOfFlueSections, numberOfTubeSections] "Степень сухости";
    Real x_v_av "Степень сухости осредненная по заходу";
    Medium_F.Density rhov "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
    Medium_F.Density rhol "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
    //Medium_F.Temperature Ts "Температура на линии насыщения";
    Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
    Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
    Modelica.SIunits.DerDensityByPressure drldp;
    Modelica.SIunits.DerDensityByPressure drvdp;
    Modelica.SIunits.DerDensityByEnthalpy dhldp;
    Modelica.SIunits.DerDensityByEnthalpy dhvdp;
    Real AA;
    Real AA1;
    Real timeZ;
    Real derpZ;
    //**
    //Интерфейс
    //**
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfFlueSections, numberOfTubeSections] annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
//p_v_lin = razbivka_v(p_n[1], p_n[2], zahod, numberOfFlueSections, numberOfTubeSections);
//p_n_lin = razbivka_n(p_n[1], p_n[2], zahod, numberOfFlueSections, numberOfTubeSections + 1);
    if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
      deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
      deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
      deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
    else
      deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
    end if;
//*****Уравнения для потока вода/пар и металла
    for i in 1:numberOfFlueSections loop
      hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева";
//Уравнения для расчета процессов теплообмена
      for j in 1:numberOfTubeSections loop
//Осреднение по конечному объему
        deltaVFlow * rho_v[i, j] * der(h_v[i, j]) = 0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - D_flow_v[i, j] * (h_v[i, j] - h_n[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
        deltaVFlow * rho_v[i, j] * der_h_n[i, j + 1] = 0.5 * alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) - D_flow_v[i, j] * (h_n[i, j + 1] - h_v[i, j]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
        deltaMMetal * C_m * der(t_m[i, j]) = Q_flow[i, j] - alfa_flow[i, j] * deltaSFlow * (t_m[i, j] - t_flow[i, j]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
        if hod[i] < 0 then
          heat[i, j].Q_flow = Q_flow[i, j];
          heat[i, j].T = t_m[i, j];
        else
          heat[i, j].Q_flow = Q_flow[i, numberOfTubeSections - j + 1];
          heat[i, j].T = t_m[i, numberOfTubeSections - j + 1];
        end if;
//Уравнения состояния
        stateFlow[i, j] = Medium_F.setState_ph(p_v, h_v[i, j]);
        t_flow[i, j] = Medium_F.temperature(stateFlow[i, j]);
        k_flow[i, j] = Medium_F.thermalConductivity(stateFlow[i, j]);
        Pr_flow[i, j] = Medium_F.prandtlNumber(stateFlow[i, j]);
        mu_flow[i, j] = if Medium_F.dynamicViscosity(stateFlow[i, j]) < 1.503e-004 then 1.503e-004 else Medium_F.dynamicViscosity(stateFlow[i, j]);
        w_flow_v[i, j] = D_flow_v[i, j] / rho_v[i, j] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow[i, j] = abs(w_flow_v[i, j] * Din * rho_v[i, j] / mu_flow[i, j]);
//alfa_flow[i, j] = if D_flow_v[i, j] > 0.001 then 0.023 * k_flow[i, j] / Din * Re_flow[i, j] ^ 0.8 * Pr_flow[i, j] ^ 0.4 else 0;
        alfa_flow[i, j] = 1600;
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium_F2.setState_ph(p_v, h_v[i, j]);
        x_v[i, j] = if h_v[i, j] < hl then 0 elseif h_v[i, j] > hv then 1 else (h_v[i, j] - hl) / (hv - hl);
        D_flow_v[i, j] = (D_flow_n[i, j + 1] + D_flow_n[i, j]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
        D_flow_n[i, j + 1] = D_flow_n[i, j] - C1[i, j] - C2[i, j] "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
        C1[i, j] = deltaVFlow * ((-1e-7) * der_h_n[i, j] + (-1e-7) * der_h_n[i, j + 1]);
        C2[i, j] = deltaVFlow * 1e-8 * der(p_v);
//C1[i, j] = 0;
//C2[i, j] = 0;
        if avoidInletEnthalpyDerivative and i == 1 and j == zahod then
// first volume properties computed by the outlet properties
          rho_v[i, j] = rho_n[i, j + 1];
          drdp_v[i, j] = drdp_n[i, j + 1];
          drdh_v1[i, j] = 0;
          drdh_v2[i, j] = drdh_n[i, j + 1];
        elseif noEvent(h_n[i, j] < hl and h_n[i, j + 1] < hl or h_n[i, j] > hv and h_n[i, j + 1] > hv or p_v >= pc - pzero or abs(h_n[i, j + 1] - h_n[i, j]) < hzero) then
// 1-phase or almost uniform properties
          rho_v[i, j] = (rho_n[i, j] + rho_n[i, j + 1]) / 2;
          drdp_v[i, j] = (drdp_n[i, j] + drdp_n[i, j + 1]) / 2;
          drdh_v1[i, j] = drdh_n[i, j] / 2;
          drdh_v2[i, j] = drdh_n[i, j + 1] / 2;
        elseif noEvent(h_n[i, j] >= hl and h_n[i, j] <= hv and h_n[i, j + 1] >= hl and h_n[i, j + 1] <= hv) then
// 2-phase
          rho_v[i, j] = AA * log(rho_n[i, j] / rho_n[i, j + 1]) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = (AA1 * log(rho_n[i, j] / rho_n[i, j + 1]) + AA * (1 / rho_n[i, j] * drdp_n[i, j] - 1 / rho_n[i, j + 1] * drdp_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - rho_n[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v2[i, j] = (rho_n[i, j + 1] - rho_v[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
        elseif noEvent(h_n[i, j] < hl and h_n[i, j + 1] >= hl and h_n[i, j + 1] <= hv) then
// liquid/2-phase
          rho_v[i, j] = ((rho_n[i, j] + rhol) * (hl - h_n[i, j]) / 2 + AA * log(rhol / rho_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = ((drdp_n[i, j] + drldp) * (hl - h_n[i, j]) / 2 + (rho_n[i, j] + rhol) / 2 * dhldp + AA1 * log(rhol / rho_n[i, j + 1]) + AA * (1 / rhol * drldp - 1 / rho_n[i, j + 1] * drdp_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - (rho_n[i, j] + rhol) / 2 + drdh_n[i, j] * (hl - h_n[i, j]) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v2[i, j] = (rho_n[i, j + 1] - rho_v[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
        elseif noEvent(h_n[i, j] >= hl and h_n[i, j] <= hv and h_n[i, j + 1] > hv) then
// 2-phase/vapour
          rho_v[i, j] = (AA * log(rho_n[i, j] / rhov) + (rhov + rho_n[i, j + 1]) * (h_n[i, j + 1] - hv) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = (AA1 * log(rho_n[i, j] / rhov) + AA * (1 / rho_n[i, j] * drdp_n[i, j] - 1 / rhov * drvdp) + (drvdp + drdp_n[i, j + 1]) * (h_n[i, j + 1] - hv) / 2 - (rhov + rho_n[i, j + 1]) / 2 * dhvdp) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - rho_n[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v2[i, j] = ((rhov + rho_n[i, j + 1]) / 2 - rho_v[i, j] + drdh_n[i, j + 1] * (h_n[i, j + 1] - hv) / 2) / (h_n[i, j + 1] - h_n[i, j]);
        elseif noEvent(h_n[i, j] < hl and h_n[i, j + 1] > hv) then
// liquid/2-phase/vapour
          rho_v[i, j] = ((rho_n[i, j] + rhol) * (hl - h_n[i, j]) / 2 + AA * log(rhol / rhov) + (rhov + rho_n[i, j + 1]) * (h_n[i, j + 1] - hv) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = ((drdp_n[i, j] + drldp) * (hl - h_n[i, j]) / 2 + (rho_n[i, j] + rhol) / 2 * dhldp + AA1 * log(rhol / rhov) + AA * (1 / rhol * drldp - 1 / rhov * drvdp) + (drvdp + drdp_n[i, j + 1]) * (h_n[i, j + 1] - hv) / 2 - (rhov + rho_n[i, j + 1]) / 2 * dhvdp) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - (rho_n[i, j] + rhol) / 2 + drdh_n[i, j] * (hl - h_n[i, j]) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v2[i, j] = ((rhov + rho_n[i, j + 1]) / 2 - rho_v[i, j] + drdh_n[i, j + 1] * (h_n[i, j + 1] - hv) / 2) / (h_n[i, j + 1] - h_n[i, j]);
        elseif noEvent(h_n[i, j] >= hl and h_n[i, j] <= hv and h_n[i, j + 1] < hl) then
// 2-phase/liquid
          rho_v[i, j] = (AA * log(rho_n[i, j] / rhol) + (rhol + rho_n[i, j + 1]) * (h_n[i, j + 1] - hl) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = (AA1 * log(rho_n[i, j] / rhol) + AA * (1 / rho_n[i, j] * drdp_n[i, j] - 1 / rhol * drldp) + (drldp + drdp_n[i, j + 1]) * (h_n[i, j + 1] - hl) / 2 - (rhol + rho_n[i, j + 1]) / 2 * dhldp) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - rho_n[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v2[i, j] = ((rhol + rho_n[i, j + 1]) / 2 - rho_v[i, j] + drdh_n[i, j + 1] * (h_n[i, j + 1] - hl) / 2) / (h_n[i, j + 1] - h_n[i, j]);
        elseif noEvent(h_n[i, j] > hv and h_n[i, j + 1] < hl) then
// vapour/2-phase/liquid
          rho_v[i, j] = ((rho_n[i, j] + rhov) * (hv - h_n[i, j]) / 2 + AA * log(rhov / rhol) + (rhol + rho_n[i, j + 1]) * (h_n[i, j + 1] - hl) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = ((drdp_n[i, j] + drvdp) * (hv - h_n[i, j]) / 2 + (rho_n[i, j] + rhov) / 2 * dhvdp + AA1 * log(rhov / rhol) + AA * (1 / rhov * drvdp - 1 / rhol * drldp) + (drldp + drdp_n[i, j + 1]) * (h_n[i, j + 1] - hl) / 2 - (rhol + rho_n[i, j + 1]) / 2 * dhldp) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - (rho_n[i, j] + rhov) / 2 + drdh_n[i, j] * (hv - h_n[i, j]) / 2) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v2[i, j] = ((rhol + rho_n[i, j + 1]) / 2 - rho_v[i, j] + drdh_n[i, j + 1] * (h_n[i, j + 1] - hl) / 2) / (h_n[i, j + 1] - h_n[i, j]);
        else
// vapour/2-phase
          rho_v[i, j] = ((rho_n[i, j] + rhov) * (hv - h_n[i, j]) / 2 + AA * log(rhov / rho_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
          drdp_v[i, j] = ((drdp_n[i, j] + drvdp) * (hv - h_n[i, j]) / 2 + (rho_n[i, j] + rhov) / 2 * dhvdp + AA1 * log(rhov / rho_n[i, j + 1]) + AA * (1 / rhov * drvdp - 1 / rho_n[i, j + 1] * drdp_n[i, j + 1])) / (h_n[i, j + 1] - h_n[i, j]);
          drdh_v1[i, j] = (rho_v[i, j] - (rho_n[i, j] + rhov) / 2 + drdh_n[i, j] * (hv - h_n[i, j]) / 2) / (drdp_n[i, j] - h_n[i, j]);
          drdh_v2[i, j] = (rho_n[i, j + 1] - rho_v[i, j]) / (h_n[i, j + 1] - h_n[i, j]);
        end if;
      end for;
      for j in 1:numberOfTubeSections + 1 loop
        stateFlow_n[i, j] = Medium_F.setState_ph(p_v, h_n[i, j]);
        drdp_n[i, j] = Medium_F.density_derp_h(stateFlow_n[i, j]);
        drdh_n[i, j] = Medium_F.density_derh_p(stateFlow_n[i, j]);
        rho_n[i, j] = Medium_F.density(stateFlow_n[i, j]);
        der_h_n[i, j] = der(h_n[i, j]);
      end for;
    end for;
    sat_v = Medium_F2.setSat_p(p_v);
//Ts = sat_v.Tsat;
    rhol = Medium_F2.bubbleDensity(sat_v);
    rhov = Medium_F2.dewDensity(sat_v);
    hl = Medium_F2.bubbleEnthalpy(sat_v);
    hv = Medium_F2.dewEnthalpy(sat_v);
    drldp = Medium_F2.dBubbleDensity_dPressure(sat_v);
    drvdp = Medium_F2.dDewDensity_dPressure(sat_v);
    dhldp = Medium_F2.dBubbleEnthalpy_dPressure(sat_v);
    dhvdp = Medium_F2.dDewEnthalpy_dPressure(sat_v);
    AA = (hv - hl) / (1 / rhov - 1 / rhol);
    AA1 = ((dhvdp - dhldp) * (rhol - rhov) * rhol * rhov - (hv - hl) * (rhov ^ 2 * drldp - rhol ^ 2 * drvdp)) / (rhol - rhov) ^ 2;
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
    p_v = (p_n[1] + p_n[2]) / 2;
    timeZ = time;
    derpZ = (p_v - pre(p_v)) / max(abs(timeZ - pre(timeZ)), 1e-6);
//Основное уравнение гидравлики
    w_flow_v_av = sum(w_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
    rho_v_av = sum(rho_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
    Re_flow_av = sum(Re_flow[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
    x_v_av = sum(x_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//wrhop = w_flow_v_av * rho_v_av * p_v * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
//Xi_flow = lambda_tr(Din, ke, Re_flow_av) * Lpipe * numberOfFlueSections / zahod / Din;
//phi = phi_heatedPipe(wrhop, p_v / 100000, x_v_av) "Расчет коэффициента phi";
//dp_fric = homotopy(if x_v_av < 1 then w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * phi * (rhol / rhov - 1)) else w_flow_v_av ^ 2 * Xi_flow * rho_v_av / 2 / Modelica.Constants.g_n, 100000 * waterIn.m_flow / setD_flow) "Потеря давления от трения";
    lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
    Xi_flow = lambda_tr * Lpipe * numberOfFlueSections / zahod / Din;
//dp_fric = w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * 1 * (rhol / rhov - 1));
    dp_fric = w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n;
    p_n[1] - p_n[2] = dp_fric + dp_piez "Формула 2-1 из книги Рудомино, Ремжин";
    if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
      H_flow[2] = H_flow[1] - sum(hod[i] * deltaHpipe for i in 1:numberOfFlueSections / zahod) "Расчет высотных отметок для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
      H_flow[2] = H_flow[1] + sum(hod[i] * deltaHpipe for i in 1:numberOfFlueSections / zahod) "Расчет высотных отметок для горизонтального КУ";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
      H_flow[2] = H_flow[1] + deltaHpipe * (numberOfFlueSections - 1) "Расчет высотных отметок для вертикального КУ";
    else
      H_flow[2] = H_flow[1] - deltaHpipe * (numberOfFlueSections - 1) "Расчет высотных отметок для вертикального КУ";
    end if;
    dp_piez = (rho_n[numberOfFlueSections, numberOfTubeSections + 1] * H_flow[2] - rho_n[1, 1] * H_flow[1]) * Modelica.Constants.g_n "Расчет перепада давления из-за изменения пьезометрической высоты";
    for i in 1:numberOfFlueSections - zahod loop
//Описание гибов
      D_flow_n[i, numberOfTubeSections + 1] = D_flow_n[i + zahod, 1];
      h_n[i, numberOfTubeSections + 1] = h_n[i + zahod, 1];
//Для горизонтальных КУ
    end for;
//Граничные условия
//Граничные условия для высотной отметки входного коллектора
    if HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
      H_flow[1] = 0 "Задание высотной отметки входного коллектора";
    elseif HRSG_type == Choices.HRSG_type.horizontalBottom then
      H_flow[1] = 0 "Задание высотной отметки входного коллектора";
    elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
      H_flow[1] = Lpipe "Задание высотной отметки входного коллектора";
    else
      H_flow[1] = deltaHpipe * (numberOfFlueSections - 1) "Задание высотной отметки входного коллектора";
    end if;
    for i in 1:zahod loop
      max(waterIn.m_flow, m_flow_small) / zahod = D_flow_n[i, 1];
    end for;
    waterOut.m_flow = -sum(D_flow_n[i, numberOfTubeSections + 1] for i in numberFirstTubeInLastZahod:numberOfFlueSections);
    waterOut.p = p_n[2];
    waterIn.p = p_n[1];
    for i in 1:zahod loop
      h_n[i, 1] = inStream(waterIn.h_outflow);
    end for;
    waterOut.h_outflow = sum(array(max(D_flow_n[i, numberOfTubeSections + 1], m_flow_small) * h_n[i, numberOfTubeSections + 1] for i in numberFirstTubeInLastZahod:numberOfFlueSections)) / sum(array(max(D_flow_n[i, numberOfTubeSections + 1], m_flow_small) for i in numberFirstTubeInLastZahod:numberOfFlueSections));
    waterIn.h_outflow = sum(array(max(D_flow_n[i, 1], m_flow_small) * h_n[i, 1] for i in 1:zahod)) / sum(array(max(D_flow_n[i, 1], m_flow_small) for i in 1:zahod));
  initial equation
    for i in 1:numberOfFlueSections loop
      for j in 1:numberOfTubeSections loop
        der(h_v[i, j]) = 0;
        der(t_m[i, j]) = 0;
//der(h_n[i, j + 1]) = 0;
      end for;
      for j in 1:numberOfTubeSections + 1 loop
        der(h_n[i, j]) = 0;
      end for;
    end for;
    der(p_v) = 0;
    annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
  end onlyFlowHEBoil_9;

  package liteModels
    model onleGasHE_lite
      function positiveMax
        extends Modelica.Icons.Function;
        input Real x;
        output Real y;
      algorithm
        y := max(x, 1e-10);
      end positiveMax;

      //**
      //***Исходные данные для газовой стороны
      //**
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate setD_gas = 509 "Номинальный (и начальный) массовый расход газов" annotation(Dialog(group = "Параметры стороны газов"));
      parameter Modelica.SIunits.Pressure setp_gas = 3e3 "Начальное давление газов" annotation(Dialog(group = "Параметры стороны газов"));
      parameter Modelica.SIunits.Temperature setT_inGas = 184 + 273.15 "Начальная входная температура газов" annotation(Dialog(group = "Параметры стороны газов"));
      parameter Modelica.SIunits.Temperature setT_outGas = 170 + 273.15 "Начальная выходная температура газов" annotation(Dialog(group = "Параметры стороны газов"));
      parameter Medium_G.MassFraction setX_gas[Medium_G.nXi] = Medium_G.reference_X;
      parameter Real k_alfaGas = 1 "Поправка к коэффициенту теплоотдачи со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
      //**
      //Конструктивные характеристики
      //**
      //Параметры
      parameter Integer numberOfTubeSections = 10 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Diameter Dout = Din + 2 * delta "Наружный диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer zahod = numberOfFlueSections "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z1 = 79 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length Hpipe = Lpipe "Разность высотных отметов выхода и входа теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Real Xi_flow = 0.3 "Коэффициент гидравлического сопротивления участка трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length omega = Modelica.Constants.pi * Dout "Наружный периметр трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      //Поток газов
      parameter Modelica.SIunits.Volume deltaVGas = z2 * Lpipe * (s1 * s2 * z1 - Modelica.Constants.pi * Dout ^ 2 / 4) "Объем одного участка газового тракта";
      parameter Modelica.SIunits.Area deltaSGas = Lpipe * Modelica.Constants.pi * Dout * z1 "Наружная площадь одного участка ряда труб";
      parameter Modelica.SIunits.Area f_gas = (1 - Dout / s1 * (1 + 2 * hfin * delta_fin / sfin / Dout)) * Lpipe * s2 * z1 "Площадь для прохода газов на одном участке разбиения";
      //**
      //Характеристики оребрения
      //
      parameter Modelica.SIunits.Length delta_fin = 0.0009 "Средняя толщина ребра, м" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Modelica.SIunits.Length hfin = 0.014 "Высота ребра, м" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Modelica.SIunits.Length sfin = 0.004 "Шаг ребер, м" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Modelica.SIunits.Length Dfin = Dout + 2 * hfin "Диаметр ребер, м" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real psi_fin = 1 / (2 * Dout * sfin) * (Dfin ^ 2 - Dout ^ 2 + 2 * Dfin * delta_fin) + 1 - delta_fin / sfin "Коэффициент оребрения, равный отношению полной поверхности пучка к поверхности несущих труб на оребренном участке" annotation(Dialog(group = "Характеристики оребрения"));
      //формула 7.22а нормативного метода
      parameter Real sigma1 = s1 / Dout "Относительный поперечный шаг" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real sigma2 = s2 / Dout "Относительный продольный шаг" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real sigma3 = sqrt(0.25 * sigma1 ^ 2 + sigma2) "Средний относительный диагональный шаг труб" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real xfin = sigma1 / sigma2 - 1.26 / psi_fin - 2 "Параметр 'x' для шахматного пучка" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real phi_fin = Modelica.Math.tanh(xfin) "Некий параметр 'фи'" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real n_fin = 0.7 + 0.08 * phi_fin + 0.005 * psi_fin "Показатель степени 'n' в формуле коэффициента теплоотдачи" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real Cs = (1.36 - phi_fin) * (11 / (psi_fin + 8) - 0.14) "Коэффициент, определяемый в зависимости от от относительного поперечного и продольного шага труб в пучке, типа пучка и коэффициента оребрения";
      parameter Real Cz = if z2 < 8 and sigma1 / sigma2 < 2 then 3.15 * z2 ^ 0.05 - 2.5 elseif z2 < 8 and sigma1 / sigma2 >= 2 then 3.5 * z2 ^ 0.03 - 2.72 else 1 "Поправка на число рядов труб по ходу газов";
      parameter Real H_fin = (omega * Lpipe * (1 - delta_fin / sfin) + 2 * Modelica.Constants.pi * (Dfin ^ 2 - Dout ^ 2) / 4 + Modelica.Constants.pi * Dfin * delta_fin * (Lpipe / sfin)) * z1 * z2 "Площадь оребренной поверхности";
      //**
      //Начальные значения
      //**
      //Поток газов
      parameter Medium_G.SpecificEnthalpy h_startGas[2] = {Medium_G.specificEnthalpy_pTX(setp_gas, setT_inGas, setX_gas), Medium_G.specificEnthalpy_pTX(setp_gas, setT_outGas, setX_gas)} "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_G.SpecificEnthalpy h_v_startGas = 0.5 * (Medium_G.specificEnthalpy_pTX(setp_gas, setT_inGas, setX_gas) + Medium_G.specificEnthalpy_pTX(setp_gas, setT_outGas, setX_gas));
      parameter Medium_G.AbsolutePressure p_startGas[2] = fill(setp_gas, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
      //**
      //Переменные
      //**
      //Поток газов
      Medium_G.BaseProperties gas;
      Medium_G.SpecificEnthalpy h_gas[2](start = h_startGas) "Энтальпия потока вода/пар по участкам трубы";
      Medium_G.SpecificEnthalpy h_gas_v(start = h_v_startGas) "Энтальпия потока вода/пар по участкам трубы";
      Medium_G.Temperature t_gas(start = setT_inGas) "Температура потока газов по участкам трубы";
      Medium_G.MassFlowRate deltaDGas[2](start = fill(setD_gas, 2)) "Расход газов через участок газохода";
      Medium_G.DynamicViscosity mu "Динамическая вязкость газов";
      Medium_G.ThermalConductivity k "Коэффициент теплопроводности газов";
      Medium_G.SpecificHeatCapacity cp "Изобарная теплоемкость газов";
      Modelica.SIunits.PerUnit Re "Число Рейнольдса";
      Medium_G.PrandtlNumber Pr "Число Прандтля";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_gas "Коэффициент теплопередачи со стороны потока газов";
      //**
      //Интерфейс
      //**
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat annotation(Placement(visible = false, transformation(origin = {0, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0), iconTransformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(extent = {{80, -20}, {120, 20}}, rotation = 0), iconTransformation(extent = {{100, -20}, {140, 20}}, rotation = 0)));
    equation
//*****Уравнения для потока газов
//deltaVGas * gas.d * der(h_gas[2]) = deltaDGas[1] * (h_gas[1] - h_gas[2]) + heat.Q_flow "Уавнение теплового баланса газов (формула 3-15 диссертации Рубашкина)";
      0.5 * deltaVGas * gas.d * der(h_gas_v) = deltaDGas[1] * (h_gas[1] - h_gas_v) + 0.5 * heat.Q_flow;
      0.5 * deltaVGas * gas.d * der(h_gas[2]) = deltaDGas[1] * (h_gas_v - h_gas[2]) + 0.5 * heat.Q_flow;
      heat.Q_flow = -alfa_gas * H_fin * (t_gas - heat.T);
//Уравнения состояния
      gas.h = h_gas[2];
      gas.p = gasIn.p "Уравнение для давления";
      gas.X = setX_gas;
      gas.T = t_gas;
      deltaDGas[1] = deltaDGas[2];
//Коэффициент теплоотдачи
      mu = Medium_G.dynamicViscosity(gas.state);
      k = Medium_G.thermalConductivity(gas.state);
      cp = Medium_G.heatCapacity_cp(gas.state);
      Re = abs(deltaDGas[1] * Dout / (f_gas * mu));
      Pr = Medium_G.prandtlNumber(gas.state);
      alfa_gas = k_alfaGas * 0.113 * Cs * Cz * k / Dout * Re ^ n_fin * Pr ^ 0.33;
//Граничные условия
      h_gas[1] = inStream(gasIn.h_outflow);
//Граничные условия
      gasIn.h_outflow = h_gas[1];
      gasOut.h_outflow = h_gas[2];
      gasIn.Xi_outflow = inStream(gasOut.Xi_outflow);
      inStream(gasIn.Xi_outflow) = gasOut.Xi_outflow;
      gasIn.m_flow - deltaDGas[1] = 0;
      gasOut.m_flow + deltaDGas[2] = 0;
      gasOut.p = gasIn.p;
    initial equation
      der(h_gas[2]) = 0;
      der(h_gas_v) = 0;
      annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-100, -115}, {100, -145}}, lineColor = {85, 170, 255}, textString = "%name")}));
    end onleGasHE_lite;

    model onlyFlowHE_lite
      //**
      //***Исходные данные для газовой стороны
      //**
      parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      //**
      //***Исходные данные по стороне вода/пар
      //**
      replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
      replaceable package Medium_F2 = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
      constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
      constant Medium_F.AbsolutePressure pc = Medium_F.fluidConstants[1].criticalPressure;
      constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
      parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
      parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
      parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
      //**
      //***Характеристики металла
      parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
      parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
      parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
      //**
      //**
      //Конструктивные характеристики
      //**
      //Параметры
      parameter MyHRSG_lite.Choices.HRSG_type HRSG_type = MyHRSG_lite.Choices.HRSG_type.horizontalBottom "Тип КУ";
      parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberFirstTubeInLastZahod = integer(numberOfFlueSections - zahod + 1) "Номер первой трубы в последнем заходе";
      parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer zahod = 1 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z2 = 2 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
      //Поток вода/пар
      parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 * z2 "Внутренняя площадь одного участка ряда труб";
      parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 * z2 / 4 "Внутренний объем одного участка ряда труб";
      parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 * z2 / 4 "Масса металла участка ряда труб";
      parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 * zahod / 4 "Площадь для прохода теплоносителя";
      parameter Boolean avoidInletEnthalpyDerivative = false "Avoid inlet enthalpy derivative";
      //**
      //Начальные значения
      //**
      //Поток вода/пар
      parameter Medium_F.SpecificEnthalpy h_startFlow_n[2] = fill(seth_in, 2) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.SpecificEnthalpy h_startFlow_v = seth_in "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.AbsolutePressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.AbsolutePressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.MassFlowRate D_startFlow_v = setD_flow "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.MassFlowRate D_startFlow_n[2] = fill(setD_flow, 2) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
      //Металл
      parameter Modelica.SIunits.Temperature t_startM = setTm "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      //**
      //Переменные
      //**
      Modelica.SIunits.Length deltaHpipe "Разность высот на участке ряда труб";
      //Поток вода/пар
      Medium_F.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
      Medium_F.ThermodynamicState stateFlow_n[2] "Термодинамическое состояние потока вода/пар на участках трубопровода";
      //Medium_F2.ThermodynamicState stateFlowTwoPhase[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
      Medium_F.Temperature t_flow "Температура потока вода/пар по участкам трубы";
      Medium_F.AbsolutePressure p_v(start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
      Medium_F.AbsolutePressure p_n[2](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
      Medium_F.SpecificEnthalpy h_v(start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
      Medium_F.SpecificEnthalpy h_n[2](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
      Real der_h_n[2] "Производняа энтальпии потока вода/пар";
      Medium_F.Density rho_v "Плотность потока по участкам трубы в конечных объемах";
      Medium_F.Density rho_n[2] "Плотность потока по участкам трубы в конечных объемах";
      //Medium_F.Density rho_v_av "Осредненная по заходу плотность потока по участкам трубы в конечных объемах";
      //Medium_F.Density rho_n[2] "Плотность потока по участкам трубы в узловых точках";
      Modelica.SIunits.DerDensityByEnthalpy drdh_v1 "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_v2 "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_n[2] "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_v "Производная плотности потока по давлению на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_n[2] "Производная плотности потока по давлению на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_new;
      Modelica.SIunits.DerDensityByPressure drdp_new;
      Medium_F.MassFlowRate D_flow_v(start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
      Medium_F.MassFlowRate D_flow_n[2](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_eco;
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_sh;
      Medium_F.ThermalConductivity k_flow_eco "Коэффициент теплопроводности для потока вода/пар";
      Medium_F.ThermalConductivity k_flow_sh;
      Medium_F.DynamicViscosity mu_flow_eco "Динамическая вязкость для потока вода/пар";
      Medium_F.DynamicViscosity mu_flow_sh;
      Modelica.SIunits.HeatFlowRate Q_flow "тепло переданное стенке трубы";
      Real Pr_flow_eco "Число Прандтля для потока вода/пар";
      Real Pr_flow_sh;
      Real Re_flow_eco "Число Рейнольдса";
      Real Re_flow_sh;
      //Real Re_flow_av "Число Рейнольдса осредненное по заходу";
      Modelica.SIunits.Temperature t_m(start = t_startM) "Температура металла на участках трубопровода";
      Real C1 "Показатель в числителе уравнения сплошности";
      Real C2 "Показатель в знаменателе уравнения сплошности";
      Real hod "Четность или не четность последнего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
      Modelica.SIunits.Length H_flow[2] "Высотная отметка каждого узла";
      Modelica.SIunits.Velocity w_flow_v "Скорость потока вода/пар в конечных объемах";
      Modelica.SIunits.Velocity w_flow_v_eco;
      Modelica.SIunits.Velocity w_flow_v_sh;
      //Modelica.SIunits.Velocity w_flow_v_av "Средняя по заходу скорость потока вода/пар в конечных объемах";
      Real dp_fric "Потеря давления из-за сил трения";
      Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
      Medium_F2.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
      //Real wrhop "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
      //Real phi "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
      Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
      Real lambda_tr "Коэффициент трения";
      Real x_v "Степень сухости";
      //Real x_v_av "Степень сухости осредненная по заходу";
      Medium_F.Density rhov "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
      Medium_F.Density rhol "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
      //Medium_F.Temperature Ts "Температура на линии насыщения";
      Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
      Modelica.SIunits.DerDensityByPressure drldp;
      Modelica.SIunits.DerDensityByPressure drvdp;
      Modelica.SIunits.DerDensityByEnthalpy dhldp;
      Modelica.SIunits.DerDensityByEnthalpy dhvdp;
      Real AA;
      Real AA1;
      Real timeZ;
      Real derpZ;
      Real A_alfa;
      Real C_alfa;
      //**
      //Интерфейс
      //**
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
        deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
      else
        deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
      end if;
//*****Уравнения для потока вода/пар и металла
      hod = (-1) ^ (z2 / zahod + (if mod(z2, zahod) == 0 then 0 else 1 - mod(z2, zahod) / zahod)) "Расчет четный или нечетный последний ход повехности нагева";
//Уравнения для расчета процессов теплообмена
//Осреднение по конечному объему
      0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
      0.5 * deltaVFlow * rho_v * der_h_n[2] = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
      deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
      heat.Q_flow = Q_flow;
      heat.T = t_m;
//Уравнения состояния
      t_flow = Medium_F.temperature(Medium_F.setState_ph(p_v, h_v));
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
//alfa_flow = if D_flow_n[1] > 0.011 then 0.023 * k_flow / Din * Re_flow ^ 0.8 * Pr_flow ^ 0.4 else 0;
//alfa_flow = 0.023 * k_flow / Din * Re_flow ^ 0.8 * Pr_flow ^ 0.4;
//alfa_flow = if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv) then 0.023 * k_flow / Din * Re_flow ^ 0.8 * Pr_flow ^ 0.4 else 20000;
      A_alfa = min(max((hl - h_n[1]) / max(h_n[2] - h_n[1], 0.01), 0), 1);
      C_alfa = min(max((h_n[2] - hv) / max(h_n[2] - h_n[1], 0.01), 0), 1);
      alfa_flow_eco = 0.023 * k_flow_eco / Din * Re_flow_eco ^ 0.8 * Pr_flow_eco ^ 0.4;
      alfa_flow_sh = 0.023 * k_flow_sh / Din * Re_flow_sh ^ 0.8 * Pr_flow_sh ^ 0.4;
      alfa_flow = ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) * alfa_flow_eco + ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2) * alfa_flow_sh + (1 - ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) - ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2)) * 20000;
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium_F2.setState_ph(p_v, h_v[i, j]);
      x_v = if h_v < hl then 0 elseif h_v > hv then 1 else (h_v - hl) / (hv - hl);
      D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
      D_flow_n[2] = D_flow_n[1] - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
//C1 = deltaVFlow * ((-1e-7) * der_h_n[1] + (-1e-7) * der_h_n[2]);
//C2 = deltaVFlow * 1e-8 * der(p_v);
      C1 = deltaVFlow * drdh_new * der(h_v);
      C2 = deltaVFlow * drdp_new * der(p_v);
      drdh_new = if abs(h_n[2] - h_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_v, h_n[2])) - Medium_F.density(Medium_F.setState_ph(p_v, h_n[1]))) / (h_n[2] - h_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_v, h_n[2])) - Medium_F.density(Medium_F.setState_ph(p_v, h_n[2] - 0.01))) / 0.01;
      drdp_new = if abs(p_n[2] - p_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
//if avoidInletEnthalpyDerivative then
// first volume properties computed by the outlet properties
//rho_v = rho_n[2];
//drdp_v = drdp_n[2];
//drdh_v1 = 0;
//drdh_v2 = drdh_n[2];
      if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
// 1-phase or almost uniform properties
        rho_v = (rho_n[1] + rho_n[2]) / 2;
        drdp_v = (drdp_n[1] + drdp_n[2]) / 2;
        drdh_v1 = drdh_n[1] / 2;
        drdh_v2 = drdh_n[2] / 2;
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, h_v));
        k_flow_sh = k_flow_eco;
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, h_v));
        Pr_flow_sh = Pr_flow_eco;
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, h_v)), 1.503e-004);
        mu_flow_sh = mu_flow_eco;
        w_flow_v_eco = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
        Re_flow_sh = Re_flow_eco;
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
// 2-phase
        rho_v = AA * log(rho_n[1] / rho_n[2]) / (h_n[2] - h_n[1]);
        drdp_v = (AA1 * log(rho_n[1] / rho_n[2]) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
        drdh_v2 = (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, h_v));
        k_flow_sh = k_flow_eco;
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, h_v));
        Pr_flow_sh = Pr_flow_eco;
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, h_v)), 1.503e-004);
        mu_flow_sh = mu_flow_eco;
        w_flow_v_eco = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
        Re_flow_sh = Re_flow_eco;
      elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
// liquid/2-phase
        rho_v = ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rho_n[2])) / (h_n[2] - h_n[1]);
        drdp_v = ((drdp_n[1] + drldp) * (hl - h_n[1]) / 2 + (rho_n[1] + rhol) / 2 * dhldp + AA1 * log(rhol / rho_n[2]) + AA * (1 / rhol * drldp - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - (rho_n[1] + rhol) / 2 + drdh_n[1] * (hl - h_n[1]) / 2) / (h_n[2] - h_n[1]);
        drdh_v2 = (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
// 2-phase/vapour
        rho_v = (AA * log(rho_n[1] / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
        drdp_v = (AA1 * log(rho_n[1] / rhov) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rhov * drvdp) + (drvdp + drdp_n[2]) * (h_n[2] - hv) / 2 - (rhov + rho_n[2]) / 2 * dhvdp) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
        drdh_v2 = ((rhov + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
// liquid/2-phase/vapour
        rho_v = ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
        drdp_v = ((drdp_n[1] + drldp) * (hl - h_n[1]) / 2 + (rho_n[1] + rhol) / 2 * dhldp + AA1 * log(rhol / rhov) + AA * (1 / rhol * drldp - 1 / rhov * drvdp) + (drvdp + drdp_n[2]) * (h_n[2] - hv) / 2 - (rhov + rho_n[2]) / 2 * dhvdp) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - (rho_n[1] + rhol) / 2 + drdh_n[1] * (hl - h_n[1]) / 2) / (h_n[2] - h_n[1]);
        drdh_v2 = ((rhov + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
// 2-phase/liquid
        rho_v = (AA * log(rho_n[1] / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
        drdp_v = (AA1 * log(rho_n[1] / rhol) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rhol * drldp) + (drldp + drdp_n[2]) * (h_n[2] - hl) / 2 - (rhol + rho_n[2]) / 2 * dhldp) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
        drdh_v2 = ((rhol + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
// vapour/2-phase/liquid
        rho_v = ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
        drdp_v = ((drdp_n[1] + drvdp) * (hv - h_n[1]) / 2 + (rho_n[1] + rhov) / 2 * dhvdp + AA1 * log(rhov / rhol) + AA * (1 / rhov * drvdp - 1 / rhol * drldp) + (drldp + drdp_n[2]) * (h_n[2] - hl) / 2 - (rhol + rho_n[2]) / 2 * dhldp) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - (rho_n[1] + rhov) / 2 + drdh_n[1] * (hv - h_n[1]) / 2) / (h_n[2] - h_n[1]);
        drdh_v2 = ((rhol + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      else
// vapour/2-phase
        rho_v = ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rho_n[2])) / (h_n[2] - h_n[1]);
        drdp_v = ((drdp_n[1] + drvdp) * (hv - h_n[1]) / 2 + (rho_n[1] + rhov) / 2 * dhvdp + AA1 * log(rhov / rho_n[2]) + AA * (1 / rhov * drvdp - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - (rho_n[1] + rhov) / 2 + drdh_n[1] * (hv - h_n[1]) / 2) / (h_n[2] - h_n[1]);
//ПОДОЗРИТЕЛЬНАЯ Ф-ЛА!!!
        drdh_v2 = (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      end if;
      for i in 1:2 loop
        stateFlow_n[i] = Medium_F.setState_ph(p_v, h_n[i]);
        drdp_n[i] = Medium_F.density_derp_h(stateFlow_n[i]);
        drdh_n[i] = Medium_F.density_derh_p(stateFlow_n[i]);
        rho_n[i] = Medium_F.density(stateFlow_n[i]);
        der_h_n[i] = der(h_n[i]);
      end for;
      sat_v = Medium_F2.setSat_p(p_v);
//Ts = sat_v.Tsat;
      rhol = Medium_F2.bubbleDensity(sat_v);
      rhov = Medium_F2.dewDensity(sat_v);
      hl = Medium_F2.bubbleEnthalpy(sat_v);
      hv = Medium_F2.dewEnthalpy(sat_v);
      drldp = Medium_F2.dBubbleDensity_dPressure(sat_v);
      drvdp = Medium_F2.dDewDensity_dPressure(sat_v);
      dhldp = Medium_F2.dBubbleEnthalpy_dPressure(sat_v);
      dhvdp = Medium_F2.dDewEnthalpy_dPressure(sat_v);
      AA = (hv - hl) / (1 / rhov - 1 / rhol);
      AA1 = ((dhvdp - dhldp) * (rhol - rhov) * rhol * rhov - (hv - hl) * (rhov ^ 2 * drldp - rhol ^ 2 * drvdp)) / (rhol - rhov) ^ 2;
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
//p_v = (p_n[1] + p_n[2]) / 2;
      p_v = p_n[1];
      timeZ = time;
      derpZ = (p_v - pre(p_v)) / max(abs(timeZ - pre(timeZ)), 1e-6);
//Основное уравнение гидравлики
//w_flow_v_av = sum(w_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//rho_v_av = sum(rho_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//Re_flow_av = sum(Re_flow[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//x_v_av = sum(x_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//wrhop = w_flow_v_av * rho_v_av * p_v * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
//Xi_flow = lambda_tr(Din, ke, Re_flow_av) * Lpipe * numberOfFlueSections / zahod / Din;
//phi = phi_heatedPipe(wrhop, p_v / 100000, x_v_av) "Расчет коэффициента phi";
//dp_fric = homotopy(if x_v_av < 1 then w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * phi * (rhol / rhov - 1)) else w_flow_v_av ^ 2 * Xi_flow * rho_v_av / 2 / Modelica.Constants.g_n, 100000 * waterIn.m_flow / setD_flow) "Потеря давления от трения";
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * Lpipe * z2 / zahod / Din;
//dp_fric = w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * 1 * (rhol / rhov - 1));
//dp_fric = w_flow_v ^ 2 * Xi_flow * max(rhol, rho_v) / 2 / Modelica.Constants.g_n;
      dp_fric = w_flow_v ^ 2 * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
//p_n[1] - p_n[2] = dp_fric + dp_piez "Формула 2-1 из книги Рудомино, Ремжин";
      p_n[1] - p_n[2] = dp_fric;
      if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
        H_flow[2] = H_flow[1] - hod * deltaHpipe "Расчет высотных отметок для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        H_flow[2] = H_flow[1] + hod * deltaHpipe "Расчет высотных отметок для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        H_flow[2] = H_flow[1] + deltaHpipe * (z2 - 1) "Расчет высотных отметок для вертикального КУ";
      else
        H_flow[2] = H_flow[1] - deltaHpipe * (z2 - 1) "Расчет высотных отметок для вертикального КУ";
      end if;
      dp_piez = (rho_n[2] * H_flow[2] - rho_n[1] * H_flow[1]) * Modelica.Constants.g_n "Расчет перепада давления из-за изменения пьезометрической высоты";
//Граничные условия
//Граничные условия для высотной отметки входного коллектора
      if HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        H_flow[1] = 0 "Задание высотной отметки входного коллектора";
      elseif HRSG_type == Choices.HRSG_type.horizontalBottom then
        H_flow[1] = 0 "Задание высотной отметки входного коллектора";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        H_flow[1] = Lpipe "Задание высотной отметки входного коллектора";
      else
        H_flow[1] = deltaHpipe * (numberOfFlueSections - 1) "Задание высотной отметки входного коллектора";
      end if;
      waterIn.m_flow = D_flow_n[1];
      waterOut.m_flow = -D_flow_n[2];
      waterOut.p = p_n[2];
      waterIn.p = p_n[1];
      h_n[1] = inStream(waterIn.h_outflow);
      waterOut.h_outflow = h_n[2];
      waterIn.h_outflow = h_n[1];
    initial equation
      der(h_v) = 0;
      der(t_m) = 0;
      der(p_v) = 0;
      for i in 1:2 loop
        der(h_n[i]) = 0;
      end for;
      annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
    end onlyFlowHE_lite;

    model GF_HE_lite
      extends HE_Icon;
      parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      //***Исходные данные для газовой стороны
      //**
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas "Номинальный (и начальный) массовый расход газов";
      parameter Modelica.SIunits.Pressure pgas "Начальное давление газов";
      parameter Modelica.SIunits.Temperature Tingas "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas "Начальная выходная температура газов";
      //parameter Modelica.SIunits.Temperature T2gas = (Tingas + Toutgas) / 2 "Промежуточная температура газов";
      parameter Real k_gamma_gas "Поправка к коэффициенту теплоотдачи со стороны газов";
      parameter Real Set_X[6] "Состав дымовых газов";
      //**
      //***Исходные данные для водяной стороны
      //**
      replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wflow "Номинальный массовый расход воды/пар";
      parameter Modelica.SIunits.Pressure pflow_in "Начальное давление потока вода/пар на входе";
      parameter Modelica.SIunits.Pressure pflow_out "Начальное давление потока вода/пар на выходе";
      parameter Modelica.SIunits.Temperature Tinflow "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
      parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
      parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
      //**
      //***Исходные данные по разбиению
      //**
      parameter Integer numberOfTubeSections = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      //**
      //***конструктивные характеристики
      //**
      parameter MyHRSG_lite.Choices.HRSG_type HRSG_type_set = Choices.HRSG_type.horizontalBottom "Выбор типа КУ (горизонтальный/вертикальный)";
      parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг";
      parameter Integer zahod = 1 "заходность труб теплообменника";
      parameter Integer z1 = 126 "Число труб по ширине газохода";
      parameter Integer z2 = 4 "Число труб по ходу газов в теплообменнике";
      parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки";
      ///Оребрение
      parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м";
      ////
      //////
      ////
      Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      onleGasHE_lite gasHE(redeclare package Medium_G = Medium_G, setD_gas = wgas, setp_gas = pgas, setT_inGas = Tingas, setT_outGas = Toutflow, k_alfaGas = k_gamma_gas, numberOfTubeSections = numberOfTubeSections, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe, delta_fin = delta_fin, hfin = hfin, sfin = sfin) annotation(Placement(visible = true, transformation(origin = {0, 50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
      replaceable onlyFlowHE_lite flowHE(setD_flow = wflow, setp_flow_in = pflow_in, setp_flow_out = pflow_out, setT_inFlow = Tinflow, setT_outFlow = Toutflow, numberOfTubeSections = numberOfTubeSections, numberPMCalcSections = numberPMCalcSections, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe, seth_in = seth_in, seth_out = seth_out, HRSG_type = HRSG_type_set, setTm = setTm, m_flow_small = m_flow_small) annotation(Placement(visible = true, transformation(origin = {0, -50}, extent = {{-30, -30}, {30, 30}}, rotation = 90)));
    equation
      connect(gasHE.gasOut, gasOut) annotation(Line(points = {{36, 50}, {92, 50}, {92, 48}, {92, 48}}, color = {0, 127, 255}));
      connect(gasIn, gasHE.gasIn) annotation(Line(points = {{-90, 50}, {-34, 50}, {-34, 48}, {-34, 48}}));
      connect(flowHE.heat, gasHE.heat);
      connect(flowHE.waterOut, flowOut) annotation(Line(points = {{36, -50}, {94, -50}, {94, -50}, {94, -50}}, color = {0, 127, 255}));
      connect(flowIn, flowHE.waterIn) annotation(Line(points = {{-90, -50}, {-34, -50}, {-34, -50}, {-34, -50}}));
      annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), version = "", uses);
    end GF_HE_lite;

    package Tests
      model Test1
        parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
        package Medium_F = Modelica.Media.Water.WaterIF97_ph;
        parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
        parameter Modelica.SIunits.MassFlowRate wsteam = 4.23 "Расход пара на выходе из сепаратора";
        parameter Modelica.SIunits.Pressure patm = 1.013e5 "Начальное давление потока вода/пар за клапаном (турбиной)";
        replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate wgas = 1276.6 / 3.6 "Номинальный (и начальный) массовый расход газов ";
        parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
        parameter Medium_F.SaturationProperties sat_start = Medium_F.setSat_p(pflow_ote2);
        //Исходные данные для сепаратора
        parameter Modelica.SIunits.Length Dsep = 0.348 "Внутренний диаметр сепаратор";
        parameter Modelica.SIunits.Length Lsep = 5 "Длина (высота) сепаратора";
        parameter Modelica.SIunits.Length deltaSep = 0.04 "Толщина стенки сепаратора";
        parameter Integer n_sep_set = 2 "Количество сепараторов";
        //Начальные значения для сепаратора
        parameter Modelica.SIunits.Length Hw_start_set = 2 "Начальное значение уровня воды в сепараторе";
        //Констуктивные характеристики поверхностей нагрева
        parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
        //Исходные данные для экономайзера
        parameter Modelica.SIunits.Diameter Din_eco = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
        parameter Integer zahod_eco = 1 "заходность труб теплообменника";
        parameter Integer z1_eco = 58 "Число труб по ширине газохода";
        parameter Integer z2_eco = 8 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб экономайзера
        parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
        //Исходные данные по разбиению экономайзера
        parameter Integer numberOfTubeSections_eco = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_eco = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для экономайзера
        parameter Modelica.SIunits.Pressure pflow_eco = 7.7e5 "Начальное давление потока вода/пар перед ECO";
        parameter Modelica.SIunits.Temperature Tinflow_eco = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_eco = 160 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны экономайзера
        parameter Modelica.SIunits.Temperature Tingas_eco = Toutgas_ote1 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_eco = 161.4 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для прямоточного испарителя №1 (OTE1)
        parameter Modelica.SIunits.Diameter Din_ote1 = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_ote1 = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_ote1 = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_ote1 = 79e-3 "Продольный шаг";
        parameter Integer zahod_ote1 = 1 "заходность труб теплообменника";
        parameter Integer z1_ote1 = 58 "Число труб по ширине газохода";
        parameter Integer z2_ote1 = 10 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб прямоточного испарителя №1 (OTE1)
        parameter Modelica.SIunits.Length delta_fin_ote1 = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_ote1 = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_ote1 = 2.002e-3 "Шаг ребер, м";
        //Исходные данные по разбиению испарителя №1 (OTE1)
        parameter Integer numberOfTubeSections_ote1 = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_ote1 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_ote1 = z2_ote1 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для экономайзера
        parameter Modelica.SIunits.Pressure pflow_ote1 = 7.7e5 "Начальное давление потока вода/пар перед ECO";
        parameter Modelica.SIunits.Temperature Tinflow_ote1 = Toutflow_eco "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_ote1 = 158 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_in = hflow_eco_out "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_out = 0.97e6 "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны экономайзера
        parameter Modelica.SIunits.Temperature Tingas_ote1 = Toutgas_ote2 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_ote1 = 179 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_ote1 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для прямоточного испарителя №2 (OTE2)
        parameter Modelica.SIunits.Diameter Din_ote2 = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_ote2 = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_ote2 = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_ote2 = 79e-3 "Продольный шаг";
        parameter Integer zahod_ote2 = 2 "заходность труб теплообменника";
        parameter Integer z1_ote2 = 58 "Число труб по ширине газохода";
        parameter Integer z2_ote2 = 6 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб прямоточного испарителя №2 (OTE2)
        parameter Modelica.SIunits.Length delta_fin_ote2 = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_ote2 = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_ote2 = 2.735e-3 "Шаг ребер, м";
        //Исходные данные по разбиению испарителя №2 (OTE2)
        parameter Integer numberOfTubeSections_ote2 = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_ote2 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_ote2 = z2_ote2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для испарителя №2
        parameter Modelica.SIunits.Pressure pflow_ote2 = 5.5e5 "Начальное давление потока вода/пар перед OTE2";
        parameter Modelica.SIunits.Temperature Tinflow_ote2 = Toutflow_ote1 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_ote2 = 145 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_in = hflow_ote1_out "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_out = 1.15e6 "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны испарителя №2
        parameter Modelica.SIunits.Temperature Tingas_ote2 = Toutgas_sh "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
        parameter Modelica.SIunits.Temperature Toutgas_ote2 = 191 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_ote2 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для пароперегревателя (SH)
        parameter Modelica.SIunits.Diameter Dout_sh = 0.038 "Наружный диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_sh = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_sh = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_sh = 79e-3 "Продольный шаг";
        parameter Integer zahod_sh = 1 "заходность труб теплообменника";
        parameter Integer z1_sh = 58 "Число труб по ширине газохода";
        parameter Integer z2_sh = 8 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб пароперегревателя (SH)
        parameter Modelica.SIunits.Length delta_fin_sh = 0.001 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_sh = 0.012 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_sh = 5.102e-3 "Шаг ребер, м";
        //Исходные данные по разбиению пароперегревателя (SH)
        parameter Integer numberOfTubeSections_sh = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_sh = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_sh = z2_sh "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для пароперегревателя
        parameter Modelica.SIunits.Pressure pflow_sh = 3.7e5 "Начальное давление потока вода/пар перед SH";
        parameter Modelica.SIunits.Temperature Tinflow_sh = Toutflow_ote2 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_sh = 198 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_in = hflow_ote2_out "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_out = Medium_F.specificEnthalpy_pT(pflow_sh, Toutflow_sh) "Начальная энтальпия входного потока вода/пар";
        //Исходные данные для газовой стороны испарителя №2
        parameter Modelica.SIunits.Temperature Tingas_sh = 200 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_sh = 199 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_sh = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        inner Modelica.Fluid.System system(allowFlowReversal = false, m_flow_small = m_flow_small) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, T = Tinflow_eco, m_flow = wflow, nPorts = 1, use_T_in = true, use_m_flow_in = false) annotation(Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite ECO(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, numberOfFlueSections = numberOfFlueSections_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, m_flow_small = system.m_flow_small) annotation(Placement(visible = true, transformation(origin = {-46, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 0, height = 0, offset = wgas, startTime = 0) annotation(Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 400, height = -140, offset = Tingas_sh, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.Ramp ramp1(duration = 0, height = 0, offset = Tinflow_eco, startTime = 0) annotation(Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(ECO.flowOut, flowSink.ports[1]) annotation(Line(points = {{-42, 24}, {-42, 24}, {-42, 56}, {60, 56}, {60, 56}}, color = {0, 127, 255}));
        connect(ECO.gasIn, gasSource.ports[1]) annotation(Line(points = {{-40, 12}, {38, 12}, {38, -6}, {60, -6}, {60, -6}}, color = {0, 127, 255}));
        connect(ramp1.y, flowSource.T_in) annotation(Line(points = {{-78, 92}, {-72, 92}, {-72, 72}, {-98, 72}, {-98, 54}, {-96, 54}}, color = {0, 0, 127}));
//separator.steam.p = pflow_eco;
//SH.flowIn.m_flow = wsteam;
//SH.flowIn.h_outflow = hflow_sh_in;
        connect(gasSource.T_in, rampGasTemp.y) annotation(Line(points = {{82, -2}, {87, -2}, {87, -2}, {92, -2}, {92, -34}, {82, -34}, {82, -34}}, color = {0, 0, 127}));
        connect(rampGasFlow.y, gasSource.m_flow_in) annotation(Line(points = {{81, -66}, {89, -66}, {89, -66}, {97, -66}, {97, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}}, color = {0, 0, 127}));
        connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -6}, {-60, -6}, {-60, 12}, {-52, 12}}, color = {0, 127, 255}));
        connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-74, 50}, {-50, 50}, {-50, 23}}, color = {0, 127, 255}));
        annotation(uses(Modelica(version = "3.2.1")), Documentation(info = "<html>
      <p>
      Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
      </p>
      </html>"), experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-10, Interval = 0.005), __OpenModelica_simulationFlags(jacobian = "coloredNumerical", s = "dassl", lv = "LOG_STATS"));
      end Test1;

      model startUpTest1
        package Medium_F = Modelica.Media.Water.WaterIF97_ph;
        parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
        parameter Modelica.SIunits.MassFlowRate wsteam = 0.01 "Расход пара на выходе из сепаратора";
        replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate wgas = 100 / 3.6 "Номинальный (и начальный) массовый расход газов ";
        parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
        parameter Medium_F.SaturationProperties sat_start = Medium_F.setSat_p(pflow_ote2);
        //Исходные данные для сепаратора
        parameter Modelica.SIunits.Length Dsep = 0.348 "Внутренний диаметр сепаратор";
        parameter Modelica.SIunits.Length Lsep = 5 "Длина (высота) сепаратора";
        parameter Modelica.SIunits.Length deltaSep = 0.04 "Толщина стенки сепаратора";
        parameter Integer n_sep_set = 2 "Количество сепараторов";
        //Начальные значения для сепаратора
        parameter Modelica.SIunits.Length Hw_start_set = 2 "Начальное значение уровня воды в сепараторе";
        //Констуктивные характеристики поверхностей нагрева
        parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
        //Исходные данные для экономайзера
        parameter Modelica.SIunits.Diameter Din_eco = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
        parameter Integer zahod_eco = 1 "заходность труб теплообменника";
        parameter Integer z1_eco = 58 "Число труб по ширине газохода";
        parameter Integer z2_eco = 8 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб экономайзера
        parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
        //Исходные данные по разбиению экономайзера
        parameter Integer numberOfTubeSections_eco = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_eco = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для экономайзера
        parameter Modelica.SIunits.Pressure pflow_eco = 1.013e5 "Начальное давление потока вода/пар перед ECO";
        parameter Modelica.SIunits.Temperature Tinflow_eco = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_eco = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_eco = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны экономайзера
        parameter Modelica.SIunits.Temperature Tingas_eco = 60 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_eco = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для прямоточного испарителя №1 (OTE1)
        parameter Modelica.SIunits.Diameter Din_ote1 = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_ote1 = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_ote1 = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_ote1 = 79e-3 "Продольный шаг";
        parameter Integer zahod_ote1 = 1 "заходность труб теплообменника";
        parameter Integer z1_ote1 = 58 "Число труб по ширине газохода";
        parameter Integer z2_ote1 = 10 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб прямоточного испарителя №1 (OTE1)
        parameter Modelica.SIunits.Length delta_fin_ote1 = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_ote1 = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_ote1 = 2.002e-3 "Шаг ребер, м";
        //Исходные данные по разбиению испарителя №1 (OTE1)
        parameter Integer numberOfTubeSections_ote1 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_ote1 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_ote1 = z2_ote1 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для экономайзера
        parameter Modelica.SIunits.Pressure pflow_ote1 = 1.013e5 "Начальное давление потока вода/пар перед ECO";
        parameter Modelica.SIunits.Temperature Tinflow_ote1 = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_ote1 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_ote1 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_in = hflow_eco_out "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_out = hflow_ote1_in "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны экономайзера
        parameter Modelica.SIunits.Temperature Tingas_ote1 = 60 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_ote1 = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_ote1 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для прямоточного испарителя №2 (OTE2)
        parameter Modelica.SIunits.Diameter Din_ote2 = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_ote2 = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_ote2 = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_ote2 = 79e-3 "Продольный шаг";
        parameter Integer zahod_ote2 = 2 "заходность труб теплообменника";
        parameter Integer z1_ote2 = 58 "Число труб по ширине газохода";
        parameter Integer z2_ote2 = 6 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб прямоточного испарителя №2 (OTE2)
        parameter Modelica.SIunits.Length delta_fin_ote2 = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_ote2 = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_ote2 = 2.735e-3 "Шаг ребер, м";
        //Исходные данные по разбиению испарителя №2 (OTE2)
        parameter Integer numberOfTubeSections_ote2 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_ote2 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_ote2 = z2_ote2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для испарителя №2
        parameter Modelica.SIunits.Pressure pflow_ote2 = 1.013e5 "Начальное давление потока вода/пар перед OTE2";
        parameter Modelica.SIunits.Temperature Tinflow_ote2 = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_ote2 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_ote2 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_in = hflow_ote1_out "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_out = hflow_ote2_in "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны испарителя №2
        parameter Modelica.SIunits.Temperature Tingas_ote2 = 60 + 273.15 "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
        parameter Modelica.SIunits.Temperature Toutgas_ote2 = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_ote2 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для пароперегревателя (SH)
        parameter Modelica.SIunits.Diameter Dout_sh = 0.038 "Наружный диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_sh = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_sh = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_sh = 79e-3 "Продольный шаг";
        parameter Integer zahod_sh = 2 "заходность труб теплообменника";
        parameter Integer z1_sh = 58 "Число труб по ширине газохода";
        parameter Integer z2_sh = 8 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб пароперегревателя (SH)
        parameter Modelica.SIunits.Length delta_fin_sh = 0.001 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_sh = 0.012 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_sh = 5.102e-3 "Шаг ребер, м";
        //Исходные данные по разбиению пароперегревателя (SH)
        parameter Integer numberOfTubeSections_sh = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_sh = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_sh = z2_sh "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для пароперегревателя
        parameter Modelica.SIunits.Pressure pflow_sh = 1.013e5 "Начальное давление потока вода/пар перед SH";
        parameter Modelica.SIunits.Temperature Tinflow_sh = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_sh = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_sh = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_in = 2.676e6 "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_out = hflow_sh_in "Начальная энтальпия входного потока вода/пар";
        //Исходные данные для газовой стороны испарителя №2
        parameter Modelica.SIunits.Temperature Tingas_sh = 60 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_sh = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_sh = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        inner Modelica.Fluid.System system(allowFlowReversal = false) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wflow, T = Tinflow_eco) annotation(Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite ECO(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, numberOfFlueSections = numberOfFlueSections_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco) annotation(Placement(visible = true, transformation(origin = {-46, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite OTE1(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, numberOfTubeSections = numberOfTubeSections_ote1, numberPMCalcSections = numberPMCalcSections_ote1, numberOfFlueSections = numberOfFlueSections_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, setTm = setTm_ote1) annotation(Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite OTE2(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, numberOfTubeSections = numberOfTubeSections_ote2, numberPMCalcSections = numberPMCalcSections_ote2, numberOfFlueSections = numberOfFlueSections_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2) annotation(Placement(visible = true, transformation(origin = {2, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-38, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature2(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
        Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 600, height = 1000, offset = wgas, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 40, height = 200, offset = Tingas_sh, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite SH(redeclare MyHRSG_lite.liteModels.onlyFlowHE_SH_lite flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, numberOfTubeSections = numberOfTubeSections_sh, numberPMCalcSections = numberPMCalcSections_sh, numberOfFlueSections = numberOfFlueSections_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2) annotation(Placement(visible = true, transformation(origin = {34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //Modelica.Fluid.Valves.ValveLinear CV1(redeclare package Medium = Medium_F, dp_nominal = 1000, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {23, 67}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
        //Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(Placement(visible = true, transformation(origin = {-2, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.Separator2 separator21 annotation(Placement(visible = true, transformation(origin = {14, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(SH.flowOut, flowSink.ports[1]) annotation(Line(points = {{38, 24}, {38, 24}, {38, 56}, {60, 56}, {60, 56}}, color = {0, 127, 255}));
        connect(separator21.steam, SH.flowIn) annotation(Line(points = {{14, 52}, {14, 52}, {14, 54}, {30, 54}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
//connect(separator21.steam, CV1.port_a) annotation(Line(points = {{14, 51}, {14, 68}, {18, 68}}, color = {0, 127, 255}));
        connect(OTE2.flowOut, separator21.fedWater) annotation(Line(points = {{6, 24}, {6, 47}, {7, 47}}, color = {0, 127, 255}));
//connect(constCV2.y, CV2.opening) annotation(Line(points = {{48, 86}, {54, 86}, {54, 70}, {46, 70}, {46, 62}, {48, 62}}, color = {0, 0, 127}));
//connect(CV2.port_b, flowSink.ports[1]) annotation(Line(points = {{52, 57}, {56, 57}, {56, 56}, {60, 56}}, color = {0, 127, 255}));
//connect(SH.flowOut, CV2.port_a) annotation(Line(points = {{38, 24}, {38, 57}, {42, 57}}, color = {0, 127, 255}));
//connect(constCV1.y, CV1.opening) annotation(Line(points = {{10, 80}, {24, 80}, {24, 72}, {24, 72}}, color = {0, 0, 127}));
//connect(CV1.port_b, SH.flowIn) annotation(Line(points = {{28, 68}, {32, 68}, {32, 38}, {30, 38}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
        connect(SH.gasOut, OTE2.gasIn) annotation(Line(points = {{28, 12}, {8, 12}, {8, 12}, {8, 12}}, color = {0, 127, 255}));
        connect(gasSource.ports[1], SH.gasIn) annotation(Line(points = {{60, -6}, {48, -6}, {48, 12}, {40, 12}, {40, 12}}, color = {0, 127, 255}));
        connect(gasSource.T_in, rampGasTemp.y) annotation(Line(points = {{82, -2}, {87, -2}, {87, -2}, {92, -2}, {92, -34}, {82, -34}, {82, -34}}, color = {0, 0, 127}));
        connect(rampGasFlow.y, gasSource.m_flow_in) annotation(Line(points = {{81, -66}, {89, -66}, {89, -66}, {97, -66}, {97, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}}, color = {0, 0, 127}));
        connect(OTE1.flowOut, temperature2.port_a) annotation(Line(points = {{-17.8, 23}, {-17.8, 26.5}, {-17.8, 26.5}, {-17.8, 30}, {-13.8, 30}}, color = {0, 127, 255}));
        connect(temperature2.port_b, OTE2.flowIn) annotation(Line(points = {{-6, 30}, {-2, 30}, {-2, 26}, {-2, 26}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
        connect(temperature1.port_b, OTE1.flowIn) annotation(Line(points = {{-34, 30}, {-26, 30}, {-26, 26.5}, {-26, 26.5}, {-26, 23}}, color = {0, 127, 255}));
        connect(ECO.flowOut, temperature1.port_a) annotation(Line(points = {{-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 31}, {-41.8, 31}, {-41.8, 29}, {-41.8, 29}}, color = {0, 127, 255}));
        connect(OTE1.gasIn, OTE2.gasOut) annotation(Line(points = {{-15.8, 12}, {-3.8, 12}}, color = {0, 127, 255}));
        connect(ECO.gasIn, OTE1.gasOut) annotation(Line(points = {{-39.8, 12}, {-27.8, 12}}, color = {0, 127, 255}));
        connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -6}, {-60, -6}, {-60, 12}, {-52, 12}}, color = {0, 127, 255}));
        connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-74, 50}, {-50, 50}, {-50, 23}}, color = {0, 127, 255}));
        annotation(uses(Modelica(version = "3.2.1")), Documentation(info = "<html>
      <p>
      Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
      </p>
      </html>"), experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-6, Interval = 0.005));
      end startUpTest1;

      model startUpTest2
        package Medium_F = Modelica.Media.Water.WaterIF97_ph;
        parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
        parameter Modelica.SIunits.MassFlowRate wsteam = 0.01 "Расход пара на выходе из сепаратора";
        replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate wgas = 100 / 3.6 "Номинальный (и начальный) массовый расход газов ";
        parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
        parameter Medium_F.SaturationProperties sat_start = Medium_F.setSat_p(pflow_ote2);
        //Исходные данные для сепаратора
        parameter Modelica.SIunits.Length Dsep = 0.348 "Внутренний диаметр сепаратор";
        parameter Modelica.SIunits.Length Lsep = 5 "Длина (высота) сепаратора";
        parameter Modelica.SIunits.Length deltaSep = 0.04 "Толщина стенки сепаратора";
        parameter Integer n_sep_set = 2 "Количество сепараторов";
        //Начальные значения для сепаратора
        parameter Modelica.SIunits.Length Hw_start_set = 2 "Начальное значение уровня воды в сепараторе";
        //Констуктивные характеристики поверхностей нагрева
        parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
        //Исходные данные для экономайзера
        parameter Modelica.SIunits.Diameter Din_eco = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
        parameter Integer zahod_eco = 1 "заходность труб теплообменника";
        parameter Integer z1_eco = 58 "Число труб по ширине газохода";
        parameter Integer z2_eco = 8 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб экономайзера
        parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
        //Исходные данные по разбиению экономайзера
        parameter Integer numberOfTubeSections_eco = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_eco = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для экономайзера
        parameter Modelica.SIunits.Pressure pflow_eco = 1.013e5 "Начальное давление потока вода/пар перед ECO";
        parameter Modelica.SIunits.Temperature Tinflow_eco = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_eco = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_eco = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны экономайзера
        parameter Modelica.SIunits.Temperature Tingas_eco = 60 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_eco = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для прямоточного испарителя №1 (OTE1)
        parameter Modelica.SIunits.Diameter Din_ote1 = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_ote1 = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_ote1 = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_ote1 = 79e-3 "Продольный шаг";
        parameter Integer zahod_ote1 = 1 "заходность труб теплообменника";
        parameter Integer z1_ote1 = 58 "Число труб по ширине газохода";
        parameter Integer z2_ote1 = 10 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб прямоточного испарителя №1 (OTE1)
        parameter Modelica.SIunits.Length delta_fin_ote1 = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_ote1 = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_ote1 = 2.002e-3 "Шаг ребер, м";
        //Исходные данные по разбиению испарителя №1 (OTE1)
        parameter Integer numberOfTubeSections_ote1 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_ote1 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_ote1 = z2_ote1 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для экономайзера
        parameter Modelica.SIunits.Pressure pflow_ote1 = 1.013e5 "Начальное давление потока вода/пар перед ECO";
        parameter Modelica.SIunits.Temperature Tinflow_ote1 = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_ote1 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_ote1 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_in = hflow_eco_out "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_out = hflow_ote1_in "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны экономайзера
        parameter Modelica.SIunits.Temperature Tingas_ote1 = 60 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_ote1 = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_ote1 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для прямоточного испарителя №2 (OTE2)
        parameter Modelica.SIunits.Diameter Din_ote2 = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_ote2 = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_ote2 = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_ote2 = 79e-3 "Продольный шаг";
        parameter Integer zahod_ote2 = 2 "заходность труб теплообменника";
        parameter Integer z1_ote2 = 58 "Число труб по ширине газохода";
        parameter Integer z2_ote2 = 10 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб прямоточного испарителя №2 (OTE2)
        parameter Modelica.SIunits.Length delta_fin_ote2 = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_ote2 = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_ote2 = 2.735e-3 "Шаг ребер, м";
        //Исходные данные по разбиению испарителя №2 (OTE2)
        parameter Integer numberOfTubeSections_ote2 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_ote2 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_ote2 = z2_ote2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для испарителя №2
        parameter Modelica.SIunits.Pressure pflow_ote2 = 1.013e5 "Начальное давление потока вода/пар перед OTE2";
        parameter Modelica.SIunits.Temperature Tinflow_ote2 = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_ote2 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_ote2 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_in = hflow_ote1_out "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_out = hflow_ote2_in "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны испарителя №2
        parameter Modelica.SIunits.Temperature Tingas_ote2 = 60 + 273.15 "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
        parameter Modelica.SIunits.Temperature Toutgas_ote2 = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_ote2 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для пароперегревателя (SH)
        parameter Modelica.SIunits.Diameter Dout_sh = 0.038 "Наружный диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_sh = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_sh = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_sh = 79e-3 "Продольный шаг";
        parameter Integer zahod_sh = 2 "заходность труб теплообменника";
        parameter Integer z1_sh = 58 "Число труб по ширине газохода";
        parameter Integer z2_sh = 8 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб пароперегревателя (SH)
        parameter Modelica.SIunits.Length delta_fin_sh = 0.001 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_sh = 0.012 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_sh = 5.102e-3 "Шаг ребер, м";
        //Исходные данные по разбиению пароперегревателя (SH)
        parameter Integer numberOfTubeSections_sh = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_sh = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_sh = z2_sh "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для пароперегревателя
        parameter Modelica.SIunits.Pressure pflow_sh = 1.013e5 "Начальное давление потока вода/пар перед SH";
        parameter Modelica.SIunits.Temperature Tinflow_sh = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_sh = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_sh = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_in = 2.676e6 "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_out = hflow_sh_in "Начальная энтальпия входного потока вода/пар";
        //Исходные данные для газовой стороны испарителя №2
        parameter Modelica.SIunits.Temperature Tingas_sh = 60 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_sh = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_sh = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        inner Modelica.Fluid.System system(allowFlowReversal = false) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wflow, T = Tinflow_eco) annotation(Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite2 ECO(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, numberOfFlueSections = numberOfFlueSections_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco, numberOfVolumes = 2) annotation(Placement(visible = true, transformation(origin = {-46, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite2 OTE1(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, numberOfTubeSections = numberOfTubeSections_ote1, numberPMCalcSections = numberPMCalcSections_ote1, numberOfFlueSections = numberOfFlueSections_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, setTm = setTm_ote1, numberOfVolumes = 10) annotation(Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite2 OTE2(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, numberOfTubeSections = numberOfTubeSections_ote2, numberPMCalcSections = numberPMCalcSections_ote2, numberOfFlueSections = numberOfFlueSections_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2, numberOfVolumes = 10) annotation(Placement(visible = true, transformation(origin = {2, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-38, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature2(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
        Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 600, height = 1000, offset = wgas, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 40, height = 200, offset = Tingas_sh, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite SH(redeclare MyHRSG_lite.liteModels.onlyFlowHE_SH_lite flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, numberOfTubeSections = numberOfTubeSections_sh, numberPMCalcSections = numberPMCalcSections_sh, numberOfFlueSections = numberOfFlueSections_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2) annotation(Placement(visible = true, transformation(origin = {34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //Modelica.Fluid.Valves.ValveLinear CV1(redeclare package Medium = Medium_F, dp_nominal = 1000, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {23, 67}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
        //Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(Placement(visible = true, transformation(origin = {-2, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.Separator2 separator21 annotation(Placement(visible = true, transformation(origin = {14, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(SH.flowOut, flowSink.ports[1]) annotation(Line(points = {{38, 24}, {38, 24}, {38, 56}, {60, 56}, {60, 56}}, color = {0, 127, 255}));
        connect(separator21.steam, SH.flowIn) annotation(Line(points = {{14, 52}, {14, 52}, {14, 54}, {30, 54}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
//connect(separator21.steam, CV1.port_a) annotation(Line(points = {{14, 51}, {14, 68}, {18, 68}}, color = {0, 127, 255}));
        connect(OTE2.flowOut, separator21.fedWater) annotation(Line(points = {{6, 24}, {6, 47}, {7, 47}}, color = {0, 127, 255}));
//connect(constCV2.y, CV2.opening) annotation(Line(points = {{48, 86}, {54, 86}, {54, 70}, {46, 70}, {46, 62}, {48, 62}}, color = {0, 0, 127}));
//connect(CV2.port_b, flowSink.ports[1]) annotation(Line(points = {{52, 57}, {56, 57}, {56, 56}, {60, 56}}, color = {0, 127, 255}));
//connect(SH.flowOut, CV2.port_a) annotation(Line(points = {{38, 24}, {38, 57}, {42, 57}}, color = {0, 127, 255}));
//connect(constCV1.y, CV1.opening) annotation(Line(points = {{10, 80}, {24, 80}, {24, 72}, {24, 72}}, color = {0, 0, 127}));
//connect(CV1.port_b, SH.flowIn) annotation(Line(points = {{28, 68}, {32, 68}, {32, 38}, {30, 38}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
        connect(SH.gasOut, OTE2.gasIn) annotation(Line(points = {{28, 12}, {8, 12}, {8, 12}, {8, 12}}, color = {0, 127, 255}));
        connect(gasSource.ports[1], SH.gasIn) annotation(Line(points = {{60, -6}, {48, -6}, {48, 12}, {40, 12}, {40, 12}}, color = {0, 127, 255}));
        connect(gasSource.T_in, rampGasTemp.y) annotation(Line(points = {{82, -2}, {87, -2}, {87, -2}, {92, -2}, {92, -34}, {82, -34}, {82, -34}}, color = {0, 0, 127}));
        connect(rampGasFlow.y, gasSource.m_flow_in) annotation(Line(points = {{81, -66}, {89, -66}, {89, -66}, {97, -66}, {97, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}}, color = {0, 0, 127}));
        connect(OTE1.flowOut, temperature2.port_a) annotation(Line(points = {{-17.8, 23}, {-17.8, 26.5}, {-17.8, 26.5}, {-17.8, 30}, {-13.8, 30}}, color = {0, 127, 255}));
        connect(temperature2.port_b, OTE2.flowIn) annotation(Line(points = {{-6, 30}, {-2, 30}, {-2, 26}, {-2, 26}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
        connect(temperature1.port_b, OTE1.flowIn) annotation(Line(points = {{-34, 30}, {-26, 30}, {-26, 26.5}, {-26, 26.5}, {-26, 23}}, color = {0, 127, 255}));
        connect(ECO.flowOut, temperature1.port_a) annotation(Line(points = {{-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 31}, {-41.8, 31}, {-41.8, 29}, {-41.8, 29}}, color = {0, 127, 255}));
        connect(OTE1.gasIn, OTE2.gasOut) annotation(Line(points = {{-15.8, 12}, {-3.8, 12}}, color = {0, 127, 255}));
        connect(ECO.gasIn, OTE1.gasOut) annotation(Line(points = {{-39.8, 12}, {-27.8, 12}}, color = {0, 127, 255}));
        connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -6}, {-60, -6}, {-60, 12}, {-52, 12}}, color = {0, 127, 255}));
        connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-74, 50}, {-50, 50}, {-50, 23}}, color = {0, 127, 255}));
        annotation(uses(Modelica(version = "3.2.1")), Documentation(info = "<html>
      <p>
      Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
      </p>
      </html>"), experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-6, Interval = 0.005));
      end startUpTest2;

      model startUpTest3
        package Medium_F = Modelica.Media.Water.WaterIF97_ph;
        parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
        parameter Modelica.SIunits.MassFlowRate wsteam = 0.01 "Расход пара на выходе из сепаратора";
        replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate wgas = 100 / 3.6 "Номинальный (и начальный) массовый расход газов ";
        parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
        parameter Medium_F.SaturationProperties sat_start = Medium_F.setSat_p(pflow_ote2);
        //Исходные данные для сепаратора
        parameter Modelica.SIunits.Length Dsep = 0.348 "Внутренний диаметр сепаратор";
        parameter Modelica.SIunits.Length Lsep = 5 "Длина (высота) сепаратора";
        parameter Modelica.SIunits.Length deltaSep = 0.04 "Толщина стенки сепаратора";
        parameter Integer n_sep_set = 2 "Количество сепараторов";
        //Начальные значения для сепаратора
        parameter Modelica.SIunits.Length Hw_start_set = 2 "Начальное значение уровня воды в сепараторе";
        //Констуктивные характеристики поверхностей нагрева
        parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
        //Исходные данные для экономайзера
        parameter Modelica.SIunits.Diameter Din_eco = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
        parameter Integer zahod_eco = 1 "заходность труб теплообменника";
        parameter Integer z1_eco = 58 "Число труб по ширине газохода";
        parameter Integer z2_eco = 8 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб экономайзера
        parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
        //Исходные данные по разбиению экономайзера
        parameter Integer numberOfTubeSections_eco = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_eco = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для экономайзера
        parameter Modelica.SIunits.Pressure pflow_eco = 1.013e5 "Начальное давление потока вода/пар перед ECO";
        parameter Modelica.SIunits.Temperature Tinflow_eco = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_eco = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_eco = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны экономайзера
        parameter Modelica.SIunits.Temperature Tingas_eco = 60 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_eco = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для прямоточного испарителя №1 (OTE1)
        parameter Modelica.SIunits.Diameter Din_ote1 = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_ote1 = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_ote1 = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_ote1 = 79e-3 "Продольный шаг";
        parameter Integer zahod_ote1 = 1 "заходность труб теплообменника";
        parameter Integer z1_ote1 = 58 "Число труб по ширине газохода";
        parameter Integer z2_ote1 = 10 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб прямоточного испарителя №1 (OTE1)
        parameter Modelica.SIunits.Length delta_fin_ote1 = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_ote1 = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_ote1 = 2.002e-3 "Шаг ребер, м";
        //Исходные данные по разбиению испарителя №1 (OTE1)
        parameter Integer numberOfTubeSections_ote1 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_ote1 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_ote1 = z2_ote1 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для экономайзера
        parameter Modelica.SIunits.Pressure pflow_ote1 = 1.013e5 "Начальное давление потока вода/пар перед ECO";
        parameter Modelica.SIunits.Temperature Tinflow_ote1 = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_ote1 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_ote1 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_in = hflow_eco_out "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_out = hflow_ote1_in "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны экономайзера
        parameter Modelica.SIunits.Temperature Tingas_ote1 = 60 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_ote1 = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_ote1 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для прямоточного испарителя №2 (OTE2)
        parameter Modelica.SIunits.Diameter Din_ote2 = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_ote2 = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_ote2 = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_ote2 = 79e-3 "Продольный шаг";
        parameter Integer zahod_ote2 = 2 "заходность труб теплообменника";
        parameter Integer z1_ote2 = 58 "Число труб по ширине газохода";
        parameter Integer z2_ote2 = 6 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб прямоточного испарителя №2 (OTE2)
        parameter Modelica.SIunits.Length delta_fin_ote2 = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_ote2 = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_ote2 = 2.735e-3 "Шаг ребер, м";
        //Исходные данные по разбиению испарителя №2 (OTE2)
        parameter Integer numberOfTubeSections_ote2 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_ote2 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_ote2 = z2_ote2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для испарителя №2
        parameter Modelica.SIunits.Pressure pflow_ote2 = 1.013e5 "Начальное давление потока вода/пар перед OTE2";
        parameter Modelica.SIunits.Temperature Tinflow_ote2 = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_ote2 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_ote2 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_in = hflow_ote1_out "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_out = hflow_ote2_in "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны испарителя №2
        parameter Modelica.SIunits.Temperature Tingas_ote2 = 60 + 273.15 "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
        parameter Modelica.SIunits.Temperature Toutgas_ote2 = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_ote2 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для пароперегревателя (SH)
        parameter Modelica.SIunits.Diameter Dout_sh = 0.038 "Наружный диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_sh = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_sh = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_sh = 79e-3 "Продольный шаг";
        parameter Integer zahod_sh = 2 "заходность труб теплообменника";
        parameter Integer z1_sh = 58 "Число труб по ширине газохода";
        parameter Integer z2_sh = 8 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб пароперегревателя (SH)
        parameter Modelica.SIunits.Length delta_fin_sh = 0.001 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_sh = 0.012 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_sh = 5.102e-3 "Шаг ребер, м";
        //Исходные данные по разбиению пароперегревателя (SH)
        parameter Integer numberOfTubeSections_sh = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_sh = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_sh = z2_sh "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для пароперегревателя
        parameter Modelica.SIunits.Pressure pflow_sh = 1.013e5 "Начальное давление потока вода/пар перед SH";
        parameter Modelica.SIunits.Temperature Tinflow_sh = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_sh = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_sh = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_in = 2.676e6 "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_out = hflow_sh_in "Начальная энтальпия входного потока вода/пар";
        //Исходные данные для газовой стороны испарителя №2
        parameter Modelica.SIunits.Temperature Tingas_sh = 60 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_sh = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_sh = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        inner Modelica.Fluid.System system(allowFlowReversal = false) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wflow, T = Tinflow_eco) annotation(Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite3 ECO(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, numberOfFlueSections = numberOfFlueSections_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco, numberOfVolumes = 2) annotation(Placement(visible = true, transformation(origin = {-46, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite3 OTE1(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, numberOfTubeSections = numberOfTubeSections_ote1, numberPMCalcSections = numberPMCalcSections_ote1, numberOfFlueSections = numberOfFlueSections_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, setTm = setTm_ote1, numberOfVolumes = 10) annotation(Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite3 OTE2(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, numberOfTubeSections = numberOfTubeSections_ote2, numberPMCalcSections = numberPMCalcSections_ote2, numberOfFlueSections = numberOfFlueSections_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2, numberOfVolumes = 10) annotation(Placement(visible = true, transformation(origin = {2, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-38, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature2(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
        Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 600, height = 1000, offset = wgas, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 40, height = 200, offset = Tingas_sh, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.liteModels.GF_HE_lite SH(redeclare MyHRSG_lite.liteModels.onlyFlowHE_SH_lite flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, numberOfTubeSections = numberOfTubeSections_sh, numberPMCalcSections = numberPMCalcSections_sh, numberOfFlueSections = numberOfFlueSections_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2) annotation(Placement(visible = true, transformation(origin = {34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //Modelica.Fluid.Valves.ValveLinear CV1(redeclare package Medium = Medium_F, dp_nominal = 1000, m_flow_nominal = wsteam) annotation(Placement(visible = true, transformation(origin = {23, 67}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
        //Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(Placement(visible = true, transformation(origin = {-2, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.Separator2 separator21 annotation(Placement(visible = true, transformation(origin = {14, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(SH.flowOut, flowSink.ports[1]) annotation(Line(points = {{38, 24}, {38, 24}, {38, 56}, {60, 56}, {60, 56}}, color = {0, 127, 255}));
        connect(separator21.steam, SH.flowIn) annotation(Line(points = {{14, 52}, {14, 52}, {14, 54}, {30, 54}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
//connect(separator21.steam, CV1.port_a) annotation(Line(points = {{14, 51}, {14, 68}, {18, 68}}, color = {0, 127, 255}));
        connect(OTE2.flowOut, separator21.fedWater) annotation(Line(points = {{6, 24}, {6, 47}, {7, 47}}, color = {0, 127, 255}));
//connect(constCV2.y, CV2.opening) annotation(Line(points = {{48, 86}, {54, 86}, {54, 70}, {46, 70}, {46, 62}, {48, 62}}, color = {0, 0, 127}));
//connect(CV2.port_b, flowSink.ports[1]) annotation(Line(points = {{52, 57}, {56, 57}, {56, 56}, {60, 56}}, color = {0, 127, 255}));
//connect(SH.flowOut, CV2.port_a) annotation(Line(points = {{38, 24}, {38, 57}, {42, 57}}, color = {0, 127, 255}));
//connect(constCV1.y, CV1.opening) annotation(Line(points = {{10, 80}, {24, 80}, {24, 72}, {24, 72}}, color = {0, 0, 127}));
//connect(CV1.port_b, SH.flowIn) annotation(Line(points = {{28, 68}, {32, 68}, {32, 38}, {30, 38}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
        connect(SH.gasOut, OTE2.gasIn) annotation(Line(points = {{28, 12}, {8, 12}, {8, 12}, {8, 12}}, color = {0, 127, 255}));
        connect(gasSource.ports[1], SH.gasIn) annotation(Line(points = {{60, -6}, {48, -6}, {48, 12}, {40, 12}, {40, 12}}, color = {0, 127, 255}));
        connect(gasSource.T_in, rampGasTemp.y) annotation(Line(points = {{82, -2}, {87, -2}, {87, -2}, {92, -2}, {92, -34}, {82, -34}, {82, -34}}, color = {0, 0, 127}));
        connect(rampGasFlow.y, gasSource.m_flow_in) annotation(Line(points = {{81, -66}, {89, -66}, {89, -66}, {97, -66}, {97, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}}, color = {0, 0, 127}));
        connect(OTE1.flowOut, temperature2.port_a) annotation(Line(points = {{-17.8, 23}, {-17.8, 26.5}, {-17.8, 26.5}, {-17.8, 30}, {-13.8, 30}}, color = {0, 127, 255}));
        connect(temperature2.port_b, OTE2.flowIn) annotation(Line(points = {{-6, 30}, {-2, 30}, {-2, 26}, {-2, 26}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
        connect(temperature1.port_b, OTE1.flowIn) annotation(Line(points = {{-34, 30}, {-26, 30}, {-26, 26.5}, {-26, 26.5}, {-26, 23}}, color = {0, 127, 255}));
        connect(ECO.flowOut, temperature1.port_a) annotation(Line(points = {{-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 31}, {-41.8, 31}, {-41.8, 29}, {-41.8, 29}}, color = {0, 127, 255}));
        connect(OTE1.gasIn, OTE2.gasOut) annotation(Line(points = {{-15.8, 12}, {-3.8, 12}}, color = {0, 127, 255}));
        connect(ECO.gasIn, OTE1.gasOut) annotation(Line(points = {{-39.8, 12}, {-27.8, 12}}, color = {0, 127, 255}));
        connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -6}, {-60, -6}, {-60, 12}, {-52, 12}}, color = {0, 127, 255}));
        connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-74, 50}, {-50, 50}, {-50, 23}}, color = {0, 127, 255}));
        annotation(uses(Modelica(version = "3.2.1")), Documentation(info = "<html>
      <p>
      Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
      </p>
      </html>"), experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 0.005));
      end startUpTest3;
    end Tests;

    model onlyFlowHE_SH_lite
      //**
      //***Исходные данные для газовой стороны
      //**
      parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      //**
      //***Исходные данные по стороне вода/пар
      //**
      replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
      replaceable package Medium_F2 = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
      constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
      constant Medium_F.AbsolutePressure pc = Medium_F.fluidConstants[1].criticalPressure;
      constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
      parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
      parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
      parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
      //**
      //***Характеристики металла
      parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
      parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
      parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
      //**
      //**
      //Конструктивные характеристики
      //**
      //Параметры
      parameter MyHRSG_lite.Choices.HRSG_type HRSG_type = MyHRSG_lite.Choices.HRSG_type.horizontalBottom "Тип КУ";
      parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberFirstTubeInLastZahod = integer(numberOfFlueSections - zahod + 1) "Номер первой трубы в последнем заходе";
      parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer zahod = 1 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z2 = 2 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
      //Поток вода/пар
      parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 * z2 "Внутренняя площадь одного участка ряда труб";
      parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 * z2 / 4 "Внутренний объем одного участка ряда труб";
      parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 * z2 / 4 "Масса металла участка ряда труб";
      parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 * zahod / 4 "Площадь для прохода теплоносителя";
      parameter Boolean avoidInletEnthalpyDerivative = false "Avoid inlet enthalpy derivative";
      //**
      //Начальные значения
      //**
      //Поток вода/пар
      parameter Medium_F.SpecificEnthalpy h_startFlow_n[2] = fill(seth_in, 2) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.SpecificEnthalpy h_startFlow_v = seth_in "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.AbsolutePressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.AbsolutePressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.MassFlowRate D_startFlow_v = setD_flow "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.MassFlowRate D_startFlow_n[2] = fill(setD_flow, 2) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
      //Металл
      parameter Modelica.SIunits.Temperature t_startM = setTm "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      //**
      //Переменные
      //**
      Modelica.SIunits.Length deltaHpipe "Разность высот на участке ряда труб";
      //Поток вода/пар
      Medium_F.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
      Medium_F.ThermodynamicState stateFlow_n[2] "Термодинамическое состояние потока вода/пар на участках трубопровода";
      //Medium_F2.ThermodynamicState stateFlowTwoPhase[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
      Medium_F.Temperature t_flow "Температура потока вода/пар по участкам трубы";
      Medium_F.AbsolutePressure p_v(start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
      Medium_F.AbsolutePressure p_n[2](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
      Medium_F.SpecificEnthalpy h_v(start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
      Medium_F.SpecificEnthalpy h_n[2](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
      Real der_h_n[2] "Производняа энтальпии потока вода/пар";
      Medium_F.Density rho_v "Плотность потока по участкам трубы в конечных объемах";
      Medium_F.Density rho_n[2] "Плотность потока по участкам трубы в конечных объемах";
      //Medium_F.Density rho_v_av "Осредненная по заходу плотность потока по участкам трубы в конечных объемах";
      //Medium_F.Density rho_n[2] "Плотность потока по участкам трубы в узловых точках";
      Modelica.SIunits.DerDensityByEnthalpy drdh_v1 "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_v2 "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_n[2] "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_v "Производная плотности потока по давлению на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_n[2] "Производная плотности потока по давлению на участках ряда труб";
      Medium_F.MassFlowRate D_flow_v(start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
      Medium_F.MassFlowRate D_flow_n[2](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
      Medium_F.ThermalConductivity k_flow "Коэффициент теплопроводности для потока вода/пар";
      Medium_F.DynamicViscosity mu_flow "Динамическая вязкость для потока вода/пар";
      Modelica.SIunits.HeatFlowRate Q_flow "тепло переданное стенке трубы";
      Real Pr_flow "Число Прандтля для потока вода/пар";
      Real Re_flow "Число Рейнольдса";
      Real Re_flow_alfa;
      //Real Re_flow_av "Число Рейнольдса осредненное по заходу";
      Modelica.SIunits.Temperature t_m(start = t_startM) "Температура металла на участках трубопровода";
      Real C1 "Показатель в числителе уравнения сплошности";
      Real C2 "Показатель в знаменателе уравнения сплошности";
      Real hod "Четность или не четность последнего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
      Modelica.SIunits.Length H_flow[2] "Высотная отметка каждого узла";
      Modelica.SIunits.Velocity w_flow_v "Скорость потока вода/пар в конечных объемах";
      Modelica.SIunits.Velocity w_flow_alfa;
      //Modelica.SIunits.Velocity w_flow_v_av "Средняя по заходу скорость потока вода/пар в конечных объемах";
      Real dp_fric "Потеря давления из-за сил трения";
      Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
      Medium_F2.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
      //Real wrhop "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
      //Real phi "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
      Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
      Real lambda_tr "Коэффициент трения";
      Real x_v "Степень сухости";
      //Real x_v_av "Степень сухости осредненная по заходу";
      Medium_F.Density rhov "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
      Medium_F.Density rhol "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
      //Medium_F.Temperature Ts "Температура на линии насыщения";
      Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
      Modelica.SIunits.DerDensityByPressure drldp;
      Modelica.SIunits.DerDensityByPressure drvdp;
      Modelica.SIunits.DerDensityByEnthalpy dhldp;
      Modelica.SIunits.DerDensityByEnthalpy dhvdp;
      Real AA;
      Real AA1;
      Real timeZ;
      Real derpZ;
      //**
      //Интерфейс
      //**
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
        deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
      else
        deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
      end if;
//*****Уравнения для потока вода/пар и металла
      hod = (-1) ^ (z2 / zahod + (if mod(z2, zahod) == 0 then 0 else 1 - mod(z2, zahod) / zahod)) "Расчет четный или нечетный последний ход повехности нагева";
//Уравнения для расчета процессов теплообмена
//Осреднение по конечному объему
      0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_n[1] * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
      0.5 * deltaVFlow * rho_v * der_h_n[2] = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//0 = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_n[1] * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
//0 = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//0 = alfa_flow * deltaSFlow * (t_m - t_flow) - (D_flow_n[2] * h_n[2] - D_flow_n[1] * h_n[1]);
//h_v = 0.5 * (h_n[1] + h_n[2]);
//Уравнение теплового баланса металла
      deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
      heat.Q_flow = Q_flow;
      heat.T = t_m;
//Уравнения состояния
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      t_flow = Medium_F.temperature(stateFlow);
      k_flow = Medium_F.thermalConductivity(stateFlow);
      Pr_flow = Medium_F.prandtlNumber(stateFlow);
      mu_flow = if Medium_F.dynamicViscosity(stateFlow) < 1.503e-004 then 1.503e-004 else Medium_F.dynamicViscosity(stateFlow);
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
      w_flow_alfa = max((D_flow_n[1] - m_flow_small) / rho_v / f_flow, 0);
      Re_flow = abs(w_flow_v * Din * rho_v / mu_flow);
      Re_flow_alfa = abs(w_flow_alfa * Din * rho_v / mu_flow);
//alfa_flow = if D_flow_n[1] > 0.011 then 0.023 * k_flow / Din * Re_flow ^ 0.8 * Pr_flow ^ 0.4 else 0;
//when D_flow_n[1] > m_flow_small then
      alfa_flow = 0.023 * k_flow / Din * Re_flow_alfa ^ 0.8 * Pr_flow ^ 0.4;
//end when;
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium_F2.setState_ph(p_v, h_v[i, j]);
      x_v = if h_v < hl then 0 elseif h_v > hv then 1 else (h_v - hl) / (hv - hl);
      D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
      D_flow_n[2] = D_flow_n[1] - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
      C1 = deltaVFlow * ((-1e-7) * der_h_n[1] + (-1e-7) * der_h_n[2]);
      C2 = deltaVFlow * 1e-8 * der(p_v);
/*if avoidInletEnthalpyDerivative then
// first volume properties computed by the outlet properties
    rho_v = rho_n[2];
    drdp_v = drdp_n[2];
    drdh_v1 = 0;
    drdh_v2 = drdh_n[2];
  elseif noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then*/
// 1-phase or almost uniform properties
      rho_v = (rho_n[1] + rho_n[2]) / 2;
      drdp_v = (drdp_n[1] + drdp_n[2]) / 2;
      drdh_v1 = drdh_n[1] / 2;
      drdh_v2 = drdh_n[2] / 2;
/*elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
// 2-phase
    rho_v = AA * log(rho_n[1] / rho_n[2]) / (h_n[2] - h_n[1]);
    drdp_v = (AA1 * log(rho_n[1] / rho_n[2]) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
    drdh_v1 = (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
    drdh_v2 = (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
// liquid/2-phase
    rho_v = ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rho_n[2])) / (h_n[2] - h_n[1]);
    drdp_v = ((drdp_n[1] + drldp) * (hl - h_n[1]) / 2 + (rho_n[1] + rhol) / 2 * dhldp + AA1 * log(rhol / rho_n[2]) + AA * (1 / rhol * drldp - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
    drdh_v1 = (rho_v - (rho_n[1] + rhol) / 2 + drdh_n[1] * (hl - h_n[1]) / 2) / (h_n[2] - h_n[1]);
    drdh_v2 = (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
// 2-phase/vapour
    rho_v = (AA * log(rho_n[1] / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
    drdp_v = (AA1 * log(rho_n[1] / rhov) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rhov * drvdp) + (drvdp + drdp_n[2]) * (h_n[2] - hv) / 2 - (rhov + rho_n[2]) / 2 * dhvdp) / (h_n[2] - h_n[1]);
    drdh_v1 = (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
    drdh_v2 = ((rhov + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
// liquid/2-phase/vapour
    rho_v = ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
    drdp_v = ((drdp_n[1] + drldp) * (hl - h_n[1]) / 2 + (rho_n[1] + rhol) / 2 * dhldp + AA1 * log(rhol / rhov) + AA * (1 / rhol * drldp - 1 / rhov * drvdp) + (drvdp + drdp_n[2]) * (h_n[2] - hv) / 2 - (rhov + rho_n[2]) / 2 * dhvdp) / (h_n[2] - h_n[1]);
    drdh_v1 = (rho_v - (rho_n[1] + rhol) / 2 + drdh_n[1] * (hl - h_n[1]) / 2) / (h_n[2] - h_n[1]);
    drdh_v2 = ((rhov + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
// 2-phase/liquid
    rho_v = (AA * log(rho_n[1] / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
    drdp_v = (AA1 * log(rho_n[1] / rhol) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rhol * drldp) + (drldp + drdp_n[2]) * (h_n[2] - hl) / 2 - (rhol + rho_n[2]) / 2 * dhldp) / (h_n[2] - h_n[1]);
    drdh_v1 = (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
    drdh_v2 = ((rhol + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
  elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
// vapour/2-phase/liquid
    rho_v = ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
    drdp_v = ((drdp_n[1] + drvdp) * (hv - h_n[1]) / 2 + (rho_n[1] + rhov) / 2 * dhvdp + AA1 * log(rhov / rhol) + AA * (1 / rhov * drvdp - 1 / rhol * drldp) + (drldp + drdp_n[2]) * (h_n[2] - hl) / 2 - (rhol + rho_n[2]) / 2 * dhldp) / (h_n[2] - h_n[1]);
    drdh_v1 = (rho_v - (rho_n[1] + rhov) / 2 + drdh_n[1] * (hv - h_n[1]) / 2) / (h_n[2] - h_n[1]);
    drdh_v2 = ((rhol + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
  else
// vapour/2-phase
    rho_v = ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rho_n[2])) / (h_n[2] - h_n[1]);
    drdp_v = ((drdp_n[1] + drvdp) * (hv - h_n[1]) / 2 + (rho_n[1] + rhov) / 2 * dhvdp + AA1 * log(rhov / rho_n[2]) + AA * (1 / rhov * drvdp - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
    drdh_v1 = (rho_v - (rho_n[1] + rhov) / 2 + drdh_n[1] * (hv - h_n[1]) / 2) / (drdp_n[1] - h_n[1]);
//ПОДОЗРИТЕЛЬНАЯ Ф-ЛА!!!
    drdh_v2 = (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
  end if;*/
      for i in 1:2 loop
        stateFlow_n[i] = Medium_F.setState_ph(p_v, h_n[i]);
        drdp_n[i] = Medium_F.density_derp_h(stateFlow_n[i]);
        drdh_n[i] = Medium_F.density_derh_p(stateFlow_n[i]);
        rho_n[i] = Medium_F.density(stateFlow_n[i]);
      end for;
      der_h_n[1] = der(h_n[2]);
      der_h_n[2] = der(h_n[2]);
      sat_v = Medium_F2.setSat_p(p_v);
//Ts = sat_v.Tsat;
      rhol = Medium_F2.bubbleDensity(sat_v);
      rhov = Medium_F2.dewDensity(sat_v);
      hl = Medium_F2.bubbleEnthalpy(sat_v);
      hv = Medium_F2.dewEnthalpy(sat_v);
      drldp = Medium_F2.dBubbleDensity_dPressure(sat_v);
      drvdp = Medium_F2.dDewDensity_dPressure(sat_v);
      dhldp = Medium_F2.dBubbleEnthalpy_dPressure(sat_v);
      dhvdp = Medium_F2.dDewEnthalpy_dPressure(sat_v);
      AA = (hv - hl) / (1 / rhov - 1 / rhol);
      AA1 = ((dhvdp - dhldp) * (rhol - rhov) * rhol * rhov - (hv - hl) * (rhov ^ 2 * drldp - rhol ^ 2 * drvdp)) / (rhol - rhov) ^ 2;
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
//p_v = (p_n[1] + p_n[2]) / 2;
      p_v = p_n[1];
      timeZ = time;
      derpZ = (p_v - pre(p_v)) / max(abs(timeZ - pre(timeZ)), 1e-6);
//Основное уравнение гидравлики
//w_flow_v_av = sum(w_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//rho_v_av = sum(rho_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//Re_flow_av = sum(Re_flow[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//x_v_av = sum(x_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//wrhop = w_flow_v_av * rho_v_av * p_v * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
//Xi_flow = lambda_tr(Din, ke, Re_flow_av) * Lpipe * numberOfFlueSections / zahod / Din;
//phi = phi_heatedPipe(wrhop, p_v / 100000, x_v_av) "Расчет коэффициента phi";
//dp_fric = homotopy(if x_v_av < 1 then w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * phi * (rhol / rhov - 1)) else w_flow_v_av ^ 2 * Xi_flow * rho_v_av / 2 / Modelica.Constants.g_n, 100000 * waterIn.m_flow / setD_flow) "Потеря давления от трения";
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * Lpipe * z2 / zahod / Din;
//dp_fric = w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * 1 * (rhol / rhov - 1));
//dp_fric = w_flow_v ^ 2 * Xi_flow * max(rhol, rho_v) / 2 / Modelica.Constants.g_n;
      dp_fric = w_flow_v ^ 2 * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
      p_n[1] - p_n[2] = dp_fric + dp_piez "Формула 2-1 из книги Рудомино, Ремжин";
      if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
        H_flow[2] = H_flow[1] - hod * deltaHpipe "Расчет высотных отметок для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        H_flow[2] = H_flow[1] + hod * deltaHpipe "Расчет высотных отметок для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        H_flow[2] = H_flow[1] + deltaHpipe * (z2 - 1) "Расчет высотных отметок для вертикального КУ";
      else
        H_flow[2] = H_flow[1] - deltaHpipe * (z2 - 1) "Расчет высотных отметок для вертикального КУ";
      end if;
//dp_piez = (rho_n[2] * H_flow[2] - rho_n[1] * H_flow[1]) * Modelica.Constants.g_n "Расчет перепада давления из-за изменения пьезометрической высоты";
      dp_piez = 0;
//Граничные условия
//Граничные условия для высотной отметки входного коллектора
      if HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        H_flow[1] = 0 "Задание высотной отметки входного коллектора";
      elseif HRSG_type == Choices.HRSG_type.horizontalBottom then
        H_flow[1] = 0 "Задание высотной отметки входного коллектора";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        H_flow[1] = Lpipe "Задание высотной отметки входного коллектора";
      else
        H_flow[1] = deltaHpipe * (numberOfFlueSections - 1) "Задание высотной отметки входного коллектора";
      end if;
      waterIn.m_flow = D_flow_n[1];
      waterOut.m_flow = -D_flow_n[2];
//waterOut.p = p_n[2];
      p_n[2] = waterOut.p + 7.7e6 * D_flow_n[2] / 40;
      waterIn.p = p_n[1];
      h_n[1] = inStream(waterIn.h_outflow);
      waterOut.h_outflow = h_n[2];
      waterIn.h_outflow = h_n[1];
    initial equation
      der(h_v) = 0;
      der(t_m) = 0;
      der(p_v) = 0;
      der(h_n[1]) = 0;
      der(h_n[2]) = 0;
      annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
    end onlyFlowHE_SH_lite;

    model onlyFlowHE_ECO_lite
      //**
      //***Исходные данные для газовой стороны
      //**
      parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      //**
      //***Исходные данные по стороне вода/пар
      //**
      replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
      replaceable package Medium_F2 = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
      constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
      constant Medium_F.AbsolutePressure pc = Medium_F.fluidConstants[1].criticalPressure;
      constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
      parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
      parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
      parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
      //**
      //***Характеристики металла
      parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
      parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
      parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
      //**
      //**
      //Конструктивные характеристики
      //**
      //Параметры
      parameter MyHRSG_lite.Choices.HRSG_type HRSG_type = MyHRSG_lite.Choices.HRSG_type.horizontalBottom "Тип КУ";
      parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberFirstTubeInLastZahod = integer(numberOfFlueSections - zahod + 1) "Номер первой трубы в последнем заходе";
      parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer zahod = 1 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z2 = 2 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
      //Поток вода/пар
      parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 * z2 "Внутренняя площадь одного участка ряда труб";
      parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 * z2 / 4 "Внутренний объем одного участка ряда труб";
      parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 * z2 / 4 "Масса металла участка ряда труб";
      parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 * zahod / 4 "Площадь для прохода теплоносителя";
      parameter Boolean avoidInletEnthalpyDerivative = false "Avoid inlet enthalpy derivative";
      //**
      //Начальные значения
      //**
      //Поток вода/пар
      parameter Medium_F.SpecificEnthalpy h_startFlow_n[2] = fill(seth_in, 2) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.SpecificEnthalpy h_startFlow_v = seth_in "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.AbsolutePressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.AbsolutePressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.MassFlowRate D_startFlow_v = setD_flow "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.MassFlowRate D_startFlow_n[2] = fill(setD_flow, 2) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
      //Металл
      parameter Modelica.SIunits.Temperature t_startM = setTm "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      //**
      //Переменные
      //**
      Modelica.SIunits.Length deltaHpipe "Разность высот на участке ряда труб";
      //Поток вода/пар
      Medium_F.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
      Medium_F.ThermodynamicState stateFlow_n[2] "Термодинамическое состояние потока вода/пар на участках трубопровода";
      //Medium_F2.ThermodynamicState stateFlowTwoPhase[numberOfFlueSections, numberOfTubeSections] "Термодинамическое состояние потока вода/пар на участках трубопровода";
      Medium_F.Temperature t_flow "Температура потока вода/пар по участкам трубы";
      Medium_F.AbsolutePressure p_v(start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
      Medium_F.AbsolutePressure p_n[2](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
      Medium_F.SpecificEnthalpy h_v(start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
      Medium_F.SpecificEnthalpy h_n[2](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
      Real der_h_n[2] "Производняа энтальпии потока вода/пар";
      Medium_F.Density rho_v "Плотность потока по участкам трубы в конечных объемах";
      Medium_F.Density rho_n[2] "Плотность потока по участкам трубы в конечных объемах";
      //Medium_F.Density rho_v_av "Осредненная по заходу плотность потока по участкам трубы в конечных объемах";
      //Medium_F.Density rho_n[2] "Плотность потока по участкам трубы в узловых точках";
      Modelica.SIunits.DerDensityByEnthalpy drdh_v1 "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_v2 "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_n[2] "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_v "Производная плотности потока по давлению на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_n[2] "Производная плотности потока по давлению на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_new;
      Modelica.SIunits.DerDensityByPressure drdp_new;
      Medium_F.MassFlowRate D_flow_v(start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
      Medium_F.MassFlowRate D_flow_n[2](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_eco;
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_sh;
      Medium_F.ThermalConductivity k_flow_eco "Коэффициент теплопроводности для потока вода/пар";
      Medium_F.ThermalConductivity k_flow_sh;
      Medium_F.DynamicViscosity mu_flow_eco "Динамическая вязкость для потока вода/пар";
      Medium_F.DynamicViscosity mu_flow_sh;
      Modelica.SIunits.HeatFlowRate Q_flow "тепло переданное стенке трубы";
      Real Pr_flow_eco "Число Прандтля для потока вода/пар";
      Real Pr_flow_sh;
      Real Re_flow_eco "Число Рейнольдса";
      Real Re_flow_sh;
      //Real Re_flow_av "Число Рейнольдса осредненное по заходу";
      Modelica.SIunits.Temperature t_m(start = t_startM) "Температура металла на участках трубопровода";
      Real C1 "Показатель в числителе уравнения сплошности";
      Real C2 "Показатель в знаменателе уравнения сплошности";
      Real hod "Четность или не четность последнего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
      Modelica.SIunits.Length H_flow[2] "Высотная отметка каждого узла";
      Modelica.SIunits.Velocity w_flow_v "Скорость потока вода/пар в конечных объемах";
      Modelica.SIunits.Velocity w_flow_v_eco;
      Modelica.SIunits.Velocity w_flow_v_sh;
      //Modelica.SIunits.Velocity w_flow_v_av "Средняя по заходу скорость потока вода/пар в конечных объемах";
      Real dp_fric "Потеря давления из-за сил трения";
      Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
      Medium_F2.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
      //Real wrhop "Произведение массовой скорости на давление внутри конечного объема для поправочного коэффициента phi";
      //Real phi "Коэффициент для расчета гидравлического сопротивления двухфазного потока";
      Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
      Real lambda_tr "Коэффициент трения";
      Real x_v "Степень сухости";
      //Real x_v_av "Степень сухости осредненная по заходу";
      Medium_F.Density rhov "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
      Medium_F.Density rhol "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
      //Medium_F.Temperature Ts "Температура на линии насыщения";
      Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
      Modelica.SIunits.DerDensityByPressure drldp;
      Modelica.SIunits.DerDensityByPressure drvdp;
      Modelica.SIunits.DerDensityByEnthalpy dhldp;
      Modelica.SIunits.DerDensityByEnthalpy dhvdp;
      Real AA;
      Real AA1;
      Real timeZ;
      Real derpZ;
      Real A_alfa;
      Real C_alfa;
      //**
      //Интерфейс
      //**
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
        deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
      else
        deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
      end if;
//*****Уравнения для потока вода/пар и металла
      hod = (-1) ^ (z2 / zahod + (if mod(z2, zahod) == 0 then 0 else 1 - mod(z2, zahod) / zahod)) "Расчет четный или нечетный последний ход повехности нагева";
//Уравнения для расчета процессов теплообмена
//Осреднение по конечному объему
      0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
      0.5 * deltaVFlow * rho_v * der_h_n[2] = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
      deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
      heat.Q_flow = Q_flow;
      heat.T = t_m;
//Уравнения состояния
      t_flow = Medium_F.temperature(Medium_F.setState_ph(p_v, h_v));
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
//alfa_flow = if D_flow_n[1] > 0.011 then 0.023 * k_flow / Din * Re_flow ^ 0.8 * Pr_flow ^ 0.4 else 0;
//alfa_flow = 0.023 * k_flow / Din * Re_flow ^ 0.8 * Pr_flow ^ 0.4;
//alfa_flow = if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv) then 0.023 * k_flow / Din * Re_flow ^ 0.8 * Pr_flow ^ 0.4 else 20000;
      A_alfa = min(max((hl - h_n[1]) / max(h_n[2] - h_n[1], 0.01), 0), 1);
      C_alfa = min(max((h_n[2] - hv) / max(h_n[2] - h_n[1], 0.01), 0), 1);
      alfa_flow_eco = 0.023 * k_flow_eco / Din * Re_flow_eco ^ 0.8 * Pr_flow_eco ^ 0.4;
      alfa_flow_sh = 0.023 * k_flow_sh / Din * Re_flow_sh ^ 0.8 * Pr_flow_sh ^ 0.4;
      alfa_flow = ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) * alfa_flow_eco + ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2) * alfa_flow_sh + (1 - ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) - ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2)) * 20000;
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium_F2.setState_ph(p_v, h_v[i, j]);
      x_v = if h_v < hl then 0 elseif h_v > hv then 1 else (h_v - hl) / (hv - hl);
      D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
      D_flow_n[2] = D_flow_n[1] - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
//C1 = deltaVFlow * ((-1e-7) * der_h_n[1] + (-1e-7) * der_h_n[2]);
//C2 = deltaVFlow * 1e-8 * der(p_v);
      C1 = 0;
      C2 = 0;
      drdh_new = if abs(h_n[2] - h_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_v, h_n[2])) - Medium_F.density(Medium_F.setState_ph(p_v, h_n[1]))) / (h_n[2] - h_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_v, h_n[2])) - Medium_F.density(Medium_F.setState_ph(p_v, h_n[2] - 0.01))) / 0.01;
      drdp_new = if abs(p_n[2] - p_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
//if avoidInletEnthalpyDerivative then
// first volume properties computed by the outlet properties
//rho_v = rho_n[2];
//drdp_v = drdp_n[2];
//drdh_v1 = 0;
//drdh_v2 = drdh_n[2];
      if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
// 1-phase or almost uniform properties
        rho_v = (rho_n[1] + rho_n[2]) / 2;
        drdp_v = (drdp_n[1] + drdp_n[2]) / 2;
        drdh_v1 = drdh_n[1] / 2;
        drdh_v2 = drdh_n[2] / 2;
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, h_v));
        k_flow_sh = k_flow_eco;
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, h_v));
        Pr_flow_sh = Pr_flow_eco;
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, h_v)), 1.503e-004);
        mu_flow_sh = mu_flow_eco;
        w_flow_v_eco = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
        Re_flow_sh = Re_flow_eco;
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
// 2-phase
        rho_v = AA * log(rho_n[1] / rho_n[2]) / (h_n[2] - h_n[1]);
        drdp_v = (AA1 * log(rho_n[1] / rho_n[2]) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
        drdh_v2 = (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, h_v));
        k_flow_sh = k_flow_eco;
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, h_v));
        Pr_flow_sh = Pr_flow_eco;
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, h_v)), 1.503e-004);
        mu_flow_sh = mu_flow_eco;
        w_flow_v_eco = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
        Re_flow_sh = Re_flow_eco;
      elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
// liquid/2-phase
        rho_v = ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rho_n[2])) / (h_n[2] - h_n[1]);
        drdp_v = ((drdp_n[1] + drldp) * (hl - h_n[1]) / 2 + (rho_n[1] + rhol) / 2 * dhldp + AA1 * log(rhol / rho_n[2]) + AA * (1 / rhol * drldp - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - (rho_n[1] + rhol) / 2 + drdh_n[1] * (hl - h_n[1]) / 2) / (h_n[2] - h_n[1]);
        drdh_v2 = (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
// 2-phase/vapour
        rho_v = (AA * log(rho_n[1] / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
        drdp_v = (AA1 * log(rho_n[1] / rhov) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rhov * drvdp) + (drvdp + drdp_n[2]) * (h_n[2] - hv) / 2 - (rhov + rho_n[2]) / 2 * dhvdp) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
        drdh_v2 = ((rhov + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
// liquid/2-phase/vapour
        rho_v = ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
        drdp_v = ((drdp_n[1] + drldp) * (hl - h_n[1]) / 2 + (rho_n[1] + rhol) / 2 * dhldp + AA1 * log(rhol / rhov) + AA * (1 / rhol * drldp - 1 / rhov * drvdp) + (drvdp + drdp_n[2]) * (h_n[2] - hv) / 2 - (rhov + rho_n[2]) / 2 * dhvdp) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - (rho_n[1] + rhol) / 2 + drdh_n[1] * (hl - h_n[1]) / 2) / (h_n[2] - h_n[1]);
        drdh_v2 = ((rhov + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        k_flow_sh = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
        Pr_flow_sh = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2])));
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
      elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
// 2-phase/liquid
        rho_v = (AA * log(rho_n[1] / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
        drdp_v = (AA1 * log(rho_n[1] / rhol) + AA * (1 / rho_n[1] * drdp_n[1] - 1 / rhol * drldp) + (drldp + drdp_n[2]) * (h_n[2] - hl) / 2 - (rhol + rho_n[2]) / 2 * dhldp) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - rho_n[1]) / (h_n[2] - h_n[1]);
        drdh_v2 = ((rhol + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
// vapour/2-phase/liquid
        rho_v = ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
        drdp_v = ((drdp_n[1] + drvdp) * (hv - h_n[1]) / 2 + (rho_n[1] + rhov) / 2 * dhvdp + AA1 * log(rhov / rhol) + AA * (1 / rhov * drvdp - 1 / rhol * drldp) + (drldp + drdp_n[2]) * (h_n[2] - hl) / 2 - (rhol + rho_n[2]) / 2 * dhldp) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - (rho_n[1] + rhov) / 2 + drdh_n[1] * (hv - h_n[1]) / 2) / (h_n[2] - h_n[1]);
        drdh_v2 = ((rhol + rho_n[2]) / 2 - rho_v + drdh_n[2] * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      else
// vapour/2-phase
        rho_v = ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rho_n[2])) / (h_n[2] - h_n[1]);
        drdp_v = ((drdp_n[1] + drvdp) * (hv - h_n[1]) / 2 + (rho_n[1] + rhov) / 2 * dhvdp + AA1 * log(rhov / rho_n[2]) + AA * (1 / rhov * drvdp - 1 / rho_n[2] * drdp_n[2])) / (h_n[2] - h_n[1]);
        drdh_v1 = (rho_v - (rho_n[1] + rhov) / 2 + drdh_n[1] * (hv - h_n[1]) / 2) / (h_n[2] - h_n[1]);
//ПОДОЗРИТЕЛЬНАЯ Ф-ЛА!!!
        drdh_v2 = (rho_n[2] - rho_v) / (h_n[2] - h_n[1]);
        k_flow_eco = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        k_flow_sh = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        Pr_flow_eco = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
        Pr_flow_sh = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1])));
        mu_flow_eco = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
        mu_flow_sh = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
        w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
        Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
        Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
      end if;
      for i in 1:2 loop
        stateFlow_n[i] = Medium_F.setState_ph(p_v, h_n[i]);
        drdp_n[i] = Medium_F.density_derp_h(stateFlow_n[i]);
        drdh_n[i] = Medium_F.density_derh_p(stateFlow_n[i]);
        rho_n[i] = Medium_F.density(stateFlow_n[i]);
      end for;
      der_h_n[1] = der(h_n[1]);
      der_h_n[2] = 0;
      sat_v = Medium_F2.setSat_p(p_v);
//Ts = sat_v.Tsat;
      rhol = Medium_F2.bubbleDensity(sat_v);
      rhov = Medium_F2.dewDensity(sat_v);
      hl = Medium_F2.bubbleEnthalpy(sat_v);
      hv = Medium_F2.dewEnthalpy(sat_v);
      drldp = Medium_F2.dBubbleDensity_dPressure(sat_v);
      drvdp = Medium_F2.dDewDensity_dPressure(sat_v);
      dhldp = Medium_F2.dBubbleEnthalpy_dPressure(sat_v);
      dhvdp = Medium_F2.dDewEnthalpy_dPressure(sat_v);
      AA = (hv - hl) / (1 / rhov - 1 / rhol);
      AA1 = ((dhvdp - dhldp) * (rhol - rhov) * rhol * rhov - (hv - hl) * (rhov ^ 2 * drldp - rhol ^ 2 * drvdp)) / (rhol - rhov) ^ 2;
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
//p_v = (p_n[1] + p_n[2]) / 2;
      p_v = p_n[1];
      timeZ = time;
      derpZ = (p_v - pre(p_v)) / max(abs(timeZ - pre(timeZ)), 1e-6);
//Основное уравнение гидравлики
//w_flow_v_av = sum(w_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//rho_v_av = sum(rho_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//Re_flow_av = sum(Re_flow[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//x_v_av = sum(x_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//wrhop = w_flow_v_av * rho_v_av * p_v * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
//Xi_flow = lambda_tr(Din, ke, Re_flow_av) * Lpipe * numberOfFlueSections / zahod / Din;
//phi = phi_heatedPipe(wrhop, p_v / 100000, x_v_av) "Расчет коэффициента phi";
//dp_fric = homotopy(if x_v_av < 1 then w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * phi * (rhol / rhov - 1)) else w_flow_v_av ^ 2 * Xi_flow * rho_v_av / 2 / Modelica.Constants.g_n, 100000 * waterIn.m_flow / setD_flow) "Потеря давления от трения";
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * Lpipe * z2 / zahod / Din;
//dp_fric = w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * 1 * (rhol / rhov - 1));
//dp_fric = w_flow_v ^ 2 * Xi_flow * max(rhol, rho_v) / 2 / Modelica.Constants.g_n;
      dp_fric = w_flow_v ^ 2 * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
//p_n[1] - p_n[2] = dp_fric + dp_piez "Формула 2-1 из книги Рудомино, Ремжин";
      p_n[1] - p_n[2] = dp_fric;
      if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
        H_flow[2] = H_flow[1] - hod * deltaHpipe "Расчет высотных отметок для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        H_flow[2] = H_flow[1] + hod * deltaHpipe "Расчет высотных отметок для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        H_flow[2] = H_flow[1] + deltaHpipe * (z2 - 1) "Расчет высотных отметок для вертикального КУ";
      else
        H_flow[2] = H_flow[1] - deltaHpipe * (z2 - 1) "Расчет высотных отметок для вертикального КУ";
      end if;
      dp_piez = (rho_n[2] * H_flow[2] - rho_n[1] * H_flow[1]) * Modelica.Constants.g_n "Расчет перепада давления из-за изменения пьезометрической высоты";
//Граничные условия
//Граничные условия для высотной отметки входного коллектора
      if HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        H_flow[1] = 0 "Задание высотной отметки входного коллектора";
      elseif HRSG_type == Choices.HRSG_type.horizontalBottom then
        H_flow[1] = 0 "Задание высотной отметки входного коллектора";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        H_flow[1] = Lpipe "Задание высотной отметки входного коллектора";
      else
        H_flow[1] = deltaHpipe * (numberOfFlueSections - 1) "Задание высотной отметки входного коллектора";
      end if;
      waterIn.m_flow = D_flow_n[1];
      waterOut.m_flow = -D_flow_n[2];
      waterOut.p = p_n[2];
      waterIn.p = p_n[1];
      h_n[1] = inStream(waterIn.h_outflow);
      waterOut.h_outflow = h_n[2];
      waterIn.h_outflow = h_n[1];
    initial equation
      der(h_v) = 0;
      der(t_m) = 0;
//der(p_v) = 0;
      der(h_n[1]) = 0;
//der(h_n[2]) = 0;
      annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
    end onlyFlowHE_ECO_lite;

    model onlyFlowHEBoil_lite2
      //**
      //***Исходные данные для газовой стороны
      //**
      parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      //**
      //***Исходные данные по стороне вода/пар
      //**
      replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
      replaceable package Medium_F2 = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
      constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
      constant Medium_F.AbsolutePressure pc = Medium_F.fluidConstants[1].criticalPressure;
      constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
      parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
      parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
      parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
      parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
      //**
      //***Характеристики металла
      parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
      parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
      parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
      //**
      //**
      //Конструктивные характеристики
      //**
      //Параметры
      parameter MyHRSG_lite.Choices.HRSG_type HRSG_type = MyHRSG_lite.Choices.HRSG_type.horizontalBottom "Тип КУ";
      parameter Integer numberOfTubeSections = 1 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections = 1 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberFirstTubeInLastZahod = integer(numberOfFlueSections - zahod + 1) "Номер первой трубы в последнем заходе";
      parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода (число заходов труб)" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfVolumes = 5 "Число участков разбиения";
      parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer zahod = 1 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z2 = 2 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
      //Поток вода/пар
      parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 * z2 / numberOfVolumes "Внутренняя площадь одного участка ряда труб";
      parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 * z2 / 4 / numberOfVolumes "Внутренний объем одного участка ряда труб";
      parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 * z2 / 4 / numberOfVolumes "Масса металла участка ряда труб";
      parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 * zahod / 4 "Площадь для прохода теплоносителя";
      parameter Boolean avoidInletEnthalpyDerivative = false "Avoid inlet enthalpy derivative";
      //**
      //Начальные значения
      //**
      //Поток вода/пар
      parameter Medium_F.SpecificEnthalpy h_startFlow_n[numberOfVolumes + 1] = fill(seth_in, numberOfVolumes + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.SpecificEnthalpy h_startFlow_v[numberOfVolumes] = fill(seth_in, numberOfVolumes) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.AbsolutePressure p_startFlow_v[numberOfVolumes] = fill(setp_flow_in, numberOfVolumes) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.AbsolutePressure p_startFlow_n[numberOfVolumes + 1] = fill(setp_flow_in, numberOfVolumes + 1) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.MassFlowRate D_startFlow_v[numberOfVolumes] = fill(setD_flow, numberOfVolumes) "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_F.MassFlowRate D_startFlow_n[numberOfVolumes + 1] = fill(setD_flow, numberOfVolumes + 1) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
      //Металл
      parameter Modelica.SIunits.Temperature t_startM[numberOfVolumes] = fill(setTm, numberOfVolumes) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      //**
      //Переменные
      //**
      //Modelica.SIunits.Length deltaHpipe "Разность высот на участке ряда труб";
      //Поток вода/пар
      //Medium_F.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
      Medium_F.ThermodynamicState stateFlow_n[numberOfVolumes + 1] "Термодинамическое состояние потока вода/пар на участках трубопровода";
      Medium_F.Temperature t_flow[numberOfVolumes] "Температура потока вода/пар по участкам трубы";
      Medium_F.AbsolutePressure p_v[numberOfVolumes](start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
      Medium_F.AbsolutePressure p_n[numberOfVolumes + 1](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
      Medium_F.SpecificEnthalpy h_v[numberOfVolumes](start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
      Medium_F.SpecificEnthalpy h_n[numberOfVolumes + 1](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
      Real der_h_n[numberOfVolumes + 1] "Производняа энтальпии потока вода/пар";
      Medium_F.Density rho_v[numberOfVolumes] "Плотность потока по участкам трубы в конечных объемах";
      Medium_F.Density rho_n[numberOfVolumes + 1] "Плотность потока по участкам трубы в узловых точках";
      Modelica.SIunits.DerDensityByEnthalpy drdh_v1[numberOfVolumes] "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_v2[numberOfVolumes] "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_n[numberOfVolumes + 1] "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_v[numberOfVolumes] "Производная плотности потока по давлению на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_n[numberOfVolumes + 1] "Производная плотности потока по давлению на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_new[numberOfVolumes];
      Modelica.SIunits.DerDensityByPressure drdp_new[numberOfVolumes];
      Medium_F.MassFlowRate D_flow_v[numberOfVolumes](start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
      Medium_F.MassFlowRate D_flow_n[numberOfVolumes + 1](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow[numberOfVolumes] "Коэффициент теплопередачи со стороны потока вода/пар";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_eco[numberOfVolumes];
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_sh[numberOfVolumes];
      Medium_F.ThermalConductivity k_flow_eco[numberOfVolumes] "Коэффициент теплопроводности для потока вода/пар";
      Medium_F.ThermalConductivity k_flow_sh[numberOfVolumes];
      Medium_F.DynamicViscosity mu_flow_eco[numberOfVolumes] "Динамическая вязкость для потока вода/пар";
      Medium_F.DynamicViscosity mu_flow_sh[numberOfVolumes];
      Modelica.SIunits.HeatFlowRate Q_flow[numberOfVolumes] "тепло переданное стенке трубы";
      Real Pr_flow_eco[numberOfVolumes] "Число Прандтля для потока вода/пар";
      Real Pr_flow_sh[numberOfVolumes];
      Real Re_flow_eco[numberOfVolumes] "Число Рейнольдса";
      Real Re_flow_sh[numberOfVolumes];
      //Real Re_flow_av "Число Рейнольдса осредненное по заходу";
      Modelica.SIunits.Temperature t_m[numberOfVolumes](start = t_startM) "Температура металла на участках трубопровода";
      Real C1[numberOfVolumes] "Показатель в числителе уравнения сплошности";
      Real C2[numberOfVolumes] "Показатель в знаменателе уравнения сплошности";
      //Real hod "Четность или не четность последнего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
      //Modelica.SIunits.Length H_flow[2] "Высотная отметка каждого узла";
      Modelica.SIunits.Velocity w_flow_v[numberOfVolumes] "Скорость потока вода/пар в конечных объемах";
      Modelica.SIunits.Velocity w_flow_v_eco[numberOfVolumes];
      Modelica.SIunits.Velocity w_flow_v_sh[numberOfVolumes];
      Real dp_fric[numberOfVolumes] "Потеря давления из-за сил трения";
      //Real dp_piez[numberOfVolumes] "Перепад давления из-за изменения пьезометрической высоты";
      Medium_F2.SaturationProperties sat_v[numberOfVolumes] "State vector to compute saturation properties внутри конечного объема";
      Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
      Real lambda_tr "Коэффициент трения";
      Real x_v[numberOfVolumes] "Степень сухости";
      Medium_F.Density rhov[numberOfVolumes] "Плотность пара на линии насыщения по участкам трубы в конечных объемах";
      Medium_F.Density rhol[numberOfVolumes] "Плотность  на воды линии насыщения по участкам трубы в конечных объемах";
      Medium_F.SpecificEnthalpy hl[numberOfVolumes] "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv[numberOfVolumes] "Энтальпия пара на линии насыщения";
      Modelica.SIunits.DerDensityByPressure drldp[numberOfVolumes];
      Modelica.SIunits.DerDensityByPressure drvdp[numberOfVolumes];
      Modelica.SIunits.DerDensityByEnthalpy dhldp[numberOfVolumes];
      Modelica.SIunits.DerDensityByEnthalpy dhvdp[numberOfVolumes];
      Real AA[numberOfVolumes];
      Real AA1[numberOfVolumes];
      Real timeZ;
      Real derpZ[numberOfVolumes];
      Real A_alfa[numberOfVolumes];
      Real C_alfa[numberOfVolumes];
      //**
      //Интерфейс
      //**
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat[numberOfVolumes] annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      timeZ = time;
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * Lpipe * z2 / zahod / Din / numberOfVolumes;
/*if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
        deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        deltaHpipe = Lpipe "Разность высотных отметок труб для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
      else
        deltaHpipe = s2 "Разность высотных отметок труб для вертикального КУ";
      end if;*/
//*****Уравнения для потока вода/пар и металла
//hod = (-1) ^ (z2 / zahod + (if mod(z2, zahod) == 0 then 0 else 1 - mod(z2, zahod) / zahod)) "Расчет четный или нечетный последний ход повехности нагева";
      for i in 1:numberOfVolumes loop
//Уравнения для расчета процессов теплообмена
//Осреднение по конечному объему
//deltaVFlow * rho_v[i] * der(h_v[i]) = alfa_flow[i] * deltaSFlow * (t_m[i] - t_flow[i]) - D_flow_v[i] * (h_n[i + 1] - h_n[i]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
//h_v[i] = h_n[i + 1];
        0.5 * deltaVFlow * rho_v[i] * der(h_v[i]) = 0.5 * alfa_flow[i] * deltaSFlow * (t_m[i] - t_flow[i]) - D_flow_v[i] * (h_v[i] - h_n[i]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
        0.5 * deltaVFlow * rho_v[i] * der_h_n[i + 1] = 0.5 * alfa_flow[i] * deltaSFlow * (t_m[i] - t_flow[i]) - D_flow_v[i] * (h_n[i + 1] - h_v[i]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
        deltaMMetal * C_m * der(t_m[i]) = Q_flow[i] - alfa_flow[i] * deltaSFlow * (t_m[i] - t_flow[i]) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
        heat[numberOfVolumes + 1 - i].Q_flow = Q_flow[i];
        heat[numberOfVolumes + 1 - i].T = t_m[i];
//Уравнения состояния
        t_flow[i] = Medium_F.temperature(Medium_F.setState_ph(p_v[i], h_v[i]));
        w_flow_v[i] = D_flow_v[i] / rho_v[i] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
//Расчет коэффициента теплоотдачи
        A_alfa[i] = min(max((hl[i] - h_n[i]) / max(h_n[i + 1] - h_n[i], 0.01), 0), 1);
        C_alfa[i] = min(max((h_n[i + 1] - hv[i]) / max(h_n[i + 1] - h_n[i], 0.01), 0), 1);
        alfa_flow_eco[i] = 0.023 * k_flow_eco[i] / Din * Re_flow_eco[i] ^ 0.8 * Pr_flow_eco[i] ^ 0.4;
        alfa_flow_sh[i] = 0.023 * k_flow_sh[i] / Din * Re_flow_sh[i] ^ 0.8 * Pr_flow_sh[i] ^ 0.4;
        alfa_flow[i] = ((-6 / 3 * A_alfa[i] ^ 3) + 6 / 2 * A_alfa[i] ^ 2) * alfa_flow_eco[i] + ((-6 / 3 * C_alfa[i] ^ 3) + 6 / 2 * C_alfa[i] ^ 2) * alfa_flow_sh[i] + (1 - ((-6 / 3 * A_alfa[i] ^ 3) + 6 / 2 * A_alfa[i] ^ 2) - ((-6 / 3 * C_alfa[i] ^ 3) + 6 / 2 * C_alfa[i] ^ 2)) * 20000;
//Про две фазы
        x_v[i] = if h_v[i] < hl[i] then 0 elseif h_v[i] > hv[i] then 1 else (h_v[i] - hl[i]) / (hv[i] - hl[i]);
        D_flow_v[i] = (D_flow_n[i] + D_flow_n[i + 1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
        D_flow_n[i + 1] = D_flow_n[i] - C1[i] - C2[i] "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
        C1[i] = deltaVFlow * (drdh_v1[i] * der_h_n[i] + drdh_v2[i] * der_h_n[i + 1]);
        C2[i] = deltaVFlow * drdp_v[i] * der(p_v[i]);
//C1[i] = deltaVFlow * drdh_new[i] * der(h_v[i]);
//C2[i] = deltaVFlow * drdp_new[i] * der(p_v[i]);
        drdh_new[i] = if abs(h_n[i + 1] - h_n[i]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_v[i], h_n[i + 1])) - Medium_F.density(Medium_F.setState_ph(p_v[i], h_n[i]))) / (h_n[i + 1] - h_n[i]) else (Medium_F.density(Medium_F.setState_ph(p_v[i], h_n[i + 1])) - Medium_F.density(Medium_F.setState_ph(p_v[i], h_n[i + 1] - 0.01))) / 0.01;
        drdp_new[i] = if abs(p_n[i + 1] - p_n[i]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_n[i + 1], h_v[i])) - Medium_F.density(Medium_F.setState_ph(p_n[i], h_v[i]))) / (p_n[i + 1] - p_n[i]) else (Medium_F.density(Medium_F.setState_ph(p_n[i + 1], h_v[i])) - Medium_F.density(Medium_F.setState_ph(p_n[i + 1] - 0.01, h_v[i]))) / 0.01;
        if noEvent(h_n[i] < hl[i] and h_n[i + 1] < hl[i] or h_n[i] > hv[i] and h_n[i + 1] > hv[i] or p_v[i] >= pc - pzero or abs(h_n[i + 1] - h_n[i]) < hzero) then
// 1-phase or almost uniform properties
          rho_v[i] = (rho_n[i] + rho_n[i + 1]) / 2;
          drdp_v[i] = (drdp_n[i] + drdp_n[i + 1]) / 2;
          drdh_v1[i] = drdh_n[i] / 2;
          drdh_v2[i] = drdh_n[i + 1] / 2;
          k_flow_eco[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], h_v[i]));
          k_flow_sh[i] = k_flow_eco[i];
          Pr_flow_eco[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], h_v[i]));
          Pr_flow_sh[i] = Pr_flow_eco[i];
          mu_flow_eco[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], h_v[i])), 1.503e-004);
          mu_flow_sh[i] = mu_flow_eco[i];
          w_flow_v_eco[i] = D_flow_v[i] / rho_v[i] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh[i] = w_flow_v_eco[i] "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco[i] = abs(w_flow_v_eco[i] * Din * rho_v[i] / mu_flow_eco[i]);
          Re_flow_sh[i] = Re_flow_eco[i];
        elseif noEvent(h_n[i] >= hl[i] and h_n[i] <= hv[i] and h_n[i + 1] >= hl[i] and h_n[i + 1] <= hv[i]) then
// 2-phase
          rho_v[i] = AA[i] * log(rho_n[i] / rho_n[i + 1]) / (h_n[i + 1] - h_n[i]);
          drdp_v[i] = (AA1[i] * log(rho_n[i] / rho_n[i + 1]) + AA[i] * (1 / rho_n[i] * drdp_n[i] - 1 / rho_n[i + 1] * drdp_n[i + 1])) / (h_n[i + 1] - h_n[i]);
          drdh_v1[i] = (rho_v[i] - rho_n[i]) / (h_n[i + 1] - h_n[i]);
          drdh_v2[i] = (rho_n[i + 1] - rho_v[i]) / (h_n[i + 1] - h_n[i]);
          k_flow_eco[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], h_v[i]));
          k_flow_sh[i] = k_flow_eco[i];
          Pr_flow_eco[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], h_v[i]));
          Pr_flow_sh[i] = Pr_flow_eco[i];
          mu_flow_eco[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], h_v[i])), 1.503e-004);
          mu_flow_sh[i] = mu_flow_eco[i];
          w_flow_v_eco[i] = D_flow_v[i] / rho_v[i] / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh[i] = w_flow_v_eco[i] "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco[i] = abs(w_flow_v_eco[i] * Din * rho_v[i] / mu_flow_eco[i]);
          Re_flow_sh[i] = Re_flow_eco[i];
        elseif noEvent(h_n[i] < hl[i] and h_n[i + 1] >= hl[i] and h_n[i + 1] <= hv[i]) then
// liquid/2-phase
          rho_v[i] = ((rho_n[i] + rhol[i]) * (hl[i] - h_n[i]) / 2 + AA[i] * log(rhol[i] / rho_n[i + 1])) / (h_n[i + 1] - h_n[i]);
          drdp_v[i] = ((drdp_n[i] + drldp[i]) * (hl[i] - h_n[i]) / 2 + (rho_n[i] + rhol[i]) / 2 * dhldp[i] + AA1[i] * log(rhol[i] / rho_n[i + 1]) + AA[i] * (1 / rhol[i] * drldp[i] - 1 / rho_n[i + 1] * drdp_n[i + 1])) / (h_n[i + 1] - h_n[i]);
          drdh_v1[i] = (rho_v[i] - (rho_n[i] + rhol[i]) / 2 + drdh_n[i] * (hl[i] - h_n[i]) / 2) / (h_n[i + 1] - h_n[i]);
          drdh_v2[i] = (rho_n[i + 1] - rho_v[i]) / (h_n[i + 1] - h_n[i]);
          k_flow_eco[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i] + hl[i])));
          k_flow_sh[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i + 1])));
          Pr_flow_eco[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i] + hl[i])));
          Pr_flow_sh[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i + 1])));
          mu_flow_eco[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i] + hl[i]))), 1.503e-004);
          mu_flow_sh[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i + 1]))), 1.503e-004);
          w_flow_v_eco[i] = D_flow_v[i] / (0.5 * (rho_n[i] + rhol[i])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh[i] = D_flow_v[i] / (0.5 * (rhov[i] + rho_n[i + 1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco[i] = abs(w_flow_v_eco[i] * Din * 0.5 * (rho_n[i] + rhol[i]) / mu_flow_eco[i]);
          Re_flow_sh[i] = abs(w_flow_v_sh[i] * Din * 0.5 * (rhov[i] + rho_n[i + 1]) / mu_flow_sh[i]);
        elseif noEvent(h_n[i] >= hl[i] and h_n[i] <= hv[i] and h_n[i + 1] > hv[i]) then
// 2-phase/vapour
          rho_v[i] = (AA[i] * log(rho_n[i] / rhov[i]) + (rhov[i] + rho_n[i + 1]) * (h_n[i + 1] - hv[i]) / 2) / (h_n[i + 1] - h_n[i]);
          drdp_v[i] = (AA1[i] * log(rho_n[i] / rhov[i]) + AA[i] * (1 / rho_n[i] * drdp_n[i] - 1 / rhov[i] * drvdp[i]) + (drvdp[i] + drdp_n[i + 1]) * (h_n[i + 1] - hv[i]) / 2 - (rhov[i] + rho_n[i + 1]) / 2 * dhvdp[i]) / (h_n[i + 1] - h_n[i]);
          drdh_v1[i] = (rho_v[i] - rho_n[i]) / (h_n[i + 1] - h_n[i]);
          drdh_v2[i] = ((rhov[i] + rho_n[i + 1]) / 2 - rho_v[i] + drdh_n[i + 1] * (h_n[i + 1] - hv[i]) / 2) / (h_n[i + 1] - h_n[i]);
          k_flow_eco[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i] + hl[i])));
          k_flow_sh[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i + 1])));
          Pr_flow_eco[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i] + hl[i])));
          Pr_flow_sh[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i + 1])));
          mu_flow_eco[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i] + hl[i]))), 1.503e-004);
          mu_flow_sh[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i + 1]))), 1.503e-004);
          w_flow_v_eco[i] = D_flow_v[i] / (0.5 * (rho_n[i] + rhol[i])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh[i] = D_flow_v[i] / (0.5 * (rhov[i] + rho_n[i + 1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco[i] = abs(w_flow_v_eco[i] * Din * 0.5 * (rho_n[i] + rhol[i]) / mu_flow_eco[i]);
          Re_flow_sh[i] = abs(w_flow_v_sh[i] * Din * 0.5 * (rhov[i] + rho_n[i + 1]) / mu_flow_sh[i]);
        elseif noEvent(h_n[i] < hl[i] and h_n[i + 1] > hv[i]) then
// liquid/2-phase/vapour
          rho_v[i] = ((rho_n[i] + rhol[i]) * (hl[i] - h_n[i]) / 2 + AA[i] * log(rhol[i] / rhov[i]) + (rhov[i] + rho_n[i + 1]) * (h_n[i + 1] - hv[i]) / 2) / (h_n[i + 1] - h_n[i]);
          drdp_v[i] = ((drdp_n[i] + drldp[i]) * (hl[i] - h_n[i]) / 2 + (rho_n[i] + rhol[i]) / 2 * dhldp[i] + AA1[i] * log(rhol[i] / rhov[i]) + AA[i] * (1 / rhol[i] * drldp[i] - 1 / rhov[i] * drvdp[i]) + (drvdp[i] + drdp_n[i + 1]) * (h_n[i + 1] - hv[i]) / 2 - (rhov[i] + rho_n[i + 1]) / 2 * dhvdp[i]) / (h_n[i + 1] - h_n[i]);
          drdh_v1[i] = (rho_v[i] - (rho_n[i] + rhol[i]) / 2 + drdh_n[i] * (hl[i] - h_n[i]) / 2) / (h_n[i + 1] - h_n[i]);
          drdh_v2[i] = ((rhov[i] + rho_n[i + 1]) / 2 - rho_v[i] + drdh_n[i + 1] * (h_n[i + 1] - hv[i]) / 2) / (h_n[i + 1] - h_n[i]);
          k_flow_eco[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i] + hl[i])));
          k_flow_sh[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i + 1])));
          Pr_flow_eco[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i] + hl[i])));
          Pr_flow_sh[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i + 1])));
          mu_flow_eco[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i] + hl[i]))), 1.503e-004);
          mu_flow_sh[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i + 1]))), 1.503e-004);
          w_flow_v_eco[i] = D_flow_v[i] / (0.5 * (rho_n[i] + rhol[i])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh[i] = D_flow_v[i] / (0.5 * (rhov[i] + rho_n[i + 1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco[i] = abs(w_flow_v_eco[i] * Din * 0.5 * (rho_n[i] + rhol[i]) / mu_flow_eco[i]);
          Re_flow_sh[i] = abs(w_flow_v_sh[i] * Din * 0.5 * (rhov[i] + rho_n[i + 1]) / mu_flow_sh[i]);
        elseif noEvent(h_n[i] >= hl[i] and h_n[i] <= hv[i] and h_n[i + 1] < hl[i]) then
// 2-phase/liquid
          rho_v[i] = (AA[i] * log(rho_n[i] / rhol[i]) + (rhol[i] + rho_n[i + 1]) * (h_n[i + 1] - hl[i]) / 2) / (h_n[i + 1] - h_n[i]);
          drdp_v[i] = (AA1[i] * log(rho_n[i] / rhol[i]) + AA[i] * (1 / rho_n[i] * drdp_n[i] - 1 / rhol[i] * drldp[i]) + (drldp[i] + drdp_n[i + 1]) * (h_n[i + 1] - hl[i]) / 2 - (rhol[i] + rho_n[i + 1]) / 2 * dhldp[i]) / (h_n[i + 1] - h_n[i]);
          drdh_v1[i] = (rho_v[i] - rho_n[i]) / (h_n[i + 1] - h_n[i]);
          drdh_v2[i] = ((rhol[i] + rho_n[i + 1]) / 2 - rho_v[i] + drdh_n[i + 1] * (h_n[i + 1] - hl[i]) / 2) / (h_n[i + 1] - h_n[i]);
          k_flow_eco[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i + 1] + hl[i])));
          k_flow_sh[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i])));
          Pr_flow_eco[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i + 1] + hl[i])));
          Pr_flow_sh[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i])));
          mu_flow_eco[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i + 1] + hl[i]))), 1.503e-004);
          mu_flow_sh[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i]))), 1.503e-004);
          w_flow_v_eco[i] = D_flow_v[i] / (0.5 * (rho_n[i + 1] + rhol[i])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh[i] = D_flow_v[i] / (0.5 * (rhov[i] + rho_n[i])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco[i] = abs(w_flow_v_eco[i] * Din * 0.5 * (rho_n[i + 1] + rhol[i]) / mu_flow_eco[i]);
          Re_flow_sh[i] = abs(w_flow_v_sh[i] * Din * 0.5 * (rhov[i] + rho_n[i]) / mu_flow_sh[i]);
        elseif noEvent(h_n[i] > hv[i] and h_n[i + 1] < hl[i]) then
// vapour/2-phase/liquid
          rho_v[i] = ((rho_n[i] + rhov[i]) * (hv[i] - h_n[i]) / 2 + AA[i] * log(rhov[i] / rhol[i]) + (rhol[i] + rho_n[i + 1]) * (h_n[i + 1] - hl[i]) / 2) / (h_n[i + 1] - h_n[i]);
          drdp_v[i] = ((drdp_n[i] + drvdp[i]) * (hv[i] - h_n[i]) / 2 + (rho_n[i] + rhov[i]) / 2 * dhvdp[i] + AA1[i] * log(rhov[i] / rhol[i]) + AA[i] * (1 / rhov[i] * drvdp[i] - 1 / rhol[i] * drldp[i]) + (drldp[i] + drdp_n[i + 1]) * (h_n[i + 1] - hl[i]) / 2 - (rhol[i] + rho_n[i + 1]) / 2 * dhldp[i]) / (h_n[i + 1] - h_n[i]);
          drdh_v1[i] = (rho_v[i] - (rho_n[i] + rhov[i]) / 2 + drdh_n[i] * (hv[i] - h_n[i]) / 2) / (h_n[i + 1] - h_n[i]);
          drdh_v2[i] = ((rhol[i] + rho_n[i + 1]) / 2 - rho_v[i] + drdh_n[i + 1] * (h_n[i + 1] - hl[i]) / 2) / (h_n[i + 1] - h_n[i]);
          k_flow_eco[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i + 1] + hl[i])));
          k_flow_sh[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i])));
          Pr_flow_eco[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i + 1] + hl[i])));
          Pr_flow_sh[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i])));
          mu_flow_eco[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i + 1] + hl[i]))), 1.503e-004);
          mu_flow_sh[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i]))), 1.503e-004);
          w_flow_v_eco[i] = D_flow_v[i] / (0.5 * (rho_n[i + 1] + rhol[i])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh[i] = D_flow_v[i] / (0.5 * (rhov[i] + rho_n[i])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco[i] = abs(w_flow_v_eco[i] * Din * 0.5 * (rho_n[i + 1] + rhol[i]) / mu_flow_eco[i]);
          Re_flow_sh[i] = abs(w_flow_v_sh[i] * Din * 0.5 * (rhov[i] + rho_n[i]) / mu_flow_sh[i]);
        else
// vapour/2-phase
          rho_v[i] = ((rho_n[i] + rhov[i]) * (hv[i] - h_n[i]) / 2 + AA[i] * log(rhov[i] / rho_n[i + 1])) / (h_n[i + 1] - h_n[i]);
          drdp_v[i] = ((drdp_n[i] + drvdp[i]) * (hv[i] - h_n[i]) / 2 + (rho_n[i] + rhov[i]) / 2 * dhvdp[i] + AA1[i] * log(rhov[i] / rho_n[i + 1]) + AA[i] * (1 / rhov[i] * drvdp[i] - 1 / rho_n[i + 1] * drdp_n[i + 1])) / (h_n[i + 1] - h_n[i]);
          drdh_v1[i] = (rho_v[i] - (rho_n[i] + rhov[i]) / 2 + drdh_n[i] * (hv[i] - h_n[i]) / 2) / (h_n[i + 1] - h_n[i]);
//ПОДОЗРИТЕЛЬНАЯ Ф-ЛА!!!
          drdh_v2[i] = (rho_n[i + 1] - rho_v[i]) / (h_n[i + 1] - h_n[i]);
          k_flow_eco[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i + 1] + hl[i])));
          k_flow_sh[i] = Medium_F.thermalConductivity(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i])));
          Pr_flow_eco[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i + 1] + hl[i])));
          Pr_flow_sh[i] = Medium_F.prandtlNumber(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i])));
          mu_flow_eco[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], 0.5 * (h_n[i + 1] + hl[i]))), 1.503e-004);
          mu_flow_sh[i] = max(Medium_F.dynamicViscosity(Medium_F.setState_ph(p_v[i], 0.5 * (hv[i] + h_n[i + 1]))), 1.503e-004);
          w_flow_v_eco[i] = D_flow_v[i] / (0.5 * (rho_n[i + 1] + rhol[i])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh[i] = D_flow_v[i] / (0.5 * (rhov[i] + rho_n[i])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco[i] = abs(w_flow_v_eco[i] * Din * 0.5 * (rho_n[i + 1] + rhol[i]) / mu_flow_eco[i]);
          Re_flow_sh[i] = abs(w_flow_v_sh[i] * Din * 0.5 * (rhov[i] + rho_n[i]) / mu_flow_sh[i]);
        end if;
        sat_v[i] = Medium_F2.setSat_p(p_v[i]);
//Ts = sat_v.Tsat;
        rhol[i] = Medium_F2.bubbleDensity(sat_v[i]);
        rhov[i] = Medium_F2.dewDensity(sat_v[i]);
        hl[i] = Medium_F2.bubbleEnthalpy(sat_v[i]);
        hv[i] = Medium_F2.dewEnthalpy(sat_v[i]);
        drldp[i] = Medium_F2.dBubbleDensity_dPressure(sat_v[i]);
        drvdp[i] = Medium_F2.dDewDensity_dPressure(sat_v[i]);
        dhldp[i] = Medium_F2.dBubbleEnthalpy_dPressure(sat_v[i]);
        dhvdp[i] = Medium_F2.dDewEnthalpy_dPressure(sat_v[i]);
        AA[i] = (hv[i] - hl[i]) / (1 / rhov[i] - 1 / rhol[i]);
        AA1[i] = ((dhvdp[i] - dhldp[i]) * (rhol[i] - rhov[i]) * rhol[i] * rhov[i] - (hv[i] - hl[i]) * (rhov[i] ^ 2 * drldp[i] - rhol[i] ^ 2 * drvdp[i])) / (rhol[i] - rhov[i]) ^ 2;
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
//p_v = (p_n[1] + p_n[2]) / 2;
        p_v[i] = p_n[i];
        derpZ[i] = (p_v[i] - pre(p_v[i])) / max(abs(timeZ - pre(timeZ)), 1e-6);
//Основное уравнение гидравлики
//w_flow_v_av = sum(w_flow_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//rho_v_av = sum(rho_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//Re_flow_av = sum(Re_flow[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//x_v_av = sum(x_v[i, j] for i in 1:numberOfFlueSections, j in 1:numberOfTubeSections) / numberOfFlueSections / numberOfTubeSections;
//wrhop = w_flow_v_av * rho_v_av * p_v * 10 ^ (-5) "Произведение wrhop для расчета phi [кг/(м2*с)*кгс/см2]";
//Xi_flow = lambda_tr(Din, ke, Re_flow_av) * Lpipe * numberOfFlueSections / zahod / Din;
//phi = phi_heatedPipe(wrhop, p_v / 100000, x_v_av) "Расчет коэффициента phi";
//dp_fric = homotopy(if x_v_av < 1 then w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * phi * (rhol / rhov - 1)) else w_flow_v_av ^ 2 * Xi_flow * rho_v_av / 2 / Modelica.Constants.g_n, 100000 * waterIn.m_flow / setD_flow) "Потеря давления от трения";
//dp_fric = w_flow_v_av ^ 2 * Xi_flow * max(rhol, rho_v_av) / 2 / Modelica.Constants.g_n * (1 + x_v_av * 1 * (rhol / rhov - 1));
//dp_fric = w_flow_v ^ 2 * Xi_flow * max(rhol, rho_v) / 2 / Modelica.Constants.g_n;
        dp_fric[i] = w_flow_v[i] ^ 2 * Xi_flow * rho_v[i] / 2 / Modelica.Constants.g_n;
//p_n[1] - p_n[2] = dp_fric + dp_piez "Формула 2-1 из книги Рудомино, Ремжин";
        p_n[i] - p_n[i + 1] = dp_fric[i];
      end for;
/*if HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
        H_flow[2] = H_flow[1] - hod * deltaHpipe "Расчет высотных отметок для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        H_flow[2] = H_flow[1] + hod * deltaHpipe "Расчет высотных отметок для горизонтального КУ";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        H_flow[2] = H_flow[1] + deltaHpipe * (z2 - 1) "Расчет высотных отметок для вертикального КУ";
      else
        H_flow[2] = H_flow[1] - deltaHpipe * (z2 - 1) "Расчет высотных отметок для вертикального КУ";
      end if;*/
//dp_piez = (rho_n[2] * H_flow[2] - rho_n[1] * H_flow[1]) * Modelica.Constants.g_n "Расчет перепада давления из-за изменения пьезометрической высоты";
      for i in 1:numberOfVolumes + 1 loop
        stateFlow_n[i] = Medium_F.setState_ph(p_n[i], h_n[i]);
        drdp_n[i] = Medium_F.density_derp_h(stateFlow_n[i]);
        drdh_n[i] = Medium_F.density_derh_p(stateFlow_n[i]);
        rho_n[i] = Medium_F.density(stateFlow_n[i]);
        der_h_n[i] = der(h_n[i]);
      end for;
//Граничные условия
//Граничные условия для высотной отметки входного коллектора
/*if HRSG_type == MyHRSG_lite.Choices.HRSG_type.verticalBottom then
        H_flow[1] = 0 "Задание высотной отметки входного коллектора";
      elseif HRSG_type == Choices.HRSG_type.horizontalBottom then
        H_flow[1] = 0 "Задание высотной отметки входного коллектора";
      elseif HRSG_type == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
        H_flow[1] = Lpipe "Задание высотной отметки входного коллектора";
      else
        H_flow[1] = deltaHpipe * (numberOfFlueSections - 1) "Задание высотной отметки входного коллектора";
      end if;*/
      waterIn.m_flow = D_flow_n[1];
      waterOut.m_flow = -D_flow_n[numberOfVolumes + 1];
      waterOut.p = p_n[numberOfVolumes + 1];
      waterIn.p = p_n[1];
      h_n[1] = inStream(waterIn.h_outflow);
      waterOut.h_outflow = h_n[numberOfVolumes + 1];
      waterIn.h_outflow = h_n[1];
    initial equation
      for i in 1:numberOfVolumes loop
        der(h_v[i]) = 0;
        der(t_m[i]) = 0;
        der(p_v[i]) = 0;
      end for;
      for i in 2:numberOfVolumes + 1 loop
        der(h_n[i]) = 0;
      end for;
      annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
    end onlyFlowHEBoil_lite2;

    model onlyGasHE_lite2
      function positiveMax
        extends Modelica.Icons.Function;
        input Real x;
        output Real y;
      algorithm
        y := max(x, 1e-10);
      end positiveMax;

      //**
      //***Исходные данные для газовой стороны
      //**
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate setD_gas = 509 "Номинальный (и начальный) массовый расход газов" annotation(Dialog(group = "Параметры стороны газов"));
      parameter Modelica.SIunits.Pressure setp_gas = 3e3 "Начальное давление газов" annotation(Dialog(group = "Параметры стороны газов"));
      parameter Modelica.SIunits.Temperature setT_inGas = 184 + 273.15 "Начальная входная температура газов" annotation(Dialog(group = "Параметры стороны газов"));
      parameter Modelica.SIunits.Temperature setT_outGas = 170 + 273.15 "Начальная выходная температура газов" annotation(Dialog(group = "Параметры стороны газов"));
      parameter Medium_G.MassFraction setX_gas[Medium_G.nXi] = Medium_G.reference_X;
      parameter Real k_alfaGas = 1 "Поправка к коэффициенту теплоотдачи со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
      //**
      //Конструктивные характеристики
      //**
      //Параметры
      parameter Integer numberOfTubeSections = 10 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfVolumes = 2 "Число участков разбиения";
      parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Diameter Dout = Din + 2 * delta "Наружный диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer zahod = numberOfFlueSections "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z1 = 79 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length Hpipe = Lpipe "Разность высотных отметов выхода и входа теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Real Xi_flow = 0.3 "Коэффициент гидравлического сопротивления участка трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length omega = Modelica.Constants.pi * Dout "Наружный периметр трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      //Поток газов
      parameter Modelica.SIunits.Volume deltaVGas = z2 * Lpipe * (s1 * s2 * z1 - Modelica.Constants.pi * Dout ^ 2 / 4) / numberOfVolumes "Объем одного участка газового тракта";
      parameter Modelica.SIunits.Area deltaSGas = Lpipe * Modelica.Constants.pi * Dout * z1 / numberOfVolumes "Наружная площадь одного участка ряда труб";
      parameter Modelica.SIunits.Area f_gas = (1 - Dout / s1 * (1 + 2 * hfin * delta_fin / sfin / Dout)) * Lpipe * s2 * z1 "Площадь для прохода газов на одном участке разбиения";
      //**
      //Характеристики оребрения
      //
      parameter Modelica.SIunits.Length delta_fin = 0.0009 "Средняя толщина ребра, м" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Modelica.SIunits.Length hfin = 0.014 "Высота ребра, м" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Modelica.SIunits.Length sfin = 0.004 "Шаг ребер, м" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Modelica.SIunits.Length Dfin = Dout + 2 * hfin "Диаметр ребер, м" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real psi_fin = 1 / (2 * Dout * sfin) * (Dfin ^ 2 - Dout ^ 2 + 2 * Dfin * delta_fin) + 1 - delta_fin / sfin "Коэффициент оребрения, равный отношению полной поверхности пучка к поверхности несущих труб на оребренном участке" annotation(Dialog(group = "Характеристики оребрения"));
      //формула 7.22а нормативного метода
      parameter Real sigma1 = s1 / Dout "Относительный поперечный шаг" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real sigma2 = s2 / Dout "Относительный продольный шаг" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real sigma3 = sqrt(0.25 * sigma1 ^ 2 + sigma2) "Средний относительный диагональный шаг труб" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real xfin = sigma1 / sigma2 - 1.26 / psi_fin - 2 "Параметр 'x' для шахматного пучка" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real phi_fin = Modelica.Math.tanh(xfin) "Некий параметр 'фи'" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real n_fin = 0.7 + 0.08 * phi_fin + 0.005 * psi_fin "Показатель степени 'n' в формуле коэффициента теплоотдачи" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real Cs = (1.36 - phi_fin) * (11 / (psi_fin + 8) - 0.14) "Коэффициент, определяемый в зависимости от от относительного поперечного и продольного шага труб в пучке, типа пучка и коэффициента оребрения";
      parameter Real Cz = if z2 < 8 and sigma1 / sigma2 < 2 then 3.15 * z2 ^ 0.05 - 2.5 elseif z2 < 8 and sigma1 / sigma2 >= 2 then 3.5 * z2 ^ 0.03 - 2.72 else 1 "Поправка на число рядов труб по ходу газов";
      parameter Real H_fin = (omega * Lpipe * (1 - delta_fin / sfin) + 2 * Modelica.Constants.pi * (Dfin ^ 2 - Dout ^ 2) / 4 + Modelica.Constants.pi * Dfin * delta_fin * (Lpipe / sfin)) * z1 * z2 / numberOfVolumes "Площадь оребренной поверхности";
      //**
      //Начальные значения
      //**
      //Поток газов
      parameter Medium_G.SpecificEnthalpy h_startGas[numberOfVolumes + 1] = fill(Medium_G.specificEnthalpy_pTX(setp_gas, setT_inGas, setX_gas), numberOfVolumes + 1) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_G.SpecificEnthalpy h_v_startGas[numberOfVolumes] = fill(Medium_G.specificEnthalpy_pTX(setp_gas, setT_inGas, setX_gas), numberOfVolumes);
      parameter Medium_G.AbsolutePressure p_startGas[2] = fill(setp_gas, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
      //**
      //Переменные
      //**
      //Поток газов
      Medium_G.BaseProperties gas[numberOfVolumes];
      Medium_G.SpecificEnthalpy h_gas[numberOfVolumes + 1](start = h_startGas) "Энтальпия потока вода/пар по участкам трубы";
      //Medium_G.SpecificEnthalpy h_gas_v[numberOfVolumes](start = h_v_startGas) "Энтальпия потока вода/пар по участкам трубы";
      Medium_G.Temperature t_gas[numberOfVolumes](start = setT_inGas) "Температура потока газов по участкам трубы";
      Medium_G.MassFlowRate deltaDGas[numberOfVolumes + 1](start = fill(setD_gas, numberOfVolumes + 1)) "Расход газов через участок газохода";
      Medium_G.DynamicViscosity mu[numberOfVolumes] "Динамическая вязкость газов";
      Medium_G.ThermalConductivity k[numberOfVolumes] "Коэффициент теплопроводности газов";
      Medium_G.SpecificHeatCapacity cp[numberOfVolumes] "Изобарная теплоемкость газов";
      Modelica.SIunits.PerUnit Re[numberOfVolumes] "Число Рейнольдса";
      Medium_G.PrandtlNumber Pr[numberOfVolumes] "Число Прандтля";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_gas[numberOfVolumes] "Коэффициент теплопередачи со стороны потока газов";
      //**
      //Интерфейс
      //**
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat[numberOfVolumes] annotation(Placement(visible = false, transformation(origin = {0, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0), iconTransformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(extent = {{80, -20}, {120, 20}}, rotation = 0), iconTransformation(extent = {{100, -20}, {140, 20}}, rotation = 0)));
    equation
      for i in 1:numberOfVolumes loop
//*****Уравнения для потока газов
        deltaVGas * gas[i].d * der(h_gas[i + 1]) = deltaDGas[i] * (h_gas[i] - h_gas[i + 1]) + heat[i].Q_flow "Уавнение теплового баланса газов (формула 3-15 диссертации Рубашкина)";
//0.5 * deltaVGas * gas[i].d * der(h_gas_v[i]) = deltaDGas[i] * (h_gas[i] - h_gas_v[i]) + 0.5 * heat[i].Q_flow;
//0.5 * deltaVGas * gas[i].d * der(h_gas[i+1]) = deltaDGas[i] * (h_gas_v[i] - h_gas[i]) + 0.5 * heat[i].Q_flow;
        heat[i].Q_flow = -alfa_gas[i] * H_fin * (t_gas[i] - heat[i].T);
//Уравнения состояния
        gas[i].h = h_gas[i + 1];
        gas[i].p = gasIn.p;
        gas[i].X = setX_gas;
        gas[i].T = t_gas[i];
        deltaDGas[i] = deltaDGas[i + 1];
//Коэффициент теплоотдачи
        mu[i] = Medium_G.dynamicViscosity(gas[i].state);
        k[i] = Medium_G.thermalConductivity(gas[i].state);
        cp[i] = Medium_G.heatCapacity_cp(gas[i].state);
        Re[i] = abs(deltaDGas[i] * Dout / (f_gas * mu[i]));
        Pr[i] = Medium_G.prandtlNumber(gas[i].state);
        alfa_gas[i] = k_alfaGas * 0.113 * Cs * Cz * k[i] / Dout * Re[i] ^ n_fin * Pr[i] ^ 0.33;
//Граничные условия
      end for;
//Граничные условия
      gasIn.h_outflow = h_gas[1];
      gasOut.h_outflow = h_gas[numberOfVolumes + 1];
      h_gas[1] = inStream(gasIn.h_outflow);
      gasIn.Xi_outflow = inStream(gasOut.Xi_outflow);
      inStream(gasIn.Xi_outflow) = gasOut.Xi_outflow;
      gasIn.m_flow - deltaDGas[1] = 0;
      gasOut.m_flow + deltaDGas[numberOfVolumes + 1] = 0;
      gasOut.p = gasIn.p;
    initial equation
      for i in 1:numberOfVolumes loop
        der(h_gas[i + 1]) = 0;
//der(h_gas_v[i]) = 0;
      end for;
      annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-100, -115}, {100, -145}}, lineColor = {85, 170, 255}, textString = "%name")}));
    end onlyGasHE_lite2;

    model GF_HE_lite2
      extends HE_Icon;
      parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      //***Исходные данные для газовой стороны
      //**
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas "Номинальный (и начальный) массовый расход газов";
      parameter Modelica.SIunits.Pressure pgas "Начальное давление газов";
      parameter Modelica.SIunits.Temperature Tingas "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas "Начальная выходная температура газов";
      //parameter Modelica.SIunits.Temperature T2gas = (Tingas + Toutgas) / 2 "Промежуточная температура газов";
      parameter Real k_gamma_gas "Поправка к коэффициенту теплоотдачи со стороны газов";
      parameter Real Set_X[6] "Состав дымовых газов";
      //**
      //***Исходные данные для водяной стороны
      //**
      replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wflow "Номинальный массовый расход воды/пар";
      parameter Modelica.SIunits.Pressure pflow_in "Начальное давление потока вода/пар на входе";
      parameter Modelica.SIunits.Pressure pflow_out "Начальное давление потока вода/пар на выходе";
      parameter Modelica.SIunits.Temperature Tinflow "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
      parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
      parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
      //**
      //***Исходные данные по разбиению
      //**
      parameter Integer numberOfTubeSections = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfVolumes = 2 "Число участков разбиения";
      //**
      //***конструктивные характеристики
      //**
      parameter MyHRSG_lite.Choices.HRSG_type HRSG_type_set = Choices.HRSG_type.horizontalBottom "Выбор типа КУ (горизонтальный/вертикальный)";
      parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг";
      parameter Integer zahod = 1 "заходность труб теплообменника";
      parameter Integer z1 = 126 "Число труб по ширине газохода";
      parameter Integer z2 = 4 "Число труб по ходу газов в теплообменнике";
      parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки";
      ///Оребрение
      parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м";
      ////
      //////
      ////
      Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      onlyGasHE_lite2 gasHE(redeclare package Medium_G = Medium_G, setD_gas = wgas, setp_gas = pgas, setT_inGas = Tingas, setT_outGas = Toutflow, k_alfaGas = k_gamma_gas, numberOfTubeSections = numberOfTubeSections, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe, delta_fin = delta_fin, hfin = hfin, sfin = sfin, numberOfVolumes = numberOfVolumes) annotation(Placement(visible = true, transformation(origin = {0, 50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
      replaceable onlyFlowHEBoil_lite2 flowHE(setD_flow = wflow, setp_flow_in = pflow_in, setp_flow_out = pflow_out, setT_inFlow = Tinflow, setT_outFlow = Toutflow, numberOfTubeSections = numberOfTubeSections, numberPMCalcSections = numberPMCalcSections, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe, seth_in = seth_in, seth_out = seth_out, HRSG_type = HRSG_type_set, setTm = setTm, m_flow_small = m_flow_small, numberOfVolumes = numberOfVolumes) annotation(Placement(visible = true, transformation(origin = {0, -50}, extent = {{-30, -30}, {30, 30}}, rotation = 90)));
    equation
      connect(gasHE.gasOut, gasOut) annotation(Line(points = {{36, 50}, {92, 50}, {92, 48}, {92, 48}}, color = {0, 127, 255}));
      connect(gasIn, gasHE.gasIn) annotation(Line(points = {{-90, 50}, {-34, 50}, {-34, 48}, {-34, 48}}));
      connect(flowHE.heat, gasHE.heat);
      connect(flowHE.waterOut, flowOut) annotation(Line(points = {{36, -50}, {94, -50}, {94, -50}, {94, -50}}, color = {0, 127, 255}));
      connect(flowIn, flowHE.waterIn) annotation(Line(points = {{-90, -50}, {-34, -50}, {-34, -50}, {-34, -50}}));
      annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), version = "", uses);
    end GF_HE_lite2;

    model GF_HE_lite3
      extends HE_Icon;
      parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      //***Исходные данные для газовой стороны
      //**
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas "Номинальный (и начальный) массовый расход газов";
      parameter Modelica.SIunits.Pressure pgas "Начальное давление газов";
      parameter Modelica.SIunits.Temperature Tingas "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas "Начальная выходная температура газов";
      //parameter Modelica.SIunits.Temperature T2gas = (Tingas + Toutgas) / 2 "Промежуточная температура газов";
      parameter Real k_gamma_gas "Поправка к коэффициенту теплоотдачи со стороны газов";
      parameter Real Set_X[6] "Состав дымовых газов";
      //**
      //***Исходные данные для водяной стороны
      //**
      replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wflow "Номинальный массовый расход воды/пар";
      parameter Modelica.SIunits.Pressure pflow_in "Начальное давление потока вода/пар на входе";
      parameter Modelica.SIunits.Pressure pflow_out "Начальное давление потока вода/пар на выходе";
      parameter Modelica.SIunits.Temperature Tinflow "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
      parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
      parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
      //**
      //***Исходные данные по разбиению
      //**
      parameter Integer numberOfTubeSections = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfVolumes = 2 "Число участков разбиения";
      //**
      //***конструктивные характеристики
      //**
      parameter MyHRSG_lite.Choices.HRSG_type HRSG_type_set = Choices.HRSG_type.horizontalBottom "Выбор типа КУ (горизонтальный/вертикальный)";
      parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг";
      parameter Integer zahod = 1 "заходность труб теплообменника";
      parameter Integer z1 = 126 "Число труб по ширине газохода";
      parameter Integer z2 = 4 "Число труб по ходу газов в теплообменнике";
      parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки";
      ///Оребрение
      parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м";
      ////
      //////
      ////
      Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      onleGasHE_lite gasHE[numberOfVolumes](redeclare package Medium_G = Medium_G, setD_gas = wgas, setp_gas = pgas, setT_inGas = Tingas, setT_outGas = Toutflow, k_alfaGas = k_gamma_gas, numberOfTubeSections = numberOfTubeSections, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe / numberOfVolumes, delta_fin = delta_fin, hfin = hfin, sfin = sfin) annotation(Placement(visible = true, transformation(origin = {0, 50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
      replaceable onlyFlowHE_lite flowHE[numberOfVolumes](setD_flow = wflow, setp_flow_in = pflow_in, setp_flow_out = pflow_out, setT_inFlow = Tinflow, setT_outFlow = Toutflow, numberOfTubeSections = numberOfTubeSections, numberPMCalcSections = numberPMCalcSections, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe / numberOfVolumes, seth_in = seth_in, seth_out = seth_out, HRSG_type = HRSG_type_set, setTm = setTm, m_flow_small = m_flow_small) annotation(Placement(visible = true, transformation(origin = {0, -50}, extent = {{-30, -30}, {30, 30}}, rotation = 90)));
    equation
      for i in 1:numberOfVolumes - 1 loop
        connect(gasHE[i].gasOut, gasHE[i + 1].gasIn) annotation(Line(points = {{36, 50}, {92, 50}, {92, 48}, {92, 48}}, color = {0, 127, 255}));
        connect(flowHE[i].waterOut, flowHE[i + 1].waterIn) annotation(Line(points = {{36, -50}, {94, -50}, {94, -50}, {94, -50}}, color = {0, 127, 255}));
      end for;
      for i in 1:numberOfVolumes loop
        connect(flowHE[i].heat, gasHE[numberOfVolumes + 1 - i].heat);
      end for;
      connect(gasHE[numberOfVolumes].gasOut, gasOut) annotation(Line(points = {{36, 50}, {92, 50}, {92, 48}, {92, 48}}, color = {0, 127, 255}));
      connect(gasIn, gasHE[1].gasIn) annotation(Line(points = {{-90, 50}, {-34, 50}, {-34, 48}, {-34, 48}}));
      connect(flowHE[numberOfVolumes].waterOut, flowOut) annotation(Line(points = {{36, -50}, {94, -50}, {94, -50}, {94, -50}}, color = {0, 127, 255}));
      connect(flowIn, flowHE[1].waterIn) annotation(Line(points = {{-90, -50}, {-34, -50}, {-34, -50}, {-34, -50}}));
      annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), version = "", uses);
    end GF_HE_lite3;
  end liteModels;

  package cleanCopy
    model flowSide_OTE
      extends BaseClases.flowSideHE(redeclare replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
      import MyHRSG_lite.cleanCopy.functions.alfaFor2ph;
      import MyHRSG_lite.cleanCopy.functions.calc_rho_v;
      //Переменные
      Modelica.SIunits.DerDensityByEnthalpy drdh_new;
      Modelica.SIunits.DerDensityByPressure drdp_new;
      Medium_F.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
      Real x_v "Степень сухости";
      Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
      Real dp_piez "Перепад давления из-за изменения пьезометрической высоты";
    equation
      0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
      0.5 * deltaVFlow * rho_v * der(h_n[2]) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
      deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
      heat.Q_flow = Q_flow;
      heat.T = t_m;
//Уравнения состояния
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      t_flow = Medium_F.temperature(stateFlow);
      rho_v = calc_rho_v(h_n, p_v);
//Уравнения для расчета процессов теплообмена
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
      alfa_flow = alfaFor2ph(h_n = h_n, D_flow_v = D_flow_v, p_v = p_v, Din = Din, f_flow = f_flow);
//Про две фазы
//stateFlowTwoPhase[i, j] = Medium_F.setState_ph(p_v, h_v[i, j]);
      x_v = if h_v < hl then 0 elseif h_v > hv then 1 else (h_v - hl) / (hv - hl);
      D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
      D_flow_n[2] = D_flow_n[1] - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
      C1 = deltaVFlow * drdh_new * der(h_v);
      C2 = deltaVFlow * drdp_new * der(p_v);
      drdh_new = if abs(h_n[2] - h_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_v, h_n[2])) - Medium_F.density(Medium_F.setState_ph(p_v, h_n[1]))) / (h_n[2] - h_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_v, h_n[2])) - Medium_F.density(Medium_F.setState_ph(p_v, h_n[2] - 0.01))) / 0.01;
      drdp_new = if abs(p_n[2] - p_n[1]) > 0.01 then (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[1], h_v))) / (p_n[2] - p_n[1]) else (Medium_F.density(Medium_F.setState_ph(p_n[2], h_v)) - Medium_F.density(Medium_F.setState_ph(p_n[2] - 0.01, h_v))) / 0.01;
      sat_v = Medium_F.setSat_p(p_v);
      hl = Medium_F.bubbleEnthalpy(sat_v);
      hv = Medium_F.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
      p_v = p_n[1];
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * Lpipe * z2 / zahod / Din;
      dp_fric = w_flow_v ^ 2 * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
      p_n[1] - p_n[2] = dp_fric;
      dp_piez = 0 "Расчет перепада давления из-за изменения пьезометрической высоты";
    initial equation
      der(h_v) = 0;
      der(t_m) = 0;
      der(p_v) = 0;
      der(h_n[2]) = 0;
      annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
    end flowSide_OTE;

    model gasSideHE
      import MyHRSG_lite.cleanCopy.functions.deltaPg;
      //**
      //***Исходные данные для газовой стороны
      //**
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate setD_gas = 509 "Номинальный (и начальный) массовый расход газов" annotation(Dialog(group = "Параметры стороны газов"));
      parameter Modelica.SIunits.Pressure setp_gas = 3e3 "Начальное давление газов" annotation(Dialog(group = "Параметры стороны газов"));
      parameter Modelica.SIunits.Temperature setT_inGas = 184 + 273.15 "Начальная входная температура газов" annotation(Dialog(group = "Параметры стороны газов"));
      parameter Modelica.SIunits.Temperature setT_outGas = 170 + 273.15 "Начальная выходная температура газов" annotation(Dialog(group = "Параметры стороны газов"));
      parameter Medium_G.MassFraction setX_gas[Medium_G.nXi] = Medium_G.reference_X;
      parameter Real k_alfaGas = 1 "Поправка к коэффициенту теплоотдачи со стороны газов" annotation(Dialog(group = "Параметры стороны газов"));
      //**
      //Конструктивные характеристики
      //**
      //Параметры
      parameter Integer numberOfVolumes = 10 "Число участков разбиения" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Diameter Dout = Din + 2 * delta "Наружный диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer zahod = 2 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z1 = 79 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer z2 = 14 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length Hpipe = Lpipe "Разность высотных отметов выхода и входа теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Real Xi_flow = 0.3 "Коэффициент гидравлического сопротивления участка трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Modelica.SIunits.Length omega = Modelica.Constants.pi * Dout "Наружный периметр трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      //Поток газов
      parameter Modelica.SIunits.Volume deltaVGas = z2 * Lpipe * (s1 * s2 * z1 - Modelica.Constants.pi * Dout ^ 2 / 4) / numberOfVolumes "Объем одного участка газового тракта";
      parameter Modelica.SIunits.Area deltaSGas = Lpipe * Modelica.Constants.pi * Dout * z1 "Наружная площадь одного участка ряда труб";
      parameter Modelica.SIunits.Area f_gas = (1 - Dout / s1 * (1 + 2 * hfin * delta_fin / sfin / Dout)) * Lpipe * s2 * z1 "Площадь для прохода газов на одном участке разбиения";
      //**
      //Характеристики оребрения
      //
      parameter Modelica.SIunits.Length delta_fin = 0.0009 "Средняя толщина ребра, м" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Modelica.SIunits.Length hfin = 0.014 "Высота ребра, м" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Modelica.SIunits.Length sfin = 0.004 "Шаг ребер, м" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Modelica.SIunits.Length Dfin = Dout + 2 * hfin "Диаметр ребер, м" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real psi_fin = 1 / (2 * Dout * sfin) * (Dfin ^ 2 - Dout ^ 2 + 2 * Dfin * delta_fin) + 1 - delta_fin / sfin "Коэффициент оребрения, равный отношению полной поверхности пучка к поверхности несущих труб на оребренном участке" annotation(Dialog(group = "Характеристики оребрения"));
      //формула 7.22а нормативного метода
      parameter Real sigma1 = s1 / Dout "Относительный поперечный шаг" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real sigma2 = s2 / Dout "Относительный продольный шаг" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real sigma3 = sqrt(0.25 * sigma1 ^ 2 + sigma2) "Средний относительный диагональный шаг труб" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real xfin = sigma1 / sigma2 - 1.26 / psi_fin - 2 "Параметр 'x' для шахматного пучка" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real phi_fin = Modelica.Math.tanh(xfin) "Некий параметр 'фи'" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real n_fin = 0.7 + 0.08 * phi_fin + 0.005 * psi_fin "Показатель степени 'n' в формуле коэффициента теплоотдачи" annotation(Dialog(group = "Характеристики оребрения"));
      parameter Real Cs = (1.36 - phi_fin) * (11 / (psi_fin + 8) - 0.14) "Коэффициент, определяемый в зависимости от от относительного поперечного и продольного шага труб в пучке, типа пучка и коэффициента оребрения";
      parameter Real Cz = if z2 < 8 and sigma1 / sigma2 < 2 then 3.15 * z2 ^ 0.05 - 2.5 elseif z2 < 8 and sigma1 / sigma2 >= 2 then 3.5 * z2 ^ 0.03 - 2.72 else 1 "Поправка на число рядов труб по ходу газов";
      parameter Real H_fin = (omega * Lpipe * (1 - delta_fin / sfin) + 2 * Modelica.Constants.pi * (Dfin ^ 2 - Dout ^ 2) / 4 + Modelica.Constants.pi * Dfin * delta_fin * (Lpipe / sfin)) * z1 * z2 "Площадь оребренной поверхности";
      //**
      //Начальные значения
      //**
      //Поток газов
      parameter Medium_G.SpecificEnthalpy h_startGas[2] = {Medium_G.specificEnthalpy_pTX(setp_gas, setT_inGas, setX_gas), Medium_G.specificEnthalpy_pTX(setp_gas, setT_outGas, setX_gas)} "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
      parameter Medium_G.SpecificEnthalpy h_v_startGas = 0.5 * (Medium_G.specificEnthalpy_pTX(setp_gas, setT_inGas, setX_gas) + Medium_G.specificEnthalpy_pTX(setp_gas, setT_outGas, setX_gas));
      parameter Medium_G.AbsolutePressure p_startGas[2] = fill(setp_gas, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
      //**
      //Переменные
      //**
      //Поток газов
      Medium_G.BaseProperties gas;
      Medium_G.SpecificEnthalpy h_gas[2](start = h_startGas) "Энтальпия потока вода/пар по участкам трубы";
      Medium_G.Temperature t_gas(start = setT_inGas) "Температура потока газов по участкам трубы";
      Medium_G.MassFlowRate deltaDGas[2](start = fill(setD_gas, 2)) "Расход газов через участок газохода";
      Medium_G.DynamicViscosity mu "Динамическая вязкость газов";
      Medium_G.ThermalConductivity k "Коэффициент теплопроводности газов";
      Medium_G.SpecificHeatCapacity cp "Изобарная теплоемкость газов";
      Modelica.SIunits.PerUnit Re "Число Рейнольдса";
      Medium_G.PrandtlNumber Pr "Число Прандтля";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_gas "Коэффициент теплопередачи со стороны потока газов";
      Medium_G.AbsolutePressure deltaP "Аэродинамическое сопротивление";
      Medium_G.DerDensityByPressure drdp;
      Medium_G.DerDensityByTemperature drdT;
      //**
      //Интерфейс
      //**
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat annotation(Placement(visible = false, transformation(origin = {0, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0), iconTransformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(extent = {{80, -20}, {120, 20}}, rotation = 0), iconTransformation(extent = {{100, -20}, {140, 20}}, rotation = 0)));
    equation
//*****Уравнения для потока газов
      deltaVGas * gas.d * der(t_gas) = deltaDGas[1] * (h_gas[1] - h_gas[2]) + heat.Q_flow;
      heat.Q_flow = -alfa_gas * H_fin * (t_gas - heat.T);
//Уравнения состояния
//gas.h = h_gas_v;
      gas.h = h_gas[2];
      gas.p = gasIn.p "Уравнение для давления";
      gas.X = setX_gas;
      gas.T = t_gas;
      drdp = Medium_G.density_derp_T(gas.state);
      drdT = Medium_G.density_derT_p(gas.state);
      deltaDGas[2] = deltaDGas[1] - deltaVGas * (drdT * der(t_gas) + drdp * der(gas.p)) "Уравнение сплошности";
//Коэффициент теплоотдачи
      mu = Medium_G.dynamicViscosity(gas.state);
      k = Medium_G.thermalConductivity(gas.state);
      cp = Medium_G.heatCapacity_cp(gas.state);
      Re = abs(deltaDGas[1] * Dout / (f_gas * mu));
      Pr = Medium_G.prandtlNumber(gas.state);
      alfa_gas = k_alfaGas * 0.113 * Cs * Cz * k / Dout * Re ^ n_fin * Pr ^ 0.33;
      deltaP = deltaPg(deltaDGas = deltaDGas[2], z1 = z1, z2 = z2, Dout = Dout, Lpipe = Lpipe, s1 = s1, s2 = s2, state = gas.state) / numberOfVolumes;
//Граничные условия
      h_gas[1] = inStream(gasIn.h_outflow);
//Граничные условия
      gasIn.h_outflow = h_gas[1];
      gasOut.h_outflow = h_gas[2];
      gasIn.Xi_outflow = inStream(gasOut.Xi_outflow);
      inStream(gasIn.Xi_outflow) = gasOut.Xi_outflow;
      gasIn.m_flow - deltaDGas[1] = 0;
      gasOut.m_flow + deltaDGas[2] = 0;
      gasOut.p = gasIn.p - deltaP;
    initial equation
      der(gas.p) = 0;
      der(t_gas) = 0;
      annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-100, -115}, {100, -145}}, lineColor = {85, 170, 255}, textString = "%name")}));
    end gasSideHE;

    model GFHE
      extends HE_Icon;
      parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      //***Исходные данные для газовой стороны
      //**
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas "Номинальный (и начальный) массовый расход газов";
      parameter Modelica.SIunits.Pressure pgas "Начальное давление газов";
      parameter Modelica.SIunits.Temperature Tingas "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas "Начальная выходная температура газов";
      //parameter Modelica.SIunits.Temperature T2gas = (Tingas + Toutgas) / 2 "Промежуточная температура газов";
      parameter Real k_gamma_gas "Поправка к коэффициенту теплоотдачи со стороны газов";
      parameter Real Set_X[6] "Состав дымовых газов";
      //**
      //***Исходные данные для водяной стороны
      //**
      replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wflow "Номинальный массовый расход воды/пар";
      parameter Modelica.SIunits.Pressure pflow_in "Начальное давление потока вода/пар на входе";
      parameter Modelica.SIunits.Pressure pflow_out "Начальное давление потока вода/пар на выходе";
      parameter Modelica.SIunits.Temperature Tinflow "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
      parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
      parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
      //**
      //***Исходные данные по разбиению
      //**
      parameter Integer numberOfTubeSections = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfVolumes = 2 "Число участков разбиения";
      //**
      //***конструктивные характеристики
      //**
      parameter MyHRSG_lite.Choices.HRSG_type HRSG_type_set = Choices.HRSG_type.horizontalBottom "Выбор типа КУ (горизонтальный/вертикальный)";
      parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг";
      parameter Integer zahod = 1 "заходность труб теплообменника";
      parameter Integer z1 = 126 "Число труб по ширине газохода";
      parameter Integer z2 = 4 "Число труб по ходу газов в теплообменнике";
      parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки";
      ///Оребрение
      parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м";
      ////
      //////
      ////
      Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      gasSideHE gasHE[numberOfVolumes](redeclare package Medium_G = Medium_G, setD_gas = wgas, setp_gas = pgas, setT_inGas = Tingas, setT_outGas = Toutflow, k_alfaGas = k_gamma_gas, numberOfVolumes = numberOfVolumes, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe, delta_fin = delta_fin, hfin = hfin, sfin = sfin) annotation(Placement(visible = true, transformation(origin = {0, 50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
      replaceable flowSide_OTE flowHE[numberOfVolumes](setD_flow = wflow, setp_flow_in = pflow_in, setp_flow_out = pflow_out, setT_inFlow = Tinflow, setT_outFlow = Toutflow, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe / numberOfVolumes, seth_in = seth_in, seth_out = seth_out, setTm = setTm, m_flow_small = m_flow_small) annotation(Placement(visible = true, transformation(origin = {0, -50}, extent = {{-30, -30}, {30, 30}}, rotation = 90)));
    equation
      for i in 1:numberOfVolumes - 1 loop
        connect(gasHE[i].gasOut, gasHE[i + 1].gasIn) annotation(Line(points = {{36, 50}, {92, 50}, {92, 48}, {92, 48}}, color = {0, 127, 255}));
        connect(flowHE[i].waterOut, flowHE[i + 1].waterIn) annotation(Line(points = {{36, -50}, {94, -50}, {94, -50}, {94, -50}}, color = {0, 127, 255}));
      end for;
      for i in 1:numberOfVolumes loop
        connect(flowHE[i].heat, gasHE[numberOfVolumes + 1 - i].heat);
      end for;
      connect(gasHE[numberOfVolumes].gasOut, gasOut) annotation(Line(points = {{36, 50}, {92, 50}, {92, 48}, {92, 48}}, color = {0, 127, 255}));
      connect(gasIn, gasHE[1].gasIn) annotation(Line(points = {{-90, 50}, {-34, 50}, {-34, 48}, {-34, 48}}));
      connect(flowHE[numberOfVolumes].waterOut, flowOut) annotation(Line(points = {{36, -50}, {94, -50}, {94, -50}, {94, -50}}, color = {0, 127, 255}));
      connect(flowIn, flowHE[1].waterIn) annotation(Line(points = {{-90, -50}, {-34, -50}, {-34, -50}, {-34, -50}}));
      annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), version = "", uses);
    end GFHE;

    package Tests
      model startUpTest_1
        package Medium_F = Modelica.Media.Water.WaterIF97_ph;
        parameter Modelica.SIunits.MassFlowRate wflow = 58 / 3.6 "Пусковой массовый расход воды на входе в сепаратор";
        parameter Modelica.SIunits.MassFlowRate wsteam = 0.01 "Расход пара на выходе из сепаратора";
        replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate wgas = 100 / 3.6 "Номинальный (и начальный) массовый расход газов ";
        parameter Modelica.SIunits.Pressure pgas = 3e3 "Начальное давление газов";
        parameter Medium_F.SaturationProperties sat_start = Medium_F.setSat_p(pflow_ote2);
        //Исходные данные для сепаратора
        parameter Modelica.SIunits.Length Dsep = 0.348 "Внутренний диаметр сепаратор";
        parameter Modelica.SIunits.Length Lsep = 5 "Длина (высота) сепаратора";
        parameter Modelica.SIunits.Length deltaSep = 0.04 "Толщина стенки сепаратора";
        parameter Integer n_sep_set = 2 "Количество сепараторов";
        //Начальные значения для сепаратора
        parameter Modelica.SIunits.Length Hw_start_set = 2 "Начальное значение уровня воды в сепараторе";
        //Констуктивные характеристики поверхностей нагрева
        parameter Modelica.SIunits.Length Lpipe = 18.492 "Длина теплообменной трубки";
        //Исходные данные для экономайзера
        parameter Modelica.SIunits.Diameter Din_eco = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_eco = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_eco = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_eco = 79e-3 "Продольный шаг";
        parameter Integer zahod_eco = 1 "заходность труб теплообменника";
        parameter Integer z1_eco = 58 "Число труб по ширине газохода";
        parameter Integer z2_eco = 8 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб экономайзера
        parameter Modelica.SIunits.Length delta_fin_eco = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_eco = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_eco = 2.215e-3 "Шаг ребер, м";
        //Исходные данные по разбиению экономайзера
        parameter Integer numberOfTubeSections_eco = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_eco = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_eco = z2_eco "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для экономайзера
        parameter Modelica.SIunits.Pressure pflow_eco = 1.013e5 "Начальное давление потока вода/пар перед ECO";
        parameter Modelica.SIunits.Temperature Tinflow_eco = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_eco = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_eco = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_in = Medium_F.specificEnthalpy_pT(pflow_eco, Tinflow_eco) "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_eco_out = Medium_F.specificEnthalpy_pT(pflow_eco, Toutflow_eco) "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны экономайзера
        parameter Modelica.SIunits.Temperature Tingas_eco = 60 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_eco = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_eco = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для прямоточного испарителя №1 (OTE1)
        parameter Modelica.SIunits.Diameter Din_ote1 = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_ote1 = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_ote1 = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_ote1 = 79e-3 "Продольный шаг";
        parameter Integer zahod_ote1 = 1 "заходность труб теплообменника";
        parameter Integer z1_ote1 = 58 "Число труб по ширине газохода";
        parameter Integer z2_ote1 = 10 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб прямоточного испарителя №1 (OTE1)
        parameter Modelica.SIunits.Length delta_fin_ote1 = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_ote1 = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_ote1 = 2.002e-3 "Шаг ребер, м";
        //Исходные данные по разбиению испарителя №1 (OTE1)
        parameter Integer numberOfTubeSections_ote1 = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_ote1 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_ote1 = z2_ote1 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для экономайзера
        parameter Modelica.SIunits.Pressure pflow_ote1 = 1.013e5 "Начальное давление потока вода/пар перед ECO";
        parameter Modelica.SIunits.Temperature Tinflow_ote1 = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_ote1 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_ote1 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_in = hflow_eco_out "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote1_out = hflow_ote1_in "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны экономайзера
        parameter Modelica.SIunits.Temperature Tingas_ote1 = 60 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_ote1 = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_ote1 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для прямоточного испарителя №2 (OTE2)
        parameter Modelica.SIunits.Diameter Din_ote2 = 0.038 "Внутренний диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_ote2 = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_ote2 = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_ote2 = 79e-3 "Продольный шаг";
        parameter Integer zahod_ote2 = 1 "заходность труб теплообменника";
        parameter Integer z1_ote2 = 58 "Число труб по ширине газохода";
        parameter Integer z2_ote2 = 6 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб прямоточного испарителя №2 (OTE2)
        parameter Modelica.SIunits.Length delta_fin_ote2 = 0.0008 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_ote2 = 0.015 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_ote2 = 2.735e-3 "Шаг ребер, м";
        //Исходные данные по разбиению испарителя №2 (OTE2)
        parameter Integer numberOfTubeSections_ote2 = 2 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_ote2 = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_ote2 = z2_ote2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для испарителя №2
        parameter Modelica.SIunits.Pressure pflow_ote2 = 1.013e5 "Начальное давление потока вода/пар перед OTE2";
        parameter Modelica.SIunits.Temperature Tinflow_ote2 = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_ote2 = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_ote2 = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_in = hflow_ote1_out "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_ote2_out = hflow_ote2_in "Начальная энтальпия выходного потока вода/пар";
        //Исходные данные для газовой стороны испарителя №2
        parameter Modelica.SIunits.Temperature Tingas_ote2 = 60 + 273.15 "Начальная входная температура газов (по расчетам Березенца за ИВД при 15С в номинале ТЭЦ-12";
        parameter Modelica.SIunits.Temperature Toutgas_ote2 = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_ote2 = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        //Исходные данные для пароперегревателя (SH)
        parameter Modelica.SIunits.Diameter Dout_sh = 0.038 "Наружный диаметр трубок теплообменника";
        parameter Modelica.SIunits.Length delta_sh = 0.002 "Толщина стенки трубки теплообменника";
        parameter Modelica.SIunits.Length s1_sh = 91.09e-3 "Поперечный шаг";
        parameter Modelica.SIunits.Length s2_sh = 79e-3 "Продольный шаг";
        parameter Integer zahod_sh = 2 "заходность труб теплообменника";
        parameter Integer z1_sh = 58 "Число труб по ширине газохода";
        parameter Integer z2_sh = 8 "Число труб по ходу газов в теплообменнике";
        ///Оребрение труб пароперегревателя (SH)
        parameter Modelica.SIunits.Length delta_fin_sh = 0.001 "Средняя толщина ребра, м";
        parameter Modelica.SIunits.Length hfin_sh = 0.012 "Высота ребра, м";
        parameter Modelica.SIunits.Length sfin_sh = 5.102e-3 "Шаг ребер, м";
        //Исходные данные по разбиению пароперегревателя (SH)
        parameter Integer numberOfTubeSections_sh = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberPMCalcSections_sh = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer numberOfFlueSections_sh = z2_sh "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        //Исходные данные вода/пар для пароперегревателя
        parameter Modelica.SIunits.Pressure pflow_sh = 1.013e5 "Начальное давление потока вода/пар перед SH";
        parameter Modelica.SIunits.Temperature Tinflow_sh = 60 + 273.15 "Начальная входная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature Toutflow_sh = 60 + 273.15 "Начальная выходная температура потока воды/пар";
        parameter Modelica.SIunits.Temperature setTm_sh = 60 + 273.15 "Начальная температура металла поверхностей нагрева";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_in = 2.676e6 "Начальная энтальпия входного потока вода/пар";
        parameter Modelica.SIunits.SpecificEnthalpy hflow_sh_out = hflow_sh_in "Начальная энтальпия входного потока вода/пар";
        //Исходные данные для газовой стороны испарителя №2
        parameter Modelica.SIunits.Temperature Tingas_sh = 60 + 273.15 "Начальная входная температура газов";
        parameter Modelica.SIunits.Temperature Toutgas_sh = 60 + 273.15 "Начальная выходная температура газов";
        parameter Real k_gamma_gas_sh = 1 "Поправка к коэффициенту теплоотдачи со стороны газов";
        inner Modelica.Fluid.System system(allowFlowReversal = false) annotation(Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.MassFlowSource_T flowSource(redeclare package Medium = Medium_F, nPorts = 1, use_T_in = false, use_m_flow_in = false, m_flow = wflow, T = Tinflow_eco) annotation(Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.FixedBoundary flowSink(redeclare package Medium = Medium_F, T = Toutflow_ote1, nPorts = 1, p = system.p_ambient, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        MyHRSG_lite.cleanCopy.GFHE ECO(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_eco, Toutgas = Tingas_eco, k_gamma_gas = k_gamma_gas_eco, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_eco, pflow_out = pflow_eco, Tinflow = Tinflow_eco, Toutflow = Tinflow_eco, numberOfTubeSections = numberOfTubeSections_eco, numberPMCalcSections = numberPMCalcSections_eco, numberOfFlueSections = numberOfFlueSections_eco, Din = Din_eco, delta = delta_eco, s1 = s1_eco, s2 = s2_eco, zahod = zahod_eco, z1 = z1_eco, z2 = z2_eco, Lpipe = Lpipe, delta_fin = delta_fin_eco, hfin = hfin_eco, sfin = sfin_eco, seth_in = hflow_eco_in, seth_out = hflow_eco_out, setTm = setTm_eco, numberOfVolumes = 2) annotation(Placement(visible = true, transformation(origin = {-46, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.MassFlowSource_T gasSource(redeclare package Medium = Medium_G, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(Placement(visible = true, transformation(origin = {70, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Modelica.Fluid.Sources.FixedBoundary gasSink(redeclare package Medium = Medium_G, T = Toutgas_eco, nPorts = 1, p = pgas, use_T = true, use_p = true) annotation(Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.cleanCopy.GFHE OTE1(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote1, Toutgas = Tingas_ote1, k_gamma_gas = k_gamma_gas_ote1, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote1, pflow_out = pflow_ote1, Tinflow = Tinflow_ote1, Toutflow = Tinflow_ote1, numberOfTubeSections = numberOfTubeSections_ote1, numberPMCalcSections = numberPMCalcSections_ote1, numberOfFlueSections = numberOfFlueSections_ote1, Din = Din_ote1, delta = delta_ote1, s1 = s1_ote1, s2 = s2_ote1, zahod = zahod_ote1, z1 = z1_ote1, z2 = z2_ote1, Lpipe = Lpipe, delta_fin = delta_fin_ote1, hfin = hfin_ote1, sfin = sfin_ote1, seth_in = hflow_ote1_in, seth_out = hflow_ote1_out, setTm = setTm_ote1, numberOfVolumes = 10) annotation(Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.cleanCopy.GFHE_new OTE2(redeclare package Medium_G = Medium_G, HRSG_type_set = MyHRSG_lite.Choices.HRSG_type.verticalTop, wgas = wgas, pgas = pgas, Tingas = Tingas_ote2, Toutgas = Tingas_ote2, k_gamma_gas = k_gamma_gas_ote2, redeclare package Medium_F = Medium_F, wflow = wflow, pflow_in = pflow_ote2, pflow_out = pflow_ote2, Tinflow = Tinflow_ote2, Toutflow = Tinflow_ote2, numberOfTubeSections = numberOfTubeSections_ote2, numberPMCalcSections = numberPMCalcSections_ote2, numberOfFlueSections = numberOfFlueSections_ote2, Din = Din_ote2, delta = delta_ote2, s1 = s1_ote2, s2 = s2_ote2, zahod = zahod_ote2, z1 = z1_ote2, z2 = z2_ote2, Lpipe = Lpipe, delta_fin = delta_fin_ote2, hfin = hfin_ote2, sfin = sfin_ote2, seth_in = hflow_ote2_in, seth_out = hflow_ote2_out, setTm = setTm_ote2, numberOfVolumes = 10) annotation(Placement(visible = true, transformation(origin = {2, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-38, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature2(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
        Modelica.Blocks.Sources.Ramp rampGasFlow(duration = 600, height = 1000, offset = wgas, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.Ramp rampGasTemp(duration = 40, height = 200, offset = Tingas_sh, startTime = 10) annotation(Placement(visible = true, transformation(origin = {70, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        MyHRSG_lite.cleanCopy.GFHE SH(redeclare MyHRSG_lite.cleanCopy.flowSide_SH flowHE, redeclare package Medium_G = Medium_G, wgas = wgas, pgas = pgas, Tingas = Tingas_sh, Toutgas = Tingas_sh, k_gamma_gas = k_gamma_gas_sh, redeclare package Medium_F = Medium_F, wflow = wsteam, pflow_in = pflow_sh, pflow_out = pflow_sh, Tinflow = Tinflow_sh, Toutflow = Tinflow_sh, numberOfTubeSections = numberOfTubeSections_sh, numberPMCalcSections = numberPMCalcSections_sh, numberOfFlueSections = numberOfFlueSections_sh, Din = Dout_sh - 2 * delta_sh, delta = delta_sh, s1 = s1_sh, s2 = s2_sh, zahod = zahod_sh, z1 = z1_sh, z2 = z2_sh, Lpipe = Lpipe, delta_fin = delta_fin_sh, hfin = hfin_sh, sfin = sfin_sh, seth_in = hflow_sh_in, seth_out = hflow_sh_out, setTm = setTm_ote2, numberOfVolumes = 1) annotation(Placement(visible = true, transformation(origin = {34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.Constant constCV1(k = 1) annotation(Placement(visible = true, transformation(origin = {35, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
        MyHRSG_lite.Separator2 separator21 annotation(Placement(visible = true, transformation(origin = {14, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Fluid.Valves.ValveCompressible CV1(redeclare package Medium = Medium_F, CvData = Modelica.Fluid.Types.CvTypes.OpPoint, dp_nominal = 7.1e+06, m_flow_nominal = 42, p_nominal = 71e5, rho_nominal = 21.22) annotation(Placement(visible = true, transformation(origin = {46, 56}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      equation
        connect(constCV1.y, CV1.opening) annotation(Line(points = {{40, 70}, {46, 70}, {46, 60}, {46, 60}}, color = {0, 0, 127}));
        connect(CV1.port_a, SH.flowOut) annotation(Line(points = {{42, 56}, {38, 56}, {38, 24}, {38, 24}}, color = {0, 127, 255}));
        connect(CV1.port_b, flowSink.ports[1]) annotation(Line(points = {{50, 56}, {60, 56}, {60, 56}, {60, 56}}, color = {0, 127, 255}));
        connect(separator21.steam, SH.flowIn) annotation(Line(points = {{14, 52}, {14, 52}, {14, 54}, {30, 54}, {30, 24}, {30, 24}}, color = {0, 127, 255}));
        connect(OTE2.flowOut, separator21.fedWater) annotation(Line(points = {{6, 24}, {6, 47}, {7, 47}}, color = {0, 127, 255}));
        connect(SH.gasOut, OTE2.gasIn) annotation(Line(points = {{28, 12}, {8, 12}, {8, 12}, {8, 12}}, color = {0, 127, 255}));
        connect(gasSource.ports[1], SH.gasIn) annotation(Line(points = {{60, -6}, {48, -6}, {48, 12}, {40, 12}, {40, 12}}, color = {0, 127, 255}));
        connect(gasSource.T_in, rampGasTemp.y) annotation(Line(points = {{82, -2}, {87, -2}, {87, -2}, {92, -2}, {92, -34}, {82, -34}, {82, -34}}, color = {0, 0, 127}));
        connect(rampGasFlow.y, gasSource.m_flow_in) annotation(Line(points = {{81, -66}, {89, -66}, {89, -66}, {97, -66}, {97, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}, {79, 2}}, color = {0, 0, 127}));
        connect(OTE1.flowOut, temperature2.port_a) annotation(Line(points = {{-17.8, 23}, {-17.8, 26.5}, {-17.8, 26.5}, {-17.8, 30}, {-13.8, 30}}, color = {0, 127, 255}));
        connect(temperature2.port_b, OTE2.flowIn) annotation(Line(points = {{-6, 30}, {-2, 30}, {-2, 26}, {-2, 26}, {-2, 24}, {-2, 24}}, color = {0, 127, 255}));
        connect(temperature1.port_b, OTE1.flowIn) annotation(Line(points = {{-34, 30}, {-26, 30}, {-26, 26.5}, {-26, 26.5}, {-26, 23}}, color = {0, 127, 255}));
        connect(ECO.flowOut, temperature1.port_a) annotation(Line(points = {{-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 23}, {-41.8, 31}, {-41.8, 31}, {-41.8, 29}, {-41.8, 29}}, color = {0, 127, 255}));
        connect(OTE1.gasIn, OTE2.gasOut) annotation(Line(points = {{-15.8, 12}, {-3.8, 12}}, color = {0, 127, 255}));
        connect(ECO.gasIn, OTE1.gasOut) annotation(Line(points = {{-39.8, 12}, {-27.8, 12}}, color = {0, 127, 255}));
        connect(gasSink.ports[1], ECO.gasOut) annotation(Line(points = {{-80, -6}, {-60, -6}, {-60, 12}, {-52, 12}}, color = {0, 127, 255}));
        connect(flowSource.ports[1], ECO.flowIn) annotation(Line(points = {{-74, 50}, {-50, 50}, {-50, 23}}, color = {0, 127, 255}));
        annotation(uses(Modelica(version = "3.2.1")), Documentation(info = "<html>
      <p>
      Параметры взяты из модели прямоточного котла для ГТЭ-110 в Thermoflex ''ВертрПрямКУсГТЭ110_OD''
      </p>
      </html>"), experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 0.005));
      end startUpTest_1;
    end Tests;

    package functions
      function alfaFor2ph
        input Medium.SpecificEnthalpy h_n[2];
        input Medium.MassFlowRate D_flow_v;
        input Medium.AbsolutePressure p_v;
        input Modelica.SIunits.Diameter Din;
        input Modelica.SIunits.Area f_flow;
        output Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
      protected
        package Medium = Modelica.Media.Water.WaterIF97_ph;
        Medium.AbsolutePressure pc = 22.06e6;
        Modelica.SIunits.SpecificEnthalpy hzero = 1e-3;
        Modelica.SIunits.Pressure pzero = 10;
        Medium.SpecificEnthalpy h_v;
        Medium.Density rho_n[2];
        Medium.Density rho_v;
        Medium.Density rhov;
        Medium.Density rhol;
        Medium.SpecificEnthalpy hl;
        Medium.SpecificEnthalpy hv;
        Real Re_flow_eco;
        Real Re_flow_sh;
        Medium.ThermalConductivity k_flow_eco;
        Medium.ThermalConductivity k_flow_sh;
        Real Pr_flow_eco;
        Real Pr_flow_sh;
        Medium.DynamicViscosity mu_flow_eco;
        Medium.DynamicViscosity mu_flow_sh;
        Modelica.SIunits.Velocity w_flow_v_eco;
        Modelica.SIunits.Velocity w_flow_v_sh;
        Real A_alfa;
        Real C_alfa;
        Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_eco "Коэффициент теплопередачи со стороны потока вода/пар";
        Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_sh "Коэффициент теплопередачи со стороны потока вода/пар";
      algorithm
        h_v := 0.5 * (h_n[1] + h_n[2]);
        for i in 1:2 loop
          rho_n[i] := Medium.density(Medium.setState_ph(p_v, h_n[i]));
        end for;
        rho_v := 0.5 * (rho_n[2] + rho_n[1]);
        hl := Medium.bubbleEnthalpy(Medium.setSat_p(p_v));
        hv := Medium.dewEnthalpy(Medium.setSat_p(p_v));
        rhol := Medium.bubbleDensity(Medium.setSat_p(p_v));
        rhov := Medium.dewDensity(Medium.setSat_p(p_v));
        if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
          k_flow_sh := k_flow_eco;
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
          Pr_flow_sh := Pr_flow_eco;
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
          mu_flow_sh := mu_flow_eco;
          w_flow_v_eco := D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
          Re_flow_sh := Re_flow_eco;
        elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
          k_flow_sh := k_flow_eco;
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
          Pr_flow_sh := Pr_flow_eco;
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
          mu_flow_sh := mu_flow_eco;
          w_flow_v_eco := D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
          Re_flow_sh := Re_flow_eco;
        elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
          mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
          w_flow_v_eco := D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
          Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
        elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
          mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
          w_flow_v_eco := D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
          Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
        elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
          mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
          w_flow_v_eco := D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
          Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
        elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
          mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
          w_flow_v_eco := D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
          Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
        elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
          mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
          w_flow_v_eco := D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
          Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
        else
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
          mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
          w_flow_v_eco := D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
          Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
        end if;
// 1-phase or almost uniform properties
// 2-phase
// liquid/2-phase
// 2-phase/vapour
// liquid/2-phase/vapour
// 2-phase/liquid
// vapour/2-phase/liquid
// vapour/2-phase
        A_alfa := min(max((hl - h_n[1]) / max(h_n[2] - h_n[1], 0.01), 0), 1);
        C_alfa := min(max((h_n[2] - hv) / max(h_n[2] - h_n[1], 0.01), 0), 1);
        alfa_flow_eco := 0.023 * k_flow_eco / Din * Re_flow_eco ^ 0.8 * Pr_flow_eco ^ 0.4;
        alfa_flow_sh := 0.023 * k_flow_sh / Din * Re_flow_sh ^ 0.8 * Pr_flow_sh ^ 0.4;
        alfa_flow := ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) * alfa_flow_eco + ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2) * alfa_flow_sh + (1 - ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) - ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2)) * 20000;
      end alfaFor2ph;

      function deltaPg
        import Modelica.SIunits.Conversions.to_degF;
        input Medium.MassFlowRate deltaDGas "Расход дымовых газов";
        input Integer z1 "Число труб по ширине газохода";
        input Integer z2 "Число труб по ходу газов в данной поверхности нагрева";
        input Modelica.SIunits.Diameter Dout "Диаметр теплообменной трубки";
        input Modelica.SIunits.Length Lpipe "Длина теплообменной трубки";
        input Modelica.SIunits.Length s1 "Поперечный шаг";
        input Modelica.SIunits.Length s2 "Продольный шаг";
        input Medium.ThermodynamicState state;
        output Medium.AbsolutePressure deltaPg;
      protected
        package Medium = MyHRSG_lite.ExhaustGas;
        Medium.MolarMass MM;
        Medium.DynamicViscosity mu "Динамическая вязкость газов";
        Medium.MassFlowRate Gg "Gas mass velocity";
      algorithm
        mu := Medium.dynamicViscosity(state);
        MM := Medium.molarMass(state);
        Gg := deltaDGas / z1 / Lpipe / (s1 - Dout);
        deltaPg := Gg ^ 1.684 * Dout ^ 0.611 * mu ^ 0.216 * (460 + to_degF(state.T)) * z2 / s1 ^ 0.412 / s2 ^ 0.515 / (MM * 10 ^ 3);
      end deltaPg;

      function alfaForSH
        input Medium.SpecificEnthalpy h_v;
        input Medium.MassFlowRate D_flow_n1;
        input Medium.AbsolutePressure p_v;
        input Modelica.SIunits.Diameter Din;
        input Modelica.SIunits.Area f_flow;
        output Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
      protected
        package Medium = Modelica.Media.Water.WaterIF97_ph;
        Medium.Density rho_v;
        Medium.DynamicViscosity mu_flow;
        Medium.MassFlowRate m_flow_small = 0.01;
        Modelica.SIunits.Velocity w_flow;
        Real Re_flow;
        Medium.ThermalConductivity k_flow;
        Real Pr_flow;
      algorithm
        if D_flow_n1 - m_flow_small < 0 then
          alfa_flow := 0;
        else
          rho_v := Medium.density(Medium.setState_ph(p_v, h_v));
          k_flow := Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
          mu_flow := Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v));
          Pr_flow := Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
          w_flow := (D_flow_n1 - m_flow_small) / rho_v / f_flow;
          Re_flow := abs(w_flow * Din * rho_v / mu_flow);
          alfa_flow := 0.023 * k_flow / Din * Re_flow ^ 0.8 * Pr_flow ^ 0.4;
        end if;
      end alfaForSH;

      function calc_rho_v
        input Medium.SpecificEnthalpy h_n[2];
        input Medium.AbsolutePressure p_v;
        output Medium.Density rho_v;
      protected
        package Medium = Modelica.Media.Water.WaterIF97_ph;
        constant Medium.AbsolutePressure pc = 22.06e6;
        constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3;
        constant Modelica.SIunits.Pressure pzero = 10;
        Medium.SaturationProperties sat;
        Medium.SpecificEnthalpy hl;
        Medium.SpecificEnthalpy hv;
        Medium.Density rhov;
        Medium.Density rhol;
        Medium.Density rho_n[2];
        Real AA;
      algorithm
        sat := Medium.setSat_p(p_v);
        hl := Medium.bubbleEnthalpy(sat);
        hv := Medium.dewEnthalpy(sat);
        rhol := Medium.bubbleDensity(sat);
        rhov := Medium.dewDensity(sat);
        AA := (hv - hl) / (1 / rhov - 1 / rhol);
        for i in 1:2 loop
          rho_n[i] := Medium.density(Medium.setState_ph(p_v, h_n[i]));
        end for;
        if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
          rho_v := (rho_n[1] + rho_n[2]) / 2;
        elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
          rho_v := AA * log(rho_n[1] / rho_n[2]) / (h_n[2] - h_n[1]);
        elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
          rho_v := ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rho_n[2])) / (h_n[2] - h_n[1]);
        elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
          rho_v := (AA * log(rho_n[1] / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
        elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
          rho_v := ((rho_n[1] + rhol) * (hl - h_n[1]) / 2 + AA * log(rhol / rhov) + (rhov + rho_n[2]) * (h_n[2] - hv) / 2) / (h_n[2] - h_n[1]);
        elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
          rho_v := (AA * log(rho_n[1] / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
        elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
          rho_v := ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rhol) + (rhol + rho_n[2]) * (h_n[2] - hl) / 2) / (h_n[2] - h_n[1]);
        else
          rho_v := ((rho_n[1] + rhov) * (hv - h_n[1]) / 2 + AA * log(rhov / rho_n[2])) / (h_n[2] - h_n[1]);
        end if;
// 1-phase or almost uniform properties
// 2-phase
// liquid/2-phase
// 2-phase/vapour
// liquid/2-phase/vapour
// 2-phase/liquid
// vapour/2-phase/liquid
// vapour/2-phase
      end calc_rho_v;
    end functions;

    package thermal
      model heatTransfer
        constant Medium.AbsolutePressure pc = Medium.fluidConstants[1].criticalPressure;
        constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
        constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
        replaceable package Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
        input Medium.SpecificEnthalpy h_n[2];
        input Medium.MassFlowRate D_flow_v;
        input Medium.Density rho_n[2];
        input Medium.Density rho_v;
        input Medium.Density rhov;
        input Medium.Density rhol;
        input Medium.SpecificEnthalpy hl;
        input Medium.SpecificEnthalpy hv;
        input Medium.AbsolutePressure p_v;
        input Medium.SpecificEnthalpy h_v;
        parameter Modelica.SIunits.Diameter Din;
        parameter Modelica.SIunits.Area f_flow;
        Real Re_flow_eco;
        Real Re_flow_sh;
        Medium.ThermalConductivity k_flow_eco;
        Medium.ThermalConductivity k_flow_sh;
        Real Pr_flow_eco;
        Real Pr_flow_sh;
        Medium.DynamicViscosity mu_flow_eco;
        Medium.DynamicViscosity mu_flow_sh;
        Modelica.SIunits.Velocity w_flow_v_eco;
        Modelica.SIunits.Velocity w_flow_v_sh;
        Real A_alfa;
        Real C_alfa;
        Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_eco "Коэффициент теплопередачи со стороны потока вода/пар";
        Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_sh "Коэффициент теплопередачи со стороны потока вода/пар";
        Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
      equation
        if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
// 1-phase or almost uniform properties
          k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
          k_flow_sh = k_flow_eco;
          Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
          Pr_flow_sh = Pr_flow_eco;
          mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
          mu_flow_sh = mu_flow_eco;
          w_flow_v_eco = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh = w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco = abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
          Re_flow_sh = Re_flow_eco;
        elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
// 2-phase
          k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
          k_flow_sh = k_flow_eco;
          Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
          Pr_flow_sh = Pr_flow_eco;
          mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
          mu_flow_sh = mu_flow_eco;
          w_flow_v_eco = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh = w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco = abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
          Re_flow_sh = Re_flow_eco;
        elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
// liquid/2-phase
          k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
          mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
          w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
          Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
        elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
// 2-phase/vapour
          k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
          mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
          w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
          Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
        elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
// liquid/2-phase/vapour
          k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
          mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
          w_flow_v_eco = D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
          Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
        elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
// 2-phase/liquid
          k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
          mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
          w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
          Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
        elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
// vapour/2-phase/liquid
          k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
          mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
          w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
          Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
        else
// vapour/2-phase
          k_flow_eco = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          k_flow_sh = Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          Pr_flow_eco = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          Pr_flow_sh = Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          mu_flow_eco = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
          mu_flow_sh = max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
          w_flow_v_eco = D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh = D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco = abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
          Re_flow_sh = abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
        end if;
        A_alfa = min(max((hl - h_n[1]) / max(h_n[2] - h_n[1], 0.01), 0), 1);
        C_alfa = min(max((h_n[2] - hv) / max(h_n[2] - h_n[1], 0.01), 0), 1);
        alfa_flow_eco = 0.023 * k_flow_eco / Din * Re_flow_eco ^ 0.8 * Pr_flow_eco ^ 0.4;
        alfa_flow_sh = 0.023 * k_flow_sh / Din * Re_flow_sh ^ 0.8 * Pr_flow_sh ^ 0.4;
        alfa_flow = ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) * alfa_flow_eco + ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2) * alfa_flow_sh + (1 - ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) - ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2)) * 20000;
      end heatTransfer;

      /* 
                                                  replaceable model HeatTransfer = MyHRSG_lite.cleanCopy.thermal.heatTransfer;
                                                  
                                                  HeatTransfer heatTransfer(
                                                    redeclare package Medium = Medium_F,
                                                    final h_n = h_n,
                                                    final D_flow_v = D_flow_v,
                                                    final rho_n = rho_n,
                                                    final rho_v = rho_v,
                                                    final rhov = rhov,
                                                    final rhol = rhol,
                                                    final hl = hl,
                                                    final hv = hv,
                                                    final p_v = p_v,
                                                    final h_v = h_v,
                                                    final Din = Din,
                                                    final f_flow = f_flow);
                                                */

      function alpha
        input Medium.SpecificEnthalpy h_n[2];
        input Medium.MassFlowRate D_flow_v;
        input Medium.AbsolutePressure p_v;
        input Modelica.SIunits.Diameter Din;
        input Modelica.SIunits.Area f_flow;
        output Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
      protected
        package Medium = Modelica.Media.Water.WaterIF97_ph;
        Medium.AbsolutePressure pc = 22.06e6;
        Modelica.SIunits.SpecificEnthalpy hzero = 1e-3;
        Modelica.SIunits.Pressure pzero = 10;
        Medium.SpecificEnthalpy h_v;
        Medium.Density rho_n[2];
        Medium.Density rho_v;
        Medium.Density rhov;
        Medium.Density rhol;
        Medium.SpecificEnthalpy hl;
        Medium.SpecificEnthalpy hv;
        Real Re_flow_eco;
        Real Re_flow_sh;
        Medium.ThermalConductivity k_flow_eco;
        Medium.ThermalConductivity k_flow_sh;
        Real Pr_flow_eco;
        Real Pr_flow_sh;
        Medium.DynamicViscosity mu_flow_eco;
        Medium.DynamicViscosity mu_flow_sh;
        Modelica.SIunits.Velocity w_flow_v_eco;
        Modelica.SIunits.Velocity w_flow_v_sh;
        Real A_alfa;
        Real C_alfa;
        Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_eco "Коэффициент теплопередачи со стороны потока вода/пар";
        Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow_sh "Коэффициент теплопередачи со стороны потока вода/пар";
      algorithm
        h_v := 0.5 * (h_n[1] + h_n[2]);
        for i in 1:2 loop
          rho_n[i] := Medium.density(Medium.setState_ph(p_v, h_n[i]));
        end for;
        rho_v := 0.5 * (rho_n[2] + rho_n[1]);
        hl := Medium.bubbleEnthalpy(Medium.setSat_p(p_v));
        hv := Medium.dewEnthalpy(Medium.setSat_p(p_v));
        rhol := Medium.bubbleDensity(Medium.setSat_p(p_v));
        rhov := Medium.dewDensity(Medium.setSat_p(p_v));
        if noEvent(h_n[1] < hl and h_n[2] < hl or h_n[1] > hv and h_n[2] > hv or p_v >= pc - pzero or abs(h_n[2] - h_n[1]) < hzero) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
          k_flow_sh := k_flow_eco;
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
          Pr_flow_sh := Pr_flow_eco;
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
          mu_flow_sh := mu_flow_eco;
          w_flow_v_eco := D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
          Re_flow_sh := Re_flow_eco;
        elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] >= hl and h_n[2] <= hv) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, h_v));
          k_flow_sh := k_flow_eco;
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, h_v));
          Pr_flow_sh := Pr_flow_eco;
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, h_v)), 1.503e-004);
          mu_flow_sh := mu_flow_eco;
          w_flow_v_eco := D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := w_flow_v_eco "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * rho_v / mu_flow_eco);
          Re_flow_sh := Re_flow_eco;
        elseif noEvent(h_n[1] < hl and h_n[2] >= hl and h_n[2] <= hv) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
          mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
          w_flow_v_eco := D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
          Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
        elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] > hv) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
          mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
          w_flow_v_eco := D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
          Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
        elseif noEvent(h_n[1] < hl and h_n[2] > hv) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl)));
          Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2])));
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[1] + hl))), 1.503e-004);
          mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[2]))), 1.503e-004);
          w_flow_v_eco := D_flow_v / (0.5 * (rho_n[1] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[2])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[1] + rhol) / mu_flow_eco);
          Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[2]) / mu_flow_sh);
        elseif noEvent(h_n[1] >= hl and h_n[1] <= hv and h_n[2] < hl) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
          mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
          w_flow_v_eco := D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
          Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
        elseif noEvent(h_n[1] > hv and h_n[2] < hl) then
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
          mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
          w_flow_v_eco := D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
          Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
        else
          k_flow_eco := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          k_flow_sh := Medium.thermalConductivity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          Pr_flow_eco := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl)));
          Pr_flow_sh := Medium.prandtlNumber(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1])));
          mu_flow_eco := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (h_n[2] + hl))), 1.503e-004);
          mu_flow_sh := max(Medium.dynamicViscosity(Medium.setState_ph(p_v, 0.5 * (hv + h_n[1]))), 1.503e-004);
          w_flow_v_eco := D_flow_v / (0.5 * (rho_n[2] + rhol)) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          w_flow_v_sh := D_flow_v / (0.5 * (rhov + rho_n[1])) / f_flow "Расчет скорости потока вода/пар в конечных объемах";
          Re_flow_eco := abs(w_flow_v_eco * Din * 0.5 * (rho_n[2] + rhol) / mu_flow_eco);
          Re_flow_sh := abs(w_flow_v_sh * Din * 0.5 * (rhov + rho_n[1]) / mu_flow_sh);
        end if;
// 1-phase or almost uniform properties
// 2-phase
// liquid/2-phase
// 2-phase/vapour
// liquid/2-phase/vapour
// 2-phase/liquid
// vapour/2-phase/liquid
// vapour/2-phase
        A_alfa := min(max((hl - h_n[1]) / max(h_n[2] - h_n[1], 0.01), 0), 1);
        C_alfa := min(max((h_n[2] - hv) / max(h_n[2] - h_n[1], 0.01), 0), 1);
        alfa_flow_eco := 0.023 * k_flow_eco / Din * Re_flow_eco ^ 0.8 * Pr_flow_eco ^ 0.4;
        alfa_flow_sh := 0.023 * k_flow_sh / Din * Re_flow_sh ^ 0.8 * Pr_flow_sh ^ 0.4;
        alfa_flow := ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) * alfa_flow_eco + ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2) * alfa_flow_sh + (1 - ((-6 / 3 * A_alfa ^ 3) + 6 / 2 * A_alfa ^ 2) - ((-6 / 3 * C_alfa ^ 3) + 6 / 2 * C_alfa ^ 2)) * 20000;
      end alpha;
    end thermal;

    model flowSide_SH
      import MyHRSG_lite.cleanCopy.functions.alfaForSH;
      extends BaseClases.flowSideHE(redeclare replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model");
      Medium_F.ThermodynamicState stateFlow_n[2] "Термодинамическое состояние потока вода/пар на участках трубопровода";
      Real der_h_n[2] "Производняа энтальпии потока вода/пар";
      Medium_F.Density rho_n[2] "Плотность потока по участкам трубы в конечных объемах";
      Modelica.SIunits.DerDensityByEnthalpy drdh_v1 "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_v2 "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByEnthalpy drdh_n[2] "Производная плотности потока по энтальпии на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_v "Производная плотности потока по давлению на участках ряда труб";
      Modelica.SIunits.DerDensityByPressure drdp_n[2] "Производная плотности потока по давлению на участках ряда труб";
      Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
      Medium_F.DynamicViscosity mu_flow "Динамическая вязкость для потока вода/пар";
      Modelica.SIunits.HeatFlowRate Q_flow "тепло переданное стенке трубы";
      Modelica.SIunits.Temperature t_m(start = t_startM) "Температура металла на участках трубопровода";
      Medium_F.SaturationProperties sat_v "State vector to compute saturation properties внутри конечного объема";
      Medium_F.SpecificEnthalpy hl "Энтальпия воды на линии насыщения";
      Medium_F.SpecificEnthalpy hv "Энтальпия пара на линии насыщения";
      //Интерфейс
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      0.5 * deltaVFlow * rho_v * der(h_v) = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_n[1] * (h_v - h_n[1]) "Уравнение баланса тепла теплоносителя (ур-е 3-1d1 диссерации Рубашкина)";
      0.5 * deltaVFlow * rho_v * der_h_n[2] = 0.5 * alfa_flow * deltaSFlow * (t_m - t_flow) - D_flow_v * (h_n[2] - h_v) "Уравнение баланса тепла теплоносителя (ур-е 3-1d2 диссерации Рубашкина)";
//Уравнение теплового баланса металла
      deltaMMetal * C_m * der(t_m) = Q_flow - alfa_flow * deltaSFlow * (t_m - t_flow) "Уравнение баланса тепла металла (формула 3-2в диссертации Рубашкина)";
//Уравнения для heat
      heat.Q_flow = Q_flow;
      heat.T = t_m;
//Уравнения состояния
      stateFlow = Medium_F.setState_ph(p_v, h_v);
      t_flow = Medium_F.temperature(stateFlow);
      mu_flow = if Medium_F.dynamicViscosity(stateFlow) < 1.503e-004 then 1.503e-004 else Medium_F.dynamicViscosity(stateFlow);
      w_flow_v = D_flow_v / rho_v / f_flow "Расчет скорости потока вода/пар в конечных объемах";
      alfa_flow = alfaForSH(h_v = h_v, D_flow_n1 = D_flow_n[1], p_v = p_v, Din = Din, f_flow = f_flow);
      D_flow_v = (D_flow_n[2] + D_flow_n[1]) / 2;
//Уравнения из ThermoPower.Water.Flow1DFEM2ph
      D_flow_n[2] = D_flow_n[1] - C1 - C2 "Уравнение сплошности (формула 3-6 диссертации Рубашкина)";
      C1 = deltaVFlow * ((-1e-7) * der_h_n[1] + (-1e-7) * der_h_n[2]);
      C2 = deltaVFlow * 1e-8 * der(p_v);
      rho_v = (rho_n[1] + rho_n[2]) / 2;
      drdp_v = (drdp_n[1] + drdp_n[2]) / 2;
      drdh_v1 = drdh_n[1] / 2;
      drdh_v2 = drdh_n[2] / 2;
      for i in 1:2 loop
        stateFlow_n[i] = Medium_F.setState_ph(p_v, h_n[i]);
        drdp_n[i] = Medium_F.density_derp_h(stateFlow_n[i]);
        drdh_n[i] = Medium_F.density_derh_p(stateFlow_n[i]);
        rho_n[i] = Medium_F.density(stateFlow_n[i]);
      end for;
      der_h_n[1] = der(h_n[2]);
      der_h_n[2] = der(h_n[2]);
      sat_v = Medium_F.setSat_p(p_v);
      hl = Medium_F.bubbleEnthalpy(sat_v);
      hv = Medium_F.dewEnthalpy(sat_v);
//Уравнения для расчета процессов массообмена
//Осреднение по конечному объему
      p_v = p_n[1];
//Основное уравнение гидравлики
      lambda_tr = 1 / (1.14 + 2 * log10(Din / ke)) ^ 2;
      Xi_flow = lambda_tr * Lpipe * z2 / zahod / Din;
      dp_fric = w_flow_v ^ 2 * Xi_flow * rho_v / 2 / Modelica.Constants.g_n;
      p_n[1] - p_n[2] = dp_fric "Формула 2-1 из книги Рудомино, Ремжин";
    initial equation
      der(h_v) = 0;
      der(t_m) = 0;
      der(p_v) = 0;
      der(h_n[1]) = 0;
      der(h_n[2]) = 0;
      annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
    end flowSide_SH;

    package BaseClases
      model flowSideHE
        parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
        replaceable package Medium_F = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
        constant Modelica.SIunits.Pressure pzero = 10 "Small deltap for calculations";
        constant Medium_F.AbsolutePressure pc = Medium_F.fluidConstants[1].criticalPressure;
        constant Modelica.SIunits.SpecificEnthalpy hzero = 1e-3 "Small value for deltah";
        parameter Modelica.SIunits.MassFlowRate setD_flow = 78 "Номинальный массовый расход воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Pressure setp_flow_in = 10e5 "Начальное давление потока вода/пар на входе в поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Pressure setp_flow_out = 10e5 "Начальное давление потока вода/пар на выходе поверхности теплообмена" annotation(Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Temperature setT_inFlow = 60 + 273.15 "Начальная входная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Temperature setT_outFlow = 80 + 273.15 "Начальная выходная температура потока воды/пар" annotation(Dialog(group = "Параметры стороны вода/пар"));
        parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
        parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
        parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
        //Характеристики металла
        parameter Modelica.SIunits.Density rho_m = 7800 "Плотность металла" annotation(Dialog(group = "Металл"));
        parameter Modelica.SIunits.SpecificHeatCapacity C_m = 578.05 "Удельная теплоемкость металла" annotation(Dialog(group = "Металл"));
        parameter Modelica.SIunits.ThermalConductivity lambda_m = 20 "Теплопроводность метала" annotation(Dialog(group = "Металл"));
        //Конструктивные характеристики
        parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length s1 = 79e-3 "Поперечный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length s2 = 92.2e-3 "Продольный шаг" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer zahod = 1 "заходность труб теплообменника" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer z1 = 78 "Число труб по ширине газохода" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Integer z2 = 2 "Число труб по ходу газов в данной поверхности нагрева" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length Lpipe = 18.4 "Длина теплообменной трубки" annotation(Dialog(group = "Конструктивные характеристики"));
        parameter Modelica.SIunits.Length ke = 0.00014 "Абсолютная эквивалентная шероховатость";
        //Поток вода/пар
        parameter Modelica.SIunits.Area deltaSFlow = Lpipe * Modelica.Constants.pi * Din * z1 * z2 "Внутренняя площадь одного участка ряда труб";
        parameter Modelica.SIunits.Volume deltaVFlow = Lpipe * Modelica.Constants.pi * Din ^ 2 * z1 * z2 / 4 "Внутренний объем одного участка ряда труб";
        parameter Modelica.SIunits.Mass deltaMMetal = rho_m * Lpipe * Modelica.Constants.pi * ((Din + delta) ^ 2 - Din ^ 2) * z1 * z2 / 4 "Масса металла участка ряда труб";
        parameter Modelica.SIunits.Area f_flow = Modelica.Constants.pi * Din ^ 2 * z1 * zahod / 4 "Площадь для прохода теплоносителя";
        //Начальные значения
        parameter Medium_F.SpecificEnthalpy h_startFlow_n[2] = fill(seth_in, 2) "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
        parameter Medium_F.SpecificEnthalpy h_startFlow_v = seth_in "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
        parameter Medium_F.AbsolutePressure p_startFlow_v = setp_flow_in "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
        parameter Medium_F.AbsolutePressure p_startFlow_n[2] = fill(setp_flow_in, 2) "Начальный вектор давлений потока вода/пар" annotation(Dialog(tab = "Инициализация"));
        parameter Medium_F.MassFlowRate D_startFlow_v = setD_flow "Начальный вектор массового расхода потока вода/пар по конечным объемам" annotation(Dialog(tab = "Инициализация"));
        parameter Medium_F.MassFlowRate D_startFlow_n[2] = fill(setD_flow, 2) "Начальный вектор массового расхода потока вода/пар по узловым точкам" annotation(Dialog(tab = "Инициализация"));
        //Металл
        parameter Modelica.SIunits.Temperature t_startM = setTm "Начальный вектор энальпии потока газов" annotation(Dialog(tab = "Инициализация"));
        //Переменные
        Medium_F.ThermodynamicState stateFlow "Термодинамическое состояние потока вода/пар на участках трубопровода";
        Medium_F.Temperature t_flow "Температура потока вода/пар по участкам трубы";
        Medium_F.AbsolutePressure p_v(start = p_startFlow_v) "Давление потока вода/пар по участкам трубы в конечных объемах";
        Medium_F.AbsolutePressure p_n[2](start = p_startFlow_n) "Давление потока вода/пар по участкам трубы в узловых точках";
        Medium_F.SpecificEnthalpy h_v(start = h_startFlow_v) "Энтальпия потока вода/пар по участкам трубы в конечных объемах";
        Medium_F.SpecificEnthalpy h_n[2](start = h_startFlow_n) "Энтальпия потока вода/пар по участкам трубы в узловых точках";
        Medium_F.Density rho_v "Плотность потока по участкам трубы в конечных объемах";
        Medium_F.MassFlowRate D_flow_v(start = D_startFlow_v) "Массовый расход потока вода/пар по участкам ряда труб";
        Medium_F.MassFlowRate D_flow_n[2](start = D_startFlow_n) "Массовый расход потока вода/пар по участкам ряда труб";
        Modelica.SIunits.CoefficientOfHeatTransfer alfa_flow "Коэффициент теплопередачи со стороны потока вода/пар";
        Modelica.SIunits.HeatFlowRate Q_flow "тепло переданное стенке трубы";
        Modelica.SIunits.Temperature t_m(start = t_startM) "Температура металла на участках трубопровода";
        Real C1 "Показатель в числителе уравнения сплошности";
        Real C2 "Показатель в знаменателе уравнения сплошности";
        Modelica.SIunits.Velocity w_flow_v "Скорость потока вода/пар в конечных объемах";
        Real dp_fric "Потеря давления из-за сил трения";
        Real Xi_flow "Коэффициент гидравлического сопротивления участка трубы";
        Real lambda_tr "Коэффициент трения";
        //Интерфейс
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat annotation(Placement(visible = false, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Fluid.Interfaces.FluidPort_b waterOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -120}, extent = {{-21, -20}, {21, 20}}, rotation = 0)));
        Modelica.Fluid.Interfaces.FluidPort_a waterIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.66454e-15, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
//Граничные условия
        waterIn.m_flow = D_flow_n[1];
        waterOut.m_flow = -D_flow_n[2];
        waterOut.p = p_n[2];
        waterIn.p = p_n[1];
        h_n[1] = inStream(waterIn.h_outflow);
        waterOut.h_outflow = h_n[2];
        waterIn.h_outflow = h_n[1];
        annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), Diagram(graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-2, 52}, lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name")}));
      end flowSideHE;
    end BaseClases;

    model GFHE_new
      extends HE_Icon;
      parameter Medium_F.MassFlowRate m_flow_small = 0.01 "Минимальный расход";
      //***Исходные данные для газовой стороны
      //**
      replaceable package Medium_G = MyHRSG_lite.ExhaustGas constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wgas "Номинальный (и начальный) массовый расход газов";
      parameter Modelica.SIunits.Pressure pgas "Начальное давление газов";
      parameter Modelica.SIunits.Temperature Tingas "Начальная входная температура газов";
      parameter Modelica.SIunits.Temperature Toutgas "Начальная выходная температура газов";
      //parameter Modelica.SIunits.Temperature T2gas = (Tingas + Toutgas) / 2 "Промежуточная температура газов";
      parameter Real k_gamma_gas "Поправка к коэффициенту теплоотдачи со стороны газов";
      parameter Real Set_X[6] "Состав дымовых газов";
      //**
      //***Исходные данные для водяной стороны
      //**
      replaceable package Medium_F = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.SIunits.MassFlowRate wflow "Номинальный массовый расход воды/пар";
      parameter Modelica.SIunits.Pressure pflow_in "Начальное давление потока вода/пар на входе";
      parameter Modelica.SIunits.Pressure pflow_out "Начальное давление потока вода/пар на выходе";
      parameter Modelica.SIunits.Temperature Tinflow "Начальная входная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature Toutflow "Начальная выходная температура потока воды/пар";
      parameter Modelica.SIunits.Temperature setTm "Начальная температура металла поверхностей нагрева";
      parameter Medium_F.SpecificEnthalpy seth_in "Начальная входная энтальпия";
      parameter Medium_F.SpecificEnthalpy seth_out "Начальная выходная энтальпия";
      //**
      //***Исходные данные по разбиению
      //**
      parameter Integer numberOfTubeSections = 3 "Число участков разбиения трубы" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberPMCalcSections = 3 "Число участков разбиения трубы входящих в один участок расчета процессов массообмена" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfFlueSections = z2 "Число участков разбиения газохода" annotation(Dialog(group = "Конструктивные характеристики"));
      parameter Integer numberOfVolumes = numberOfFlueSections * numberOfTubeSections "Число участков разбиения";
      //**
      //***конструктивные характеристики
      //**
      parameter MyHRSG_lite.Choices.HRSG_type HRSG_type_set = Choices.HRSG_type.horizontalBottom "Выбор типа КУ (горизонтальный/вертикальный)";
      parameter Modelica.SIunits.Diameter Din = 0.038 "Внутренний диаметр трубок теплообменника";
      parameter Modelica.SIunits.Length delta = 0.003 "Толщина стенки трубки теплообменника";
      parameter Modelica.SIunits.Length s1 = 82e-3 "Поперечный шаг";
      parameter Modelica.SIunits.Length s2 = 110e-3 "Продольный шаг";
      parameter Integer zahod = 2 "заходность труб теплообменника";
      parameter Integer z1 = 126 "Число труб по ширине газохода";
      parameter Integer z2 = 6 "Число труб по ходу газов в теплообменнике";
      parameter Modelica.SIunits.Length Lpipe = 20.85 "Длина теплообменной трубки";
      ///Оребрение
      parameter Modelica.SIunits.Length delta_fin = 0.0008 "Средняя толщина ребра, м";
      parameter Modelica.SIunits.Length hfin = 0.017 "Высота ребра, м";
      parameter Modelica.SIunits.Length sfin = 0.00404 "Шаг ребер, м";
      //Переменные
      Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)";
      Modelica.SIunits.Length deltaHpipe[numberOfFlueSections, numberOfTubeSections] "Разность высот на участке ряда труб";
      ////
      //////
      ////
      Modelica.Fluid.Interfaces.FluidPort_b gasOut(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a gasIn(redeclare package Medium = Medium_G) annotation(Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b flowOut(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a flowIn(redeclare package Medium = Medium_F) annotation(Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-42, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      gasSideHE gasHE[numberOfFlueSections, numberOfTubeSections](redeclare package Medium_G = Medium_G, setD_gas = wgas, setp_gas = pgas, setT_inGas = Tingas, setT_outGas = Toutflow, k_alfaGas = k_gamma_gas, numberOfVolumes = numberOfVolumes, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe, delta_fin = delta_fin, hfin = hfin, sfin = sfin) annotation(Placement(visible = true, transformation(origin = {0, 50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
      replaceable flowSide_OTE flowHE[numberOfFlueSections, numberOfTubeSections](setD_flow = wflow, setp_flow_in = pflow_in, setp_flow_out = pflow_out, setT_inFlow = Tinflow, setT_outFlow = Toutflow, Din = Din, delta = delta, s1 = s1, s2 = s2, zahod = zahod, z1 = z1, z2 = z2, Lpipe = Lpipe / numberOfVolumes, seth_in = seth_in, seth_out = seth_out, setTm = setTm, m_flow_small = m_flow_small) annotation(Placement(visible = true, transformation(origin = {0, -50}, extent = {{-30, -30}, {30, 30}}, rotation = 90)));
    equation
    
      for i in 1:numberOfFlueSections loop
        hod[i] = (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева(минус 1 - нечетный, плюс 1 - четный)";
      end for;
      
      if HRSG_type_set == MyHRSG_lite.Choices.HRSG_type.verticalBottom or HRSG_type_set == MyHRSG_lite.Choices.HRSG_type.verticalTop then
        deltaHpipe = fill(0, numberOfFlueSections, numberOfTubeSections);
      else
        for i in 1:numberOfFlueSections loop
          for j in 1:numberOfTubeSections loop
            if HRSG_type_set == MyHRSG_lite.Choices.HRSG_type.horizontalBottom then
              deltaHpipe[i, j] = (-1) * hod[i * (j - 1) + j] * Lpipe / numberOfTubeSections "Разность высотных отметок труб для горизонтального КУ с нижним входным коллектором";
            elseif HRSG_type_set == MyHRSG_lite.Choices.HRSG_type.horizontalTop then
              deltaHpipe[i, j] = hod[i * (j - 1) + j] * Lpipe / numberOfTubeSections "Разность высотных отметок труб для горизонтального КУ с верхним входным коллектором";
            end if;
          end for;
        end for;
      end if;
      
      for i in 1:numberOfFlueSections - 1 loop
        for j in 1:numberOfTubeSections loop
          connect(gasHE[i, j].gasOut, gasHE[i + 1, j].gasIn) annotation(Line(points = {{36, 50}, {92, 50}, {92, 48}, {92, 48}}, color = {0, 127, 255}));
        end for;
      end for;
      
      for i in 1:numberOfFlueSections loop
        for j in 1:numberOfTubeSections - 1 loop
          connect(flowHE[i, j].waterOut, flowHE[i, j + 1].waterIn) annotation(Line(points = {{36, -50}, {94, -50}, {94, -50}, {94, -50}}, color = {0, 127, 255}));                
        end for;      
      end for;
      //Гибы
      for i in 1:numberOfFlueSections-zahod loop
          connect(flowHE[i, numberOfTubeSections].waterOut, flowHE[i + zahod, 1].waterIn) annotation(Line(points = {{36, -50}, {94, -50}, {94, -50}, {94, -50}}, color = {0, 127, 255}));   
      end for;
        
      for i in 1:numberOfFlueSections loop
        for j in 1:numberOfTubeSections loop
          connect(flowHE[i, j].heat, gasHE[i, j].heat);
        end for;
      end for;
      
      
      //Граничные условия
      //Газы
      for j in 1:numberOfTubeSections loop
        connect(gasHE[numberOfFlueSections, j].gasOut, gasOut) annotation(Line(points = {{36, 50}, {92, 50}, {92, 48}, {92, 48}}, color = {0, 127, 255}));
        connect(gasIn, gasHE[1, j].gasIn) annotation(Line(points = {{-90, 50}, {-34, 50}, {-34, 48}, {-34, 48}}));
      
        //gasIn.h_outflow = h_gas[1];
        //gasOut.h_outflow = h_gas[2];
        //gasIn.Xi_outflow = inStream(gasOut.Xi_outflow);
        //inStream(gasIn.Xi_outflow) = gasOut.Xi_outflow;
        //gasIn.m_flow - deltaDGas[1] = 0;
        //gasOut.m_flow + deltaDGas[2] = 0;
        //gasOut.p = gasIn.p - deltaP;
      
      end for;
      //Воды/Пар
      for i in 1:zahod loop
        //connect(flowIn, flowHE[i, 1].waterIn) annotation(Line(points = {{-90, -50}, {-34, -50}, {-34, -50}, {-34, -50}}));  
        connect(flowHE[numberOfFlueSections - (i - 1), numberOfTubeSections].waterOut, flowOut) annotation(Line(points = {{36, -50}, {94, -50}, {94, -50}, {94, -50}}, color = {0, 127, 255}));
    
      
        flowHE[i, 1].waterIn.m_flow + flowIn.m_flow / zahod = 0;
        //flowHE[numberOfFlueSections - (i - 1), numberOfTubeSections].waterOut.p = flowOut.p;
        flowHE[i, 1].waterIn.h_outflow = inStream(flowIn.h_outflow);
             
      end for;
        //sum(flowHE[numberOfFlueSections - (i - 1), numberOfTubeSections].waterOut.m_flow for i in (numberOfFlueSections - zahod):numberOfFlueSections) + flowOut.m_flow = 0;
        //sum(inStream(flowHE[numberOfFlueSections - (i - 1), numberOfTubeSections].waterOut.h_outflow) for i in (numberOfFlueSections - zahod):numberOfFlueSections) / zahod = flowOut.h_outflow;
        sum(flowHE[i, 1].waterIn.p for i in 1:zahod) / zahod = flowIn.p;
      annotation(Documentation(info = "<HTML>Модель теплообменника с heatPort. Моделируется несколько ходов. Кипение. Модель воды - Modelica.Media.Water.WaterIF97_ph. Первый заход труб номеруется с 1, второй также с 1. Т.е. во всех заходах поток с одним знаком, и разность давлений с одним знаком (другое описание гибов).</html>"), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02), version = "", uses);
    end GFHE_new;
  end cleanCopy;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), uses(Modelica(version = "3.2.2"), ThermoPower(version = "3.1")));
end MyHRSG_lite;
