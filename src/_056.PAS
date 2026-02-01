Program MoveProc;

uses CRT;

var
    Page     : pointer;
    { promˆnn‚,  kter‚ se pou‘¡vaj¡  p©i ukl d n¡ obrazovek,
      mus¡ b˜t deklarov ny jako glob ln¡ }

Procedure SaveScreenTo(var Page : pointer);
{ procedura p©enese obsah obrazov‚ pamˆti, str nky 0 do
  prostoru haldy. Promˆnn  page se mus¡ nejprve vytvo©i
  p©ed vol n¡m procedury }
begin
   Move(Mem[$B800:0],Page^,4096);
end;

Procedure RestScreenFrom(var Page : pointer);
{ procedura je opakem procedury SaveScreenTo, p©enese obsah
  promˆnn‚ page do prostoru obrazov‚ pamˆti, str nku 0. Po
  vol n¡ procedury by se mˆla promˆnn  page.. z haldy uvol-
  nit. }
begin
   Move(Page^,Mem[$B800:0],4096);
end;


begin
   TextBackground(Black);
   ClrScr;
   Write('Obrazovka cislo 1....');
   GetMem(Page,4096);   { ulo‘en¡ obsahu obrazovky }
   SaveScreenTo(Page);
   Delay(2000);
   TextBackground(Red);
   ClrScr;
   Write('Obrazovka cislo 2....');
   Delay(2000);

   { Procedury nov‚ho form tov n¡ obrazovky. }

   RestScreenFrom(Page);{ obnoven¡ p–vodn¡ho obsahu }
   Dispose(Page);
   Delay(2000);
end.


