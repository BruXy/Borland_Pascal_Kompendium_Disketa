Program DrawPolyDemo;

uses Graph, GraphIni, CRT;

const
   Trojuhelnik : array[1..4] of PointType = ((X :  20; Y : 100),
                                             (X : 100; Y : 100),
                                             (X : 200; Y : 200),
                                             (X :  20; Y : 100));
begin
   Inicializace;
   SetColor(LightGreen);
   DrawPoly(4,Trojuhelnik);
   repeat
   until Keypressed;
   TextovyRezim;
end.
