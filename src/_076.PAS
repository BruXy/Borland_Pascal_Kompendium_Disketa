Program TvarKurzoru;

uses
   CRT, DOS;

function CtiTvarKurzoru(Stranka : byte) : Word;
{ funkce vrac¡ velikost kurzoru  Hi(CtiTvarKurzoru)...Zacatek,
                                 Lo(CtiTvarKurzoru)...Konec }
var Regs : Registers;

begin
   with Regs do
   begin
      AH:=$03;        { ‡¡slo slu‘by do AH }
      BH:=Stranka;    { ‡tu tvar kurzoru ve str nce }
      Intr($10,Regs);
      CtiTvarKurzoru := CX;
   end;
end;

procedure NastavTvarKurzoru(Zacatek,Konec : byte);
{ nastav¡ po‘adovan˜ tvar kurzoru }

var Regs : Registers;

begin
   with Regs do
   begin
      AH:=$01;
      CH:=Zacatek;
      CL:=Konec;
      Intr($10,Regs);
   end;
end;

begin
   WriteLn('Horni rastrovaci radek : ',Hi(CtiTvarKurzoru(0)));
   WriteLn('Spodni rastrovaci radek: ',Lo(CtiTvarKurzoru(0)));
   Delay(2000);
   NastavTvarKurzoru(0,14);
   WriteLn('Horni rastrovaci radek : ',Hi(CtiTvarKurzoru(0)));
   WriteLn('Spodni rastrovaci radek: ',Lo(CtiTvarKurzoru(0)));
   Delay(2000);
end.