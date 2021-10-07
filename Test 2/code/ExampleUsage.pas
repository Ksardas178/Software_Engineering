uses _CounterClass;

begin
  var (a, b) := ReadlnInteger2('Insert numbers: ');
  
  $'Miltiplication: {a} * {b} = {CounterClass.multiply(a,b)}'.Println;
  $'Substraction: {a} - {b} = {CounterClass.substract(a,b)}'.Println;
  var divRes := CounterClass.divide(a,b);
  $'Division: {a} / {b} = {divRes.Item1}. Remainder = {divRes.Item2}'.Println;
end.
