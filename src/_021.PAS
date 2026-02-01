program Aritmetika;
uses
   CRT;
var
   X : real;
begin
   X := 1;
   WriteLn('Zadan‚ ‡¡slo: ',X:2:3);
   WriteLn;
   WriteLn('Funkce Abs  : ',Abs(X):5:3); { 1.000 }
   WriteLn('Funkce Ln   : ',Ln(X):5:3);  { 0.000 }
   WriteLn('Funkce Exp  : ',Exp(X):5:3); { 2.718 }
   WriteLn('Funkce Sqr  : ',Sqr(X):5:3); { 1.000 }
   WriteLn('Funkce Sqrt : ',Sqrt(X):5:3);{ 1.000 }
   repeat
      Write('Zadej re ln‚ ‡¡slo / 0 kon‡¡ cyklus: ');
      ReadLn(X);
      if Round(X)<>0 then
      begin
         WriteLn('Funkce Abs  : ',Abs(X):5:3);
         WriteLn('Funkce Ln   : ',Ln(X):5:3);
         WriteLn('Funkce Exp  : ',Exp(X):5:3);
         WriteLn('Funkce Sqr  : ',Sqr(X):5:3);
         WriteLn('Funkce Sqrt : ',Sqrt(X):5:3);
      end;
   until (Round(X)=0);
end.