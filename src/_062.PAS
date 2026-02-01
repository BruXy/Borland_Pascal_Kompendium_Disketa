Program testPriznaku;

uses
   DOS, CRT;
type
   Keystroke = (Charakter,AltK,CtrlK,LeftShift,RightShift,
                InsertK,CapsLock,NumLock,ScrollLock);

const                         { p©¡znakov‚ konstanty }
   RShift = $01;              { prav˜ SHIFT }
   LShift = $02;              { lev˜ SHIFT }  
   Ctrl   = $04;              { kl vesa CTRL }
   Alt    = $08;              { kl vesa ALT }
   Scroll = $10;              { kl vesa SCROLLLOCK }
   Num    = $20;              { kl vesa NUMLOCK }
   Caps   = $40;              { kl vesa CAPSLOCK }
   Insert = $80;              { kl vesa INSERT }

var
  Reg : Registers;            { registrov  promˆnn  }

Function TestKeyb : Keystroke;
begin
   with Reg do
   begin
      AH:=$02;                { slu‘ba testu stisku kl ves }
      Intr($16,Reg);
      If AL and RShift <> 0 then
         TestKeyb := RightShift
      else
      If AL and LShift <> 0 then
         TestKeyb := LeftShift
      else
      If AL and Ctrl <> 0 then
         TestKeyb := CtrlK
      else
      IF AL and Alt <> 0 then
         TestKeyb := AltK;
   end;
end;

Procedure TestLock(var R : string);
begin
   R := '';
   with Reg do
   begin
      AH:=$02;                { slu‘ba testu stisku kl vesy }
      Intr($16,Reg);
      If AL and Scroll <> 0 then
         R := 'SCR ';
      If AL and Num <> 0 then
         R := R+'NUM ';
      If AL and Caps <> 0 then
         R := R+'CAPS ';
      IF AL and Insert <> 0 then
         R := R+'INS ';
   end;
end;

var
   R : string;
begin
   ClrScr;
   repeat
      TestLock(R);
      Write(R);
   until TestKeyb = CtrlK;
   repeat
      case TestKeyb of
         AltK : Write('ALT');
         CtrlK: Write('Ctrl');
      end;
   until TestKeyb = LeftShift;
end.