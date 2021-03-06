program X2UtilsSettingsTest;

{$APPTYPE CONSOLE}

uses
  madExcept,
  madLinkDisAsm,
  Classes,
  SysUtils,
  Variants,
  Windows,
  X2UtApp in '..\X2UtApp.pas',
  X2UtSettings in '..\X2UtSettings.pas',
  X2UtSettingsINI in '..\X2UtSettingsINI.pas',
  X2UtSettingsRegistry in '..\X2UtSettingsRegistry.pas';

type
  TCheck  = class(TObject)
  public
    class procedure CheckValue(const AAction: TX2SettingsAction;
                               const ASection, AName: String;
                               var AValue: Variant);
  end;

procedure TraverseSection(const ASettings: TX2SettingsFactory;
                          const ASection: String = '';
                          const AIndent: Integer = 0);
var
  sIndent:          String;
  slSections:       TStringList;
  iSection:         Integer;
  slValues:         TStringList;
  iValue:           Integer;
  sSection:         String;

begin
  sIndent     := StringOfChar(' ', AIndent * 2);
  slSections  := TStringList.Create();
  try
    with ASettings[ASection] do
      try
        GetSectionNames(slSections);

        for iSection  := 0 to slSections.Count - 1 do begin
          WriteLn(sIndent, '[', slSections[iSection], ']');

          sSection  := ASection;
          if Length(sSection) > 0 then
            sSection  := sSection + '.';

          sSection  := sSection + slSections[iSection];

          slValues  := TStringList.Create();
          try
            with ASettings[sSection] do
              try
                GetValueNames(slValues);

                for iValue  := 0 to slValues.Count - 1 do
                  WriteLn(sIndent, slValues[iValue], '=', ReadString(slValues[iValue]));
              finally
                Free();
              end;
          finally
            FreeAndNil(slValues);
          end;

          TraverseSection(ASettings, sSection, AIndent + 1);
        end;
      finally
        Free();
      end;
  finally
    FreeAndNil(slSections);
  end;
end;

{ TCheck }
class procedure TCheck.CheckValue;
begin
  if AAction = saWrite then
  begin
    if AValue < 0 then
      AValue  := 0
    else if AValue > 15 then
      AValue  := 15
    else
      if (AValue > 5) and (AValue < 10) then
        AValue  := 5;
  end;
end;


var
  Settings:         TX2SettingsFactory;

begin
  // INI settings
  //WriteLn('INI data:');
  Settings  := TX2INISettingsFactory.Create();
  try
    with TX2INISettingsFactory(Settings) do
      Filename := App.Path + 'settings.ini';

    {
    // Deletes one section
    with Settings['Test.Section'] do
      try
        DeleteSection();
      finally
        Free();
      end;
    }

    {
    // Deletes everything
    with Settings[''] do
      try
        DeleteSection();
      finally
        Free();
      end;
    }

    // Test for the definitions
    Settings.Define('Test', 'Value', 5, TCheck.CheckValue);

    with Settings['Test'] do
    try
      WriteInteger('Value', 6);
      WriteLn(ReadInteger('Value'));
    finally
      Free();
    end;

    {
    TraverseSection(Settings, '', 1);
    WriteLn;
    }
  finally
    FreeAndNil(Settings);
  end;
  ReadLn;

  {
  // Registry settings
  WriteLn('Registry data:');
  Settings  := TX2RegistrySettingsFactory.Create();
  try
    with TX2RegistrySettingsFactory(Settings) do begin
      Root     := HKEY_CURRENT_USER;
      Key      := '\Software\X2Software\X2FileShare\';
    end;

    // Note: you WILL get exceptions here due to the fact that not all
    // values are strings yet they are treated as such here. Perhaps in the
    // future type conversion will be done on-the-fly, but for now just press
    // F5 when debugging (you won't get exceptions when running the EXE as
    // standalone) and the default value will be returned. Perhaps the best
    // solution...
    TraverseSection(Settings, '', 1);
    ReadLn;
  finally
    FreeAndNil(Settings);
  end;
  }
end.
