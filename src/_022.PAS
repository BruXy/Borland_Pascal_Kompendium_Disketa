program FracInt;
uses
   CRT;
var
   X : real;
begin
   X := 54.656;
   WriteLn('Zadan‚ ‡¡slo: ',X:5:3);
   WriteLn;
   WriteLn('Funkce Frac : ',Frac(X):6:3); {  0.656 }
   WriteLn('Funkce Int  : ',Int(X):6:3);  { 54.000 }
   WriteLn('Funkce Round: ',Round(X):2);  { 55     }
   WriteLn('Funkce Trunc: ',Trunc(X):2);  { 54     }
   repeat
      Write('Zadej re ln‚ ‡¡slo / 0 kon‡¡ cyklus: ');
      ReadLn(X);
      WriteLn('Funkce Frac : ',Frac(X):6:3);
      WriteLn('Funkce Int  : ',Int(X):6:3);
      WriteLn('Funkce Round: ',Round(X):2);
      WriteLn('Funkce Trunc: ',Trunc(X):2);
   until (Round(X)=0);
end.