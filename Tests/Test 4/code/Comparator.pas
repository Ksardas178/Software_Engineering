
function compare(s1, s2: String): Boolean;
begin
  result := false;
  if (s1.Length = s2.Length) then
  begin
    //CP866
    var letters: array[0..255] of Integer;
    foreach var l in s1 do
      letters[Ord(l)] += 1;
    
    foreach var l in s2 do
    begin
      letters[Ord(l)] -= 1;
      if (letters[Ord(l)] < 0) then Exit;
    end;
    result := true;
  end;
end;

begin
  var (s1, s2) := ('T  34', '  4T3');
  if compare(s1, s2) then Writeln('Yes') else Writeln('No');
end.