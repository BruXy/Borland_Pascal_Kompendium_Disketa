Program Vyplne2;

uses Graph, GraphIni, CRT;

function IntToStr(I : LongInt) : string;
{ P©ev d¡ cel‚ ‡¡slo na ©etˆzec znak–. }
var
  S : string;
begin
  Str(I, S);
  IntToStr := S;
end;

procedure Box(X, Y, Sirka, Vyska, Styl : word);
{ Kresl¡ ohrani‡en˜ ‡tu©£heln¡k, kter˜ vypln¡ nastavenou v˜pln¡. }
begin
   SetFillStyle(Styl, GetColor);
   Bar(X, Y, X+Sirka, Y+Vyska);
   Rectangle(X, Y, X+Sirka, Y+Vyska);
   OutTextXY(X+(Sirka div 2), Y+Vyska+4, IntToStr(Styl));
end;

Procedure Vyplne;
var
   X,Y,I,J : integer;        { X,Y - sou©adnice, I,J - ‡¡ta‡e }
   Sirka   : word;           { ¨¡©ka ‡ty©£heln¡ku }
   Vyska   : word;           { v˜¨ka ‡ty©£heln¡ku }
   Port    : ViewPortType;   { parametry v˜©ezu }
   Styl    : word;           { zp–sob v˜plnˆ ‡tu©£heln¡ku }

begin
  GetViewSettings(Port);     { ‡ten¡ parametr– obrazovky }
  with Port do
  begin                      { v˜po‡et ¨¡©ky a v˜¨ky v˜©ezu }
    Sirka := 2 * (x2 div 12);
    Vyska := 2 * (y2 div 10);
  end;
  X := Sirka div 2;          { sou©adnice prvn¡ho ‡ty©£heln¡ku }
  Y := Vyska div 2;
  Styl := 0;                 { k¢d prvn¡ v˜plnˆ }
  for J := 1 to 3 do
  begin
    for I := 1 to 4 do
    begin                    { nakresli ‡ty©£heln¡k s v˜pln¡ }
      Box(X, Y, Sirka, Vyska, Styl);
      X := X + ((Sirka div 2) * 3);
      Inc(Styl);             { dal¨¡ zp–sob v˜plnˆ }
    end;
    X := Sirka div 2;        { sou©adnice dal¨¡ho ‡ty©£heln¡ku }
    Y := Y + ((Vyska div 2) * 3);
  end;
end;

begin
   Inicializace;
   Vyplne;
   repeat
   until Keypressed;
   TextovyRezim;
end.