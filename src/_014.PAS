program Priklad014;

uses DOS;

var
   Reg : registers;

begin
   Reg.AX := $00;
   with Reg do
   begin
      AX := $00;
   end;
end.