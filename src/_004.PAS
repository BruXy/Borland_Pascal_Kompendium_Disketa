program Priklad004;

uses Graph;
type
   Lokace = object
   	       X, Y : integer;
               procedure Init(Xi,Yi : integer);
            end;

   Bod    = object(Lokace)
               Viditelnost : boolean;
               procedure Init(Xi, Yi : integer;
	                 ViditelnostI: boolean);
               procedure Rozsvit;
               procedure Zhasni;
               procedure Posuv(Dx, Dy : integer);
            end;

procedure Lokace.Init(Xi, Yi : integer);
begin
   X := Xi;
   Y := Yi;
end;

procedure Bod.Init(Xi, Yi : integer; ViditelnostI : boolean);
begin
   Viditelnost := ViditelnostI;
   Lokace.Init(Xi, Yi);
end;

procedure Bod.Rozsvit;
begin
   Graph.PutPixel(X,Y,Graph.GetColor);
end;

procedure Bod.Zhasni;
begin
   Graph.PutPixel(X,Y,Graph.GetBkColor);
end;

procedure Bod.Posuv(Dx,Dy : integer);
begin
   Bod.Zhasni;
   X := X+Dx;
   Y := Y+Dy;
   Bod.Rozsvit;
end;

begin
end.