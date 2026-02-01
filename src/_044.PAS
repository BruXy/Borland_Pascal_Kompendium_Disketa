Program DemoAdresare;
{$I-}

uses CRT, DOS;

type
   S = string[80];

procedure MakeDir(Dir : S);
{ vytvo©¡ na disku nov˜ adres ©e }
begin
   MkDir(Dir);
   if IOResult <> 0 then
   begin
      GotoXY(20,0);
      Write('Adres © ji‘ existuje nebo nelze vytvo©it.');
      Delay(2000);
      Halt(1);
   end;
end;

procedure RemoveDir(Dir : S);
{ zru¨¡ adres © ze struktury disku }
begin
   RmDir(Dir);
   if IOResult <> 0 then
   begin
      GotoXY(20,0);
      Write('Adres © nen¡ pr zdn˜ nebo je ¨patnˆ definov n.');
      Delay(2000);
      Halt(1);
   end;
end;

procedure ChgDir(Dir : S);
{ zmˆn¡ aktu ln¡ adres © na disku }
begin
   ChDir(Dir);
   if IOResult <> 0 then
   begin
      GotoXY(20,0);
      Write('Adres © na disku neexistuje.');
      Delay(2000);
      Halt(1);
   end;
end;

var
   Jmeno : S;

begin
   ClrScr;
   Write('Demonstrace pr ce s adres ©i: ');
   WriteLn;
   Write('Vytvo©en¡ adres ©e - zadej jm‚no: ');
   ReadLn(Jmeno);
   MakeDir(Jmeno);
   WriteLn('Teƒ se vytvo©il adres © ',Jmeno);
   WriteLn;
   Delay(2000);
   Write('Zmˆna aktu ln¡ho adres ©e - zadej jm‚no: ');
   ReadLn(Jmeno);
   ChgDir(Jmeno);
   WriteLn('Teƒ se provedla zmˆna adres ©e za ',Jmeno);
   WriteLn;
   Delay(2000);
   Write('Zmˆna aktu ln¡ho adres ©e - zadej jm‚no: ');
   ReadLn(Jmeno);
   ChgDir(Jmeno);
   WriteLn('Teƒ se provedla zmˆna adres ©e za ',Jmeno);
   WriteLn;
   Write('Ru¨en¡ adres ©e - zadej jm‚no: ');
   ReadLn(Jmeno);
   RemoveDir(Jmeno);
   WriteLn('Teƒ se zru¨il adres ©e ',Jmeno);
   WriteLn;
   Delay(2000);
end.