unit DelphiHolidays;

interface

uses
  DH.PublicHoliday,
  DH.Enums,
  DH.Contract,
  System.Generics.Collections, System.SysUtils;

type
  TCountryCode = DH.Enums.TCountryCode;

  TDelphiHolidays = class
  const
    CountryCodeParsingError = 'Country code %S is not valid according to ISO 3166-1 ALPHA-2';
  private
    FPublicHolidaysProviders: TDictionary<TCountryCode, IPublicHolidayProvider>;
    FNonUniversalWeekendProviders: TDictionary<TCountryCode, IWeekendProvider>;
  public
    constructor Create;
    destructor Destroy; override;
    function GetPublicHolidayProvider(const ACountryCode: string): IPublicHolidayProvider; overload;
    function GetPublicHolidayProvider(const ACountryCode: TCountryCode): IPublicHolidayProvider; overload;
    /// <summary>
    /// GetWeekendProvider
    /// </summary>
    /// <param name="ACountryCode">Country Code (ISO 3166-1 ALPHA-2)</param>
    /// <returns>Specialized weekend provider for country if exists, universal weekend provider otherwise</returns>
    function GetWeekendProvider(const ACountryCode: TCountryCode): IWeekendProvider; overload;
    /// <summary>
    /// GetWeekendProvider
    /// </summary>
    /// <param name="ACountryCode">Country Code (ISO 3166-1 ALPHA-2)</param>
    /// <returns>Specialized weekend provider for country if exists, universal weekend provider otherwise</returns>
    /// <exception cref="System.ArgumentException">Thrown when given country code is not recognized valid</exception>   function GetWeekendProvider(const ACountryCode: string): IWeekendProvider; overload;

    function GetWeekendProvider(const ACountryCode: string): IWeekendProvider; overload;
    /// <summary>
    /// Parse given string to CountryCode
    /// </summary>
    /// <param name="ACountryCode"></param>
    /// <param name="AParsedCountryCode"></param>
    /// <returns>
    /// True for existing country code, false for non existent.
    /// Parsed country code is returned in out parameter.
    /// </returns>
    class function ParseCountryCode(const ACountryCode: string; out AParsedCountryCode: TCountryCode): Boolean;
    /// <summary>
    /// Get Public Holidays of a given year
    /// </summary>
    /// <param name="year">The year</param>
    /// <param name="countryCode">Country Code (ISO 3166-1 ALPHA-2)</param>
    /// <returns>Set of public holidays for given country and year</returns>
    /// <exception cref="System.ArgumentException">Thrown when given country code is not recognized valid</exception>
    function GetPublicHolidays(const AYear: Integer; const ACountryCode: string): TArray<TPublicHoliday>; overload;
    /// <summary>
    /// Get Public Holidays of a given year
    /// </summary>
    /// <param name="year">The year</param>
    /// <param name="countryCode">Country Code (ISO 3166-1 ALPHA-2)</param>
    /// <returns>Set of public holidays for given country and year</returns>
    function GetPublicHolidays(const AYear: Integer; const ACountryCode: TCountryCode): TArray<TPublicHoliday>;
      overload;

    /// <summary>
    /// Get Public Holidays of a given date range
    /// </summary>
    /// <param name="startDate">The start date</param>
    /// <param name="endDate">The end date</param>
    /// <param name="countryCode">Country Code (ISO 3166-1 ALPHA-2)</param>
    /// <returns>Set of public holidays for given country and date range</returns>
    /// <exception cref="System.ArgumentException">Thrown when given end date is before given start date</exception>
    function GetPublicHolidays(AStartDate, AEndDate: TDate; ACountryCode: TCountryCode)
      : TArray<TPublicHoliday>; overload;

    /// <summary>
    /// Get Public Holidays of a given date range
    /// </summary>
    /// <param name="startDate">The start date</param>
    /// <param name="endDate">The end date</param>
    /// <param name="countryCode">Country Code (ISO 3166-1 ALPHA-2)</param>
    /// <returns>Set of public holidays for given country and date range</returns>
    /// <exception cref="System.ArgumentException">Thrown when given country code is not recognized valid</exception>
    function GetPublicHolidays(AStartDate, AEndDate: TDate; const ACountryCode: string)
      : TArray<TPublicHoliday>; overload;
    function GetPublicHolidays(const AStartDate, AEndDate: TDate): TArray<TPublicHoliday>; overload;
  private
    function GetPublicHolidayFilter(ADate: TDateTime; ACountyCode: string = ''): TFunc<TPublicHoliday, Boolean>;
  end;

implementation

uses
  DH.Provider.Ukraine,
  System.Rtti,
  System.DateUtils,
  DH.Provider.NoHolidaysProvider,
  DH.Provider.Weekends;

constructor TDelphiHolidays.Create;
begin
  inherited Create;
  FPublicHolidaysProviders := TDictionary<TCountryCode, IPublicHolidayProvider>.Create();
  FNonUniversalWeekendProviders := TDictionary<TCountryCode, IWeekendProvider>.Create();
  //
  FPublicHolidaysProviders.Add(TCountryCode.UA, TUkraineProvider.Create);
end;

destructor TDelphiHolidays.Destroy;
begin
  FPublicHolidaysProviders.Free;
  FNonUniversalWeekendProviders.Free;
  inherited Destroy;
end;

function TDelphiHolidays.GetPublicHolidayFilter(ADate: TDateTime; ACountyCode: string = '')
  : TFunc<TPublicHoliday, Boolean>;
var
  LL: TList<TPublicHoliday>;
begin

end;

function TDelphiHolidays.GetPublicHolidayProvider(const ACountryCode: TCountryCode): IPublicHolidayProvider;
begin
  if not FPublicHolidaysProviders.TryGetValue(ACountryCode, Result) then
    Result := TNoHolidaysProvider.Create;
end;

function TDelphiHolidays.GetPublicHolidayProvider(const ACountryCode: string): IPublicHolidayProvider;
var
  LParsedCountryCode: TCountryCode;
begin
  if not ParseCountryCode(ACountryCode, LParsedCountryCode) then
    raise EArgumentException.CreateFmt(CountryCodeParsingError, [ACountryCode]);
  Result := GetPublicHolidayProvider(LParsedCountryCode);
end;

function TDelphiHolidays.GetPublicHolidays(const AYear: Integer; const ACountryCode: string): TArray<TPublicHoliday>;
var
  LProvider: IPublicHolidayProvider;
begin
  LProvider := GetPublicHolidayProvider(ACountryCode);
  Result := LProvider.GetHolidays(AYear);
end;

function TDelphiHolidays.GetPublicHolidays(const AYear: Integer; const ACountryCode: TCountryCode)
  : TArray<TPublicHoliday>;
var
  LProvider: IPublicHolidayProvider;
begin
  LProvider := GetPublicHolidayProvider(ACountryCode);
  Result := LProvider.GetHolidays(AYear);
end;

function TDelphiHolidays.GetPublicHolidays(AStartDate, AEndDate: TDate; ACountryCode: TCountryCode)
  : TArray<TPublicHoliday>;
var
  LCurrentYear: Word;
  LEndYear: Word;
  LItems: TArray<TPublicHoliday>;
begin
  LCurrentYear := YearOf(AStartDate);
  LEndYear := YearOf(AEndDate);
  while LCurrentYear <= LEndYear do
  begin
    LItems := GetPublicHolidays(LCurrentYear, ACountryCode);
    for var LItem in LItems do
      if (LItem.Date >= AStartDate) and (LItem.Date <= AEndDate) then
        Result := Result + [LItem];
    Inc(LCurrentYear);
  end;
end;

function TDelphiHolidays.GetPublicHolidays(const AStartDate, AEndDate: TDate): TArray<TPublicHoliday>;
begin
  for var LProvider in FPublicHolidaysProviders do
    Result := Result + GetPublicHolidays(AStartDate, AEndDate, LProvider.Key);
end;

function TDelphiHolidays.GetPublicHolidays(AStartDate, AEndDate: TDate; const ACountryCode: string)
  : TArray<TPublicHoliday>;
var
  LCountry: TCountryCode;
begin
  if not TDelphiHolidays.ParseCountryCode(ACountryCode, LCountry) then
    raise EArgumentException.CreateFmt(CountryCodeParsingError, [ACountryCode]);
  Result := GetPublicHolidays(AStartDate, AEndDate, LCountry);
end;

function TDelphiHolidays.GetWeekendProvider(const ACountryCode: TCountryCode): IWeekendProvider;
begin
  if not FNonUniversalWeekendProviders.TryGetValue(ACountryCode, Result) then
    Result := TWeekendProvider.Universal;
end;

function TDelphiHolidays.GetWeekendProvider(const ACountryCode: string): IWeekendProvider;
var
  LCountry: TCountryCode;
begin
  if not TDelphiHolidays.ParseCountryCode(ACountryCode, LCountry) then
    raise EArgumentException.CreateFmt(CountryCodeParsingError, [ACountryCode]);
  Result := GetWeekendProvider(LCountry);
end;

class function TDelphiHolidays.ParseCountryCode(const ACountryCode: string;
  out AParsedCountryCode: TCountryCode): Boolean;
begin
  AParsedCountryCode := TRttiEnumerationType.GetValue<TCountryCode>(ACountryCode);
  Result := AParsedCountryCode < TCountryCode(255);
end;

end.
