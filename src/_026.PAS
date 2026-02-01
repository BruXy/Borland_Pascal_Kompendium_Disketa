Program GoniometrickeFce;
uses
   CRT;
var
   X : real;
begin
   X := Pi;
   WriteLn('€¡slo PI: ',X:5:3);
   WriteLn;
   WriteLn('Funkce Sin    : ',Sin(X):5:3);   {  0.000 }
   WriteLn('Funkce Cos    : ',Cos(X):5:3);   { -1.000 }
   WriteLn('Funkce ArcTan : ',ArcTan(X):5:3);{  1.263 }
   repeat
      Write('Zadej re ln‚ ‡¡slo / 0 kon‡¡ cyklus: ');
      ReadLn(X);
      WriteLn('Funkce Sin    : ',Sin(X):5:3);
      WriteLn('Funkce Cos    : ',Cos(X):5:3);
      WriteLn('Funkce ArcTan : ',ArcTan(X):5:3);
   until (Round(X)=0);
end.