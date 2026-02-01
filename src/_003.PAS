type
   Zaznam = record
               Jmeno    : string;
               Adresa   : string;
               Telefon  : longint;
               case Akt : boolean of
                            False : (Skoleni : string);
                            True  : (Od      : integer;
                                     Zakazka : string);
            end;
begin
end.