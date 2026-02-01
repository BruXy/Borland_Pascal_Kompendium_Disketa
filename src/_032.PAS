Program RegisterMonitor;
uses
   CRT;
var
   I : longint;
begin
   ClrScr;
   GotoXY(1,1);
   Write('Obsah registru CS: ',CSeg);
   GotoXY(1,2);
   Write('Obsah registru DS: ',DSeg);
   GotoXY(1,3);
   Write('Obsah registru SP: ',Sptr);
   GotoXY(1,4);
   Write('Obsah registru SS: ',SSeg);
   repeat
   until Keypressed;
end.