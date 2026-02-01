Program DemoRetezce;

uses
   CRT;
type
   Retezec = string;
var
   R, S : Retezec;
begin
   ClrScr;
   R := 'Zacatek retezce, ';
   S := 'konec retezce.';
   WriteLn('Zadan˜ ©etˆzec R            : ',R);
   WriteLn('Zadan˜ ©etˆzec S            : ',S);
   WriteLn;
   WriteLn('    Concat(R,S)             : ',Concat(R,S));
   WriteLn('    Copy(R,8,8)             : ',Copy(R,8,8));
   Delete(R,8,8);
   WriteLn('    Delete(R,8,8)           : ',R);
   Insert(' retezec',R,8);
   WriteLn('    Insert('' retezec'',R,8)  : ',R);
   WriteLn('    Pos(''r'',R)              : ',Pos('r',R));
   WriteLn;
   repeat until Keypressed;
end.
