unit DH.PublicHoliday;

interface

uses
  DH.Enums;

type
  TPublicHoliday = record
  private
    FDate: TDateTime;
    FLocalName: string;
    FName: string;
    FFixed: Boolean;
    FCounties: TArray<string>;
    FGlobal: Boolean;
    FType: TPublicHolidayType;
    FLaunchYear: Integer;
    FCountryCode: TCountryCode;
    function GetGlobal: Boolean;
  public
    /// <summary>
    /// The date
    /// </summary>
    property Date: TDateTime read FDate write FDate;
    /// <summary>
    /// Local name
    /// </summary>
    property LocalName: string read FLocalName write FLocalName;
    /// <summary>
    /// English name
    /// </summary>
    property Name: string read FName write FName;
    /// <summary>
    /// ISO 3166-1 alpha-2
    /// </summary>
    property CountryCode: TCountryCode read FCountryCode write FCountryCode;
    /// <summary>
    /// Is this public holiday every year on the same date
    /// </summary>
    property Fixed: Boolean read FFixed write FFixed;
    /// <summary>
    /// ISO-3166-2 - Federal states
    /// </summary>
    property Counties: TArray<string> read FCounties write FCounties;
    /// <summary>
    /// Is this public holiday in every county (federal state)
    /// </summary>
    property Global: Boolean read GetGlobal;
    /// <summary>
    /// A list of types the public holiday it is valid
    /// </summary>
    property &Type: TPublicHolidayType read FType write FType;
    /// <summary>
    /// The launch year of the public holiday
    /// </summary>
    property LaunchYear: Integer read FLaunchYear write FLaunchYear;
    class function Create(const AYear, AMonth, ADay: Integer; const ALocalName, AEnglishName: string;
      const ACountryCode: TCountryCode; const ALaunchYear: Integer = 0; const ACounties: TArray<string> = [];
      const AType: TPublicHolidayType = TPublicHolidayType.&Public): TPublicHoliday; overload; static;
    class function Create(const ADate: TDate; const ALocalName, AEnglishName: string; const ACountryCode: TCountryCode;
      const ALaunchYear: Integer = 0; const ACounties: TArray<string> = [];
      const AType: TPublicHolidayType = TPublicHolidayType.&Public): TPublicHoliday; overload; static;
  end;

implementation

uses
  System.DateUtils;

class function TPublicHoliday.Create(const AYear, AMonth, ADay: Integer; const ALocalName, AEnglishName: string;
  const ACountryCode: TCountryCode; const ALaunchYear: Integer = 0; const ACounties: TArray<string> = [];
  const AType: TPublicHolidayType = TPublicHolidayType.&Public): TPublicHoliday;
begin
  Result.FDate := EncodeDateTime(AYear, AMonth, ADay, 0, 0, 0, 0);
  Result.FLocalName := ALocalName;
  Result.FName := AEnglishName;
  Result.FCountryCode := ACountryCode;
  Result.FLaunchYear := ALaunchYear;
  Result.FCounties := ACounties;
  Result.FType := AType;
end;

class function TPublicHoliday.Create(const ADate: TDate; const ALocalName, AEnglishName: string;
  const ACountryCode: TCountryCode; const ALaunchYear: Integer = 0; const ACounties: TArray<string> = [];
  const AType: TPublicHolidayType = TPublicHolidayType.&Public): TPublicHoliday;
begin
  Result.FDate := ADate;
  Result.FLocalName := ALocalName;
  Result.FName := AEnglishName;
  Result.FCountryCode := ACountryCode;
  Result.FLaunchYear := ALaunchYear;
  Result.FCounties := ACounties;
  Result.FType := AType;
end;

{ TPublicHoliday }

function TPublicHoliday.GetGlobal: Boolean;
begin
  Result := Length(Counties) > 0;
end;

end.
