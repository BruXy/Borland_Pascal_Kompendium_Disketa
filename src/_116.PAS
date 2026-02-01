Program NULL3;
uses
   Strings,CRT;

const
   ArrayS : array[0..79]
            of char = 'Demonstra‡n¡ ©etˆzec znak–.'#0;
var
   NullS   : PChar;
   Novy    : PChar;
begin
   ClrScr;
   WriteLn('Po‡ te‡n¡ pamˆŸ                 : ',MemAvail);
   NullS := @ArrayS;
   WriteLn;
   WriteLn('ArrayS : ',ArrayS);
   WriteLn;
   WriteLn('NullS  : ',NullS);
   WriteLn;
   WriteLn('PamˆŸ - NullS ukazuje na ArrayS : ',MemAvail);
   Novy := StrNew(NullS);
   WriteLn;
   WriteLn('Novy   : ',Novy);
   WriteLn;
   WriteLn('PamˆŸ - Vznikl nov˜ ukazatel    : ',MemAvail);
   WriteLn;
   Novy := 'Znaky vlo‘en‚ do novˆ vytvo©en‚ho ©etˆzce.';
   WriteLn('Novy   : ',Novy);
   WriteLn;
   WriteLn('PamˆŸ - po naplnˆn¡ ©etˆzce Novy: ',MemAvail);
   repeat
   until Keypressed;
end.
