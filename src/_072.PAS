Program VstupDoVRAM;

uses DOS, CRT;

type
   Prvek = record
              Znak    : char;
              Atribut : byte;
           end;

   VRAM = array[1..2000] of Prvek;

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

procedure PrimoDoVRAM( Sl, Ra, Barva : byte;
                       Retezec : string); 
var 
   BarevnaVRAM : VRAM absolute $B800:0000; 
   MonoVRAM    : VRAM absolute $B000:0000; 
   Pozice      : word;   { pozice v pamˆti } 
   Delka       : byte;   { d‚lka ©etˆzce } 
   I           : byte;   { index v ©etˆzci } 
   Regs        : Registers;
begin 
   Delka := Length(Retezec); { zji¨tˆn¡ d‚lky ©etˆzce } 
   Pozice:= Ra * 80 + Sl;    { nastaven¡ pozice ve VRAM }
   if CtiRezim = 7 then 
   begin                     { pro monoadapt‚r }
      for I:=1 to Delka do   { z pis do pamˆti } 
      begin 
         MonoVRAM[Pozice].Znak := Retezec[I];{z pis znaku} 
         MonoVRAM[Pozice].Atribut := Barva;  {z pis atributu}
         Inc(Pozice);        { zv˜¨en¡ pozice } 
      end; 
   end 
   else                      { barevn˜ adapt‚r } 
   begin 
      for I:=1 to Delka do   { z pis do pamˆti } 
      begin 
         BarevnaVRAM[Pozice].Znak := Retezec[I]; 
         BarevnaVRAM[Pozice].Atribut := Barva; 
         Inc(Pozice);        
      end; 
   end; 
   Regs.AH := $02;           { nastaven¡ nov˜ch sou©adnic }
   Regs.BH := 0;                                      
   Regs.DH := ((Sl+Ra*80+Delka) div 80);
   Regs.DL := ((Sl+Ra*80+Delka) mod 80);
   Intr($10, Regs); 
end; 

begin
   ClrScr;
   PrimoDoVRAM( 10, 5, 5, 'Vlozeno primo do VRAM.'); 
   repeat
   until Keypressed;
end.