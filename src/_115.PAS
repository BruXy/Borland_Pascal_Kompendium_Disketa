Program NULL2;
uses
   Strings,CRT;
var
   ArrayS : array[0..79] of char;
   NullS  : PChar;
   P      : PChar;
   I      : integer;
begin
   WriteLn('PamˆŸ: ',MemAvail);
   readln(ArrayS);
   NullS := StrNew(ArrayS);
   WriteLn('PamˆŸ: ',MemAvail);
   NullS := 'Hodnota ©etˆzce ukon‡en‚ho znakem NULL.';
   WriteLn(NullS);
   WriteLn(ArrayS);
   repeat
   until Keypressed;
end.