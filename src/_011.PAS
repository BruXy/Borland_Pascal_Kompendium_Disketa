program Priklad011;

var
   Mode    : byte absolute $0040:$0049;
   Stranka : array[1..25,1..80] of
             record
                Ch, Atr : char;
             end absolute $B800:$0000;

begin
end.