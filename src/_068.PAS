Program TestVGA;

uses DOS;

function VGA : boolean; 
var 
   Regs : Registers; 
begin 
   Regs.AH := $1A;      { ‡¡slo funkce slu‘by BIOS } 
   Regs.AL := $00;     
   intr($10, Regs);     { vol n¡ p©eru¨en¡ } 
   if ( Regs.AL = $1A ) then
      if (Regs.BL = 7 ) or ( Regs.BL = 8 ) then 
         VGA := True    { VGA je instalov n } 
      else 
         VGA := False;  { VGA nen¡ instalov n } 
end; 

begin
   if VGA then
      Write('Je pripojen adapter VGA.')
   else
      Write('Je pripojen jiny adapter nez VGA.');
end.