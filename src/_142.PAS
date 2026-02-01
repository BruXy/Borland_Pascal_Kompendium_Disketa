program TV1;

{ Uk zkov˜ program v Turbo Vision. }

{ P©¡klad vytvo©en¡ nab¡dky (menu) v programu. }

uses
  Objects, Drivers, Views, Menus, App,
  _140,  {- seznam konstant cmXXXX }
  _141;  {- seznam konstant hcXXXX }

type
  { TTVApp - program }

  PTVApp = ^TTVApp;
  TTVApp = object(TApplication)
    procedure InitMenuBar; virtual;
      {- Vytvo©en¡ nab¡dky programu. }
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

var
  TVApp: TTVApp;

begin { hlavn¡ program }
  TVApp.Init;  {- inicializace     }
  TVApp.Run;   {- pr ce v programu }
  TVApp.Done;  {- ukon‡en¡         }
end.
