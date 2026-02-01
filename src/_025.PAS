Program HiLoSawp;

uses
   CRT, DOS;
var
   DosVer : longint;
begin
   DosVer:=DosVersion;
   WriteLn;
   WriteLn('Verze opera‡n¡ho syst‚mu   : ',DosVer);
   WriteLn('Verze po rozkladu - Lo a Hi: ',Lo(DosVer),'.',Hi(DosVer));
   DosVer:=Swap(DosVer);
   WriteLn('Verze po v˜mˆnˆ - Swap     : ',DosVer);
   WriteLn('Verze po rozkladu - Lo a Hi: ',Lo(DosVer),'.',Hi(DosVer));
   repeat
   until Keypressed;
end.