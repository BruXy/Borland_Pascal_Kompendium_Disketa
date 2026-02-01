Program CteniZnaku;

uses
    CRT, DOS;
type
    Prvek = record
       Znak    : char;
       Atribut : byte;
    end;

const
    Stranka : byte = 0;

procedure CtiZnakAtribut(var Znak : Prvek);
{p©e‡te atribut a znak pod kursorem v aktivn¡ obrazov‚ str nce}

var Regs : Registers;

begin
   with Regs do
   begin
      AH:=$08;          { slu‘ba $08 p©eru¨en¡ $10 }
      BH:=Stranka;      { ‡¡slo obrazov‚ str nky }
      Intr($10,Regs);   { vol n¡ p©eru¨en¡ $10 }
      Znak.Atribut:= AH;{ p©e‡ten˜ atribut }
      Znak.Znak:=Chr(AL);{ p©e‡ten˜ znak }
   end;
end;

procedure PisZnakAtribut(Znak : Prvek);
{ Zap¡¨e do obrazov‚ pamˆti jeden znak a jeho atribut. }
var 
   Regs    : Registers;
begin
   with Regs do
   begin
      AL:=Ord(Znak.Znak);{ zapisovan˜ znak }
      AH:=$09;           { ‡¡slo slu‘by BIOS }
      BH:=Stranka;       { ‡¡slo obrazov‚ str nky }
      BL:=Znak.Atribut;  { atribut znaku }
      CX:=1;             { po‡et kopi¡ znaku }
      Intr($10,Regs);    { vol n¡ p©eru¨en¡ }
   end;
end;

var
   P : Prvek;
begin
   P.Znak := 'A';
   P.Atribut := 6;
   PisZnakAtribut(P);
   repeat
   until Keypressed;
end.