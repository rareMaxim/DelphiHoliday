unit Test.Main;

interface

uses
  DelphiHolidays,
  DUnitX.TestFramework;

type

  [TestFixture]
  THolidaysTest = class
  strict private
    FHolidays: TDelphiHolidays;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    [TestCase('Ukraine +', 'UA,TRUE')]
    [TestCase('Ukraine -', 'UA7,FALSE')]
    procedure ParseCountryCodeOK(const AValue: string; const AIsOk: Boolean);
    // Test with TestCase Attribute to supply parameters.
    [Test]
    [TestCase('TestA', '1,2')]
    [TestCase('TestB', '3,4')]
    procedure Test2(const AValue1: Integer; const AValue2: Integer);
  end;

implementation

procedure THolidaysTest.Setup;
begin
  FHolidays := TDelphiHolidays.Create;
end;

procedure THolidaysTest.TearDown;
begin
  FHolidays.Free;
end;

procedure THolidaysTest.ParseCountryCodeOK(const AValue: string; const AIsOk: Boolean);
var
  lCode: TCountryCode;
  lResult: Boolean;
begin
  lResult := FHolidays.ParseCountryCode(AValue, lCode);
  Assert.AreEqual(AIsOk, lResult, AValue);
end;

procedure THolidaysTest.Test2(const AValue1: Integer; const AValue2: Integer);
begin
end;

initialization

TDUnitX.RegisterTestFixture(THolidaysTest);

end.
