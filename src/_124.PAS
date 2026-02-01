Program DemoOOP;

type
   Lokace = object
               X : integer;
               Y : integer;
            end;
   BodPtr = ^Bod;
   Bod    = object(Lokace)
               Stav : boolean;
            end;

var
   StatickyBod  : Bod;
   DynamickyBod : BodPtr;

begin
end.