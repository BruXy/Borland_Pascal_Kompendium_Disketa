Program DecInc;

uses
   CRT;
var
   I, J : byte;
begin
   ClrScr;
   WriteLn('INC  ');
   WriteLn('DEC  ');
   I:=1;
   J:=10;
   while I<=10 do
   begin
      GotoXY(WhereX+4,1);
      Write(I:2);
      GotoXY(WhereX-2,2);
      Write(J:2);
      Inc(I);
      Dec(J);
      Delay(400);
   end;
end.