unit DelphiHolidays;

interface

uses
  DH.PublicHoliday,
  DH.CountryCode,
  DH.Contract.PublicHolidayProvider,
  System.Generics.Collections;

type
  TCountryCode = DH.CountryCode.TCountryCode;

  TDelphiHolidays = class
  private
    FPublicHolidaysProviders: TDictionary<TCountryCode, IPublicHolidayProvider>;
  public
    constructor Create;
    destructor Destroy; override;
    function GetPublicHolidayProvider(const ACountryCode: string): IPublicHolidayProvider; overload;
    function GetPublicHolidayProvider(const ACountryCode: TCountryCode): IPublicHolidayProvider; overload;
    class function ParseCountryCode(const ACountryCode: string; out AParsedCountryCode: TCountryCode): Boolean;
  end;

implementation

uses
  DH.Provider.Ukraine,
  System.Rtti, System.SysUtils, DH.Provider.NoHolidaysProvider;

constructor TDelphiHolidays.Create;
begin
  inherited Create;
  FPublicHolidaysProviders := TDictionary<TCountryCode, IPublicHolidayProvider>.Create();
  //
  FPublicHolidaysProviders.Add(TCountryCode.UA, TUkraineProvider.Create);
end;

destructor TDelphiHolidays.Destroy;
begin
  FPublicHolidaysProviders.Free;
  inherited Destroy;
end;

function TDelphiHolidays.GetPublicHolidayProvider(const ACountryCode: TCountryCode): IPublicHolidayProvider;
begin
  if not FPublicHolidaysProviders.TryGetValue(ACountryCode, Result) then
    Result := TNoHolidaysProvider.Create;

end;

function TDelphiHolidays.GetPublicHolidayProvider(const ACountryCode: string): IPublicHolidayProvider;
const
  CountryCodeParsingError = 'Country code %S is not valid according to ISO 3166-1 ALPHA-2';
var
  LParsedCountryCode: TCountryCode;
begin
  if not ParseCountryCode(ACountryCode, LParsedCountryCode) then
    raise EArgumentException.CreateFmt(CountryCodeParsingError, [ACountryCode]);
  Result := GetPublicHolidayProvider(LParsedCountryCode);
end;

class function TDelphiHolidays.ParseCountryCode(const ACountryCode: string;
  out AParsedCountryCode: TCountryCode): Boolean;
begin
  AParsedCountryCode := TRttiEnumerationType.GetValue<TCountryCode>(ACountryCode);
  Result := AParsedCountryCode < TCountryCode(255);
end;

end.
