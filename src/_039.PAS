Program TestFile;

uses CRT, DOS;                    
{$I-}

Function ExistujeSoubor(Jmeno : PathStr) : boolean;
var
   F : file;
begin
   Assign(F,Jmeno);
   Reset(F);
   if IOResult=0 then
   begin
      Close(F);
      ExistujeSoubor:=True;
   end
   else
      ExistujeSoubor:=False;
end;

{ Telo hlavniho programu }
var
   Jmeno : PathStr;
begin
   ClrScr;
   Write('Zadej jmeno souboru : ');
   ReadLn(Jmeno);
   if ExistujeSoubor(Jmeno) then
      Writeln('Soubor ',Jmeno,' na disku existuje....')
   else
      Writeln('Soubor ',Jmeno,' na disku neexistuje....');
   Delay(2000);	
end.