program TV2;

{ Uk zkov˜ program v Turbo Vision. }

{ Roz¨¡©en¡ programu TV1 o nastaven¡ stavov‚ho © dku.  }
{ Zmˆny jsou ozna‡eny pozn mkou *2*, modulov‚ jednotky }
{ TVCmds a TVHelp jsou stejn‚, nov  jednotka TVStLine. }

uses
  Objects, Drivers, Views, Menus, App,
  _143a, _143b,
  _143;  {- definuje objekt stavov˜ © dek }          {*2*}

type
  { TTVApp - program }

  PTVApp = ^TTVApp;
  TTVApp = object(TApplication)
    procedure InitMenuBar; virtual;
      {- Vytvo©en¡ nab¡dky programu. }
    procedure InitStatusLine; virtual;                   {*2*}
      {- Vytvo©en¡ stavov‚ho © dku. }
  end; { TTVApp }

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

procedure TTVApp.InitStatusLine;                         {*2*}
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
