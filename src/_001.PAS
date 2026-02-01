Program Priklad001;

type
   String1 = string;
   String2 = string[80];
var
   S : String2;
begin
   S := 'Ahoj';
   if S[1] = 'A' then
      Write('žetˆzec je kompatibiln¡ s typem char.');
end.