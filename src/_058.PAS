Program ParamDemo;

uses
   CRT;
const
   I : integer = 0;
begin
   ClrScr;
   WriteLn('Po‡et parametr–: ',ParamCount);
   if ParamCount > 0 then
   begin
      while I <= ParamCount do
      begin
         WriteLn('Patametr ',I:2,' ',ParamStr(I));
         Inc(I);
      end;
   end;
   repeat
   until Keypressed;
end.