Unit Keyb;

Interface


uses DOS,CRT;

const
   Null    =   #0; { znak NULL }
   BS      =   #8; { kl vesa BACKSPACE }
   CR      =  #13; { kl vesa ENTER }
   Esc     =  #27; { kl vesa ESC }
   Space   =  #32; { mezern¡k }
   F1      = #187; { funk‡n¡ kl¡‡ 1 }
   F2      = #188; { funk‡n¡ kl¡‡ 2 }
   F3      = #189; { funk‡n¡ kl¡‡ 3 }
   F4      = #190; { funk‡n¡ kl¡‡ 4 }
   F5      = #191; { funk‡n¡ kl¡‡ 5 }
   F6      = #192; { funk‡n¡ kl¡‡ 6 }
   F7      = #193; { funk‡n¡ kl¡‡ 7 }
   F8      = #194; { funk‡n¡ kl¡‡ 8 }
   F9      = #195; { funk‡n¡ kl¡‡ 9 }
   F10     = #196; { funk‡n¡ kl¡‡ 10 }
   Home    = #199; { kl vesa HOME }
   EndK    = #207; { kl vesa END }
   Ins     = #210; { kl vesa INS }
   Del     = #211; { kl vesa DEL }
   Up      = #200; { kl vesa ¨ipka nahoru }
   Down    = #208; { kl vesa ¨ipka dolu }
   Left    = #203; { kl vesa ¨ipka vlevo }
   Right   = #205; { kl vesa ¨ipka vpravo }
   PgUp    = #201; { kl vesa str nka nahoru }
   PgDn    = #209; { kl vesa str nka dolu }

type
    CharSet = set of char; { mno‘ina v¨ech znak– }
    Retezec = string[80];


    Procedure ClearTA; 
    procedure WaitTo;
    Function GetKey : char;
    function GetLegalKey(LegalSet : CharSet) : char;
    function GetString(X,Y,Delka : byte) : Retezec;
    function GetChar(X,Y : byte) : char;
    function GetInteger(X,Y,Delka : byte; Spodni, Horni : integer):integer;

implementation

    Procedure ClearTA; { vymaze vyrovnavaci pamet klavesnice,
                         se kterou pracuje systemova obsluha. }
    var
       Reg : Registers;{ sada registru procesoru }

    begin
       Reg.AH := $0C;  { cislo sluzby jadra operacniho systemu }
       Reg.AL := $06;  { cislo V/V sluzby jadra systemu }
       Reg.DL := $FF;  { parametr provedeni operace }
       MsDos(Reg);     { vyvola preruseni 21H a provede sluzbu }
    end;

    procedure WaitTo;
    begin
       ClearTA;
       repeat until KeyPressed;
    end;

    Function GetKey : char;
    var
       Key : char;
    begin
       ClearTA;
       repeat
       until KeyPressed; { cekej na stisk libovolne klavesy }
       Key := ReadKey;   { precti znak z klavesnice }
       if (Key = Null) and KeyPressed then
       begin             { jestlize se jedna o rozsirenou
                           klavesu }
          Key := ReadKey;{ precti druhy byte kodu klavesy }
          Key := Chr(Ord(Key)+128);
       end;
       GetKey := UpCase(Key);
    end;

    function GetLegalKey(LegalSet : CharSet) : char;
    var
       Key : char;
    begin
       repeat
          Key := GetKey;     { cekej na vstup z klavesnice}
       until Key in LegalSet;{ patri znak do mnoziny ? }
       GetLegalKey := Key;
    end;

    function GetKeyb : char;
    var
       Key : char;
    begin
       ClearTA;
       Key := ReadKey;
       if (Key = Null) then
       begin
          Key := ReadKey;
          Key := Chr(Ord(Key)+128);
       end;
       GetKeyb := Key;
    end;

    function GetString(X,Y,Delka : byte) : Retezec;
    { Delka : delka pole, do ktereho se ma retezec vkladat }

    function Input(Delka : byte;
                   var R : Retezec) : char;
    { Funkce  ceka  na  vstup  z  klavesnice  a  vraci  znakovou
      reprezentaci stisknute klavesy. }
    var
       Znak: char;           { vkladany znak }
       D   : byte absolute R;{ aktualni delka vkladaneho retezce}
    begin
       Znak:= GetLegalKey([#32..#126, BS, CR, ESC]);
       case Znak of
       { jestlize se stiskne zobrazitelny znak ze  spodni  poloviny
         tabulky ASCII a aktualni delka retezce je mensi nez povolene
         maximum, znak se prida do retezce  a  zobrazi  za  poslednim
         znakem retezce }
         #32..#126 : if D < Delka then
                     begin
                        R := R + Znak;
                        Write(Znak);
                    end;
         { jestlize se stiskne klavesa  BackSpace,  posledni  vlozeny
           znak se vymaze }
         BS       : begin
                       Write(Bs+' '+Bs);
                       Delete(R,D,1);
                    end;
        ESC       : R := ESC;
      end;
      Input := Znak;
    end;

    var
       R  : Retezec;
       Z  : char;

    begin
       R := '';
       GotoXY(X, Y);
       repeat
           Z := Input(Delka, R);
       until Z in [ESC, CR];
       if R <> ESC then
           GetString := R
       else
           GetString := '';
    end;


    function GetChar(X, Y : byte) : char;
    var
       R : Retezec;
    begin
       R := GetString(X, Y, 1);
       If R[0] <> #0 then
          GetChar := R[1];
    end;


    function GetInteger(X,Y,Delka : byte;Spodni,Horni : integer):integer;
      var
         R : Retezec;         { vstupni retezec cislic }
         N, C : integer;      { N - vysledek zpetneho prevodu }
                              { C - kontrolni kod zpetneho prevodu }
         Ok   : boolean;      { pomocna promenna }
      begin
         Ok := False;
         repeat
             R := GetString(X, Y, Delka);  { vstup cislic do retezce }
             Val(R, N, C);    { prevod retezce na cislo typu integer }
             Ok := ((N >= Spodni) and (N <= Horni) and (C = 0) and
                  (R <> '')); { test spravnosti cisla }
         until Ok;            { opakovani vstupu je-li zadani spatne }
         GetInteger := N;
     end;

end.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   