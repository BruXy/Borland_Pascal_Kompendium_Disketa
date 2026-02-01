Program SizeOfFce;

uses CRT;
type
    Screen = array[1..4000] of byte;
var
    P : pointer;
begin
   ClrScr;
   WriteLn('Voln  pamˆŸ: ',MemAvail:6);
   GetMem(P, SizeOf(Screen));
   WriteLn('Voln  pamˆŸ: ',MemAvail:6);
   FreeMem(P, SizeOf(Screen));
   WriteLn('Voln  pamˆŸ: ',MemAvail:6);
   repeat
   until Keypressed;
end.


