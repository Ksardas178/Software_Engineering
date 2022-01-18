##
  var input := ReadString('Insert sequence');
  var count := 0;
  foreach var s in input do
  begin
    case s of
      '(': count += 1;
      ')': count -= 1;
    end;
  end;
  if (count = 0) then println('Correct') else println('Incorrect');