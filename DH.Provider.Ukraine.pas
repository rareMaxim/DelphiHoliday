unit DH.Provider.Ukraine;

interface

uses
  DH.CountryCode,
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
var
  lCountry: TCountryCode;
begin
  lCountry := TCountryCode.UA;
  Result := [//
    TPublicHoliday.Create(AYear, 1, 1, 'Новий Рік', 'New Year''s Day', lCountry),
    TPublicHoliday.Create(AYear, 1, 7, 'Різдво', '(Julian) Christmas', lCountry)
  //
    ];
end;

function TUkraineProvider.GetSources: TArray<string>;
begin
  Result := [];
end;

end.
