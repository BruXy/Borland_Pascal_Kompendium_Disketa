Program MemAvailMaxAvail;

uses CRT;
type
    ObrazovkyType = array[1..200] of pointer;
var
    Obrazovka : ObrazovkyType;
    I    : integer;
begin
   ClrScr;
   WriteLn('Voln  pamˆŸ: ',MemAvail,' souvisl˜ blok ',MaxAvail);
   while I <= 50 do
   begin               { alokov n¡ promˆnn˜ch }
      GetMem(Obrazovka[I],4000);
      Inc(I);          { line rnˆ kles  souvisl˜ blok }
   end;
   I := 1;
   while I <= 20 do
   begin               { vznikaj¡ d¡ry v pamˆti }
      FreeMem(Obrazovka[I],4000);
      Inc(I)
   end;
   WriteLn('Voln  pamˆŸ: ',MemAvail,' souvisl˜ blok ',MaxAvail);
   repeat
   until Keypressed;
end.


