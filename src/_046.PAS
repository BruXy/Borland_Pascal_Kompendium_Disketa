Program FunkceChr;

uses
   CRT;
const
   I : integer = 32;
   J : integer = 0;
begin
   ClrScr;
   while J<2000 do
   begin
      Write(Chr(I));
      Inc(I);
      Inc(J);
      if I=256 then
         I:=32;
   end;
   repeat
   until Keypressed;
end.