Program GraphInit;

uses
   _090p325, Graph;
var
   Ovladac, Rezim : integer;

begin
   Ovladac := Detect;
   InitGraph(Ovladac, Rezim, '');
   if Chyba then
      Halt(1);
end.