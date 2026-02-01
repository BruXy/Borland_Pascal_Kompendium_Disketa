{ Procedury popisuje oddil III, kapitola 1.6. }

Program DemoFile;

uses DOS,CRT;                        { Klauzule neni v kapitole 1.6. }

Function ExistujeSoubor(Jmeno : PathStr) : boolean;
var
   F : file   ;
begin
   Assign(F,Jmeno);
   Reset(F);
   if IOResult=0 then
   begin
      Close(F);
      ExistujeSoubor := True;
   end
   else
      ExistujeSoubor := False;
end;

procedure ZrusSoubor(Jmeno : PathStr);
var 
   F : file;
begin
  if not ExistujeSoubor(Jmeno) then
     WriteLn('Soubor v adres ©i disku neexistuje.')
  else
  begin
     Assign(F, Jmeno);
     Erase(F);
     if IOResult <> 0 then
        WriteLn('Soubor z disku nelze zru¨it.');
  end;
end;

Procedure PrejmenujSoubor(Zdroj, Cil : PathStr);
var 
   F : file;
begin
   if not ExistujeSoubor(Zdroj) then
      WriteLn('Soubor na disku neexistuje.')
   else
   begin
      Assign(F, Zdroj);
      Rename(F, Cil);
      if IOResult<>0 then
         WriteLn('Chyba z pisu na disk.');
  end;
end;

var
   N1,N2 : PathStr;
begin
     ClrScr;
     WriteLn;
     WriteLn;
     WriteLn('Demonstrace p©ejmenov n¡ souboru: ');
     WriteLn;
     WriteLn;
     Write('Zadej star‚ jm‚no souboru: ');
     ReadLn(N1);
     Write('Zadej nov‚ jm‚no souboru:  ');
     ReadLn(N2);
     PrejmenujSoubor(N1,N2);
     Delay(2000);
     Writeln;
     WriteLn;
     Write('Demonstrace maz n¡ souboru z disku: ');
     Writeln;
     WriteLn;
     Write('Zadej jm‚no souboru: ');
     ReadLn(N1);
     ZrusSoubor(N1);
     Delay(2000);
     Writeln;
     WriteLn;
     Write('O spravnosti provedeni operaci se presvedcite prostredky OS.');
     Delay(2000);
end.