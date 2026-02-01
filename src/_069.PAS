Program TestAdapter;

uses DOS;

type
    TypAdapteru = (Neznamy,Hercules, CGA, EGA, VGA, MCGA);

function Adapter : TypAdapteru;

var Regs : Registers;
    Kod  : Byte;
begin
   Adapter := Neznamy;
   with Regs do
   begin
      AX:=$1A00;          { ‡¡slo slu‘by }
      Intr($10,Regs);     { vol n¡ p©eru¨en¡ }
      if AL=$1A then      
      begin
         Kod:=BL;
         case kod of      { ur‡en¡ typu adapt‚ru }
               1 : Adapter:=Hercules;
               2 : Adapter:=CGA;
            4..5 : Adapter:=EGA;
            7..8 : Adapter:=VGA;
          $A..$C : Adapter:=MCGA
         end;
      end;
   end;
end;

begin
   case Adapter of
      Hercules : Write('Hercules');
      CGA      : Write('CGA');
      EGA      : Write('EGA');
      VGA      : Write('VGA');
      MCGA     : Write('MCGA');
   end;
end.