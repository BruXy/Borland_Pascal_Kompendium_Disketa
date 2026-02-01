program Init1;
uses Graph, CRT;

var
   Ovladac, Rezim : integer;

begin
   Ovladac := CGA;
   Rezim := CGAHi;
   InitGraph(Ovladac,Rezim,'');
   if GraphResult <> GrOK then
      Halt(1);
   OutText('Grafika je nyn¡ inicializov na.');
   Delay(1000);
   CloseGraph;
end.