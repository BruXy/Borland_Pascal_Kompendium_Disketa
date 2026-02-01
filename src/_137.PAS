     unit _137;    { Virtu ln¡ metody a polymorfn¡ objekty.}

     interface                        

     uses Graph, CRT;

     type
         Lokace = object
           X,Y : integer;
           procedure Init(Xi,Yi : integer);
           function CtiX : integer;
           function CtiY : integer;
         end;

         Bod = object(Lokace)
           Viditelnost : boolean;
           Barva       : byte;
           constructor Init(Xi,Yi : integer);
           procedure NastavBarvu(KodBarvy : byte);
           procedure Zobraz; virtual;
           procedure Zhasni; virtual;
           function Stav : boolean;
           procedure Posuv(Xn,Yn : integer);
           procedure Pohyb(B : integer); virtual;
        end;

     implementation

     { Metody objektu Lokace }

     procedure Lokace.Init(Xi,Yi : integer);
     begin
        X := Xi;
        Y := Yi;
     end;

     function Lokace.CtiX : integer;
     begin
        CtiX := X;
     end;

     function Lokace.CtiY : integer;
     begin
        CtiY := Y;
     end;

     { Implementace metod objektu Bod }

     constructor Bod.Init(Xi,Yi : integer);
     begin
        Lokace.Init(Xi,Yi);
        Barva:=Graph.GetColor;
        Viditelnost := False;
     end;

     procedure Bod.NastavBarvu(KodBarvy : byte);
     { Nastav¡ barvu bodu. }
     begin
        Barva := KodBarvy;
        Graph.SetColor(KodBarvy);
     end;

     procedure Bod.Zobraz;
     begin
        Viditelnost := True;
        Graph.PutPixel(X,Y,Barva);
     end;

     procedure Bod.Zhasni;
     begin
        Viditelnost := False;
        Graph.PutPixel(X,Y,Graph.GetBkColor);
     end;

     function Bod.Stav : boolean;
     begin
        Stav := Viditelnost;
     end;

     procedure Bod.Posuv(Xn,Yn : integer);
     begin
        Zhasni;
        X := Xn;
        Y := Yn;
        Zobraz;
     end;

     function GetDelta(var Dx,Dy : integer) : boolean;
     var
        Key : Char;
        Quit : boolean;
     begin
        Dx := 0;               { 0 - beze zmˆny }
        Dy := 0;
        GetDelta := True;
        repeat
           Key := CRT.ReadKey; { €te znak z kl vesnice. }
           Quit := True;
           case ord(Key) of
             0 : begin         { byla stisknuta ©¡d¡c¡ kl. }
                    key := CRT.readkey;
                    case ord(key) of
                       72 : Dy := -1;   { ¨ipka nahoru }
                       80 : Dy := 1;    { ¨ipka dol– }
                       75 : Dx := -1;   { ¨ipka vlevo }
                       77 : Dx := 1;    { ¨ipka vpravo }
                    else Quit := False;
                    end;
                 end;
            13 : GetDelta := False;     { kl vesa CR }
            else Quit := False;         { ignoruj jinou kl.}
            end;
        until Quit;
     end;

     procedure Bod.Pohyb(B : integer);
     var
        Dx,Dy : integer;
        Px,Py : integer;
     begin
        Zobraz;              { Zobraz obrazec. }
        Px := GetX;          { Nastaven¡ aktu ln¡ch sou©ad.}
        Py := GetY;
        while GetDelta(Dx,Dy) do
        begin
           Px := Px + (Dx * B);
           Py := Py + (Dy * B);
           Posuv(Px,Py);
        end;
     end;

     end.


