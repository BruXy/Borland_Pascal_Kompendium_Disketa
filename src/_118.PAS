Program DemoNul;
uses
   Strings,CRT;
const
   ArrayS1 : array[0..79]
             of char = 'Demo retezec c.1.'#0;
   ArrayS2 : array[0..79]
             of char = 'Demo retezec c.2.'#0;
var
   NullS1  : PChar;
   NullS2  : PChar;
   Kod     : integer;
begin
   ClrScr;
   NullS1 := @ArrayS1;
   NullS2 := @ArrayS2;
   { z©etˆzen¡ }
   WriteLn('NullS2 se p©ipoj¡ na konec NullS1');
   WriteLn;
   NullS1 := StrCat(NullS1,NullS2);
   WriteLn(NullS1);
   WriteLn;
   { porovn n¡ }
   WriteLn('porovn  se NullS1 s NullS2');
   WriteLn;
   Kod := StrComp(NullS1, NullS2);
   if Kod < 0 then WriteLn('NullS1 < NullS2');
   if Kod = 0 then WriteLn('NullS1 = NullS2');
   if Kod > 0 then WriteLn('NullS1 > NullS2');
   WriteLn;
   { d‚lka ©etˆzce }
   WriteLn('stanoven¡ d‚lky -> StrLen(NullS2) ',StrLen(NullS2));
   WriteLn('stanoven¡ d‚lky -> StrEnd(NullS2)-NullS2 ',StrEnd(NullS2)-NullS2);
   WriteLn;
   { p©evod na velk  p¡smena }
   WriteLn('NullS2 na velk  p¡smena -> ',StrUpper(NullS2));
   WriteLn;
   { p©evod na mal  p¡smena }
   WriteLn('NullS2 na mal  p¡smena  -> ',StrLower(NullS2));
   WriteLn;
   repeat
   until Keypressed;
end.