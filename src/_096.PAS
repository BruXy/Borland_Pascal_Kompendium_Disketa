Program Posun;

uses GraphIni, Graph, CRT;

function IntToStr(I : LongInt) : string;
{ p©ev d¡ cel‚ ‡¡slo na ©etˆzec znak– }
var
  S : string;
begin
  Str(I, S);
  IntToStr := S;
end;

var
   Bod   : PointType;
   Barva : word;
begin
   Inicializace;
   Bod.X:=GetX;
   Bod.Y:=GetY;
   Barva:=15;
   while (Bod.X<=GetMaxX) and (Bod.Y<=GetMaxY) do
   begin
      MoveTo(Bod.X,Bod.Y);
      Bod.X:=Bod.X+30;
      Bod.Y:=Bod.Y+50;
      SetColor(Barva);
      LineTo(Bod.X,Bod.Y);
      OutTextXY(Bod.X+20,Bod.Y,
                IntToStr(Bod.X)+','+IntToStr(Bod.Y));
      Dec(Barva);
      Delay(1000);
   end;
   repeat
   until Keypressed;
   TextovyRezim;
end.
