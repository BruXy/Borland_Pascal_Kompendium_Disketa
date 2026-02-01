Program OrdPred;
uses
   CRT;
var
   Znak : char;
begin
   ClrScr;
   repeat
      WriteLn;
      Write('Stiskni znak (ESC - konec programu)    : ');
      Znak:=ReadKey;
      WriteLn;
      WriteLn;
      WriteLn('Byl stisknut znak                      : ',Znak);
      WriteLn('Ordin ln¡ hodnota (ASCII k¢d) znaku    : ',Ord(Znak));
      WriteLn('Ordin ln¡ hodnota p©edch zej¡c¡ho znaku: ',Pred(Ord(Znak)));
      WriteLn('P©edch zej¡c¡ znak                     : ',Chr(Pred(Ord(Znak))));
      WriteLn('Ordin ln¡ hodnota n sleduj¡c¡ho znaku  : ',Succ(Ord(Znak)));
      WriteLn('N sleduj¡c¡ znak                       : ',Chr(Succ(Ord(Znak))));
   until Znak=#27;
end.
