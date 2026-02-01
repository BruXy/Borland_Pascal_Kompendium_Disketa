program Atributy;

uses CRT, DOS;
{$I-}

Function ExistujeS(Jmeno : PathStr) : Boolean;
{ vrac¡ hodnotu true, jestli‘e soubor existuje na disku 
  v definovan‚m nebo pracovn¡m adres ©i }
var
   F : file;
begin
   if Length(Jmeno) = 0 then
      ExistujeS := False   { test naplnˆn¡ parametru }
    else
    begin
      Assign(F, Jmeno);
      Reset(F);
      if IOResult = 0 then
      begin
        ExistujeS := True; { £spˆ¨n‚ otev©en¡ = existuje }
        Close(F);
      end
      else
        ExistujeS := False;{ ne£spˆ¨n‚ otev©en¡ = neexistuje}
    end;
end;

Function CtiAtribut(Jmeno : PathStr;var Attr : word): string;
{ vrac¡ atribut diskov‚ho souboru a p©¡znakov˜ ©etˆzec } 
var
    F : file;
    S : string;
begin
    Assign(F, Jmeno);
    GetFAttr(F, Attr);       { ‡ten¡ atributu }
    S:='';
    if DosError <> 0 then
       CtiAtribut:=S
    else
    begin
       If Attr and ReadOnly <> 0 then
          S:=S+'R' else S:=S+'.';
       If Attr and Hidden <> 0 then
          S:=S+'H' else S:=S+'.';
       If Attr and SysFile <> 0 then
          S:=S+'S' else S:=S+'.';
       If Attr and VolumeID <> 0 then
          S:=S+'V' else S:=S+'.';
       If Attr and Directory <> 0 then
          S:=S+'D' else S:=S+'.';
       If Attr and Archive <> 0 then
          S:=S+'A' else S:=S+'.';
       CtiAtribut := S;
   end;
end;

var
   Jmeno : PathStr;
   Attr  : word;
begin
   Write('Zadej jmeno souboru: ');
   repeat
       ReadLn(Jmeno);
   until (ExistujeS(Jmeno)) and (Jmeno<>'');
   WriteLn('Soubor m  tyto atributy ',CtiAtribut(Jmeno,Attr));
   WriteLn('Atribut diskov‚ho souboru ',Jmeno,' je : ',Attr);
   repeat
   until Keypressed;
end.
