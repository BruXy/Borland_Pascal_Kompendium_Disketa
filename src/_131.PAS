     unit _131;

     interface

     uses graph;

     type
        { Definice nejabstraktnˆj¨¡ho typu objekt - Lokace.}
        Lokace = object
            X,Y  :  integer;
            procedure Init(Xi,Yi : integer);
            function CtiX : integer;
            function CtiY : integer;
        end;

        { Definice typu potomka - Bod, kter˜ dˆd¡ vlastnos-
          ti typu p©edka, kter˜m je objekt Lokace. }
        Bod = object(Lokace)
            Viditelnost  :  boolean;
            Barva        :  byte;
            procedure Init(Xi,Yi : integer);
            procedure Zobraz;
            procedure Zhasni;
            procedure NastavBarvu(KodBarvy : byte);
            function CtiBarvu : byte;
            function Stav : boolean;
            procedure Posuv(Xn,Yn : integer);
        end;

        implementation

        { Implementace metod typu objekt - Lokace }

        procedure Lokace.Init(Xi,Yi : integer);
        { Provede inicializaci datov˜ch slo‘ek objektu X,Y.}
        begin
            X := Xi;
            Y := Yi;
        end;

        function Lokace.CtiX : integer;
        { Zjist¡ aktu ln¡ sou©adnici X bodu. }
        begin
            CtiX := X;
        end;

        function Lokace.CtiY : integer;
        { Zjist¡ aktu ln¡ sou©adnici Y bodu. }
        begin
            CtiY := Y;
        end;

        { Implementace metod typu potomka - objektu Bod }

        procedure Bod.Init(Xi,Yi : integer);
        {Procedura modifikuje zdˆdˆnou metodu p©edka. P–vod-
         n¡ metoda se roz¨i©uje o nastaven¡ polo‘ky Viditel-
         nost na po‡ te‡n¡ hodnotu - bod je neviditeln˜.
         V¨imˆte si vol n¡ metody p©edka s p©edponou identi-
         fik toru objektu p©edka. }
        begin
           Lokace.Init(Xi,Yi);
           Viditelnost := False;
           Barva := Graph.GetColor;
        end;

        procedure Bod.Zobraz;
        { Rozsv¡t¡ bod na aktu ln¡ sou©adnici v aktu ln¡
          barvˆ. }
        begin
           Viditelnost := True;
           Graph.PutPixel(X,Y,Barva);
        end;

        Procedure Bod.Zhasni;
        { Zobraz¡ bod v barvˆ pozad¡ na aktu ln¡ sou©adnici
          - bod zhasne. }
        begin
           Viditelnost := False;
           Graph.PutPixel(X,Y,Graph.GetBkColor);
        end;

        procedure Bod.NastavBarvu(KodBarvy : byte);
        { Nastav¡ barvu bodu. }
        begin
           Barva := KodBarvy;
           Graph.SetColor(KodBarvy);
        end;

        function Bod.CtiBarvu : byte;
        { Nastav¡ barvu bodu. }
        begin
           CtiBarvu := Barva;
        end;

        function Bod.Stav : boolean;
        { Zjist¡ stav zobrazen¡ bodu na obrazovce. }
        begin
           Stav := Viditelnost;
        end;

        procedure Bod.Posuv(Xn,Yn : integer);
        { Zobraz¡ bod na nov‚ sou©adnici definovan‚ paramet-
          ry metody. }
        begin
           Zhasni;
           X := Xn;
           Y := Yn;
           Zobraz;
        end;

        end.
