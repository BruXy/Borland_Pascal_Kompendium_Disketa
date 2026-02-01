program Knih2;
{ Vyp¡¨e z znamy z existuj¡c¡ho souboru. }

uses
   CRT;

type
   kniha = record
              Nazev    : string[60];
              Autor    : string[20];
              Rok      : word;
              Nakladatel: string[10];
           end;
var
   F        : file of kniha;
   Zaznam   : kniha;

Procedure Vypis_zaznam;
begin
   with Zaznam do
   begin
      Writeln;
      Writeln;
      WriteLn('Nazev knihy : ',Nazev);
      WriteLn('Autor       : ',Autor);
      WriteLn('Rok vydani  : ',Rok);
      WriteLn('Vydavatel   : ',Nakladatel);
   end;
end;

begin
   ClrScr;
   Assign(F,'Knihovna.dbf');
   Reset(F);
   while not eof(F) do
   begin
      Read(F,Zaznam);
      Vypis_zaznam;
   end;
   Close(F);
   repeat
   until Keypressed;
end.

