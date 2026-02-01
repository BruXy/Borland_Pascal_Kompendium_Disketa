Program DemoOOP;

type
   Lokace = object
               X : integer;
               Y : integer;
            end;
var
   L : Lokace;
begin
   L.X := 5;
   L.Y := 6;
   with L do
   begin
      X := 5;
      Y := 6;
   end;
end.