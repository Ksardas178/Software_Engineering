unit _CounterClass;

{-------------------------------}
interface

type
  CounterClass = class
  
  public
    static function multiply(a, b: Integer): Integer;
    static function substract(a, b: Integer): Integer;
    static function divide(a, b: Integer): (Integer, Integer);
  private
    static function getSign(a, b: Integer): Integer;
  end;

{-------------------------------}
implementation

{$region public methods}

static function CounterClass.multiply(a, b: Integer): Integer;
begin
  if (a = 0) or (b = 0) then exit;
  var resSign := getSign(a, b);
  a := Abs(a);
  b := Abs(b);
  loop b do result += a;
  if (resSign = (Integer.MinValue + Integer.MaxValue)) then 
    result := result xor (Integer.MinValue + Integer.MaxValue) + 1;
end;

static function CounterClass.substract(a, b: Integer): Integer :=
  a + 1 + (b xor (Integer.MinValue + Integer.MaxValue));

static function CounterClass.divide(a, b: Integer): (Integer, Integer);
begin
  if (a = 0) then 
  begin
    result := (0, 0);
    exit;
  end;
  if (b = 0) then
  begin
    result := (a > 0) ? (Integer.MaxValue, Integer.MaxValue) : 
                        (Integer.MinValue, Integer.MinValue);
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

static function CounterClass.getSign(a, b: Integer): Integer;
begin
  if (a = b) then result := 0 else
  result := (Sign(a) = Sign(b)) ? 1 : (Integer.MinValue + Integer.MaxValue);
end;

{$endregion private methods}

{---------------------------------}
begin
end . 
