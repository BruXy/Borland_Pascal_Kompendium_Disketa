Program Cara1;

uses Graph, GraphIni, CRT;

function IntToStr(I : LongInt) : string;
{ P©ev d¡ cel‚ ‡¡slo na ©etˆzec znak–. }
var
  S : string;
begin
  Str(I, S);
  IntToStr := S;
end;

Procedure CaryStandard;
var
  Styl     : word;
  X, Y     : word;
  Port     : ViewPortType;
begin
   GetViewSettings(Port);
   X := GetX;
   Y := GetY+20;

   OutTextXY(X, Y-20, 'Tenke cary - NormWidth');
   for Styl := 0 to 3 do
   begin
      SetLineStyle(Styl, 0, NormWidth);
      Line(X+50, Y, Port.X2-50, Y);
      OutTextXY(Port.X2-30, Y, IntToStr(Styl));
      Y := Y +((Port.X2-Port.X1) div 10);
   end;
   OutTextXY(X, Y-20, 'Tucne cary - ThickWidth');
   for Styl := 0 to 3 do
   begin
      SetLineStyle(Styl, 0, ThickWidth);
      Line(X+50, Y, Port.X2-50, Y);
      OutTextXY(Port.X2-30, Y, IntToStr(Styl));
      Y := Y +((Port.X2-Port.X1) div 10);
   end;
end;

begin
   Inicializace;
   CaryStandard;
   repeat
   until Keypressed;
   TextovyRezim;
end.