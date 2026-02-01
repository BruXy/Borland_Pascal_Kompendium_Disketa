Program DelkaRetezce;

uses
   CRT;
type
   Retezec = string;
var
   R     : string;
   Delka : byte absolute R;
begin
   ClrScr;
   Write('Zadej ©etˆzec znak– z kl vesnice: ');
   ReadLn(R);
   WriteLn;
   WriteLn('Zji¨tˆn¡ d‚lky z promˆnn‚ Delka          : ',Delka);
   WriteLn;
   WriteLn('Zji¨tˆn‚ d‚lky z nult‚ho znaku Ord(R[0]) : ',Ord(R[0]));
   WriteLn;
   WriteLn('Zji¨tˆn¡ d‚lky funkc¡ Length(R)          : ',Length(R));
   WriteLn;
   repeat
   until Keypressed;
end.