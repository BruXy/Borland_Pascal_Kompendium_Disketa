Program KopirkaPrg;
{$I-}

uses DOS,CRT;

Function ExistujeSoubor(Jmeno : PathStr) : boolean;
var
   F : file   ;
begin
   Assign(F,Jmeno);
   Reset(F);
   if IOResult=0 then
   begin
      Close(F);
      ExistujeSoubor := True;
   end
   else
      ExistujeSoubor := False;
end;

procedure Kopirka(Zdroj,Cil : PathStr);
type
  InfoRec = record
    Zd,Cl     : PathStr; { jm‚na diskov˜ch soubor– }
    F1,F2     : file;    { promˆnn‚ netypov˜ch soubor– }
    Buffer    : pointer; { ukazatel na blok pamˆti ur‡en˜ pro
                           p©enos dat, maxim ln¡ velikost bloku
                           je 64 KB }
    Velikost  : word;    { aktu ln¡ velikost bloku pamˆti }
    OK        : boolean; { informace o spr vnosti operace }
  end;

procedure Otevri(var C : InfoRec);
{ otev©e diskov‚ soubory, existuj¡c¡ soubor zdroje a nov˜
  soubor, kam se bude ukl dat obsah p–vodn¡ho souboru }
begin
  with C do
  begin
    Assign(F1, Zd);     { p©i©ad¡ promˆnn‚ F1 zdrojov˜ s. }
    Reset(F1,1);        { otev©e diskov˜ soubor a definuje
    OK:=False;           velikost p©en ¨en‚ho bloku }
    if IOResult<>0 then { test spr vnosti ote©en¡ souboru }
       Exit;
    if ExistujeSoubor(Cl) then
    begin               { jestli‘e diskov˜ soubor, do
                          kter‚ho se m  kopie ulo‘it
                          existuje }
        Close(F1);      { uzav©i soubor zdroje }
        Exit;           { ukon‡i proceduru }
    end;
    Assign(F2, Cl);     { otev©en¡ c¡lov‚ho souboru }
    Rewrite(F2, 1);
    if IOResult<>0 then { test spr vnosti otev©en¡ c¡le }
    begin
       Close(F1);
       Exit;
    end;
    OK := True;         { jestli‘e jsou oba soubory otev©eny }
  end;
end;

procedure GetBuffer(var C : InfoRec);
{ vymez¡ blok pamˆti pro p©enos dat }
begin
  with C do
  begin
    OK := False;        { blok nelze vymezit }
    if MaxAvail > $FFF8 then
    begin
       Velikost := $FFF8;
       OK:= true;
    end
    else
       Exit;
    GetMem(Buffer, Velikost); 
                        { vymezen¡ bloku pamˆti }
  end;
end;

procedure ReadWrite(var C : InfoRec);
{ zaji¨Ÿuje ‡ten¡ ze zdroje a z pis do c¡le, pokud probˆhne
operace korektnˆ, promˆnn  OK se nastav¡ na TRUE }
var
    B : word;
begin
  with C do
  begin
    OK := False;
    repeat
      BlockRead(F1, Buffer^, Velikost, B);
      { ‡ten¡ ze zdrojov‚ho souboru do bloku pamˆti }
      If IOResult<>0 then{ test spr vnosti V/V operace }
      begin
        Close(F1);      { uzav©en¡ soubor– }
        Close(F2);
        Erase(F2);      { maz n¡ c¡lov‚ho souboru }
        Exit;
      end;
      BlockWrite(F2, Buffer^, B, B);
     { z pis na‡ten‚ho po‡tu blok– do c¡lov‚ho souboru }
      if IOResult <> 0 then
      begin
        Close(F1);
        Close(F2);
        Erase(F2);
        Exit;
      end;
    until B=0;          { zastav¡ kop¡rov n¡ po z pisu v¨ech
                          blok– }
    OK := True;
  end;
end;

var C : InfoRec;

begin
  with C do
  begin
    Zd := Zdroj;
    Cl := Cil;
    Otevri(C);
    if not OK then
       Exit;
    GetBuffer(C);
    if OK then
    begin
      ReadWrite(C);
      FreeMem(Buffer, Velikost);
    end;
    if not OK then
        Exit;
    Close(C.F1);
    Close(C.F2);
    Writeln('Kopie probehla korektne....');
    Delay(2000);
  end;
end;

{ Telo hlavniho programu }
var
     N1,N2 : PathStr;

begin
     ClrScr;
     Write('Zadej jmeno zdrojoveho souboru : ');
     ReadLn(N1);
     Write('Zadej jmeno kopie : ');
     ReadLn(N2);
     Kopirka(N1,N2);
end.