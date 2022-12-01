unit DH.Contract;

interface

uses
  DH.Enums,
  DH.PublicHoliday;

type
  IPublicHolidayProvider = interface
    ['{92DE74C8-7BEF-46BA-B856-81B2FF961F72}']
    /// <summary>
    /// Get Holidays of the given year
    /// </summary>
    /// <param name="year"></param>
    /// <returns>Set of public holidays for given year</returns>
    function GetHolidays(const AYear: Integer): TArray<TPublicHoliday>;
    /// <summary>
    /// Get the Holiday Sources
    /// </summary>
    /// <returns>Set of public holiday sources (links)</returns>
    function GetSources: TArray<string>;
  end;

  /// <summary>
  /// IWeekendProvider
  /// </summary>
  IWeekendProvider = interface
    ['{C04FC7A2-9235-4A8A-A794-3954D19C241F}']
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
    function LastWeekendDay: TDayOfWeek; { get; }
  end;

implementation

end.
