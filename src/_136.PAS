Program _136;

type
   Lokace = object
      X, Y : integer;
      procedure Init(Xi, Yi : integer);
      function CtiX : integer;
      function CtiY : integer;
   end;
   Bod = object(Lokace)
      Viditelnost : boolean;
      Barva       : byte;
      constructor Init(Xi, Yi : integer);
      procedure NastavBarvu(KodBarvy : byte);
      procedure Zobraz;
      procedure Zhasni;
      function Stav : boolean;
      procedure Posuv(Xn, Yn : integer);
   end;
   Kruh = object(Bod)
      R : integer;
      constructor Init(Xi, Yi : integer);
      procedure Zobraz; virtual;
      procedure Zhasni; virtual;
      procedure Zvets(E : integer); virtual;
      procedure Zmensi(C : integer); virtual;
   end;
