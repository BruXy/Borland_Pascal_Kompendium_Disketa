Program OvladaniPriznaku;
uses DOS, CRT;
const
   SCR  = $10;             { deklarace p©¡znak– kl ves }
   NUM  = $20; 
   CAP  = $40; 
   INS  = $80; 

procedure NastavPriznak(Klavesa : byte);

var 
   Regs     : Registers;
   Stav     : byte absolute $0040:$0017;
                           { stavov˜ byte kl vesnice }
begin
   Stav := Stav or Klavesa;{ nastaven¡ stavov‚ho bitu }
   Regs.AH := $01;         { slu‘ba BIOS }
   Intr($16, Regs);        { p©eru¨en¡ $16 BIOS }
end;

procedure ZrusPriznak(Klavesa : byte);

var 
   Regs     : Registers; 
   Stav     : byte absolute $0040:$0017;
                           { stavov˜ byte kl vesnice }
begin
   Stav := Stav and ( not Klavesa);
                           { zru¨en¡ nastaven¡ bitu }
   Regs.AH := $01;         { slu‘ba BIOS }
   Intr($16, Regs);        { p©eru¨en¡ $16 BIOS }
end;

begin
   repeat
      NastavPriznak(CAP);
      Delay(100);
      ZrusPriznak(CAP);
      Delay(100);
   until Keypressed;
end.
