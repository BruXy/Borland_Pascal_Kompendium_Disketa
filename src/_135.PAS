     uses graph,crt,_131;

     type

       Kruh = object(Bod)
           R : integer;
           procedure Init(Xi,Yi,Ri : integer);
           procedure Zhasni;
           procedure Zobraz;
           procedure Zvets(E : integer);
           procedure Posuv(Xn,Yn : integer);
           procedure Zmensi(C : integer);
       end;

       procedure Kruh.Init(Xi,Yi,Ri : integer);
       {  Nastav¡ parametry kruhu. Sou©adnice st©edu se
          nastav¡ vol n¡m zdˆdˆn‚ metody Init po objektu p©edka Bod,
          p–vodn¡ metoda se roz¨i©uje o nastaven¡ polomˆru kruhu. }
       begin
           Bod.Init(Xi,Yi);
           R := Ri;
       end;

       procedure Kruh.Zobraz;
       { Nakresl¡ kruh. Metoda se dˆd¡ z objektu Bod, ale
         pro kreslen¡ kruhu se mus¡ jej¡ tˆlo p©edefinovat. }
       begin
           Viditelnost := True;
           NastavBarvu(Barva);
           Graph.Circle(X,Y,R);       { Procedura jednotky Graph }
       end;

       procedure Kruh.Zhasni;
       { Zru¨¡ zobrazen¡ kruhu z obrazovky. Metoda se dˆd¡ z
         objektu  Bod, ale pro zhasnut¡ kruhu   se  mus¡  jej¡   tˆlo
         p©edefinovat. }
       begin
           Graph.SetColor(Graph.GetBkColor);
                                      { nastav¡ barvu pozad¡}
           Viditelnost := False;
           Graph.Circle(X,Y,R);       { kresl¡ kruh barvou pozad¡ }
       end; { GetColor,SetColor a Circle jsou procedury jed-
              notky Graph. }

       procedure Kruh.Zvets(E : integer);
       {  Nakresl¡ kruh  jeho‘ polomˆr  se zvˆt¨¡  o hodnotu
          parametru E. P–vodn¡ kruh zhasne, zvˆt¨en˜ se zobraz¡. }
       begin
           Zhasni;                    { p–vodn¡ kruh se vyma‘e }
           R := R + E;                { zvˆt¨en¡ polomˆru o E }
           If R<0 then R:=0;
           Zobraz;                    { zobraz¡ vˆt¨¡ kruh }
       end;

       procedure Kruh.Zmensi(C : integer);
       { Nakresl¡ kruh jeho‘ polomˆr se zmen¨¡ o hodnotu pa-
         rametru C.  Zmˆnu polomˆru a  kreslen¡ kruhu provede  metoda
         Zvets. }
       begin
           Zvets(-C);
       end;

       procedure Kruh.Posuv(Xn,Yn : integer);
       { Posune kruh do bodu, jeho‘ sou©adnici definuj¡ para-
         metry metody. }
       begin
           Zhasni;                    { v˜maz p–vodn¡ho kruhu }
           X := Xn;
           Y := Yn;
           Zobraz;                    { zobraz¡ kruh na nov‚ sou©.}
       end;

       var
          K : Kruh;
          Gdrv : integer;
          Gmode: integer;
          key  : char;

       begin
           DetectGraph(Gdrv,Gmode);
           InitGraph(Gdrv,Gmode,'');

           K.Init(200,150,20);
           K.Zobraz;
           Randomize;
           repeat
              K.NastavBarvu(Random(15));
              CRT.Delay(80);
              K.Zvets(Random(30));
              CRT.Delay(80);
              K.Zmensi(20);
              CRT.Delay(80);
              K.Posuv(Random(GetMaxX),Random(GetMaxY));
           until Keypressed;
       end.

