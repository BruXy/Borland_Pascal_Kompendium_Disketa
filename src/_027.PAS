Program OfsetSegmen;
uses
   CRT;
var
   S : string;
   P : pointer;
begin
   ClrScr;
   S:='Obsah ©etˆzce.';
   P := Addr(S);
   WriteLn('Promˆnn  P ukazuje na S.');
   WriteLn;
   P := Ptr(Seg(S),Ofs(S));
   WriteLn;
   WriteLn('Obsah ©etˆzce  : ',S);
   WriteLn('Adresa segmentu: ',Seg(S));
   WriteLn('Adresa ofsetu  : ',Ofs(S));
   repeat
   until Keypressed;
end.