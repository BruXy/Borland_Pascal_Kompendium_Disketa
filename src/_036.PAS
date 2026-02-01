Program CtiText;

uses CRT;
var
   F   : text;
   Line: string;
   I   : integer;
begin
   Assign(F,'Text.TXT');
   Reset(F);
   I := 1;
   while not(Eof(F)) do
   begin
      ReadLn(F,Line);
      WriteLn(I,' ',Line);
      Inc(I);
   end;
   Close(F);
   Delay(2000);
end.