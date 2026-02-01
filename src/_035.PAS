Program VytvorTextFile;

var
   F : text;
begin
   Assign(F, 'Text.txt');
   Rewrite(F);
   WriteLn(F,'Radek v textovem souboru.');
   WriteLn(F,'Konec textoveho souboru.');
   Close(F);
end.