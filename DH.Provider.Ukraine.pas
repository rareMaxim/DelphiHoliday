unit DH.Provider.Ukraine;

interface

uses
  DH.PublicHoliday,
  DH.Contract.PublicHolidayProvider;

type
  TUkraineProvider = class(TInterfacedObject, IPublicHolidayProvider)
  public
    function GetHolidays(const AYear: Integer): TArray<TPublicHoliday>;
    function GetSources: TArray<string>;
  end;

implementation

{ TUkraineProvider }

function TUkraineProvider.GetHolidays(const AYear: Integer): TArray<TPublicHoliday>;
begin

end;

function TUkraineProvider.GetSources: TArray<string>;
begin
  Result := [];
end;

end.
