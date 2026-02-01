Program Vysec;

uses Graph, GraphIni, CRT;

var
   X, Y    : word;
   Up, Uk  : word;
   R       : word;

begin
   Inicializace;
   X := GetMaxX div 3;
   Y := GetMaxY div 2;
   Up:=  0;
   Uk:= 90;
   R := GetMaxX div 4;
   Arc(X-R, Y, Up, Uk, R);
   PieSlice((2*X)-R, Y, Up, Uk, R);
   Sector((3*X)-R, Y, Up, Uk, R, R div 2);
   repeat
   until Keypressed;
   TextovyRezim;
end.