Program WriteProc;
uses
   CRT;
var
   X : byte;
   R : real;
   C : char;
   S : string;
begin
   X := 2;
   R := 234.67898;
   WriteLn('Cel‚ ‡¡slo zarovnan‚ na t©i m¡sta    : ',X:3);
   WriteLn('Cel‚ ‡¡slo zarovnan‚ na dvˆ m¡sta    : ',X:2);
   WriteLn('Cel‚ ‡¡slo zarovnan‚ na jedno m¡sto  : ',X:1);
   WriteLn;
   WriteLn('Re ln‚ ‡¡slo - t©i cel ,jedno desetinn‚ : ',R:5:1);
   WriteLn('Re ln‚ ‡¡slo - t©i cel ,dvˆ   desetinn  : ',R:6:2);
   WriteLn('Re ln‚ ‡¡slo - t©i cel ,t©i   desetinn  : ',R:7:3);
   WriteLn('Re ln‚ ‡¡slo - t©i cel ,‡ty©i desetinn  : ',R:8:4);
   repeat
   until Keypressed;
end.
