program Priklad015;

type
   Bod = record
            X, Y : integer;
         end;

var
   X, Y : integer;
   B    : Bod;

begin
   with B do
   begin
      X := 5;
      Y := 8;
   end;
end.