Program GetFreeMem;

uses CRT;

type
    ObrazovkyType = array[1..200] of pointer;
var
    Obrazovka : ObrazovkyType;
    I    : integer;

Procedure VypisStav(I : integer);
var
   X, Y : byte;
begin
   X:=WhereX;          { pomocn  procedura }
   Y:=WhereY;          { MemAvail - celkov  pamˆŸ }
   GoToXY(14,1);       { MaxAvail - souvisl˜ blok }
   Write('Voln  pamˆŸ: ',MemAvail,' souvisl˜ blok ',MaxAvail);
   GotoXY(X,Y);
end;

begin
   ClrScr;
   VypisStav(1);
   WriteLn;
   WriteLn;
   WriteLn('Za‡ tek alokov n¡ pamˆti.');
   WriteLn('Index roste od 1 do 50. ');
   Delay(1000);
   I := 1;
   while I <= 50 do
   begin               { alokov n¡ promˆnn˜ch }
      GetMem(Obrazovka[I],4096);
      Delay(300);
      VypisStav(I);    { line rnˆ kles  voln  pamˆŸ }
      Inc(I);          { line rnˆ kles  souvisl˜ blok }
   end;
   WriteLn;
   WriteLn('Konec alokov n¡ pamˆti.');
   WriteLn;
   WriteLn('Za‡ tek uvol¤ov n¡ pamˆti.');
   WriteLn('Index roste od 1 do 20.');
   Delay(1000);
   I:=1;
   while I <= 20 do
   begin               { vznikaj¡ d¡ry v pamˆti }
      FreeMem(Obrazovka[I],4096);
      Delay(300);      { roste voln  pamˆŸ }
      VypisStav(I);    { souvisl˜ blok stagnuje }
      Inc(I)
   end;
   WriteLn('Za‡ tek spr vn‚ho uvol¤ov n¡ pamˆti.');
   WriteLn('Index kles  od 50 do 21.');
   Delay(1000);
   I:=50;
   while I >= 21 do
   begin               { nevznikaj¡ d¡ry }
      FreeMem(Obrazovka[I],4096);
      Delay(300);      { roste voln  pamˆŸ }
      VypisStav(I);    { roste souvisl˜ blok }
      Dec(I)
   end;
   WriteLn('Konec programu.');
   Delay(1000);
end.


