Program DemoOOP;

type
   Lokace  = object
                X : integer;
                Y : integer;
             end;
   Bod     = object(Lokace)
                Stav : boolean;
             end;
   BodX = record
             Pozice : Lokace;
             Stav   : Boolean;
          end;
begin
end.
