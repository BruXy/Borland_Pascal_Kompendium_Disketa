Program OknaDemo;

uses 
   CRT,DOS,_Keyb;

type
   Retezec   = string;
   TypRamecku= (Zadny, Jednoduchy, Dvojity);
   BarvaRec= record
                Popredi,Pozadi : byte;
             end;
   Okna    = record
                X, Y         : byte;
                Sirka, Vyska : byte;
                Barva        : BarvaRec;
                Ramecek      : TypRamecku;
                Xs, Ys       : byte;
             end;

{ P©¡klad deklarace barevn˜ch kombinac¡ a parametr– ok‚nek. }
const
   { Pou‘it  okna v programu. }
   OknoPlne    : Okna      = (X       : 1;
                              Y       : 1;
                              Sirka   : 25;
                              Vyska   : 80;
                              Barva   : (Popredi : White;
                                         Pozadi : Black);
                              Ramecek : Zadny;
                              Xs      : 1;
                              Ys      : 1);

   { Ok‚nko zpr v a informac¡. }
   Info        : Okna      = (X       : 1;
                              Y       : 25;
                              Sirka   : 80;
                              Vyska   : 1;
                              Barva   : (Popredi : Yellow;
                                         Pozadi  : Red);
                              Ramecek : Zadny;
                              Xs      : 1;
                              Ys      : 1);


   OknoAPP1    : Okna      = (X       : 2;
                              Y       : 2;
                              Sirka   : 50;
                              Vyska   : 10;
                              Barva   : (Popredi : White;
                                         Pozadi  : Red);
                              Ramecek : Jednoduchy;
                              Xs      : 1;
                              Ys      : 1);

var
   AktualniOkno : Okna;    { parametry aktivn¡ho ok‚nka }
   PuvodniOkno  : Okna;    { parametry nahrazovan‚ho ok‚nka}
   Ch           : Char;    { znak z kl vesnice }

Procedure NastavBarvu(Okno : Okna);
{ Nastav¡ po‘adovanou kombinaci barev v textov‚m re‘imu.}
begin
   with Okno.Barva do
   begin
      TextColor(Popredi);  { Nastaven¡ barev.}
      TextBackground(Pozadi);
   end;
end;

procedure NastavOkno(Okno : Okna);
{ Definuje okno na obrazovce. }
begin
  with Okno do
  begin
    Window(X, Y, Pred(X + Sirka), Pred(Y + Vyska));
    GotoXY(Xs, Ys);
  end;
  NastavBarvu(Okno);
  AktualniOkno := Okno;
end;


procedure ZmenaOkna(Okno : Okna);
{ Zmˆn¡ aktu ln¡ okno za jin‚. }
begin
  NastavBarvu(Okno);
  with Okno do
  begin
    Window(X, Y, Pred(X + Sirka), Pred(Y + Vyska));
    GoToXY(Xs,Ys);
  end;
  AktualniOkno := Okno;
end;

procedure KresliRamecek(Okno : Okna);
{ Nakresl¡ kolem ok‚nka r me‡ek. }
type
   RamecekRec = record
      HL, HP, SL, SP, Horiz, Vert : char;
   end;                           { Popis r me‡ku. }
const
   Ramecky : array[Jednoduchy..Dvojity] of RamecekRec =
     ((HL : 'Ú'; HP : '¿'; SL : 'À';          
       SP : 'Ù'; Horiz  : 'Ä'; Vert : '³'),
      (HL : 'É'; HP : '»'; SL : 'È';         
       SP : '¼'; Horiz  : 'Í'; Vert : 'º'));

var
   Citac : byte;
begin
   NastavOkno(OknoPlne);          { Aktivvuj ok‚nko cel  obr.}
   NastavBarvu(Okno);             { barevn  kombinace ok‚nka }
   with Okno do
   begin
      GotoXY(Pred(X),Pred(Y));
      Write(Ramecky[Ramecek].HL); { Kreslen¡ r me‡ku, r me‡ek
                                    se kresl¡ vnˆ ok‚nka. }

      for Citac := 1 to Sirka do
          Write(Ramecky[Ramecek].Horiz);
      Write(Ramecky[Ramecek].HP);
      for Citac := 1 to (Vyska) do
      begin
         GotoXY(Pred(X),Pred(Y) + Citac);
         Write(Ramecky[Ramecek].Vert);
         GotoXY(X + Sirka, WhereY);
         Write(Ramecky[Ramecek].Vert);
      end;
      GotoXY(Pred(X), Y + Vyska);
      Write(Ramecky[Ramecek].SL);
      for Citac := 1 to Sirka do
         Write(Ramecky[Ramecek].Horiz);
      Write(Ramecky[Ramecek].SP);
   end;
   NastavOkno(Okno);              { Aktivuje vytv ©en‚ ok‚nko.}
end;

procedure VytvorOkno(Okno : Okna);
{ Vytvo©¡ na obrazovce nov‚ ok‚nko. }
begin
   with Okno do
   begin
      if Ramecek <> Zadny then
         KresliRamecek(Okno);
      ClrScr;
      GotoXY(Xs,Ys);
   end;
end;

procedure VymazOkno(Okno : Okna);
{ Vyma‘e obsah ok‚nka, r me‡ek z–stane nezmˆnˆn. }
begin
   NastavOkno(Okno);
   with Okno do
   begin
      Window(Succ(X),Succ(Y),(X+Sirka-2),(Y+Vyska-2));
      ClrScr;
   end;
   NastavOkno(Okno);
end;


procedure ZrusOkno(Okno : Okna);
{ Zru¨¡ z obrazovky existuj¡c¡ okno a aktivuje celou obrazovku.}
begin
  with Okno do
  begin
    NastavOkno(Okno);
    ClrScr;
  end;
  NastavOkno(OknoPlne);
end;

function Dotaz(Zpr : Retezec) : char;
{ Zobraz¡ textovou informaci na © dku 24 a ‡ek  na odpovˆƒ.}
var
   X,Y       : byte;
begin
  X:=WhereX;                 { ulo‘¡ st vaj¡c¡ polohu kurzoru }
  Y:=WhereY;
  PuvodniOkno :=PuvodniOkno; { ulo‘¡ parametry st vaj¡c¡ho ok‚nka }
  NastavOkno(Info);          { aktivuje ok‚nko informac¡ }
  VymazOkno(Info);           { vyma‘e ok‚nko informac¡ }
  Zpr:=Zpr+' (A/N) ';        { p©id  k ©etˆzci mo‘nosti odpovˆd¡ }
  Write(Zpr);
  Dotaz := GetLegalKey(['A','a','N','n']);
  NastavOkno(PuvodniOkno);   { nastaven¡ do p–vodn¡ho stavu }
  GotoXY(X,Y);
end;

Procedure Zprava(Zpr : Retezec);
{ Zobraz¡ informaci na © dku 24 a ne‡ek  na ‘ dnou odezvu. }
var
   X, Y : byte;
begin
   X := WhereX;
   Y := WhereY;
   PuvodniOkno:=AktualniOkno;{ ulo‘¡ parametry aktu ln¡ho ok‚nka}
   NastavOkno(Info);         { nastav¡ ok‚nko infoformac¡ }
   VymazOkno(Info);          { vyma‘e okno informac¡ }
   NastavBarvu(Info);        { nastav¡ barevnou kombinaci }
   Write(Zpr);
   NastavOkno(PuvodniOkno);  { nastav¡ p–vodn¡ re‘im }
   GoToXY(X,Y);
end;

begin
     ClrScr;
     VytvorOkno(OknoAPP1);
     Write('Okno cislo 1.');
     Zprava('Stiskni libovolnou klavesu...');
     WaitTo;
     Ch:=Dotaz('Konec Programu ');
     TextBackGround(Black);
     TextColor(White);
     ClrScr;
end.

