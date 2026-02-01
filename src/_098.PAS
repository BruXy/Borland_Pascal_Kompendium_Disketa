Program ViewPort;

uses Graph, GraphIni, CRT;

function IntToStr(I : LongInt) : string;
{ P©ev d¡ cel‚ ‡¡slo na ©etˆzec znak–. }
var
  S : string;
begin
  Str(I, S);
  IntToStr := S;
end;

var
   Port : ViewPortType;

begin
   Inicializace;

   GetViewSettings(Port);
   SetColor(LightRed);
   OutTextXY(GetX+50,GetY+10,'Sirka vyrezu : '+IntToStr(Port.X2-Port.X1));
   OutTextXY(GetX+50,GetY+20,'Vyska vyrezu : '+IntToStr(Port.Y2-Port.Y1));
   Line(0,0,GetMaxX,GetMaxY);

   Delay(1000);
   SetViewPort(200,100,400,300,ClipON);

   SetColor(LightGreen);
   GetViewSettings(Port);
   OutTextXY(GetX+50,GetY+10,'Sirka vyrezu : '+IntToStr(Port.X2-Port.X1));
   OutTextXY(GetX+50,GetY+20,'Vyska vyrezu : '+IntToStr(Port.Y2-Port.Y1));
   Line(0,0,GetMaxX,GetMaxY);

   Delay(1000);
   SetViewPort(0,200,200,400,ClipON);

   SetColor(Yellow);
   GetViewSettings(Port);
   OutTextXY(GetX+50,GetY+10,'Sirka vyrezu : '+IntToStr(Port.X2-Port.X1));
   OutTextXY(GetX+50,GetY+20,'Vyska vyrezu : '+IntToStr(Port.Y2-Port.Y1));
   Line(0,0,GetMaxX,GetMaxY);

   repeat
   until Keypressed;
   TextovyRezim;
end.