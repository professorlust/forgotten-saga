object Form1: TForm1
  Left = 192
  Top = 107
  Caption = 'Form1'
  ClientHeight = 376
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit1: TRichEdit
    Left = 160
    Top = 8
    Width = 337
    Height = 361
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    Zoom = 100
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Attack'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 144
    Width = 145
    Height = 25
    Caption = 'Run'
    TabOrder = 2
    OnClick = Button2Click
  end
  object RichEdit2: TRichEdit
    Left = 504
    Top = 8
    Width = 177
    Height = 329
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 3
    Zoom = 100
  end
  object ListBox1: TListBox
    Left = 8
    Top = 40
    Width = 145
    Height = 97
    ItemHeight = 13
    TabOrder = 4
  end
  object Button3: TButton
    Left = 8
    Top = 344
    Width = 145
    Height = 25
    Caption = 'Auto (100)'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 504
    Top = 344
    Width = 177
    Height = 25
    Caption = 'Restart'
    TabOrder = 6
    OnClick = Button4Click
  end
end
