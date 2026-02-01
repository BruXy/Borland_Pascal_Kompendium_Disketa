program Init2;

uses Graph, Ovladace, CRT;

var
  Ovladac, Rezim : integer;

Procedure Registrace;
begin
   if RegisterBGIdriver(@CGAOvladac) < 0 then
      Halt(2);
   if RegisterBGIdriver(@EGAVGAOvladac) < 0 then
      Halt(2);
   if RegisterBGIdriver(@HercOvladac) < 0 then
      Halt(2);
   if RegisterBGIdriver(@ATTOvladac) < 0 then
      Halt(2);
end;

begin
   Registrace;
   Ovladac := Detect;
   InitGraph(Ovladac, Rezim, '');
   if GraphResult <> GrOk then
   begin
      Writeln('Chyba p©i inicializaci grafick‚ho syst‚mu.');
      Halt(1);
   end;
   OutText('Grafick˜ syst‚m je nyn¡ inicializov n.');
   Delay(1000);
   CloseGraph;
end.
