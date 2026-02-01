uses dos,crt;
 {$M $4000,0,0}
begin
clrscr;
exec ('c:\command.com','/C dir *.pas');
write(doserror);
delay(2000);
end.

