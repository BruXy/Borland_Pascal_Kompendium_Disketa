Program CteniRezimu;

uses DOS;

var
   Rezim     : byte;
   SegmentVP : word;
   OffsetVP  : word;
   Stranka   : byte;

function CtiRezim : Byte;
 { funkce vrac¡ aktu ln¡ re‘im zobrazen¡ a nastavuje tyto         
   glob ln¡ promˆnn‚: 
            Rezim      k¢d aktu ln¡ho re‘imu zobrazen¡
            SegmentVP  adresa segmentu obrazov‚ pamˆti
            OffsetVP   adresa offsetu obrazov‚ pamˆti 
            Stranka    ‡¡slo aktu ln¡ str nky }

var 
   Regs:Registers;
begin
   With Regs do
   begin
      AH := $0F;                { ‡¡slo slu‘by BIOS do AH }
      Intr($10,Regs);           { vol n¡ p©eru¨en¡ $10  }
      Rezim := AL and $7F;      { nastaven˜ re‘im }
      Stranka := BH;            { aktivn¡ str nka }
      if Rezim <= 3 then        { adapt‚r CGA, EGA, VGA }
      begin
         SegmentVP := $B800;
         OffsetVP := MemW[$40:$4E] div 16; 
                                { slovo na adrese $40:$4E
                                  obsahuje offset
                                  aktivn¡ str nky }

      end;
      if Rezim = 7 then         { monochromatick˜ re‘im }
      begin
         SegmentVP := $B000;
         OffsetVP := $0000;
      end;
   end;
   CtiRezim:=Rezim;
end;    

begin
   Write(CtiRezim);
end.