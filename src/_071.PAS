Program Stranky;

uses DOS, CRT;

Procedure NastavStranku(Stranka : byte);
var 
   Regs : Registers; 
begin
   Regs.AH := 5;         { ‡¡slo slu‘by programu BIOS }
   Regs.AL := Stranka;   { nastaven¡ str nky }
   Intr($10, Regs);      { vol n¡ p©eru¨en¡ $10 }
end;

Function CtiStranku : byte;
var
   Stranka : byte absolute $0040:$0062;
begin
   CtiStranku := Stranka;
end;

begin
   Write(CtiStranku);
   Delay(2000);
   NastavStranku(2);
   Write(Ctistranku);
   Delay(2000);
end.