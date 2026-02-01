Program DemoOOP;

type
   Pozice = object
               X, Y : integer;
               procedure Init(Xn, Yn : integer);
            end;

procedure Pozice.Init(Xn, Yn : integer);
begin
   Self.X := Xn;
   Self.Y := Yn;
end;

begin
end.