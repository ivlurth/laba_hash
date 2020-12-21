object frmMain: TfrmMain
  Left = 384
  Top = 145
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1088#1077#1076#1084#1077#1090#1085#1099#1081' '#1091#1082#1072#1079#1072#1090#1077#1083#1100
  ClientHeight = 452
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 279
    Top = 245
    Width = 100
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1086#1076#1090#1077#1088#1084#1080#1085
  end
  object Label2: TLabel
    Left = 279
    Top = 139
    Width = 82
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1088#1084#1080#1085
  end
  object Label3: TLabel
    Left = 8
    Top = 345
    Width = 121
    Height = 13
    Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077'  '#1087#1086' '#1090#1077#1088#1084#1080#1085#1091
  end
  object mmOutput: TMemo
    Left = 8
    Top = 8
    Width = 265
    Height = 321
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object btAddTerm: TButton
    Left = 279
    Top = 358
    Width = 265
    Height = 34
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1077#1088#1084#1080#1085
    TabOrder = 1
    OnClick = btAddTermClick
  end
  object btViewTerm: TButton
    Left = 135
    Top = 358
    Width = 121
    Height = 34
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100
    TabOrder = 2
    OnClick = btViewTermClick
  end
  object edViewTerm: TEdit
    Left = 8
    Top = 364
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object btDelete: TButton
    Left = 406
    Top = 190
    Width = 121
    Height = 34
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 4
    OnClick = btDeleteClick
  end
  object btSortAlphabet: TButton
    Left = 279
    Top = 48
    Width = 265
    Height = 33
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1072#1083#1092#1072#1074#1080#1090#1091
    TabOrder = 5
    OnClick = btSortAlphabetClick
  end
  object btSortPages: TButton
    Left = 279
    Top = 8
    Width = 265
    Height = 34
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1089#1090#1088#1072#1085#1080#1094#1072#1084
    TabOrder = 6
    OnClick = btSortPagesClick
  end
  object edSearchTerm: TEdit
    Left = 279
    Top = 262
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object btSearchTerm: TButton
    Left = 406
    Top = 256
    Width = 121
    Height = 34
    Caption = #1048#1089#1082#1072#1090#1100' '#1090#1077#1088#1084#1080#1085
    TabOrder = 8
    OnClick = btSearchTermClick
  end
  object edSearchSubterm: TEdit
    Left = 279
    Top = 156
    Width = 121
    Height = 21
    TabOrder = 9
  end
  object btSearchSubterm: TButton
    Left = 406
    Top = 150
    Width = 121
    Height = 34
    Caption = #1048#1089#1082#1072#1090#1100' '#1087#1086#1076#1090#1077#1088#1084#1080#1085
    TabOrder = 10
    OnClick = btSearchSubtermClick
  end
  object btShowTable: TButton
    Left = 279
    Top = 96
    Width = 265
    Height = 34
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1102'  '#1090#1072#1073#1083#1080#1094#1091
    TabOrder = 11
    OnClick = btShowTableClick
  end
end
