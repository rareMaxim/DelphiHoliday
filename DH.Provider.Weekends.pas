unit DH.Provider.Weekends;

interface

uses
  DH.Enums,
  DH.Contract,
  DH.PublicHoliday,
  System.Generics.Collections;

type
  /// <summary>
  /// WeekendProvider
  /// </summary>
  TWeekendProvider = class(TInterfacedObject, IWeekendProvider)
  private
    FWeekendDays: TList<TDayOfWeek>;
  public
    constructor Create(const AWeekendDays: TArray<TDayOfWeek>);
    /// <summary>
    /// Returns a WeekendProvider for Saturday and Sunday
    /// </summary>
    class function Universal: IWeekendProvider;
    /// <summary>
    /// Returns a WeekendProvider for only Friday
    /// </summary>
    class function FridayOnly: IWeekendProvider;
    /// <summary>
    /// Returns a WeekendProvider for only Saturday
    /// </summary>
    class function SaturdayOnly: IWeekendProvider;
    /// <summary>
    /// Returns a WeekendProvider for only Sunday
    /// </summary>
    class function SundayOnly: IWeekendProvider;
    /// <summary>
    /// Returns a WeekendProvider for Friday and Sunday
    /// </summary>
    class function FridaySunday: IWeekendProvider;
    /// <summary>
    /// Returns a WeekendProvider for Friday and Saturday
    /// </summary>
    class function SemiUniversal: IWeekendProvider;
    /// <summary>
    /// Get weekend days
    /// </summary>
    function WeekendDays: TArray<TDayOfWeek>;
    /// <summary>
    /// Is given date in the weekend
    /// </summary>
    /// <param name="ADate"></param>
    /// <returns>True if given date is weekend, false otherwise</returns>
    function IsWeekend(ADate: TDateTime): Boolean; overload;
    /// <summary>
    /// Is given public holiday in the weekend
    /// </summary>
    /// <param name="publicHoliday"></param>
    /// <returns>True if given public holiday is in the weekend, false otherwise</returns>
    function IsWeekend(PublicHoliday: TPublicHoliday): Boolean; overload;
    /// <summary>
    /// Is given day in the weekend
    /// </summary>
    /// <param name="dayOfWeek"></param>
    /// <returns>True if given day of week is in the weekend, false otherwise</returns>
    function IsWeekend(ADayOfWeek: TDayOfWeek): Boolean; overload;
    /// <summary>
    /// Get first weekend day
    /// </summary>
    function FirstWeekendDay: TDayOfWeek; { get; }
    /// <summary>
    /// Get last weekend day
    /// </summary>
    function LastWeekendDay: TDayOfWeek;
    destructor Destroy; override; { get; }
  end;

implementation

uses
  System.Rtti,
  System.SysUtils;

constructor TWeekendProvider.Create(const AWeekendDays: TArray<TDayOfWeek>);
begin
  FWeekendDays := TList<TDayOfWeek>.Create();
  FWeekendDays.AddRange(AWeekendDays);
end;

destructor TWeekendProvider.Destroy;
begin
  FWeekendDays.Free;
  inherited;
end;

function TWeekendProvider.FirstWeekendDay: TDayOfWeek;
begin
  Result := FWeekendDays.First;
end;

class function TWeekendProvider.FridayOnly: IWeekendProvider;
begin
  Result := TWeekendProvider.Create([TDayOfWeek.Friday]);
end;

class function TWeekendProvider.FridaySunday: IWeekendProvider;
begin
  Result := TWeekendProvider.Create([TDayOfWeek.Friday, TDayOfWeek.Sunday]);
end;

function TWeekendProvider.IsWeekend(PublicHoliday: TPublicHoliday): Boolean;
begin
  Result := IsWeekend(PublicHoliday.Date);
end;

function TWeekendProvider.IsWeekend(ADayOfWeek: TDayOfWeek): Boolean;
begin
  Result := FWeekendDays.Contains(ADayOfWeek);
end;

function TWeekendProvider.IsWeekend(ADate: TDateTime): Boolean;
var
  LDayOfWeek: TDayOfWeek;
begin
  LDayOfWeek := TDayOfWeek(DayOfWeek(ADate) - 1);
  Result := IsWeekend(LDayOfWeek);
end;

function TWeekendProvider.LastWeekendDay: TDayOfWeek;
begin
  Result := FWeekendDays.Last;
end;

class function TWeekendProvider.SaturdayOnly: IWeekendProvider;
begin
  Result := TWeekendProvider.Create([TDayOfWeek.Saturday]);
end;

class function TWeekendProvider.SemiUniversal: IWeekendProvider;
begin
  Result := TWeekendProvider.Create([TDayOfWeek.Friday, TDayOfWeek.Saturday]);
end;

class function TWeekendProvider.SundayOnly: IWeekendProvider;
begin
  Result := TWeekendProvider.Create([TDayOfWeek.Sunday]);
end;

class function TWeekendProvider.Universal: IWeekendProvider;
begin
  Result := TWeekendProvider.Create([TDayOfWeek.Saturday, TDayOfWeek.Sunday]);
end;

function TWeekendProvider.WeekendDays: TArray<TDayOfWeek>;
begin
  Result := FWeekendDays.ToArray;
end;

end.
