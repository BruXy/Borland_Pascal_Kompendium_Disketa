program Knih1;
{ Vytvo©¡ nov˜ soubor a na‡te do nˆj N z znam–. }

uses
   CRT;

type
   Kniha = record
              Nazev    : string[60];
              Autor    : string[20];
              Rok      : word;
              Nakladatel: string[10];
           end;
var
   F        : file of kniha;
   Zaznam   : kniha;
   I,N      : integer;

Procedure Cti_zaznam;
begin
   with Zaznam do
   begin
      Writeln;
      Writeln;
      Write('Nazev knihy : ');
      Readln(Nazev);
      Write('Autor       : ');
      Readln(Autor);
      Write('Rok vydani  : ');
      Readln(Rok);
      Write('Vydavatel   : ');
      Readln(Nakladatel);
   end;
end;

begin
   ClrScr;
   Write('Zadej pocet knih: ');
   ReadLn(N);
   Assign(F,'Knihovna.dbf');
   Rewrite(F);
   for I := 1 to N do
   begin
      Cti_zaznam;
      Write(F,Zaznam);
   end;
   Close(F);
end.

