unit _151u;

{ Dialogov  okna pro program TV5. }

interface

uses
  Objects, Drivers, Views, Dialogs,
  TVHelp;

type
  { TStatickaVypln - objekt vypln¡ dan˜ v˜©ez zadan˜m znakem }

  PStatickaVypln = ^TStatickaVypln;
  TStatickaVypln = object(TView)
    Vypln: Char; {- znak pro v˜pl¤ }
    constructor Init(var Bounds: TRect; AVypln: Char);
      {- Vytvo©en¡ objektu; zad n¡ v˜©ezu a znaku pro v˜pl¤. }
    procedure Draw; virtual;
      {- Zobrazen¡ objektu. }
    function GetPalette: PPalette; virtual;
      {- Nastaven¡ barev pro objekt. }
  end; { TStatickaVypln }

  { TPaletaDialog - dialogov‚ okno pro zmˆnu barevn‚ palety }

  PPaletaDialog = ^TPaletaDialog;
  TPaletaDialog = object(TDialog)
    constructor Init;
  end; { TPaletaDialog }

  { TUzivatelDialog - p©¡klad dialogov‚ho okna }

  PUzivatelDialog = ^TUzivatelDialog;
  TUzivatelDialog = object(TDialog)
    constructor Init;
  end; { TUzivatelDialog }

  {- Z znam dat nastavovan˜ch v dialogov‚m oknˆ TUzivatelDialog: }
  TUzivatelDialogData = record
    Jmeno: string[40];
    Firma: string[40];
    Adresa: string[80];
  end; { TUzivatelDialogData }

const
  {- Data nastavovan  v dialogov‚m oknˆ TUzivatelDialog: }
  UzivatelData: TUzivatelDialogData =
    (Jmeno: ''; Firma: ''; Adresa: '');

{*************************************************************************}

implementation

constructor TStatickaVypln.Init(var Bounds: TRect; AVypln: Char);
  {- Vytvo©en¡ objektu; zad n¡ v˜©ezu a znaku pro v˜pl¤. }
begin
  inherited Init(Bounds);
  Vypln := AVypln;
end; { TStatickaVypln.Init }

procedure TStatickaVypln.Draw;
  {- Zobrazen¡ objektu. }
var
  B: TDrawBuffer;
begin
  MoveChar(B, Vypln, GetColor(1), Size.X);
  WriteLine(0, 0, Size.X, Size.Y, B);
end; { TStatickaVypln.Draw }

function TStatickaVypln.GetPalette: PPalette;
  {- Nastaven¡ barev pro objekt - pou‘¡v  paletu pro objekt TStaticText. }
const
  P: String[Length(CStaticText)] = CStaticText;
begin
  GetPalette := @P;
end; { TStatickaVypln.GetPalette }

constructor TPaletaDialog.Init;
  {- Vytvo©en¡ dialogov‚ho okna pro zmˆnu palety barev. }
var
  P: PView;
  R: TRect;
begin
  R.Assign(0, 0, 34, 9);
  inherited Init(R, 'Paleta barev');
  Options := Options or ofCentered;

  R.Assign(6, 2, 28, 5);
  P := New(PRadioButtons, Init(R,
    NewSItem('~B~arevn ',
    NewSItem('€~e~rnob¡l ',
    NewSItem('~M~onochromatick ',
    nil)))
  ));
  P^.HelpCtx := hcPaletaBarevna;
  Insert(P);

  R.Assign(6, 6, 16, 8);
  P := New(PButton, Init(R, 'O~K~', cmOK, bfDefault));
  P^.HelpCtx := hcTlacitkoOK;
  Insert(P);

  R.Assign(18, 6, 28, 8);
  P := New(PButton, Init(R, '~Z~ru¨', cmCancel, bfNormal));
  P^.HelpCtx := hcTlacitkoZrus;
  Insert(P);

  SelectNext(False);
end; { TPaletaDialog }

constructor TUzivatelDialog.Init;
  {- Vytvo©en¡ dialogov‚ho okna pro zad n¡ £daj– o u‘ivateli. }
var
  R: TRect;
  P: PView;
begin
  R.Assign(0, 0, 55, 12);
  TDialog.Init(R, 'U‘ivatel');
  Options := Options or ofCentered;

  R.Assign(1, 8, 54, 9);
  P := New(PStatickaVypln, Init(R, 'Ä'));
  Insert(P);

  R.Assign(10, 2, 52, 3);
  P := New(PInputLine, Init(R, 40));
  P^.HelpCtx := hcVstupJmeno;
  Insert(P);

  R.Assign(2, 2, 10, 3);
  P := New(PLabel, Init(R, '~J~m‚no', P));
  Insert(P);

  R.Assign(10, 4, 52, 5);
  P := New(PInputLine, Init(R, 40));
  P^.HelpCtx := hcVstupFirma;
  Insert(P);

  R.Assign(2, 4, 10, 5);
  P := New(PLabel, Init(R, '~F~irma', P));
  Insert(P);

  R.Assign(10, 6, 52, 7);
  P := New(PInputLine, Init(R, 80));
  P^.HelpCtx := hcVstupAdresa;
  Insert(P);

  R.Assign(2, 6, 10, 7);
  P := New(PLabel, Init(R, '~A~dresa', P));
  Insert(P);

  R.Assign(29, 9, 39, 11);
  P := New(PButton, Init(R, 'O~K~', cmOK, bfDefault));
  P^.HelpCtx := hcTlacitkoOK;
  Insert(P);

  R.Assign(41, 9, 51, 11);
  P := New(PButton, Init(R, '~Z~ru¨', cmCancel, bfNormal));
  P^.HelpCtx := hcTlacitkoZrus;
  Insert(P);

  SelectNext(False);
end; { TUzivatelDialog.Init }

end.
