program Priklad016;

function IntToString(Cislo, Sirka : integer) : string;
var
   S : string;
begin
   Str(Cislo:Sirka, S);
   IntToString := S;
end;

begin
   writeln(IntToString(12345,8));
end.