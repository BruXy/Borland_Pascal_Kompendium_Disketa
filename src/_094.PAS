Program Barvy3;

uses Graph, GraphIni, CRT;

var
   MaxBarva : integer;     {maxim ln¡ po‡et barev v paletˆ}
   Barva    : word;        {k¢d aktu ln¡ barvy}

procedure DemoPaleta;
{ Demonstrace u‘it¡ p©¡kazu SetPalette. }
const
   Xs = 6;                 {po‡et ‡ty©£heln¡k– ve smˆru os X a Y}
   Ys = 4;
var
   Puvodni  : PaletteType; {p–vodn¡ paleta barev}
   Sirka    : word;        {¨¡©ka ‡ty©£heln¡ku}
   Vyska    : word;        {v˜¨ka ‡ty©£heln¡ku}
   I, J     : word;        {pomocn‚ ‡¡ta‡e}
   X, Y     : word;        {sou©adnice lev‚ho horn¡ho rohu}
   Vyrez    : ViewPortType;{parametry obrazovky}
begin
   GetPalette(Puvodni);    {ulo‘¡ se p–vodn¡ nastaven¡ palety}
   MaxBarva:=Puvodni.Size;
   GetViewSettings(Vyrez); {‡ten¡ rozli¨ovac¡ schopnosti obrazovky}
   with Vyrez do
   begin                   {v˜po‡et rozmˆru ‡ty©£heln¡k–}
      Sirka := (x2-x1) div Xs;
      Vyska := (y2-y1) div Ys;
   end;
   X := 0;
   Y := 0;
   Barva := 0;             {v˜choz¡ barva pro kreslen¡}
   for J := 1 to Ys do
   begin
      for I := 1 to Xs do
      begin                {kreslen¡ ‡ty©£heln¡k–}
         SetFillStyle(SolidFill, Barva);
         Bar(X, Y, X+Sirka, Y+Vyska);
         Inc(X, Sirka+1);
         Inc(Barva);       {v˜po‡et k¢du barvy}
         Barva := Barva mod (MaxBarva+1);
      end;
      X := 0;
      Inc(Y, Vyska+1);
   end;
   repeat                  {n hodn‚ generov n¡ zmˆn v paletˆ}
      SetPalette(Random(Puvodni.Size), Random(Puvodni.Size));
   until KeyPressed;
   SetAllPalette(Puvodni); {nastaven¡ p–vodn¡ palety}
end;


begin
   Inicializace;
   DemoPaleta;
   TextovyRezim;
end.