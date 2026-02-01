Program Cara2;

uses Graph, GraphIni, CRT;

var
   Port : ViewPortType;
   X,Y,I: integer;
   Styl : word;
begin
   Inicializace;
   GetViewSettings(Port);
   X := GetX;
   Y := GetY+10;
   Styl := 0;
   for I := 0 to 8 do
   begin
      {$B+}
      Styl := (Styl or I) shl 1;
      {$B-}
      SetLineStyle(UserBitLn, Styl, NormWidth);
      Line(X, Y, (Port.X2-Port.X1), Y);
      Y := Y + ((Port.Y2-Port.Y1) div 10);
   end;
   repeat
   until Keypressed;
   TextovyRezim;
end.