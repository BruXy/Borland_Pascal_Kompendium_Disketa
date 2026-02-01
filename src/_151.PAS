program TV5;

{ Uk zkov˜ program v Turbo Vision. }

{ Roz¨¡©en¡ programu TV4 o pr ci s dialogov˜mi okny.   }
{ Zmˆny jsou ozna‡eny pozn mkou *5*. Modulov‚ jednotky }
{ TvCmds a TVWin jsou bez zmˆny.                       }

uses
  Dos,
  Objects, Drivers, Views, Menus, App, MsgBox,
  Memory, Dialogs,                                       {*5*}
  TVCmds, TVHelp, TVStLine, TVWin,
  TVDial;                                                {*5*}

type
  { TTVApp - program }

  PTVApp = ^TTVApp;
  TTVApp = object(TApplication)
    procedure HandleEvent(var Event: TEvent); virtual;
      {- Obsluha ud lost¡. }
    procedure Idle; virtual;
      {- Obsluha ud lost¡ v pozad¡. }
    procedure InitMenuBar; virtual;
      {- Vytvo©en¡ nab¡dky programu. }
    procedure InitStatusLine; virtual;
      {- Vytvo©en¡ stavov‚ho © dku. }
  end; { TTVApp }

const
  MaxPocetOken = 9;      {- maxim ln¡ po‡et otev©en˜ch oken }

  {- P©ehled otev©en˜ch oken; index = ‡¡slo okna, True = otev©eno. }
  OtevrenaOkna: array[1..MaxPocetOken] of Boolean =
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

  procedure Okno(Pal: Integer);
    {- Otev©en¡ okna v barv ch dan˜ch parametrem. }
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

  procedure Uzivatel;                                    {*5*}
    {- P©¡klad dialogov‚ho okna. }
  var
    D: PDialog;  {- dialogov‚ okno }
  begin
    D := New(PUzivatelDialog, Init);           {- vytvo©en¡ okna             }
    if ValidView(D) <> nil then begin          {- kontrola vytvo©en¡         }
      D^.SetData(UzivatelData);                {- nastaven¡ dat v oknˆ       }
      if DeskTop^.ExecView(D) <> cmCancel then {- pr ce v oknˆ a pokud OK ...}
        D^.GetData(UzivatelData);              {- ... z¡sk n¡ nov˜ch dat     }
      Dispose(D, Done);                        {- zru¨en¡ okna               }
    end; { if ValidView(D) }
  end; { Uzivatel }

  procedure Paleta;                                      {*5*}
    {- Zmˆna barevn‚ palety. }
  var
    D: PDialog;  {- dialogov‚ okno }
  begin
    D := New(PPaletaDialog, Init);                   {- vytvo©en¡ okna       }
    if ValidView(D) <> nil then begin
      D^.SetData(AppPalette);                        {- sou‡asn‚ nastaven¡   }
      if DeskTop^.ExecView(D) <> cmCancel then begin {- pr ce v oknˆ         }
        D^.GetData(AppPalette);                      {- nov‚ nastaven¡       }
        Dispose(D, Done);                            {- zru¨en¡ okna         }
        {- Ur‡en¡ st¡nov n¡ oken a zobrazov n¡ pomocn˜ch zna‡ek: }
        if AppPalette <> apMonochrome then begin
          if ScreenMode and smFont8x8 <> 0 then
            ShadowSize.X := 1
          else
            ShadowSize.X := 2;
          ShadowSize.Y := 1;
          ShowMarkers := False;
        end else begin
          {- Pro mono ‘ dn˜ st¡n a zna‡ky: }
          Longint(ShadowSize) := 0;
          ShowMarkers := True;
        end; { if AppPalette <> apMonochrome }
        {- P©ekreslen¡ obrazovky v nov˜ch barv ch: }
        DoneMemory;
        ReDraw;
      end; { if Desktop^.ExecView(D) <> cmCancel }
    end; { if ValidView(D) <> nil }
  end; { Paleta }

begin { HandleEvent }
  inherited HandleEvent(Event);
  if Event.What = evCommand then begin
    {- Vyhodnocen¡ p©¡kazu: }
    case Event.Command of
      cmAbout  : OProgramu;
      cmDate   : Datum;
      cmBlueWin: Okno(wpBlueWindow);
      cmCyanWin: Okno(wpCyanWindow);
      cmGrayWin: Okno(wpGrayWindow);
      cmPalette: Paleta;                                 {*5*}
      cmSet    : Uzivatel;                               {*5*}
    else
      Exit;
    end; { case Event.Command }
  end else if (Event.What = evBroadcast) and (Event.Command = cmCloseWin) then
    {- Bylo uzav©eno okno (viz TOkno.Close), je nutn‚ prov‚st zmˆnu: }
    OtevrenaOkna[Event.InfoInt] := False
  else
    Exit;
  ClearEvent(Event); {- zru¨en¡ ud losti }
end; { TTVApp.HandleEvent }

procedure TTVApp.Idle;
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
    {- Stavov˜ © dek, je-li aktivn¡ dialogov‚ okno: }    {*5*}
    NewStatusDef(hcPaletaBarevna, hcTlacitkoZrus,
      NewStatusKey('~Alt-F3~ nebo ~Esc~ uzav©e okno', kbAltF3,  cmClose,
      nil),
    {- Stavov˜ © dek pro ostatn¡ p©¡pady: }
    NewStatusDef(0, $FFFF,
      NewStatusKey('~Alt-X~ Konec', kbAltX,   cmQuit,
      NewStatusKey('~F10~ Nab¡dka', kbF10,    cmMenu,
      NewStatusKey('',              kbAltF3,  cmClose,
      NewStatusKey('',              kbF5,     cmZoom,
      NewStatusKey('',              kbCtrlF5, cmResize,
      nil))))),
    nil)))));
end; { TTVApp.InitStatusLine }

var
  TVApp: TTVApp;

begin { hlavn¡ program }
  TVApp.Init;  {- inicializace     }
  TVApp.Run;   {- pr ce v programu }
  TVApp.Done;  {- ukon‡en¡         }
end.
