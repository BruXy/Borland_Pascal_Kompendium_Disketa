Program ChybyVV;

uses CRT;

procedure  IOError;
var
   IOVal : integer; { obsahuje v˜sledek funkce IOresult }
begin
   IOVal := IOresult;        { test v˜sledku I/O operace }
   { je-li v˜sledek r–zn˜ od nuly do¨lo k chybˆ }
   GotoXY(1,24);             { nastav kurzor na © dek 24 }
   ClrEol;                   { vyma‘ st vaj¡c¡ obsah © dku }
   if IOVal<>0 then          { jestli‘e do¨lo k chybˆ }
   begin
      Write(Chr(7));         { proveƒ zvukov˜ sign l }
      case IOVal of          { vyhodnoŸ chybu }
         $01 : Write('Soubor neexistuje !');
         $02 : Write('Soubor nelze otevrit pro vstup !');
         $03 : Write('Soubor nelze otevrit pro vystup !');
         $04 : Write('Soubor nelze otevrit !');
         $05 : Write('Ze souboru nelze cist !');
         $06 : Write('Do souboru nelze zapisovat !');
         $10 : Write('Chyba v ciselnem formatu !');
         $20 : Write('Nedovolena operace na logickem zarizeni !');
         $21 : Write('Pristup neni dovolen v primem modu !');
         $22 : Write('Priradit na standardni soubor nelze !');
         $90 : Write('Rozdilna delka zaznamu !');
         $91 : Write('Vystaveni ukazatele za konec souboru !');
         $99 : Write('Neocekavany konec souboru !');
         $F0 : Write('Chyba zapisu na disk !');
         $F1 : Write('Adresar je plny !');
         $F2 : Write('Prekroceni objemu souboru !');
         $FF : Write('Soubor zmizel !');
      else
         Write('Neidentifikovatelna  I/O chyba :  ',IOVal:3);
         { nen¡-li chyba identifikov na, tiskni upozornˆn¡ }
      end;
      GotoXY(50,24);  { nastav kurzor na sloupec 50 © dku 24 }
      Write('Libovolna klavesa -> konec !');
      { tiskni ‘ dost o stisk libovolne kl vesy }
      repeat until KeyPressed;
      ClrScr;
      Halt;           { po stisku znaku ukon‡en¡ programu }
   end;
end;

{ Telo hlavni programu neni uvedeno v kapitole 1. }

var
   F : file;

begin
   {$I-}
   Assign(F,'MPSOFT.TST');
   Reset(F);
   IOError;
   {$I+}
end.