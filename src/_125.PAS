Program DemoOOP;

type
   Lokace = object
               X, Y : integer;
               procedure Init(Xn, Yn : integer);
            end;

procedure Lokace.Init(Xn, Yn : integer);
begin
   X := Xn;
   Y := Yn;
end;

begin
end.
