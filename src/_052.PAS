Program BreakContinue;
uses
   CRT;
const
   I : longint = 1;
begin
   ClrScr;
   while I < 100 do
   begin
      Delay(200);
      GotoXY(1,1);
      Write(I:3);
      if (I > 0) and (I < 50) then
      begin
         Inc(I);
         GotoXY(1,2);
         Write('Continue');
         Continue;
      end;
      if I = 50 then
      begin
         GotoXY(1,2);
         Write('Break   ');
         Delay(500);
         Break;
      end;
      Write('Tento text se nikdy nezobraz¡.');
   end;
end.