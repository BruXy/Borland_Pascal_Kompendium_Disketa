unit Fonty;

interface

Procedure SadaTrip;
Procedure SadaLitt;
Procedure SadaSans;
Procedure SadaGoth;

implementation

Procedure SadaGoth; external;
{$L GOTH.OBJ}
Procedure SadaLitt; external;
{$L LITT.OBJ}
Procedure SadaSans; external;
{$L SANS.OBJ}
Procedure SadaTrip; external;
{$L TRIP.OBJ}

end.