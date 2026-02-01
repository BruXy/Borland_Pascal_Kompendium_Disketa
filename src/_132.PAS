     Program Demo4;
     uses Graph,_131,CRT;                       

     var  XBod : Bod;
          Gdriver  : integer;
          Gmode    : integer;

     begin
        DetectGraph(Gdriver,Gmode);
        initgraph(Gdriver,Gmode,'');

        { Vytvo©¡me  a zobraz¡me bod,  kter˜ je p©edstavov n
          instanc¡ objektu XBod, vol n¡m metod tohoto objek-
          tu.}
        XBod.Init(100,50); {Nastav¡ z kladn¡ sou©adnice bodu}
        XBod.Zobraz;       {Zobraz¡ bod na dan‚ sou©adnici.}
        Randomize;
        repeat
           Delay(100);
           XBod.NastavBarvu(Random(15));
           XBod.Posuv(Random(Graph.GetMaxX),Random(Graph.GetMaxY));
           {Posune bod na novou sou©ad.}
        until Keypressed;
        XBod.Zhasni;       {Zhasne bod na obrazovce.}
        CloseGraph;
     end.

