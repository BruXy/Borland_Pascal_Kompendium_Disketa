Program Vstup;

var
   F     : text;
   Radek : string;
begin
   Assign(F, '_060.TXT');
   Reset(F);
   ReadLn(F, Radek);
   Close(F);
end.