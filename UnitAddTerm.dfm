object frmAddTerm: TfrmAddTerm
  Left = 595
  Top = 54
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1077#1088#1084#1080#1085
  ClientHeight = 547
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 39
    Height = 13
    Caption = #1058#1077#1088#1084#1080#1085
  end
  object Label2: TLabel
    Left = 8
    Top = 230
    Width = 50
    Height = 13
    Caption = #1057#1090#1088#1072#1085#1080#1094#1099
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 65
    Height = 13
    Caption = #1055#1086#1076#1090#1077#1088#1084#1080#1085#1099
  end
  object Label4: TLabel
    Left = 16
    Top = 454
    Width = 251
    Height = 13
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1092#1086#1088#1084#1091' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1087#1086#1076#1087#1086#1076#1090#1077#1088#1084#1080#1085#1072
  end
  object Label5: TLabel
    Left = 8
    Top = 416
    Width = 497
    Height = 13
    Caption = 
      '________________________________________________________________' +
      '____________________'
  end
  object edInputTerm: TEdit
    Left = 8
    Top = 27
    Width = 497
    Height = 21
    TabOrder = 0
  end
  object edShowPages: TEdit
    Left = 8
    Top = 249
    Width = 233
    Height = 50
    AutoSize = False
    TabOrder = 1
  end
  object edInputPage: TEdit
    Left = 272
    Top = 249
    Width = 121
    Height = 21
    TabOrder = 2
    OnKeyPress = edInputPageKeyPress
  end
  object btAddPage: TButton
    Left = 408
    Top = 247
    Width = 97
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 3
    OnClick = btAddPageClick
  end
  object btDelete: TButton
    Left = 408
    Top = 278
    Width = 97
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 4
    OnClick = btDeleteClick
  end
  object mmOutputSubterms: TMemo
    Left = 8
    Top = 83
    Width = 233
    Height = 127
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object edInputSubterm: TEdit
    Left = 272
    Top = 87
    Width = 122
    Height = 21
    TabOrder = 6
  end
  object btAddSubterm: TButton
    Left = 400
    Top = 83
    Width = 105
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 7
    OnClick = btAddSubtermClick
  end
  object btDeleteSubterm: TButton
    Left = 400
    Top = 112
    Width = 105
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 8
    OnClick = btDeleteSubtermClick
  end
  object edViewSubterm: TEdit
    Left = 16
    Top = 473
    Width = 281
    Height = 21
    TabOrder = 9
  end
  object btViewSubterm: TButton
    Left = 312
    Top = 471
    Width = 193
    Height = 25
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100
    TabOrder = 10
    OnClick = btViewSubtermClick
  end
  object btAddTerm: TButton
    Left = 8
    Top = 320
    Width = 497
    Height = 64
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 11
    OnClick = btAddTermClick
  end
end
