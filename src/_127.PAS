     unit Lokace;
     interface
     var
           X,Y : integer;
     procedure Init(Xi,Yi : integer);
     function GetX : integer;
     function GetY : integer;
     implementation
     procedure  Init(Xi,Yi : integer);
     begin
           X := Xi;
           Y := Yi;
     end;
     function GetX : integer;
     begin
           GetX := X;
     end;
     Function GetY : integer;
     begin
           GetY := Y;
     end;
     end.
