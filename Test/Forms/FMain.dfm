object frmMain: TfrmMain
  Left = 199
  Top = 107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'X'#178'Utils Test'
  ClientHeight = 157
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblAppPath: TLabel
    Left = 8
    Top = 12
    Width = 79
    Height = 13
    Caption = 'Application path:'
  end
  object lblAppVersion: TLabel
    Left = 8
    Top = 36
    Width = 92
    Height = 13
    Caption = 'Application version:'
  end
  object lblOSVersion: TLabel
    Left = 8
    Top = 60
    Width = 55
    Height = 13
    Caption = 'OS version:'
  end
  object lblAppPathValue: TLabel
    Left = 112
    Top = 12
    Width = 337
    Height = 13
    AutoSize = False
    Caption = '<unknown>'
  end
  object lblAppVersionValue: TLabel
    Left = 112
    Top = 36
    Width = 337
    Height = 13
    AutoSize = False
    Caption = '<unknown>'
  end
  object lblOSVersionValue: TLabel
    Left = 112
    Top = 60
    Width = 337
    Height = 13
    AutoSize = False
    Caption = '<unknown>'
  end
  object lblInstances: TLabel
    Left = 8
    Top = 84
    Width = 49
    Height = 13
    Caption = 'Instances:'
  end
  object lstInstances: TListBox
    Left = 112
    Top = 84
    Width = 337
    Height = 65
    ItemHeight = 13
    TabOrder = 0
  end
end