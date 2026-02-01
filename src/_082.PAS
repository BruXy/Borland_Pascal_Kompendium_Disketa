program DemoDos;

uses DOS, CRT;

var
   CBreak : boolean;

begin
   ClrScr;
   SetCBreak(False);
   GetCBreak(CBreak);
   Write('Aktu ln¡ nastaven¡ testu stisku CTRL-BREAK: ');
   if CBreak then
      WriteLn('ON')
   else
      WriteLn('OFF');
   WriteLn;

   SetCBreak(True);
   GetCBreak(CBreak);
   Write('Aktu ln¡ nastaven¡ testu stisku CTRL-BREAK: ');
   if CBreak then
      WriteLn('ON')
   else
      WriteLn('OFF');
   WriteLn;

   repeat until Keypressed;
end.