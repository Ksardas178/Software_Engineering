const
  INT_LENGTH = 10;
  DIV_ACC = 15;
  MIN_FRACT = 0.000030517578125;

type
  IntB = array of Integer;

function substract(a, b: Integer): Integer := a + (b xor (-1) + 1);

function convert(a: Integer): IntB;
begin
  result := new Integer[INT_LENGTH];
  if (a < 0) then
  begin
    result[0] := 1;
    a := abs(a);
  end else result[0] := 0;
  
  var pos := 1;
  var testDiv := 1 shl substract(INT_LENGTH, 2);
  repeat
    if (substract(a, testDiv) >= 0) then
    begin
      result[pos] := 1;
      a := substract(a, testDiv);
    end;
    pos += 1;
    testDiv := testDiv shr 1;
  until (pos >= INT_LENGTH);
end;

function convert(a: IntB): Integer;
begin
  var term := 1;
  for var i := 1 to substract(INT_LENGTH, 1) do
  begin
    var index := substract(INT_LENGTH, i);
    if (a[index] = 1) then result += term;
    term += term;
  end;
  if (a[0] = 1) then result := result xor (-1) + 1;
end;

function add(a, b: IntB): IntB;
begin
  result := new Integer[INT_LENGTH];
  var c := 0;
  if (a[0] = b[0]) then
  begin
    result[0] := a[0];
    //1..INT_LENGTH-1
    for var i := 1 to substract(INT_LENGTH, 1) do
    begin
      //INT_LENGTH-1..1
      var index := substract(INT_LENGTH, i);
      result[index] := a[index] xor b[index] xor c;
      c := (a[index] + b[index] + c > 1) ? 1 : 0;
    end;
  end;
end;

function addAbs(a, b: IntB): IntB;
begin
  result := new Integer[INT_LENGTH];
  result[0] := 0;
  var c := 0;
  //1..INT_LENGTH-1
  for var i := 1 to substract(INT_LENGTH, 1) do
  begin
    //INT_LENGTH-1..1
    var index := substract(INT_LENGTH, i);
    result[index] := a[index] xor b[index] xor c;
    c := (a[index] + b[index] + c > 1) ? 1 : 0;
  end;
end;

function shiftLeft(a: IntB; offset: Integer): IntB;
begin
  result := new Integer[INT_LENGTH];
  result.Fill(0);
  //Keep sign
  result[0] := a[0];
  
  for var i := 1 to substract(INT_LENGTH, 1 + offset) do
    result[i] := a[i + offset];
end;

function multiply(a, b: IntB): IntB;
begin
  result := new Integer[INT_LENGTH];
  result.Fill(0);
  
  for var i := 1 to substract(INT_LENGTH, 1) do
  begin
    result := shiftLeft(result, 1);
    if (b[i] = 1) then result := addAbs(result, a);    
  end; 
  
  result[0] := a[0] xor b[0];
end;

function findIndex(a: IntB): Integer;
begin
  for var i := 1 to substract(INT_LENGTH, 1) do
    if (a[i] = 1) then
    begin
      result := i;
      exit;
    end;
  result := -1;
end;

function compare(a, b: IntB): Integer;
begin
  result := 0;
  if (a[0] xor b[0] = 1) then
    result := (a[0] > b[0]) ? -1 : 1 
  else
    for var i := 1 to substract(INT_LENGTH, 1) do
      if (a[i] <> b[i]) then
      begin
        result := ((a[i] > b[i]) xor (a[0] = 1)) ? 1 : -1;
        exit;
      end;
end;

//Unsafe
function substract(a, b: IntB): IntB;
begin
  result := new integer[a.Length];
  result.Fill(0);
  
  var c := 0;  
  for var i := 1 to substract(a.Length, 1) do
  begin
    var index := substract(a.Length, i);
    result[index] := a[index] xor b[index] xor c;
    c := (a[index] - b[index] - c < 0) ? 1 : 0;
  end;
end;

function divide(a, b: IntB): Real;
begin
  var res := new Integer[INT_LENGTH + DIV_ACC];
  res.Fill(0);
  res[0] := a[0] xor b[0];
  
  var (indA, indB) := (findIndex(a), findIndex(b));
  if (indA = -1) and (indB = -1) then result := Real.NaN else
  if (indA = -1) then result := 0 else
  if (indB = -1) then result := (a[0] = 0) ? Real.PositiveInfinity : 
                                             Real.NegativeInfinity else
  begin
    var offset := substract(indA, indB);
    if (offset > 0) then a := shiftLeft(a, offset) else
    if (offset < 0) then b := shiftLeft(b, offset xor (-1) + 1);
    
    for var i := offset to (DIV_ACC + offset) do
    begin
      if (compare(a, b) <> -1) then
      begin
        res[substract(INT_LENGTH, 1) + i] := 1;
        a := substract(a, b);
      end;
      a := shiftLeft(a, 1);
    end;
    
    result := convert(res.slice(0, 1, INT_LENGTH));
    var term := MIN_FRACT;
    for var i := 1 to DIV_ACC do
    begin
      var index := substract(INT_LENGTH + DIV_ACC, i);
      if (res[index] = 1) then result+=term;
      term += term;
    end;
  end;
end;

begin
  //  substract(32, 1).Print;
//  convert(23 * 1).Println('');
  var (a, b) := (convert(1), convert(3));
//  add(a, b).Println('');
//  multiply(a, b).PrintLn('');
//  compare(a, b).Println;
//  convert(b).Println;
  divide(a, b).Println;
end.