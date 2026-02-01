unit GraphIni;

interface

uses Graph, Ovladace, CRT;

var
  Ovladac, Rezim : integer;

Procedure Registrace;
Procedure Inicializace;
Function Chyba : boolean;
Procedure TextovyRezim;

implementation

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

Function Chyba : boolean;
var
   Kod    : integer;
   Zprava : string;
begin
   Kod := GraphResult;
   if Kod <> GrOK then
   begin
      Chyba := True;
      case Kod of
         GrNoInitGraph  
              : Zprava:='Nelze nainstalovat grafick˜ ovlada‡.';
         GrNotDetected  
              : Zprava:='Po‡¡ta‡ nem  grafick˜ ovlada‡.';
         GrFileNotFound 
              : Zprava:='Soubor s ovlada‡em nebyl nalezen.';
         GrInvalidDriver
              : Zprava:='Chyba grafick‚ho ovlada‡e.';
         GrNoLoadMem    
              : Zprava:='Nedostatek pamˆti pro ovlada‡.';
         GrInvalidMode  
              : Zprava:='Grafick˜ re‘im neodpov¡d  ovlada‡i.';
      end;
      WriteLn(Zprava);
   end
   else
      Chyba := False;
end;

Procedure Inicializace;
begin
   Registrace;
   Ovladac := Detect;
   InitGraph(Ovladac, Rezim, '');
   if Chyba then
      Halt(1);
end;

Procedure TextovyRezim;
begin
   CloseGraph;
   if Chyba then
      Halt(1);
end;

end.
