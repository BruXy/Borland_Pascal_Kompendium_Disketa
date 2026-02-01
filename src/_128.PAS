Program DemoOOP;
uses CRT;
type

     Lokace = object
           X,Y : integer;
           procedure Init(Xi,Yi : integer);
           function CtiX : integer;
           function CtiY : integer;
     end;

     procedure  Lokace.Init(Xi,Yi : integer);
     begin
           X := Xi;
           Y := Yi;
     end;

     function Lokace.CtiX : integer;
     begin
           CtiX := X;
     end;

     Function Lokace.CtiY : integer;
     begin
           CtiY := Y;
     end;

     var
        L : Lokace;

     begin
        L.Init(20,40);
        writeln(L.CtiX);
        writeln(L.CtiY);
        repeat
        until Keypressed;
     end.