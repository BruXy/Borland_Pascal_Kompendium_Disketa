Program GetPut;

uses Graph, GraphIni, CRT;

type
   Souradnice = record            { parametry kreslen¡ obrazu }
      X, Y   : integer;
      P      : integer;
   end;

var
   U        : Souradnice;         { promˆnn  typu Souradnice }
   X, Y     : integer;            { sou©adnice obrazu }
   I        : integer;            { pomocn˜ ‡¡ta‡ }
   Velikost : word;               { velikost obrazu }
   Obraz    : pointer;            { ukazatel na blok pamˆti pro
                                    ulo‘en¡ obrazu }

Procedure ObrazU(U : souradnice);
begin                             { konstrukce hvˆzdn‚ho obrazu }
  Ellipse(U.X, U.Y, 0, 360, U.P, (U.P div 3)+2);
  Ellipse(U.X, U.Y-4, 190, 357, U.P, U.P div 3);
  Line(U.X+6, U.Y-6, U.X+12, U.Y-12);
  Circle(U.X+10, U.Y-12, 2);
  Line(U.X-6, U.Y-6, U.X-12, U.Y-12);
  Circle(U.X-10, U.Y-12, 2);
  SetFillStyle(SolidFill, LightRed);
  FloodFill(U.X+1, U.Y+4, GetColor);
end;

Procedure UlozObraz(U : souradnice);
var                               { vypo‡¡t  rozmˆr obrazu a ulo‘¡
                                    bin rn¡ obraz do pamˆti }
   X1, Y1, X2, Y2 : integer;
begin
   X1 := U.X-(U.P+2);
   Y1 := U.Y-16;
   X2 := U.X+(U.P+2);
   Y2 := U.Y+(U.P div 3)+5;
   Velikost := ImageSize(X1, Y1, X2, Y2);
   GetMem(Obraz, Velikost);
   GetImage(X1, Y1, X2, Y2, Obraz^);
   PutImage(X1, Y1, Obraz^, XORput);
end;                              { v˜maz ufa }

begin
   Inicializace;

   X := GetMaxX;
   Y := GetMaxY;
   for I := 1 to 10000 do         { hvˆzdn  obloha }
      PutPixel(Random(X), Random(Y), Random(GetColor));
   { poprv‚ se obraz nakresl¡ ve st©edu obrazovky }
   U.X:=GetMaxX div 2;
   U.Y:=GetMaxY div 2;
   U.P:=10;
   ObrazU(U);

   UlozObraz(U);                  { ulo‘¡ bin rn¡ obraz do pamˆti }
   X := 10;                       { v˜choz¡ sou©adnice pro pohyb }
   Y := 10;

   while ((X < GetMaxX-30) or (Y < GetMaxY-30))
           and not(Keypressed) do
   begin                          { pohyb ufa }
      X := X + Random(20);
      Y := Y + Random(20);
      PutImage(X, Y, Obraz^, XORput);
      Delay(200);                 { zobrazen¡ ufa }
      PutImage(X, Y, Obraz^, XORput);
   end;                           { v˜maz ufa }
   FreeMem(Obraz, Velikost);      { uvolnˆn¡ obrazu z pamˆti }
   TextovyRezim;                  { n vrat do textov‚ho re‘imu }
end.