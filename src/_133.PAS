Program DemoOOP;

type
   Lokace = object
               X, Y : integer;
               procedure Init(Xi, Yi : integer);
            end;
   Bod = object(Lokace)
            Viditelnost : boolean;
            procedure Init(Xi, Yi : integer);
            procedure Zobraz;
            procedure Zhasni;
            function Stav : boolean;
            procedure Posuv(Xn, Yn : integer);
         private
            Barva : byte;
            procedure NastavBarvu(KodBarvy : byte);
         end;

