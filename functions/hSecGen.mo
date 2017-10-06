within TPPSim.functions;
function hSecGen
  input Integer numberOfTubeSections "Число участков разбиения трубы";
  input Integer numberOfFlueSections "Число участков разбиения газохода";
  input TPPSim.Choices.HRSG_type HRSG_type_set "Геометрия пучка (горизонтальный/вертикальный)";
  input Integer zahod "Заходность труб теплообменника";
  input Modelica.SIunits.Length Lpipe "Длина теплообменной трубки";  
  Real hod[numberOfFlueSections] "Четность или не четность текущего хода теплообменника (минус 1 - нечетный, плюс 1 - четный)"; 
  output Modelica.SIunits.Length deltaHpipe[numberOfFlueSections, numberOfTubeSections] "Разность высот на участке ряда труб";
algorithm
  for i in 1:numberOfFlueSections loop
    hod[i] := (-1) ^ (i / zahod + (if mod(i, zahod) == 0 then 0 else 1 - mod(i, zahod) / zahod)) "Расчет четный или нечетный текущий ход повехности нагева(минус 1 - нечетный, плюс 1 - четный)";
  end for;
  if HRSG_type_set == TPPSim.Choices.HRSG_type.verticalBottom or HRSG_type_set == TPPSim.Choices.HRSG_type.verticalTop then
    deltaHpipe := fill(0, numberOfFlueSections, numberOfTubeSections);
  else
    for i in 1:numberOfFlueSections loop
      for j in 1:numberOfTubeSections loop
        if HRSG_type_set == TPPSim.Choices.HRSG_type.horizontalBottom then
          deltaHpipe[i, j] := (-1) * hod[i * (j - 1) + j] * Lpipe / numberOfTubeSections "Разность высотных отметок труб для горизонтального КУ с нижним входным коллектором";
        elseif HRSG_type_set == TPPSim.Choices.HRSG_type.horizontalTop then
          deltaHpipe[i, j] := hod[i * (j - 1) + j] * Lpipe / numberOfTubeSections "Разность высотных отметок труб для горизонтального КУ с верхним входным коллектором";
        end if;
      end for;
    end for;
  end if;
  annotation(
    Documentation(info = "<html><head></head><body>Функция генерирует массив с разностями высотных отметок конца и начала участка</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>October 06, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end hSecGen;
