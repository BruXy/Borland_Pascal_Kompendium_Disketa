program ProgramVerifikace;

uses DOS, CRT;

var
   Verifikace : boolean;

begin
   ClrScr;
   SetVerify(False);
   GetVerify(Verifikace);
   Write('Aktu ln¡ nastaven¡ verifikace: ');
   if Verifikace then
      WriteLn('ON')
   else
      WriteLn('OFF');
   WriteLn;

   SetVerify(True);
   GetVerify(Verifikace);
   Write('Aktu ln¡ nastaven¡ verifikace: ');
   if Verifikace then
      WriteLn('ON')
   else
      WriteLn('OFF');
   WriteLn;

   repeat until Keypressed;
end.