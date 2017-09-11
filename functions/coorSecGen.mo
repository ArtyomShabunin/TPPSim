within TPPSim.functions;
function coorSecGen
  input Integer gas_sections;
  input Integer tube_sections;
  output Integer[gas_sections, tube_sections, 2] sections;
algorithm
  for i in 1:gas_sections loop
    for j in 1:tube_sections loop
      sections[i, j, 1] := i;
      sections[i, j, 2] := j;
    end for;
  end for;
  annotation(
    Documentation(info = "<html><head></head><body>Функция генерирует массив с координатами элементов модели</body></html>", revisions = "<html><head></head><body>
    <ul>
      <li><i>August 15, 2017</i>
   by Artyom Shabunin:<br></li>
</ul></body></html>"));
end coorSecGen;