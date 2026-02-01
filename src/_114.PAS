Program NullString1;
{$X+}         { p©edpoklad }
uses
   strings, CRT;
const
   S : array[0..79] of Char = 'Novy retezec'#0;
var
   P : PChar;
begin
   P := @S;   { adresa pole = adresa P }
   WriteLn(P);{ d–kaz identity }
   WriteLn(S);
   repeat
   until Keypressed;
end.