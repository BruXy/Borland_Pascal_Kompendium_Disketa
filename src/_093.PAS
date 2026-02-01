Program Barvy2;
{ Zobraz¡ ‡ty©£heln¡ky, ka‘d˜ v jin‚ barvˆ. Pod ka‘d˜ ‡ty©£heln¡k se
  nap¡¨e k¢d barvy.}

uses Graph, GraphIni, CRT;

var
   MaxBarva : integer;
   Barva    : word;

function IntToStr(I : LongInt) : string;
{ P©ev d¡ cel‚ ‡¡slo na ©etˆzec znak–. }
var
  S : string;
begin
  Str(I, S);
  IntToStr := S;
end;


procedure Okno(X, Y, Sirka, Vyska : word);
begin
   SetFillStyle(SolidFill, Barva);
   if Barva > MaxBarva then
      Barva:=MaxBarva;
   SetColor(Barva);
   Bar(X, Y, X+Sirka, Y+Vyska);
   OutTextXY(X+(Sirka div 2), Y+Vyska+4, IntToStr(Barva));
   Barva := Succ(Barva);
end;

procedure DemoBarvy;
{ Zobraz¡ v¨echny barvy pro dan˜ ovlada‡ a re‘im. }
var
   Sirka    : word;
   Vyska    : word;
   X,Y,I,J  : word;
   Vyrez    : ViewPortType;
begin
   MaxBarva:=GetMaxColor;
   Barva := 1;
   GetViewSettings(Vyrez);
   with Vyrez do
   begin
      Sirka := 2 * ((x2+1) div 16);
      Vyska := 2 * ((y2-10) div 10);
   end;
   X := Sirka div 2;
   Y := Vyska div 2;
   for J := 1 to 3 do
   begin
      for I := 1 to 5 do
      begin
         Okno(X, Y, Sirka, Vyska);
         Inc(X, (Sirka div 2) * 3);
      end;
      X := Sirka div 2;
      Inc(Y, (Vyska div 2) * 3);
   end;
   repeat
   until Keypressed;
end;


begin
   Inicializace;
   DemoBarvy;
   TextovyRezim;
end.