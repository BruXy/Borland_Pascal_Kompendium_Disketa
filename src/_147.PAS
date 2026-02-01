unit _147;

{ Okna pro program TVx. }

interface

uses
  Objects, Drivers, Views, App,
  TVCmds;

type
  { TOkno - jednoduch‚ okno }

  POkno = ^TOkno;
  TOkno = object(TWindow)
    constructor Init(var Bounds: TRect; APalette: Integer; ANumber: Integer);
      {- Inicializace okna: zad n¡ v˜©ezu, barevn‚ palety a ‡¡sla okna. }
    procedure Close; virtual;
      {- Uzav©en¡ (zru¨en¡) okna. }
  end; { TOkno }

{*************************************************************************}

implementation

constructor TOkno.Init(var Bounds: TRect; APalette: Integer; ANumber: Integer);
  {- Inicializace okna: zad n¡ v˜©ezu, barevn‚ palety a ‡¡sla okna. }
var
  S: TTitleStr;  {- ozna‡en¡ okna v z hlav¡ }
begin
  case APalette of
    wpBlueWindow: S := 'Modr‚ okno';
    wpCyanWindow: S := 'Modrozelen‚ okno';
    wpGrayWindow: S := '›ed‚ okno';
  end;
  inherited Init(Bounds, S, ANumber);
  Palette := APalette;
  Options := Options or ofTileable;  {- lze um¡stit do kask dy/dla‘dicovˆ }
end; { TOkno.Init }

procedure TOkno.Close;
  {- Uzav©en¡ (zru¨en¡) okna. }
begin
  if Valid(cmClose) then begin
    {- Zpr va o uvolnˆn¡ ‡¡sla okna (viz TTVApp.HandleEvent): }
    Message(Application, evBroadcast, cmCloseWin, Pointer(Number));
    Free;  {- zru¨en¡ objektu }
  end; { if Valid(cmClose) }
end; { TOkno.Close }

end.
