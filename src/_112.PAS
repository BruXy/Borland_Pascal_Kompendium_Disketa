program Texty1;

uses Graph, GraphIni, CRT;
const
  Fonts : array[0..10] of string[17] =
          ('DefaultFont', 'TriplexFont', 'SmallFont',
           'SansSerifFont', 'GothicFont', 'ScriptFont',
           'SimplexFont', 'TriplexScriptFont', 'ComplexFont',
           'EuropeanFont', 'BoldFont');

procedure VypisTextu;
const
  Sirka : array[0..10] of word = (1, 4, 7, 4, 4, 4, 4, 4, 4, 2, 2);
var
  Font : word;
  ViewInfo : ViewPortType;
  Ch : char;
begin
   SetTextJustify(LeftText, TopText);
   for Font := 0 to 10 do
   begin
      SetTextStyle(Font, HorizDir, Sirka[Font]);
      Ch := #0;
      repeat
         OutText(Ch);
         if (GetX + TextWidth('M')) > GetMaxX then
            MoveTo(2, GetY + TextHeight('M')+5);
         Ch := Succ(Ch);
      until (Ch >= #255);
      MoveTo(40, GetY + TextHeight('M')+20);
      OutText(Fonts[Font]);
      Delay(2000);
      ClearViewPort;
   end;
end;

begin
   Inicializace;
   VypisTextu;
   TextovyRezim;
end.