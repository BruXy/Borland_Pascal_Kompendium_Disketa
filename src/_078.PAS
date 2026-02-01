Program SouboryDOS;

uses DOS, CRT;
type 
   S = string;
var                      { seznam nalezen˜ch soubor– }
   Soubory : array[1..256] of SearchRec;
   Prvku   : integer;

Procedure HledejSoubor(Maska : S);
{ vyhled  soubory v adres ©i disku }
var
   I       : integer;    { ‡¡ta‡ index– pole }
   Soubor  : SearchRec;  { typ z jednotky DOS }
begin
   I:=1;                 { hledej prvn¡ podle masky }
   FindFirst(Maska,AnyFile,Soubor);
   while DosError=0 do   { dokud nedojde k chybˆ }
   begin
      Inc(I);            
      FindNext(Soubor);  { hledej dal¨¡ }
      Soubory[I]:=Soubor;{ ulo‘ nalezen˜ do pole }
   end;
   Prvku := I;           { po‡et nalezen˜ch }
end;

Procedure Atribut(Attr : byte);
{ p©evod atributu na znakov˜ symbol }
begin
    If Attr and ReadOnly <> 0 then  { vyhodnocen¡ }
       Write('R') else Write('.');
    If Attr and Hidden <> 0 then
       Write('H') else Write('.');
    If Attr and SysFile <> 0 then
       Write('S') else Write('.');
    If Attr and VolumeID <> 0 then
       Write('V') else Write('.');
    If Attr and Directory <> 0 then
       Write('D') else Write('.');
    If Attr and Archive <> 0 then
       Write('A') else Write('.');
end;

Procedure Vypis;
var
   I       : integer;    { ‡¡ta‡ index– pole }
   Soubor  : PathStr;    { deklarace ©etˆzc– }
   Cesta   : DirStr;     
   Jmeno   : NameStr;
   Pripona : ExtStr;
   DT      : DateTime;
   Ch      : char;
begin
   I := 1;
   while I <= Prvku do
   begin
      while WhereY<23 do
      begin              { rozklad jm‚na souboru }
         FSplit(Soubory[I].Name,Cesta,Jmeno,Pripona);
                         { rozklad ‡asov‚ho £daje }
         UnpackTime(Soubory[I].Time,DT);
         GotoXY(1,WhereY);
         Write(Jmeno);   { jm‚no souboru }
         GotoXY(9,WhereY);
         Write(Pripona); { p©¡pona souboru }
         GotoXY(13,WhereY);
         Write(Soubory[I].Size:10);
                         { velikost souboru }
         GotoXY(24,WhereY);
         Write(DT.Day:2,'.',DT.Month:2,'.',DT.Year:4);
                         { datum vytvo©en¡ }
         GotoXY(35,WhereY);
         Write(DT.Hour:2,':',DT.Min:2,':',DT.Sec:2);
                         { ‡as vytvo©en¡ }
         GotoXY(44,WhereY);
         Atribut(Soubory[I].Attr);
                         { p©¡znaky atribut– }
         GotoXY(51,WhereY);
         Write(FExpand(Soubory[I].Name));
                         { kompletn¡ cesta p©¡stupu }
         WriteLn;
         Inc(I);
      end;
      WriteLn('Stiskni libovolnou kl vesu...');
      repeat
      until Keypressed;
      Ch := ReadKey;
      ClrScr;
   end;
end;

begin
     ClrScr;
     HledejSoubor('*.*');
     Vypis;
end.
