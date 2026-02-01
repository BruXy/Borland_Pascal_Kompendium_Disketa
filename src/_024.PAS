Program NahodnaCisla;
uses
   CRT;
begin
   ClrScr;
   Randomize;
   repeat
      GotoXY(1,1);
      Write(Random);
      GotoXY(1,2);
      Write(Random(10));
      GotoXY(1,3);
      Write(Random(100));
      GotoXY(1,4);
      Write(Random(1000));
      Delay(200);
   until Keypressed;
end.