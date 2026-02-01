     program Demo8;

     uses CRT, DOS, Graph, _137;
     type
        Kruh = object(Bod)
           R : integer;
           constructor Init(Xi,Yi,Ri : integer);
           procedure Zobraz; virtual;
           procedure Zhasni; virtual;
           procedure Zvetsi(E : integer); virtual;
           procedure Zmensi(C : integer); virtual;
        end;
        Oblouk = object(Kruh)
           Zacatek, Konec : integer;
           constructor Init(Xi,Yi,Ri,ZacatekI,KonecI : integer);
           procedure Zobraz; virtual;
           procedure Zhasni; virtual;
        end;

        Ctverec = object(Bod)
           Strana : integer;
           constructor Init(Xi,Yi,Stranai : integer);
           procedure Zobraz; virtual;
           procedure Zhasni; virtual;
        end;

     var
        GDriver : integer;   { k¢d grafick‚ho ovlada‡e }
        GMode   : integer;   { k¢d grafick‚ho re‘imu }
        Error   : integer;   { chybov˜ k¢d }
        IOblouk : Oblouk;    { instance objektu oblouk }
        ICtverec: Ctverec;   { instance objektu ‡tverec }
        IKruh   : Kruh;      { instance objektu kruh }

     { Implementace metod objektu Kruh }

     constructor Kruh.Init(Xi,Yi,Ri : integer);
     begin
        Bod.Init(Xi,Yi);
        R := Ri;
     end;

     procedure Kruh.Zobraz;
     begin
        Viditelnost := True;
        NastavBarvu(Barva);
        Graph.Circle(X,Y,R);
     end;

     procedure Kruh.Zhasni;
     begin
        Graph.SetColor(Graph.GetBkColor);
        Viditelnost := False;
        Graph.Circle(X,Y,R);
     end;

     procedure Kruh.Zvetsi(E : integer);
     begin
        Zhasni;
        R := R + E;
        if R < 0 then R := 0;
        Zobraz;
     end;

     procedure Kruh.Zmensi(C : integer);
     begin
        Zvetsi(-C);
     end;

     { Deklarace metod objektu Oblouk }

     constructor Oblouk.Init(Xi,Yi,Ri,ZacatekI,KonecI:integer);
     begin
        Kruh.Init(Xi,Yi,Ri); { vol n¡ zdˆdˆn‚ metody }
        Zacatek := ZacatekI;
        Konec := KonecI;
     end;

     procedure Oblouk.Zobraz;
     begin
        Viditelnost := True;
        NastavBarvu(Barva);
        Graph.Arc(X,Y,Zacatek,Konec,R);
     end;

     procedure Oblouk.Zhasni;
     begin
        Graph.SetColor(Graph.GetBkColor);
        Viditelnost := False;
        { Kresl¡ oblouk barvou pozad¡. }
        Graph.Arc(X,Y,Zacatek,Konec,R);
        NastavBarvu(Barva);
     end;

     { Deklarace metod objektu Ctverec }

     constructor Ctverec.Init(Xi,Yi,Stranai:integer);
     begin
        Bod.Init(Xi,Yi); { vol n¡ zdˆdˆn‚ metody }
        Strana := Stranai;
     end;

     procedure Ctverec.Zobraz;
     begin
        Viditelnost := True;
        Bod.NastavBarvu(Barva);
        Graph.Rectangle(X,Y,X+Strana,Y+Strana);
     end;

     procedure Ctverec.Zhasni;
     begin
        Graph.SetColor(Graph.GetBkColor);
        Viditelnost := False;
        { Kresl¡ ctverec barvou pozad¡. }
        Graph.Rectangle(X,Y,X+Strana,Y+Strana);
        Bod.NastavBarvu(Barva);
     end;

     { Hlavn¡ program. }

     begin
        GDriver := Detect;  { zji¨tˆn¡ vhodn‚ho gr.ovlada‡e}
        Graph.InitGraph(GDriver,GMode,'');
        if Graph.GraphResult <> GrOk then
        begin
           WriteLn('Grafick  chyba.');
           Halt;
        end;
        { Typ  potomka,  objekt  Oblouk  obsahuje virtu ln¡
          metody,  p©ed   jejich  vyu‘it¡m  se   mus¡  volat
          constructor. }
        IKruh.Init(100,80,40);
        IOblouk.Init(100,80,20,0,90);
        ICtverec.Init(100,80,40);
        IKruh.Zobraz;
        IOblouk.Zobraz;
        ICtverec.Zobraz;
        { Posuv  oblouku se nyn¡ d   realizovat z kl vesnice
          pomoc¡ kl ves  ozna‡en˜ch ¨ipkou, posuv  se ukon‡¡
          stiskem kl vesy ENTER.}
        IKruh.Pohyb(10);
        IOblouk.Pohyb(10);  { parametrem je krok posuvu }
        ICtverec.Pohyb(10);
        Graph.CloseGraph;
     end.
