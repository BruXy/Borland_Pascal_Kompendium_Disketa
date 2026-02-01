unit _043p148;

interface

uses
  Dos;

function OtevreneKanaly(Devices : Boolean) : Byte;
{ Vrac¡ po‡et otev©en˜ch soubor– volaj¡c¡m programem. }

function VolneKanaly : Byte;
{ Vrac¡ po‡et komunika‡n¡ch kan lu, kter‚ se mohou v programu otev©¡t.
  jedn  se po‡et "handles". }

implementation

var
  Reg : Registers;


function OtevreneKanaly(Devices : Boolean) : Byte;
type
    TabulkaKanalu = array[0..19] of Byte;
                                       { tabulka ‡¡sel kan l– }
var
    KanalyPtr : ^TabulkaKanalu;        { ukazatel na tabulku }
    I, N : Byte;                       { pomocn‚ ‡¡ta‡e }
begin
    KanalyPtr := Ptr(PrefixSeg, $18);  { tabulka ‡¡sel kan lu je ulo‘ena v PSP
                                         na adrese PrefixSeg:$18 }
    N := 0;
    for I := 0 to 19 do
      if KanalyPtr^[I] <> $FF then     { jestli‘e kan l existuje }
         if (I>=0) and (I<=4) then     { prvn¡ ‡ty©i jsou vyhrazeny pro stdardn¡ za©¡zen¡ }
            Inc(N, Ord(Devices))       { jestli‘e je parametr TRUE - zahrnout }
         else
            Inc(N);                    { soubor zahrnout do po‡tu }
     OtevreneKanaly := N;
end;

function VolneKanaly : Byte;

const
    MaxSouboru = 20;                   { omezen¡ Turbo Pascalu }
var
    Soubory : array[1..MaxSouboru] of file;
                                       { pole mo‘n˜ch soubor– }
    I, N  : Byte;                      { pomocn‚ ‡¡ta‡e }
    Ano   : boolean;
begin
    N := 0;
    Ano := True;
    repeat
      Assign(Soubory[N+1], 'NUL');     { otev¡r n¡ souboru do MaxSouboru }
      Reset(Soubory[N+1]);
      Ano := (IOResult = 0);
      Inc(N, Ord(Ano))
    until (N = MaxSouboru) or not Ano;

    for I := 1 to N do begin           { uzav©en¡ v¨ech otev©en˜ch soubor– }
       Close(Soubory[I]);
       If IOResult = 0 then ;
    end;
    VolneKanaly := N;
end;

end.

