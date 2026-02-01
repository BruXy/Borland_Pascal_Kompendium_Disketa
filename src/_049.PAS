Program Retezce;

uses CRT;

type
    Retezec = string;

function Velka(S : Retezec) : Retezec;
var
   I : byte;
begin
  for I := 1 to Length(S) do
    S[I] := UpCase(S[I]);
  Velka := S;
end;

function PevnaDelka(S : Retezec; Delka : byte) : Retezec;
var
   SLen : byte absolute S;
   { SLen  je  promˆnn ,  kter   se  napln¡  hodnotou  d‚lky
     ©etˆzce. D‚lka ©etˆzce je  ulo‘ena  v  byte  retˆzce  s
     indexem 0 }
begin
  if SLen > Delka then
    Delete(S, Succ(Delka), SLen - Delka)
    { vyma‘e nadbyte‡n‚ znaky z ©etˆzce, jestli‘e  je  del¨¡
    ne‘ Delka }
  else
    while SLen < Delka do     { dopln¡ ©etˆzec mezerami }
      S := S + ' ';
  PevnaDelka := S;
end;

function Centerovani(S : Retezec) : Retezec;
var
   I : byte;
begin
  for I := 1 to (80 - Length(S)) DIV 2 do
    S := ' ' + S;
  Centerovani := S;
end;

procedure Tisk(S : Retezec; Barva : byte);

procedure NastavBarvu(Barva : byte);
begin
    TextColor(Barva);
    TextBackground(Black);
end;

begin
  NastavBarvu(Barva);
  Write(S);
  NastavBarvu(White);
end;


procedure TiskXY(S : Retezec; Barva : byte; Sl,Ra : byte);
begin
  GotoXY(Sl, Ra);
  Tisk(S, Barva);
end;

var
   R : Retezec;
   N : longint;
begin
   ClrScr;
   R := 'abcdefg';
   WriteLn(R);   { ©etˆzec mal˜ch p¡smen a }
   R := Velka(R);
   WriteLn(R);   { ©etˆzec velk˜ch p¡smen A }
   R := 'Z'+PevnaDelka(' ',20)+'K';
   WriteLn(R);   { ©etˆzec doplnˆn˜ na d‚lku 20 }
   R := Centerovani('Centrovano');
   WriteLn(R);   { ©etˆzec centrovan˜ na st©ed }
   Tisk('Cerveny retezec.',4);
   WriteLn;
   TiskXY('Zeleny retezec na souradnici 40,20.', Green,40,20);
   repeat
   until Keypressed;
end.