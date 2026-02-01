program TV4;

{ Uk zkov˜ program v Turbo Vision. }

{ Roz¨¡©en¡ programu TV3 o pr ci s okny (nap©. by      }
{ mohla slou‘it pro zobrazen¡ textu).                  }
{ Zmˆny jsou ozna‡eny pozn mkou *4*. Modulov‚ jednotky }
{ TVHelp a TVStLine jsou bez zmˆny.                    }

uses
  Dos,
  Objects, Drivers, Views, Menus, App, MsgBox,
  _146, _148a, _148b,
  _147;                   {- definuje objekt TOkno } {*4*}

type
  { TTVApp - program }

  PTVApp = ^TTVApp;
  TTVApp = object(TApplication)
    procedure HandleEvent(var Event: TEvent); virtual;
      {- Obsluha ud lost¡. }
    procedure Idle; virtual;                             {*4*}
      {- Obsluha ud lost¡ v pozad¡. }
    procedure InitMenuBar; virtual;
      {- Vytvo©en¡ nab¡dky programu. }
    procedure InitStatusLine; virtual;
      {- Vytvo©en¡ stavov‚ho © dku. }
  end; { TTVApp }

const
  MaxPocetOken = 9; {- maxim ln¡ po‡et otev©en˜ch oken } {*4*}

  {- P©ehled otev©en˜ch oken; index = ‡¡slo okna, True = otev©eno. }
  OtevrenaOkna: array[1..MaxPocetOken] of Boolean =      {*4*}
    (False, False, False, False, False, False, False, False, False);

procedure TTVApp.HandleEvent(var Event: TEvent);
  {- Obsluha ud lost¡ v programu. }

  procedure Datum;
    {- Zobrazen¡ syst‚mov‚ho data. }
  const
    Den: array [0..6] of string[7] =
      ('nedˆle', 'pondˆl¡', '£ter˜', 'st©eda', '‡tvrtek', 'p tek', 'sobota');
    Mesic: array [1..12] of string[9] =
      ('ledna', '£nora', 'b©ezna', 'dubna', 'kvˆtna', '‡ervna',
       '‡ervence', 'srpna', 'z ©¡', '©¡jna', 'listopadu', 'prosince');
  var
    r, m, d, DenVTydnu: Word;
    L: array[0..3] of Pointer;   {- pole pro FormatStr (MessageBox) }
  begin
    GetDate(r, m, d, DenVTydnu); {- zji¨tˆn¡ syst‚mov‚ho data }
    L[0] := @Den[DenVTydnu];     {- nastaven¡ parametr–       }
    L[1] := Pointer(d);
    L[2] := @Mesic[m];
    L[3] := Pointer(r);
    {- Zobrazen¡ okna s informac¡ a jedn¡m tla‡¡tkem OK. }
    MessageBox(^C'Dnes je %s ' + #13#13 +
               ^C'%d. %s %d.', @L, mfInformation + mfOkButton);
  end; { Datum }

  procedure OProgramu;
    {- Zobrazen¡ informa‡n¡ho okna s jedn¡m tla‡¡tkem OK. }
  begin
    MessageBox(^C'Turbo Vision' + #13#13 +
               ^C'zku¨ebn¡ program', nil, mfInformation + mfOkButton);
  end; { OProgramu }

  procedure Okno(Pal: Integer);                          {*4*}
    {- Otev©en¡ okna v barv ch dan˜ch parametrem.   }
  var
    R: TRect;            {- rozmˆry a um¡stˆn¡ okna }
    W: PWindow;          {- otev¡ran‚ okno          }
    CisloOkna: Integer;  {- ‡¡slo okna              }
  begin
    {- Vyhled n¡ voln‚ho ‡¡slo okna: }
    CisloOkna := 1;
    while (CisloOkna <= MaxPocetOken) and OtevrenaOkna[CisloOkna] do
      Inc(CisloOkna);
    if CisloOkna <= MaxPocetOken then begin
      Desktop^.GetExtent(R);                   {- zji¨tˆn¡ velikosti       }
      W := New(POkno, Init(R, Pal, CisloOkna));{- vytvo©en¡ okna           }
      if ValidView(W) <> nil then begin        {- kontrola vytvo©en¡       }
        Desktop^.Insert(W);                    {- um¡stˆn¡ na prac. plochu }
        OtevrenaOkna[CisloOkna] := True;
      end; { if ValidView(W) }
    end; { if CisloOkna <= MaxPocetOken }
  end; { Okno }

begin { HandleEvent }
  inherited HandleEvent(Event);
  if Event.What = evCommand then begin
    {- Vyhodnocen¡ p©¡kazu: }
    case Event.Command of
      cmAbout  : OProgramu;
      cmDate   : Datum;
      cmBlueWin: Okno(wpBlueWindow);                     {*4*}
      cmCyanWin: Okno(wpCyanWindow);                     {*4*}
      cmGrayWin: Okno(wpGrayWindow);                     {*4*}
    else
      Exit;
    end; { case Event.Command }
  end else if (Event.What = evBroadcast) and (Event.Command = cmCloseWin) then
    {- Bylo uzav©eno okno (viz TOkno.Close), je nutn‚ zaznamenat: }
    OtevrenaOkna[Event.InfoInt] := False                 {*4*}
  else
    Exit;
  ClearEvent(Event); {- zru¨en¡ ud losti }
end; { TTVApp.HandleEvent }

procedure TTVApp.Idle;                                   {*4*}
  {- ž¡zen¡ ud lost¡ v pozad¡. }

  function IsTileable(P: PView): Boolean; far;
    {- Test, zda objekt P lze uspo© dat do kask dy nebo dla‘dicovˆ. }
  begin
    IsTileable := P^.Options and ofTileable <> 0;
  end; { IsTileable }

var
  i: Integer;
  Povol: Boolean;
begin
  inherited Idle;
  {- Nastaven¡ povolen¡/zak z n¡ polo‘ek "Kask da" a "Vedle sebe" v nab¡dce: }
  SetCmdState([cmTile, cmCascade], Desktop^.FirstThat(@IsTileable) <> nil);
  {- Nastaven¡ povolen¡/zak z n¡ polo‘ek v podnab¡dce "Nov‚ okno": }
  Povol := False;
  for i := 1 to MaxPocetOken do
    Povol := Povol or not OtevrenaOkna[i];
  SetCmdState([cmBlueWin, cmCyanWin, cmGrayWin], Povol);
end; { TTVApp.Idle }

procedure TTVApp.InitMenuBar;
  {- Vytvo©en¡ nab¡dky programu. }
var
  R: TRect;  {- v˜©ez pro hlavn¡ nab¡dku }
begin
  GetExtent(R);
  R.B.Y := R.A.Y + 1;
  MenuBar := New(PMenuBar, Init(R, NewMenu(
    NewSubMenu('~'#240'~', hcInfo, NewMenu(
      NewItem('~P~rogram...',          '', kbNoKey, cmAbout, hcIAbout,
      NewItem('~D~ne¨n¡ datum...',     '', kbNoKey, cmDate,  hcIDate,
      NewLine(
      NewItem('~K~onec programu', 'Alt-X', kbAltX,  cmQuit,  hcIQuit,
      nil))))),
    NewSubMenu('~O~kna', hcWindows, NewMenu(
      NewSubMenu('~N~ov‚ okno', hcNewWindow, NewMenu(
        NewItem('~M~odr‚ okno',            'F9', kbF9,      cmBlueWin, hcWBlue,
        NewItem('M~o~drozelen‚ okno','Shift-F9', kbShiftF9, cmCyanWin, hcWCyan,
        NewItem('›~e~d‚ okno',        'Ctrl-F9', kbCtrlF9,  cmGrayWin, hcWGray,
        nil)))),
      NewLine(
      NewItem('~U~zav©en¡',        'Alt-F3', kbAltF3,   cmClose,  hcWClose,
      NewItem('~P~osun, velikost','Ctrl-F5', kbCtrlF5,  cmResize, hcWResize,
      NewItem('~Z~vˆt¨en¡, zmen¨en¡',  'F5', kbF5,      cmZoom,   hcWZoom,
      NewItem('~D~al¨¡',               'F6', kbF6,      cmNext,   hcWNext,
      NewItem('P©~e~dchoz¡',     'Shift-F6', kbShiftF6, cmPrev,   hcWPrevious,
      NewItem('~V~edle sebe',            '', kbNoKey,   cmTile,   hcWTile,
      NewItem('~K~ask da',               '', kbNoKey,   cmCascade,hcWCascade,
      nil)))))))))),
    NewSubMenu('~K~onfigurace', hcConfig, NewMenu(
      NewItem('~P~aleta barev...', '', kbNoKey, cmPalette, hcCPalette,
      NewItem('~U~‘ivatel...',     '', kbNoKey, cmSet,     hcCSet,
      nil))),
    nil))))));
end; { TTVApp.InitMenuBar }

procedure TTVApp.InitStatusLine;
  {- Vytvo©en¡ stavov‚ho © dku. }
var
  R: TRect;  {- v˜©ez pro stavov˜ © dek }
begin
  GetExtent(R);
  R.A.Y := R.B.Y - 1;
  StatusLine := New(PTVStatusLine, Init(R,
    {- Stavov˜ © dek, je-li aktivn¡ nab¡dka: }
    NewStatusDef(hcInfo, hcCSet,
      NewStatusKey('~Alt-X~ Konec', kbAltX,   cmQuit,
      nil),
    {- Stavov˜ © dek pro ostatn¡ p©¡pady: }
    NewStatusDef(0, $FFFF,
      NewStatusKey('~Alt-X~ Konec', kbAltX,   cmQuit,
      NewStatusKey('~F10~ Nab¡dka', kbF10,    cmMenu,
      NewStatusKey('',              kbAltF3,  cmClose,
      NewStatusKey('',              kbF5,     cmZoom,
      NewStatusKey('',              kbCtrlF5, cmResize,
      nil))))),
    nil))));
end; { TTVApp.InitStatusLine }

var
  TVApp: TTVApp;

begin { hlavn¡ program }
  TVApp.Init;  {- inicializace     }
  TVApp.Run;   {- pr ce v programu }
  TVApp.Done;  {- ukon‡en¡         }
end.
