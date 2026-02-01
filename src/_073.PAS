program DemoVRAM;

uses CRT, DOS;

var 
   VSegment : word;

function CtiRezim : byte;
var
   Regs : Registers;
   Rezim: byte;
begin
   with Regs do
   begin
      AH := $0F;
      Intr($10, Regs);
      Rezim := Al and $7F;
   end;
   CtiRezim := Rezim;
end;

procedure TestVideo;

begin
  if CtiRezim = 7 then  
    VSegment := $B000       
  else                      
    VSegment := $B800;      
end;

procedure Zapis(Sl, Ra, Barva : byte; Retezec : string);

var Stranka  : word absolute $0040:$004E;  
    Offset   : word;              
    I, J     : byte;                          
    ZnakAttr : word;                          

begin
   Offset := Ra * 160 + Sl * 2 + Stranka;
   ZnakAttr := Barva shl 8; 
   I := Length(Retezec); 
   for J:=1 to I do 
   begin         
      MemW[VSegment:Offset] := ZnakAttr or ord(Retezec[J]);
      Offset := Offset + 2; 
    end;
end;

var Sl, Ra, Barva : integer;

begin
   TestVideo;
   TextBackGround(Black); 
   ClrScr;                
   Randomize;  
   while not KeyPressed do 
   begin
      Sl := Random(78);              
      Ra := Random(24) + 1; 
      Barva := Random(15);
      Zapis( Sl, Ra, Barva, 'Û');
   end; 
   ClrScr;                                        
end.


