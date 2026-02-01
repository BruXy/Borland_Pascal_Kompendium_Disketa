program Priklad008;

type 
   Pole = array[0..1] of char;
var
   Z  : integer;
   P1 : ^pole;
begin
   P1 := @Z;
end.