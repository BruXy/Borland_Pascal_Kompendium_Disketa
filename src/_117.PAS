uses Strings;

Function StrNew(NullS : PChar) : PChar;
var
   P     : PChar;
   Delka : word;
begin
   if (NullS = nil) or (NullS^ = #0) then
      StrNew := nil
   else
   begin
      Delka := StrLen(NullS) + 1;
      GetMem(P, Delka);
      StrNew := P;
   end;
end;


Procedure StrDispose(NullS : PChar);
var
   Delka : word;
begin
   if NullS <> nil then
   begin
      Delka := StrLen(NullS) + 1;
      FreeMem(NullS, Delka);
   end;
end;

begin
end.