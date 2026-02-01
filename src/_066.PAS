Program TestMonitor;

uses DOS;

function TypMonitoru : byte; 
var 
   Regs : Registers;  
begin 
  Regs.AH := $12;            { slu‘ba programu BIOS } 
  Regs.BL := $10;            { d¡l‡¡ slu‘ba } 
  intr($10, Regs);           { vol n¡ p©eru¨en¡ } 
  case Regs.CL of            { typ monitoru } 
    $0B : TypMonitoru := 0;  { mono } 
    $08 : TypMonitoru := 1;  { barva } 
    $09 : TypMonitoru := 2;  { EGA monitor } 
  end; 
end; 

begin
   case TypMonitoru of
      0 : Write('MONO');
      1 : Write('BARVA');
      2 : Write('EGA special');
   end;
end. 