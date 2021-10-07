unit _CounterClass;

{-------------------------------}
interface

type
  CounterClass = class
  
  public
    static function multiply(a, b: integer): integer;
    static function substract(a, b: integer): integer;
    static function divide(a, b: integer): (integer, integer);
  private
    static function getSign(a, b: integer): integer;
  end;

{-------------------------------}
implementation

{$region public methods}

static function CounterClass.multiply(a, b: integer): integer;
begin
  if (a = 0) or (b = 0) then exit;
  var resSign := getSign(a, b);
  a := Abs(a);
  b := Abs(b);
  loop b do Result += a;
  if (resSign = (Integer.MinValue + Integer.MaxValue)) then Result := Result xor (Integer.MinValue + Integer.MaxValue) + 1;
end;

static function CounterClass.substract(a, b: integer): integer :=
  a + 1 + (b xor (Integer.MinValue + Integer.MaxValue));

static function CounterClass.divide(a, b: integer): (integer, integer);
begin
  if (a = 0) then 
  begin
    result := (0, 0);
    exit;
  end;
  if (b = 0) then
  begin
    result := (a > 0) ? (integer.MaxValue, integer.MaxValue) : 
                        (integer.MinValue, integer.MinValue);
    exit;
  end;
  var resSign := getSign(a, b);
  a := Abs(a);
  b := Abs(b);
  var quotient := 0;
  while (a >= b) do
  begin
    quotient += 1;
    a := substract(a, b);
  end;
  var remainder := a;
  if (resSign = (Integer.MinValue + Integer.MaxValue)) then 
  begin
    quotient := quotient xor (Integer.MinValue + Integer.MaxValue) + 1;
    remainder := remainder xor (Integer.MinValue + Integer.MaxValue) + 1;
  end;
  result := (quotient, remainder);
end;

{$endregion public methods}

{$region private methods}

static function CounterClass.getSign(a, b: integer): integer;
begin
  if (a = b) then result := 0 else
  result := (Sign(a) = Sign(b)) ? 1 : (Integer.MinValue + Integer.MaxValue);
end;

{$endregion private methods}

{---------------------------------}
begin
end . 
