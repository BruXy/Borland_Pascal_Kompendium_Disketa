unit _145c;

{ Objekt stavov˜ © dek pro program TVx. }

interface

uses
  Objects, Menus,
  TVHelp;

type
  { TTVStatusLine - stavov˜ © dek s n povˆdou. }

  PTVStatusLine = ^TTVStatusLine;
  TTVStatusLine = object(TStatusLine)
    function Hint(AHelpCtx: Word): String; virtual;
      {- Zobrazen¡ doprovodn˜ch informac¡ ve stavov‚m © dku. }
  end; { TTVStatusLine }

{*************************************************************************}

implementation

function TTVStatusLine.Hint(AHelpCtx: Word): String;
  {- Zobrazen¡ doprovodn˜ch informac¡ ve stavov‚m © dku. }
var
  S: String;
begin
  case AHelpCtx of
    {- Doprovodn‚ informace k nab¡dce programu: }
    hcInfo         : S := 'Informace o programu, ukon‡en¡ programu';
    hcIAbout       : S := 'Zobraz¡ okno s informac¡ o programu';
    hcIDate        : S := 'Zobraz¡ dne¨n¡ datum';
    hcIQuit        : S := 'Ukon‡¡ tento program';
    hcWindows      : S := 'Pr ce s okny: vytvo©en¡, uzav©en¡, posuny';
    hcNewWindow    : S := 'Podnab¡dka k vytvo©en¡ okna';
    hcWBlue        : S := 'Vytvo©¡ nov‚ modr‚ okno';
    hcWCyan        : S := 'Vytvo©¡ nov‚ modrozelen‚ okno';
    hcWGray        : S := 'Vytvo©¡ nov‚ ¨ed‚ okno';
    hcWClose       : S := 'Uzav©e aktivn¡ okno';
    hcWResize      : S := 'Umo‘n¡ zmˆnu velikosti a um¡stˆn¡ okna';
    hcWZoom        : S := 'Zvˆt¨¡ okno na maximum / zmen¨¡ okno';
    hcWNext        : S := 'Aktivuje n sleduj¡c¡ okno';
    hcWPrevious    : S := 'Aktivuje p©edchoz¡ okno';
    hcWTile        : S := 'Uspo© d  okna dla‘dicovˆ';
    hcWCascade     : S := 'Uspo© d  okna do kask dy';
    hcConfig       : S := 'Nastaven¡ konfigurace programu';
    hcCPalette     : S := 'Nastaven¡ barevn‚ palety';
    hcCSet         : S := 'P©¡klad nastaven¡ v dialogov‚m oknˆ';
  else
    S := ''; {- pro ostatn¡ hcXXXX }
  end; { case AHelpCtx }
  Hint := S;
end; { TTVStatusLine.Hint }

end.
