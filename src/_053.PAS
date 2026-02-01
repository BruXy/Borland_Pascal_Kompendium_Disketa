Program ExitHalt;
uses
   CRT;
const
   I : longint = 1;

Procedure Citac;
begin
   Delay(100);
   GotoXY(1,1);
   Write(I:3);
   if (I > 0) and (I < 50) then
   begin
      GotoXY(1,2);
      Write('Exit');
      Exit;
   end;
   if I = 50 then
   begin
      GotoXY(1,2);
      Write('Halt');
      Delay(500);
      Halt;
   end;
   Write('Tento text se nikdy nezobraz¡.');
end;

begin
   ClrScr;
   while I < 100 do
   begin
      Inc(I);
      Citac;
   end;
end.