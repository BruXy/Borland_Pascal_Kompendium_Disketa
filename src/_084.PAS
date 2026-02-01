
Program NastavSystemovyCitac;

Uses Dos;
var
  Reg : Registers;

Procedure NastavCitac(H_slovo,S_slovo : word);
begin
   with Reg do
   begin
      AH:=1;          {‡¡slo slu‘by p©eru¨en¡}
      CX:=H_slovo;    {nastaven¡ parametr– ‡¡ta‡e}
      DX:=S_slovo;
      Intr($1A,Reg);  {provede p©eru¨en¡}
   end;
end;

begin
   NastavCitac(0,0);
end.
