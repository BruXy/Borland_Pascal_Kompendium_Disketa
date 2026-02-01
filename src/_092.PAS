Program Barvy1;

uses Graph, GraphIni, CRT;

var
   MaxColor : integer;
   Ovladac, Rezim : string;


function IntToStr(I : LongInt) : string;
{ P©ev d¡ cel‚ ‡¡slo na ©etˆzec znak–. }
var
  S : string;
begin
  Str(I, S);
  IntToStr := S;
end;


begin
   Inicializace;
   MaxColor:=GetMaxColor;
   Ovladac:=GetDriverName;
   OutText('Graficky ovladac: '+Ovladac);
   MoveTo(0,30);
   Rezim:=GetModeName(GetGraphMode);
   OutText('Graficky rezim  : '+Rezim);
   MoveTo(0,60);
   OutText('Pocet barev     : '+IntToStr(MaxColor));
   repeat
   until Keypressed;
   TextovyRezim;
end.