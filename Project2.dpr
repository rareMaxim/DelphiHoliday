program Project2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  DH.CountryCode in 'DH.CountryCode.pas',
  DelphiHolidays in 'DelphiHolidays.pas',
  DH.PublicHoliday in 'DH.PublicHoliday.pas',
  DH.PublicHolidayType in 'DH.PublicHolidayType.pas',
  DH.Provider.Ukraine in 'DH.Provider.Ukraine.pas',
  DH.Contract.PublicHolidayProvider in 'DH.Contract.PublicHolidayProvider.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
