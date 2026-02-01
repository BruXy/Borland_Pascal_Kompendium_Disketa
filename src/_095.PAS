Program Barvy4;

uses Graph, GraphIni, CRT;

procedure Pozadi;
var
   Ch          : char;
   BarvaPozadi : word;
   MaxBarva    : integer;
begin
  MaxBarva := GetMaxColor;  {zji¨tˆn¡ maxim ln¡ho po‡tu barev}
  SetBkColor(Red);          {v˜choz¡ barvou pozad¡ bude ‡erven }
  repeat
     if KeyPressed then
     begin
        Ch := ReadKey;      {stiskem kl vesy B se mˆn¡ barva pozad¡}
        if Upcase(Ch) = 'B' then
        begin               {v˜po‡et a nastaven¡ barvy pozad¡}
           if BarvaPozadi > MaxBarva then
              BarvaPozadi := 0
           else
              Inc(BarvaPozadi);
           SetBkColor(BarvaPozadi);
        end;
     end;
  until Ch=#27;
end;


begin
   Inicializace;
   Pozadi;
   TextovyRezim;
end.