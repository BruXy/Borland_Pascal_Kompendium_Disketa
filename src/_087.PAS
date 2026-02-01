unit _087p312;

interface

procedure ATTOvladac;
procedure CgaOvladac;
procedure EgaVgaOvladac;
procedure HercOvladac;

implementation

procedure ATTOvladac; external;
{$L ATT.OBJ }
procedure CgaOvladac; external;
{$L CGA.OBJ }
procedure EgaVgaOvladac; external;
{$L EGAVGA.OBJ }
procedure HercOvladac; external;
{$L HERC.OBJ }

end.
