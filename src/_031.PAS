Program MarkRelease;

uses CRT;

type
    S = array[1..4096] of char;
    ObrazovkyType = array[1..200] of ^S;
var
    Obrazovka : ObrazovkyType;
    I    : integer;
    P    : pointer;

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
   Mark(P);
   I := 1;
   while I <= 50 do
   begin               { alokov n¡ promˆnn˜ch }
      New(Obrazovka[I]);
      Delay(300);
      VypisStav(I);    { line rnˆ kles  voln  pamˆŸ }
      Inc(I);          { line rnˆ kles  souvisl˜ blok }
   end;
   WriteLn;
   WriteLn('Konec alokov n¡ pamˆti.');
   WriteLn;
   WriteLn('Uvolnˆn¡ pamˆti.');
   Delay(1000);
   Release(P);
   VypisStav(I);
   WriteLn('Konec programu.');
   Delay(1000);
end.


