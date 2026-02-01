Program Vypln3;

uses Graph, GraphIni, CRT;

const
   Sachovnice : FillPatternType =
                ($F0, $F0, $F0, $F0, $0F, $0F, $0F, $0F);

var
   Port     : ViewPortType;

procedure Box;
begin
   SetFillPattern(Sachovnice, GetColor);
   GetViewSettings(Port);
   Bar(Port.X1, Port.Y1, Port.X2, Port.Y2);
end;

begin
   Inicializace;
   Box;
   repeat
   until Keypressed;
   TextovyRezim;
end.