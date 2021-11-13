##

var a := new Integer[20];
a.FillRandom(0, 50);
a.Println;

var num, res, diff: Integer;

Readln(num);
diff := abs(a[0] - num);

for var i := 1 to (a.Length - 1) do
begin
  var newDiff := abs(a[i] - num);
  if (diff > newDiff) then
  begin
    diff := newDiff;
    res := a[i];
  end;
end; 

Write(res);
