program InfoDos;

uses DOS, CRT;
var
   I : integer;
begin
   ClrScr;
   Write('Opera‡n¡ syst‚m MS-DOS verze: ');
   WriteLn(Lo(DOSVersion),'.',Hi(DOSVersion));
   WriteLn;
   Write('Po‡et ©etˆzc– v syst‚mov‚m prost©ed¡: ');
   WriteLn(EnvCount);
   WriteLn;
   WriteLn('Obsah promˆnn˜ch v pamˆti: ');
   for I:=1 to EnvCount do
      WriteLn(EnvStr(I));
   WriteLn;
   Write('Obsah promˆnn‚ COMSPEC: ');
   WriteLn(GetEnv('COMSPEC'));
   repeat until Keypressed;
end.