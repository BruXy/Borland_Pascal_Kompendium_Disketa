unit _042p146;
interface
uses
   Dos;
var
   Reg : Registers;

procedure SetDta(DTAptr : Pointer);
{ Nastav¡ DTA opera‡n¡ho syst‚mu DOS na adresu DTAptr. 
  DTA je blok pamˆti, kter˜ se pou‘¡v  pro p©enos dat mezi 
  diskov˜m souborem a programem a naopak. DTAptr je ukazatel 
  na nove DTA }

procedure GetDta(var DTAptr : Pointer);
{ Zjist¡ adresu aktualn¡ho DTA. DTAptr je zji¨tˆn˜ ukazatelna DTA }

implementation

procedure SetDta(DTAptr : Pointer);
{ Nastav¡ DTA opera‡n¡ho syst‚mu DOS na adresu DTAptr. 
  DTA je blok pamˆti, kter˜ se pou‘¡v  pro p©enos dat mezi 
  diskov˜m souborem a programem a naopak. DTAptr je ukazatel 
  na nove DTA }
begin
   with Reg do
   begin
      AH := $1A;                       { nastaven¡ syst‚mov‚ho DTA }
      DS := Seg(DTAptr^);              { rozklad ukazatele na SEG a OFS }
      DX := Ofs(DTAptr^);
      MsDos(Reg);
   end;
end;

procedure GetDta(var DTAptr : Pointer);
{ Zjist¡ adresu aktualn¡ho DTA. DTAptr je zji¨tˆn˜ ukazatelna DTA }
begin
   with Reg do begin
      AH := $2F;                       { ‡ten¡ adresy syst‚mov‚ho DTA }
      MsDos(Reg);
      DTAptr := Ptr(ES, BX);           { konstrukce typu ukazatel }
   end;
end;

end.

