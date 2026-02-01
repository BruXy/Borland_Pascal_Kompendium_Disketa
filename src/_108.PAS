Program Vyplne1;

uses Graph, GraphIni, CRT;

begin
   Inicializace;
   SetFillStyle(SolidFill, LightRed);

   Circle((GetMaxX div 4), (GetMaxY div 2), (GetMaxY div 5));
   Circle((GetMaxX div 4), (GetMaxY div 2), (GetMaxY div 10));
   FloodFill((GetMaxX div 4), (GetMaxY div 2), GetColor);

   Delay(1000);

   Circle((GetMaxX div 4)*2, (GetMaxY div 2), (GetMaxY div 5));
   Circle((GetMaxX div 4)*2, (GetMaxY div 2), (GetMaxY div 10));
   FloodFill(((GetMaxX div 4)*2)+(GetMaxX div 9), (GetMaxY div 2), GetColor);

   Delay(1000);

   Circle((GetMaxX div 4)*3, (GetMaxY div 2), (GetMaxY div 5));
   Circle((GetMaxX div 4)*3, (GetMaxY div 2), (GetMaxY div 10));
   FloodFill(GetMaxX, (GetMaxY div 2), GetColor);

   repeat
   until Keypressed;
   TextovyRezim;
end.