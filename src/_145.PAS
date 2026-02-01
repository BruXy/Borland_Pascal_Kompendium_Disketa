program TV3;

{ Uk zkov˜ program v Turbo Vision. }

{ Roz¨¡©en¡ programu TV2 o pr ci s informa‡n¡mi okny   }
{ a obsluhou ud lost¡.                                 }
{ Zmˆny jsou ozna‡eny pozn mkou *3*. Modulov‚ jednotky }
{ TVCmds, TVHelp a TVStLine jsou bez zmˆny.            }

uses
  Dos,           {- pou‘¡v  se procedura GetDate       } {*3*}
  Objects, Drivers, Views, Menus, App,
  MsgBox,        {- vytv ©¡ jednoduch  informa‡n¡ okna } {*3*}
  _145a, _145b, _145c;

type
  { TTVApp - program }

  PTVApp = ^TTVApp;
  TTVApp = object(TApplication)
    procedure HandleEvent(var Event: TEvent); virtual;   {*3*}
      {- Obsluha ud lost¡. }
    procedure InitMenuBar; virtual;
      {- Vytvo©en¡ nab¡dky programu. }
    procedure InitStatusLine; virtual;
      {- Vytvo©en¡ stavov‚ho © dku. }
  end; { TTVApp }

procedure TTVApp.HandleEvent(var Event: TEvent);         {*3*}
  {- Obsluha ud lost¡ v programu. }

  procedure Datum;                                       {*3*}
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

  procedure OProgramu;                                   {*3*}
    {- Zobrazen¡ informa‡n¡ho okna s jedn¡m tla‡¡tkem OK. }
  begin
    MessageBox(^C'Turbo Vision' + #13#13 +
               ^C'zku¨ebn¡ program', nil, mfInformation + mfOkButton);
  end; { OProgramu }

begin { HandleEvent }
  inherited HandleEvent(Event);
  if Event.What = evCommand then begin
    {- Vyhodnocen¡ p©¡kazu: }
    case Event.Command of
      cmAbout: OProgramu;
      cmDate : Datum;
    else
      Exit;
    end; { case Event.Command }
    ClearEvent(Event); {- zru¨en¡ ud losti }
  end; { if Event.What = evCommand }
end; { TTVApp.HandleEvent }

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
