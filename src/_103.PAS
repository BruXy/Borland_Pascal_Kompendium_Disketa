Program BarDemo;

uses Graph, GraphIni, CRT;

Procedure Pasy;
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
      SetFillStyle(Random(11),GetColor);
      Bar(Random(X),Random(Y),Random(GetMaxX),Random(GetMaxY));
      Delay(200);
   until Keypressed;
end;

begin
   Inicializace;
   Pasy;
   TextovyRezim;
end.
