     program Seznam;                

     uses Graph, CRT;
     type
         LokacePtr = ^Lokace;
         Lokace = object
           X,Y : integer;
           procedure Init(Xi,Yi : integer);
           function CtiX : integer;
           function CtiY : integer;
         end;
         BodPtr = ^Bod;
         Bod = object(Lokace)
           Viditelnost : boolean;
           Barva       : byte;
           constructor Init(Xi,Yi : integer);
           destructor Done;
           procedure NastavBarvu(KodBarvy : byte);
           procedure Zobraz; virtual;
           procedure Zhasni; virtual;
           function Stav : boolean;
           procedure Posuv(Xn,Yn : integer);
           procedure Pohyb(B : integer); virtual;
        end;
        KruhPtr = ^Kruh;
        Kruh = object(Bod)
           R : integer;
           constructor Init(Xi,Yi,Ri : integer);
           procedure Zobraz; virtual;
           procedure Zhasni; virtual;
           procedure Zvetsi(E : integer); virtual;
           procedure Zmensi(C : integer); virtual;
        end;
       ObloukPtr = ^Oblouk;
       Oblouk = object(Kruh)      { Obrazec Kruh }
         Zacatek, Konec : Integer;
         constructor Init(Xi,Yi,Ri,ZacatekI, KonecI : Integer);
         procedure Zobraz; virtual;
         procedure Zhasni; virtual;
       end;
       CtverecPtr = ^Ctverec;
       Ctverec = object(Bod)
           Strana : integer;
           constructor Init(Xi,Yi,Stranai : integer);
           procedure Zobraz; virtual;
           procedure Zhasni; virtual;
       end;

       { Dynamick˜  z znam ukazatel– na  jednotliv‚ grafick‚
         objekty.}

       ObjPtr = ^Obj;
       Obj = record
         Pa : BodPtr;    { ukazatel aktu ln¡ho objektu }
         Pn : ObjPtr;    { ukazatele n sleduj¡c¡ho objektu }
       end;

       OseznamPtr = ^Oseznam;
       Oseznam = object       { objekt udr‘uj¡c¡ seznam objekt– }
         Objekty : ObjPtr;
         constructor Init;
         destructor Done; virtual;
         procedure Vloz(Pa : BodPtr);
         procedure Vypis;
       end;

var
  GDriver : Integer;     { K¢d grafick‚ho ovlada‡e. }
  GMode : Integer;       { K¢d grafick‚ho re‘imu. }
  Text : String;         { Promˆnn  pro textov˜ ©etˆzec. }
  IOseznam : Oseznam;    { Instance objektu Oseznam. }
  POblouk : ObloukPtr;   { Ukazatel na objekt Oblouk. }
  PKruh : KruhPtr;       { Ukazatel na objekt Kruh. }
  PCtverec : CtverecPtr; { Ukazatel na objekt Ctverec. }
  PrvniObj : ObjPtr;     { Ukazatel na za‡ tek seznamu obj. }

{ Procedury, kter‚ nejsou metodami objekt–. }
procedure OutTextLn(LnText : String);
{ Zobraz¡  © dkov˜  ©etˆzec  na  aktu ln¡  pozici grafick‚ho
  ukazatele.  LnText - © dkov˜ ©etˆzec. }
begin
  OutText(LnText);
  MoveTo(0, GetY+12);
end;

procedure HeapSt(StavZpr : String);
{ Zjist¡ stav haldy a zobraz¡ informa‡n¡ zpr vu. }
begin
  Str(MemAvail : 6, Text);
  OutTextLn(StavZpr+Text);
end;

{ Metody objektu Lokace }

procedure Lokace.Init(Xi,Yi : integer);
begin
   X := Xi;
   Y := Yi;
end;

function Lokace.CtiX : integer;
begin
   CtiX := X;
end;

function Lokace.CtiY : integer;
begin
   CtiY := Y;
end;

{ Implementace metod objektu Bod }

constructor Bod.Init(Xi,Yi : integer);
begin
   Lokace.Init(Xi,Yi);
   Barva:=Graph.GetColor;
   Viditelnost := False;
end;

destructor Bod.Done;
begin
end;

procedure Bod.NastavBarvu(KodBarvy : byte);
{ Nastav¡ barvu bodu. }
begin
   Barva := KodBarvy;
   Graph.SetColor(KodBarvy);
end;

procedure Bod.Zobraz;
begin
   Viditelnost := True;
   Graph.PutPixel(X,Y,Barva);
end;

procedure Bod.Zhasni;
begin
   Viditelnost := False;
   Graph.PutPixel(X,Y,Graph.GetBkColor);
end;

function Bod.Stav : boolean;
begin
   Stav := Viditelnost;
end;

procedure Bod.Posuv(Xn,Yn : integer);
begin
   Zhasni;
   X := Xn;
   Y := Yn;
   Zobraz;
end;

function GetDelta(var Dx,Dy : integer) : boolean;
var
   Key : Char;
   Quit : boolean;
begin
   Dx := 0;               { 0 - beze zmˆny }
   Dy := 0;
   GetDelta := True;
   repeat
      Key := CRT.ReadKey; { €te znak z kl vesnice. }
      Quit := True;
      case ord(Key) of
         0 : begin         { byla stisknuta ©¡d¡c¡ kl. }
             key := CRT.readkey;
                case ord(key) of
                   72 : Dy := -1;   { ¨ipka nahoru }
                   80 : Dy := 1;    { ¨ipka dol– }
                   75 : Dx := -1;   { ¨ipka vlevo }
                   77 : Dx := 1;    { ¨ipka vpravo }
                else Quit := False;
                end;
             end;
        13 : GetDelta := False;     { kl vesa CR }
      else Quit := False;         { ignoruj jinou kl.}
      end;
   until Quit;
end;

procedure Bod.Pohyb(B : integer);
var
   Dx,Dy : integer;
   Px,Py : integer;
begin
   Zobraz;              { Zobraz obrazec. }
   Px := GetX;          { Nastaven¡ aktu ln¡ch sou©ad.}
   Py := GetY;
   while GetDelta(Dx,Dy) do
   begin
      Px := Px + (Dx * B);
      Py := Py + (Dy * B);
      Posuv(Px,Py);
   end;
end;

{ Implementace metod objektu Kruh }

constructor Kruh.Init(Xi,Yi,Ri : integer);
begin
   Bod.Init(Xi,Yi);
   R := Ri;
end;

procedure Kruh.Zobraz;
begin
   Viditelnost := True;
   NastavBarvu(Barva);
   Graph.Circle(X,Y,R);
end;

procedure Kruh.Zhasni;
begin
   Graph.SetColor(Graph.GetBkColor);
   Viditelnost := False;
   Graph.Circle(X,Y,R);
end;

procedure Kruh.Zvetsi(E : integer);
begin
   Zhasni;
   R := R + E;
   if R < 0 then R := 0;
   Zobraz;
end;

procedure Kruh.Zmensi(C : integer);
begin
   Zvetsi(-C);
end;

{ Deklarace metod objektu Ctverec }

constructor Ctverec.Init(Xi,Yi,Stranai:integer);
begin
   Bod.Init(Xi,Yi); { vol n¡ zdˆdˆn‚ metody }
   Strana := Stranai;
end;

procedure Ctverec.Zobraz;
begin
   Viditelnost := True;
   Bod.NastavBarvu(Barva);
   Graph.Rectangle(X,Y,X+Strana,Y+Strana);
end;

procedure Ctverec.Zhasni;
begin
   Graph.SetColor(Graph.GetBkColor);
   Viditelnost := False;
   { Kresl¡ ctverec barvou pozad¡. }
   Graph.Rectangle(X,Y,X+Strana,Y+Strana);
   Bod.NastavBarvu(Barva);
end;

{ Metody objektu Oblouk. }
constructor Oblouk.Init(Xi,Yi,Ri,ZacatekI, KonecI : Integer);
{ Inicializace datov˜ch slo‘ek  objektu, inicializace virtu-
   ln¡ch metod. }
begin
  Kruh.Init(Xi, Yi, Ri);
  Zacatek := ZacatekI;
  Konec := KonecI;
end;

procedure Oblouk.Zobraz;
{ Zobraz¡ kruhov˜ oblouk podle hodnot datov˜ch slo‘ek. }
begin
  Viditelnost := True;
  Graph.Arc(X, Y, Zacatek, Konec, R);
end;

procedure Oblouk.Zhasni;
{ Zru¨¡ zobrazen¡ kruhov‚ho oblouku na obrazovce. }
var
  Color : Word;
begin
  Color := Graph.GetColor;
  Graph.SetColor(Graph.GetBkColor);
  Viditelnost := False;
  { Nakresl¡ kruhov˜ oblouk v barvˆ pozad¡. }
  Graph.Arc(X, Y, Zacatek, Konec, R);
  Graph.SetColor(Color);
end;

{ Implementace metod objektu Oseznam. }
constructor Oseznam.Init;
begin
  Objekty := nil;
end;

destructor Oseznam.Done;
{ Ru¨¡ ve¨ker‚ dynamick‚ struktury z opera‡n¡ pamˆti. }
var
  O : ObjPtr;
begin
  while Objekty <> nil do
  begin
    O := Objekty;
    Objekty := O^.Pn;
    Dispose(O^.Pa, Done);
    Dispose(O);
  end;
end;

procedure Oseznam.Vloz(Pa : BodPtr);
{ Vlo‘¡ do seznamu nov˜ prvek. }
var  O : ObjPtr;
begin
  New(O);
  O^.Pa := Pa;
  O^.Pn := Objekty;
  Objekty := O;
end;

procedure Oseznam.Vypis;
{ Vyp¡¨e sou©adnice dynamick˜ch objekt– v seznamu. }
var  Aktual : ObjPtr;
begin
  Aktual := Objekty;
  while Aktual <> nil do
    begin
      Str(Aktual^.Pa^.CtiX : 3, Text);
      OutTextLn('X = '+Text);   { Sou©adnice X }
      Str(Aktual^.Pa^.CtiY : 3, Text);
      OutTextLn('Y = '+Text);   { Sou©adnice Y }
      Aktual := Aktual^.Pn;
    end;
end;

{ Hlavn¡ program. }

begin
  { Zjisteni grafickeho ovladace a grafickeho rezimu. }

  DetectGraph(GDriver, GMode);
  InitGraph(GDriver, GMode,'');
  if GraphResult <> GrOK then
    begin
      WriteLn('Grafick  chyba. ');
      Halt(1);
    end;

  HeapSt('Pred vytvorenim seznamu je zjisteno : ');

  { Vytvo©en¡ seznamu objekt–. }

  IOseznam.Init;      { Inicializace seznamu. }

  { Vytvo©en¡  seznamu a vlo‘en¡ grafick˜ch  obrazc– v jedn‚
    operaci. }

  IOseznam.Vloz(New(ObloukPtr, Init(151, 82, 25, 200, 330)));
  IOseznam.Vloz(New(KruhPtr, Init(400, 100, 40)));
  IOseznam.Vloz(New(KruhPtr, Init(305, 136, 5)));

  { Prohl‚dnut¡ seznamu a  zobrazen¡ sou©adnic X,Y jednotli-
    v˜ch prvk– seznamu. }

  IOseznam.Vypis;

  { Zji¨tˆn¡ stavu haldy po vlo‘en¡ objekt– do seznamu. }

  HeapSt('Prostor haldy po vytvoreni seznamu :');

  { Uvolnˆn¡ dynamick˜ch  struktur z  pamˆti vol n¡m metody
    destruktoru. }

  IOseznam.Done;

  { Zji¨tˆn¡ stavu pamˆti po uvolnˆn¡ prvk– seznamu. }


  HeapSt('Prostor haldy po uvolneni prvku seznamu : ');

  OutText('Stiskni ENTER.....');

  Readln;

  CloseGraph;

end.
