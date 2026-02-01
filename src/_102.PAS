Program Ctyruhel;

uses Graph, GraphIni, CRT;

Procedure Uhelniky;
var
   Port : ViewPortType;
   X, Y : integer;
begin
   GetViewSettings(Port);
   X:=GetMaxX div 2;
   Y:=GetMaxY div 2;
   Randomize;
   repeat
      SetColor(Random(MaxColors));
      SetLineStyle(Random(3),0,NormWidth);
      Rectangle(Random(X),Random(Y),Random(GetMaxX),Random(GetMaxY));
      Delay(200);
   until Keypressed;
end;

begin
   Inicializace;
   Uhelniky;
   TextovyRezim;
end.
