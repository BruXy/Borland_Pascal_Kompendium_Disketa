{$S-,R-,V-,I-,B-,F+}

unit UserDisk;

interface

uses DOS;

type
    Ch = char;
    InfoBlok  = record
                  DiskJednotka       : byte;
                  VolneAlokJednotky  : word;
                  CelkemAlokJednotek : word;
                  ByteSektor         : word;
                  SektorAlok         : word;
                end;
    TypyDisku = (FD360KB, FD720KB, FD1200KB,
                FD1440KB, NestandardFD,
                HardDisk, RamDisk, NeznamyDisk);

Function PocetDisku : Byte;
{ Vrac¡ po‡et instalovan˜ch logick˜ch jednotek. }

Procedure NastavDisk(Disk : Ch);
{ Nastav¡ specifikovanou diskovou jednotku jako pracovn¡. }

Function PracovniDisk : Char;
{ Vrac¡ ozna‡en¡ pracovn¡ho disku ve form tu velk‚ho p¡smene. }

Procedure InfoDisk(Disk : Ch; var Info : InfoBlok);
{ P©e‡te technick‚ informace o magnetick‚m m‚diu a ulo‘¡ je do z znamu
  InfoBlok, kter˜ m  slo‘ky :

         VolneAlokJednotky   po‡et voln˜ch aloka‡n¡ch jednotek
         CelkemAlokJednotek  celkov˜ po‡et aloka‡n¡ch jednotek
         ByteSektor          po‡et byte v jednom sektoru na disku
         SektorAlok          po‡et sektor– v jedn‚ aloka‡n¡ jednotce
}

Function TypDisku(Disk : Ch) : TypyDisku;
{ Vrac¡ typ disku, kter˜ se na vstupu definuje p¡smenem. }

implementation

var
   Reg : Registers;

Function PocetDisku : Byte;
{ Vrac¡ po‡et instalovan˜ch logick˜ch jednotek. }
begin
   with Reg do
   begin
      AH := $19;        { ‡¡slo implicitn¡ jednotky }
      MsDos(Reg);
      DL := AL;         { cislo aktualniho disku do DL }
      AH := $0E;        { volba diskove jednotky }
      MsDos(Reg);
      PocetDisku := AL; { pocet jednotel se vraci v AL }
   end;
end;

Procedure NastavDisk(Disk : Ch);
{ Nastav¡ specifikovanou diskovou jednotku jako pracovn¡. }
begin
    Disk:=UpCase(Disk); { znak disku na velk‚ p¡smeno }
    with Reg do
    begin
       if Disk in ['A'..'Z'] then
          DL := (Ord(Disk)-65)
       else
          Exit;
       AH := $0E;
       MsDos(Reg);
    end;
end;

Function PracovniDisk : Char;
{ Vrac¡ ozna‡en¡ pracovn¡ho disku ve form tu velk‚ho p¡smene. }
begin
   with Reg do
   begin
       AH := $19;
       MsDos(Reg);
       PracovniDisk := Chr(AL+Ord('A'));
   end;
end;

Procedure InfoDisk(Disk : Ch; var Info : InfoBlok);
{ P©e‡te technick‚ informace o magnetick‚m m‚diu a ulo‘¡ je do z znamu
  InfoBlok, kter˜ m  slo‘ky :
}

begin
    Disk:=UpCase(Disk);
    with Reg do
    begin
       If Disk=' ' then
          DL:=0
       else
       begin
          If Disk in ['A'..'Z'] then
          begin
             DL := (Ord(Disk)-64);
             Info.DiskJednotka := DL;
          end
          else
          begin
             Info.VolneAlokJednotky  := 0;
             Info.CelkemAlokJednotek := 0;
             Info.ByteSektor         := 0;
             Info.SektorAlok         := 0;
             Exit;
          end;
       end;
       AH := $36;
       MsDos(Reg);
       If AX = $0FFF then
       begin
          Info.VolneAlokJednotky  := 0;
          Info.CelkemAlokJednotek := 0;
          Info.ByteSektor         := 0;
          Info.SektorAlok         := 0;
          Exit;
       end;
       Info.VolneAlokJednotky  := BX;
       Info.CelkemAlokJednotek := DX;
       Info.ByteSektor         := CX;
       Info.SektorAlok         := AX;
    end;
end;

Function TypDisku(Disk : Ch) : TypyDisku;
{ Vrac¡ typ disku, kter˜ se na vstupu definuje p¡smenem.
  Tato rutina vyu‘¡v  nedokumentovan‚ slu‘by syst‚mu DOS $32. Informace
  o t‚to slu‘bˆ najdete v technick‚m popisu syst‚mu.}
  type
    Parametry  = record
        CisloDisku, OvladacDisku          : Byte;
        ByteNaSektor                      : Word;
        SektoruNaJednotku, ShiftFaktor    : Byte;
        ReservovaneSektoryProBoot         : Word;
        KopieFAT                          : Byte;
        RootZaznamy, PrvniDatovySektor    : Word;
        NejvyssiAlokJednotka              : Word;
        SektoruProFAT                     : Byte;
        PrvniSektorProROOT                : Word;
        AdresaOvladace                    : Pointer;
        IDMedia2a3                        : Byte;     {ID pro DOS 2.x a 3.x}
        IDMedia4a5                        : Byte;     {ID pro DOS 4.x,5.x}
        NasledujiciBlokParametru          : Pointer;
    end;
    ParametryPTR = ^Parametry;
  var
    CisloDisku      : Byte;
    MediaDeskriptor : Byte;
  begin
    TypDisku := NeznamyDisk;
    Disk := Upcase(Disk);
    If Disk in ['A'..'Z'] then
       CisloDisku := Ord(Disk)-$40
    else
       Exit;
    with Reg do
    begin
      AH := $1C;                       {cteni ukazatele na descriptor byte}
      DL := CisloDisku;                {logicke cislo disku}
      MsDos(Reg);
      MediaDeskriptor := Mem[DS:BX];   {nacteni descriptoru}

      AH := $32;                       {cteni ukazatele na blok parametru disku}
      DL := CisloDisku;                {logicke cislo disku}
      MsDos(Reg);

      if (AL = $FF) then               {jestlize se definuje spatny disk}
         Exit;

      with ParametryPTR(Ptr(DS,BX))^ do begin
        If (KopieFAT = 1) then         {jednu kopii FAT ma ramdisk}
           TypDisku := RamDisk
        else
        if (MediaDeskriptor=$F8) then  {ID $F8 prislusi pevnemu disku}
           TypDisku := HardDisk
        else
        if (MediaDeskriptor>=$F9) then {ID vyhrazena pro pruzne disky}
          case NejvyssiAlokJednotka of {alokacni jednotka s nejvyssim cislem}
             355 : TypDisku := FD360KB;
        714,1423 : TypDisku := FD720KB;
            2372 : TypDisku := FD1200KB;
            else
                   TypDisku := NestandardFD;
          end
        else if (MediaDeskriptor = $F0) and (NejvyssiAlokJednotka = 2848) then
                   TypDisku := FD1440KB
        else
                   TypDisku := NeznamyDisk;
      end;
    end;
  end;


end.

