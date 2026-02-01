Program Kurzor;

uses CRT,DOS;

type
    TypKurzoru = (Skryty,Standard,Velky,Maly,Stredni);
                             { definice symbol– pro velikost
                               kurzoru }

procedure Cursor(Stav : TypKurzoru);
{ zhas¡n  nebo rozsvˆcuje kurzor na obrazovce, vyu‘¡v  p©¡-
  m‚ho vol n¡ p©eru¨en¡ 10H programu BIOS }
const
   Zacatek   : byte = 13;    { p©edpokl d me adapt‚r EGA }
   Konec     : byte = 14;
{ konstanty definuj¡ z kladn¡ rozmˆr kurzoru pro adapt‚r EGA,
  VGA nebo MCGA. Na adapt‚ru CGA se mus¡ pou‘¡t hodnot 6 a 7 }
var
   Reg : Registers;
{ deklarace promˆnn‚ typu z znam pro p©enos parametr– na
  obsluhu p©eru¨en¡ a p©evzet¡ v˜sledk– zpˆt na volaj¡c¡
  proceduru }
begin
  case Stav of               { nastaven¡ velikosti kurzoru
                               na z kladˆ pou‘it‚ho symbolu }
       Standard: begin
                  Zacatek   := 10;
                  Konec     := 14;
                 end;
       Maly    : begin
                  Zacatek   := 13;
                  Konec     := 14;
                 end;
       Velky   : begin
                  Zacatek   := 1;
                  Konec     := 14;
                 end;
       Stredni : begin
                  Zacatek   := 7;
                  Konec     := 14;
                 end;
  end;
  with Reg do
  begin
    case Stav of
      Standard..Stredni :
           begin             { rozsv¡cen¡ kurzoru }
             AH := 1;
             CH := Zacatek;
             CL := Konec;
             Intr($10, Reg);
           end;
     Skryty:                 { zhasnut¡ kurzoru }
           begin
             AH := 1;
             CH := 32;
             CL := 0;
             Intr($10, Reg);
           end;
    end;
  end;
end;

Procedure ClearTypeAhead;
{ vyma‘e vyrovn vac¡ pamˆŸ kl vesnice }
var
   Reg : Registers;       { sada registr– procesoru }
begin
   Reg.AH := $0C;         { ‡¡slo slu‘by j dra syst‚mu }
   Reg.AL := $06;         { ‡¡slo V/V slu‘by j dra syst‚mu }
   Reg.DL := $FF;         { parametr proveden¡ operace }
   MsDos(Reg);            { vyvol  p©eru¨en¡ 21H a provede sl.}
end;

procedure WaitTo(Stav : TypKurzoru);
{ ‡ek  na stisk libovoln‚ kl vesy, zhasne/rozsv¡t¡ kurzor }
begin
   Cursor(Stav);          { zhasne/rozsv¡t¡ kurzor }
   ClearTypeAhead;        { vyma‘e vyrovn vac¡ pamˆŸ }
   repeat until keypressed;  { ‡ek  na stisk kl vesy }
end;

var
   Ch : char;

begin
     ClrScr;
     Writeln('Zhasnuty kurzor ....stiskni kl vesu..');
     WaitTo(Skryty);
     Writeln('Minimalni kurzor ...stiskni kl vesu..');
     WaitTo(Maly);
     Writeln('Stredni kurzor ...stiskni kl vesu....');
     WaitTo(Stredni);
     Writeln('Velky kurzor ...stiskni kl vesu......');
     WaitTo(Velky);
end.
