Program Texty2;

uses Graph, GraphIni, CRT;

Procedure Texty;
var
   X,Y : integer;
begin
   X := GetMaxX div 2;
   Y := 20;
   Line(X,Y,X,GetMaxY);
   SetTextStyle(TriplexFont,HorizDir,2);
   MoveTo(X,Y);
   Line(GetX-50,GetY,GetX+50,GetY);
   OutText('Left/top      text.');

   SetTextJustify(CenterText,TopText);
   MoveTo(X,GetY+2*(TextHeight('M')+5));
   Line(GetX-50,GetY,GetX+50,GetY);
   OutText('Center/top    text.');

   SetTextJustify(RightText,TopText);
   MoveTo(X,GetY+2*(TextHeight('M')+5));
   Line(GetX-50,GetY,GetX+50,GetY);
   OutText('Right/top     text.');

   SetTextJustify(LeftText,CenterText);
   MoveTo(X,GetY+2*(TextHeight('M')+5));
   Line(GetX-50,GetY,GetX+50,GetY);
   OutText('Left/Center   text.');

   SetTextJustify(CenterText,CenterText);
   MoveTo(X,GetY+2*(TextHeight('M')+5));
   Line(GetX-50,GetY,GetX+50,GetY);
   OutText('Center/Center text.');

   SetTextJustify(RightText,CenterText);
   MoveTo(X,GetY+2*(TextHeight('M')+5));
   Line(GetX-50,GetY,GetX+50,GetY);
   OutText('Right/Center  text.');

   SetTextJustify(LeftText,BottomText);
   MoveTo(X,GetY+2*(TextHeight('M')+5));
   Line(GetX-50,GetY,GetX+50,GetY);
   OutText('Left/Bottom   text.');

   SetTextJustify(CenterText,BottomText);
   MoveTo(X,GetY+2*(TextHeight('M')+5));
   Line(GetX-50,GetY,GetX+50,GetY);
   OutText('Center/Bottom text.');

   SetTextJustify(RightText,BottomText);
   MoveTo(X,GetY+2*(TextHeight('M')+5));
   Line(GetX-50,GetY,GetX+50,GetY);
   OutText('Right/Bottom  text.');
end;

begin
   Inicializace;
   Texty;
   repeat
   until Keypressed;
   TextovyRezim;
end.