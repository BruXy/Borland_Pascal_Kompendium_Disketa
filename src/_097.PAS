Program GrafickyBod;

uses GraphIni, Graph, CRT;

function IntToStr(I : LongInt) : string;
{ p©ev d¡ cel‚ ‡¡slo na ©etˆzec znak– }
var
   S : string;
begin
   Str(I, S);
   IntToStr := S;
end;


begin
   Inicializace;    { zobraz¡ ‡erven˜ bod v lev‚m horn¡m
                      rohu obrazovky }
   PutPixel(GetX,GetY,LightRed);
                    { nap¡¨e sou©adnice zobrazen‚ho bodu }
   OutTextXY(GetX+10,GetY+10,IntToStr(GetX)+','
             +IntToStr(GetY));
   Delay(1000);
   MoveTo(GetMaxX,GetMaxY);  
                    { ukazatel do prav‚ho spodn¡ho rohu }
                    { nakresl¡ ‡erven˜ bod }
   PutPixel(GetX,GetY,LightRed);
                    { nap¡¨e sou©adnice bodu }
   OutTextXY(GetX-60,GetY-20,IntToStr(GetX)+','
             +IntToStr(GetY));
   repeat
   until Keypressed;
   TextovyRezim;
end.
