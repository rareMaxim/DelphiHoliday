unit DH.Provider.NoHolidaysProvider;

interface

uses
  DH.PublicHoliday,
  DH.Contract;

type
  TNoHolidaysProvider = class(TInterfacedObject, IPublicHolidayProvider)
  public
    function GetHolidays(const AYear: Integer): TArray<TPublicHoliday>;
    function GetSources: TArray<string>;
  end;

implementation

{ TNoHolidaysProvider }

function TNoHolidaysProvider.GetHolidays(const AYear: Integer): TArray<TPublicHoliday>;
begin
  Result := nil;
end;

function TNoHolidaysProvider.GetSources: TArray<string>;
begin
  Result := nil;
end;

end.
