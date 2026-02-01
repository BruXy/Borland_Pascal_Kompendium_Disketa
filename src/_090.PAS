unit _090p325;
interface
uses
   Graph;

function Chyba : boolean;

implementation

Function Chyba : boolean;
var
   Kod    : integer;
   Zprava : string;
begin
   Kod := GraphResult;
   if Kod <> GrOK then
   begin
      Chyba := True;
      case Kod of
         GrNoInitGraph  
              : Zprava:='Nelze nainstalovat grafick˜ ovlada‡.';
         GrNotDetected  
              : Zprava:='Po‡¡ta‡ nem  grafick˜ ovlada‡.';
         GrFileNotFound 
              : Zprava:='Soubor s ovlada‡em nebyl nalezen.';
         GrInvalidDriver
              : Zprava:='Chyba grafick‚ho ovlada‡e.';
         GrNoLoadMem    
              : Zprava:='Nedostatek pamˆti pro ovlada‡.';
         GrNoScanMem
              : Zprava:='Nedostatek pamˆti pro kreslen¡.';
         GrNoFloodMem
              : Zprava:='Nedostatek pamˆti pro v˜pl¤ obrazce.';
         GrFontNotFound
              : Zprava:='Soubor s grafick˜m fontem nenalezen.';
         GrNoFontMem
              : Zprava:='Nedostatek pamˆti pro na‡ten¡ fontu.';
         GrInvalidMode  
              : Zprava:='Grafick˜ re‘im neodpov¡d  ovlada‡i.';
         GrError
              : Zprava:='Chyba, p©eplnˆn¡ tabulky font–.';
         GrIOerror
              : Zprava:='Grafick  chyba vstupu/v˜stupu.';
         GrInvalidFont
              : Zprava:='Chyba v souboru s grafick˜m fontem.';
         GrInvalidFontNum
              : Zprava:='Chyba k¢du, nesouhlas¡ s hlavi‡ka.';
      end;
      WriteLn(Zprava);
   end
   else
      Chyba := False;
end;

end.