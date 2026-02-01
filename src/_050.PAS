Program Retezce;

uses CRT;

function Velka(S : string) : string;
var
   I : byte;
begin
  for I := 1 to Length(S) do
    S[I] := UpCase(S[I]);
  Velka := S;
end;


function HexToWord(Hexa : string) : word;

var I   : byte;
    Hex : word;

begin
   Hexa := Velka(Hexa);
   Hex := 0;
   for I := 1 to Length(Hexa) do
   begin
      if (Hexa[I] in ['0'..'9','A'..'F','a'..'f']) then
      begin
         Hex := Hex shl 4;
         if (Hexa[I] >= 'A' ) then
           Inc(Hex, Ord(Hexa[I] ) - 55 )
         else
           Inc(Hex, Ord(Hexa[I] ) - 48 );
      end
      else
      begin
         HexToWord := 0;
         Exit;
      end;
   end;
   HexToWord := Hex;
end;


function LongToHexa( L : longint; Mist : byte ) : String;

var Hbyte  : byte;
    Znak   : char;
    Hexa   : String;

begin
   Hexa := '';
   while ( L > 0 ) do
   begin
      Hbyte := L and $0F;
      if (Hbyte < 10 ) then
         Znak := Chr(Hbyte + 48)
      else
         Znak := Chr(Hbyte + 55 );
      Hexa := Znak + Hexa;
      L := L shr 4;
  end;
  while (length(Hexa) < Mist) do
     Hexa := '0'+Hexa;
  Hexa[1] := '$';
  LongToHexa := Hexa;
end;


var
   R : string;
   N : longint;
begin
   ClrScr;
   repeat
      Write('Zadej hexadecim ln¡ ‡¡slo: ');
      ReadLn(R);
      WriteLn(R,'-> ',HexToWord(R));
   until R = ' ';
   N:=0;
   repeat
      Write('Zadej cel‚ ‡¡slo: ');
      ReadLn(N);
      WriteLn(N,'-> ',LongToHexa(N,5));
   until N = 0;
end.