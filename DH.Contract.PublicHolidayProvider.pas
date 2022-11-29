unit DH.Contract.PublicHolidayProvider;

interface

uses
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

implementation

end.
