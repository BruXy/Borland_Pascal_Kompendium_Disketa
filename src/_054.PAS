Program ExcludeInclude;
uses
   CRT;
type
   Znaky = set of char;
const
   Z : Znaky = ['a','b','c','d','e','f'];

Procedure Test(I : byte);
begin
   if 'c' in Z then
      WriteLn(I:2,':Ano')
   else
      WriteLn(I:2,':Ne');
end;

begin
   ClrScr;
   Test(1);
   Exclude(Z,'c');
   Test(2);
   Include(Z,'c');
   Test(3);
   Z := Z-['c'];
   Test(4);
   Z := Z+['c'];
   Test(5);
   repeat
   until Keypressed;
end.