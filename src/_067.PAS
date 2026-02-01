Program TestEga;

uses DOS;

function EGA : boolean; 
var 
   Regs : Registers;
begin 
   Regs.AH := $1A;           { ‡¡slo funkce } 
   Regs.AL := $00;           { d¡l‡¡ funkce } 
   intr($10, Regs);          { p©eru¨en¡ $10 } 
   if ( Regs.AL = $1A ) then
      if (Regs.BL = 4 ) or ( Regs.BL = 5 ) then 
         EGA := True         { ANO }
      else 
         EGA := False;       { NE }
end;

begin
   if EGA then
      Write('Pripojen adapter EGA.')
   else
      Write('Pripojen jiny adapter nez EGA.');
end.