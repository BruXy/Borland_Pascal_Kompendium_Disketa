Program DemoFillChar;

uses
   CRT;
type
   Obrazovka = array[1..4000] of char;
var
   O : Obrazovka absolute $B800:$0000;
begin
   FillChar(O,4000,'B');
   repeat
   until Keypressed;
end.
