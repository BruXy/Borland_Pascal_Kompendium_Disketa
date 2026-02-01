type
   Lokace = object
               procedure Init(xi, Yi : integer);
               function CtiX : integer;
               function CtiY : integer;
            private
               X, Y : integer;
            end;

   Bod    = object(Lokace)
               procedure Init(Xi, Yi : integer);
               procedure Zobraz;
               procedure Zhasni;
               procedure NastavBarvu(KodBarvy : byte);
               function CtiBarvu : byte;
               function Stav : boolean;
               procedure Posuv(Xn, Yn : integer);
            private
               Viditelnost : boolean;
               Barva       : byte;
            end;