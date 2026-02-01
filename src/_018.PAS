program Priklad018;

var
   X,Y : integer;

procedure Vstup(var X,Y : integer);
begin
   write('Zadej vstupni cisla : ');
   readln(X,Y);
end;

function Vypocti(A,B : integer) : real;
begin
   Vypocti := A/B;
end;

begin
   Vstup(X,Y);
   writeln('Vysledek deleni : ',Vypocti(X,Y));
end.