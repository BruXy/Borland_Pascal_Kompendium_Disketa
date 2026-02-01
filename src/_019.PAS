program Priklad019;

{$DEFINE mys}

procedure Inicializace;
begin
end;

begin
   {$IFDEF mys}
       Inicializace;
   {$ENDIF}
   {......}
end.