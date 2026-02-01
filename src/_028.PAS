Program AssignedTest;
uses
   CRT;
var
   S : string;
   P : pointer;
begin
   ClrScr;
   S:='Obsah ©etˆzce.';
   WriteLn('Ukazatel P nenaplnˆn -> hodnota NIL : ',Assigned(P));
   P := Addr(S);
   WriteLn('Ukazatel P naplnˆn -> hodnota <> NIL: ',Assigned(P));
   repeat
   until Keypressed;
end.