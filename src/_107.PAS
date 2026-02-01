Program Kompenz;

uses Graph, GraphIni, CRT;

procedure AspectDemoKruh;
var
  X, Y       : integer;      { sou©adnice st©edu }
  R          : word;         { polomˆr kru‘nice }
  Xasp, Yasp : word;         { pomˆr stran graf. re‘imu }
  I          : integer;      { ‡¡ta‡ }
begin
   X := GetMaxX div 2;       { z kladn¡ sou©adnice }
   Y := GetMaxY div 2;
   R := GetMaxY div 2;
   Circle(X, Y, R);
   GetAspectRatio(Xasp, Yasp);
   SetColor(LightRed);
   for I := 1 to 15 do
   begin                     { deformace kruhu zmˆnou pomˆru }
      SetAspectRatio(Xasp, Yasp+(2*I*GetMaxY));
      Circle(X, Y, R);
   end;
end;

begin
   Inicializace;
   AspectDemoKruh;
   repeat
   until Keypressed;
   TextovyRezim;
end.