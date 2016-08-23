unit WorldEditor.MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, Buttons, ComCtrls, ToolWin, ImgList, StdCtrls;

type
  TfMain = class(TForm)
    ToolsPanel: TPanel;
    ToolBar: TToolBar;
    StatusBar: TStatusBar;
    ImageList: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    btTerrain: TToolButton;
    btObjects: TToolButton;
    btItems: TToolButton;
    btCreatures: TToolButton;
    ToolButton3: TToolButton;
    brTerrain: TToolButton;
    brObjects: TToolButton;
    brItems: TToolButton;
    brCreatures: TToolButton;
    ListBox: TListBox;
    Label1: TLabel;
    OD: TOpenDialog;
    SD: TSaveDialog;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure brTerrainClick(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateCaption;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

uses WorldEditor.Classes, Common.Map.Tiles, Common.Utils;

{$R *.dfm}

procedure Border(Pos: TPoint; Color: Integer; Symbol: Char = #32);
begin
  Editor.Engine.Surface.Canvas.Pen.Color := Color;
  Editor.Engine.Surface.Canvas.Brush.Style := bsClear;
  Editor.Engine.Surface.Canvas.Rectangle(Pos.X * Editor.Engine.Char.Width - 1,
    Pos.Y * Editor.Engine.Char.Height - 1, Pos.X * Editor.Engine.Char.Width +
    Editor.Engine.Char.Width + 1, Pos.Y * Editor.Engine.Char.Height +
    Editor.Engine.Char.Height + 1);
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  Editor := TEditor.Create;
  Editor.ToolBarHeight := ToolBar.Height;
  ClientWidth := Editor.Engine.Surface.Width + ToolsPanel.Width;
  ClientHeight := Editor.Engine.Surface.Height + Editor.ToolBarHeight +
    StatusBar.Height;
  Left := (Screen.Width div 2) - (Width div 2);
  Top := (Screen.Height div 2) - (Height div 2);
  btTerrain.Down := True;
  btObjects.Down := True;
  btItems.Down := True;
  btCreatures.Down := True;
  brTerrain.Click;
  brTerrain.Down := True;
  UpdateCaption;
end;

procedure TfMain.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Editor.MouseMove(X, Y);
  FormPaint(Sender);
  Label1.Caption := Format('%d:%d', [Editor.Pos.X, Editor.Pos.Y]);
end;

procedure TfMain.FormPaint(Sender: TObject);
begin
  Editor.Engine.Clear;
  if btTerrain.Down then
    Editor.RenderTerrain;
  if btObjects.Down then
    Editor.RenderObjects;
  if btItems.Down then
    Editor.RenderItems;
  if btCreatures.Down then
    Editor.RenderCreatures;
  if brTerrain.Down then
    Border(Editor.Pos, clYellow);
  if brObjects.Down then
    Border(Editor.Pos, clWhite);
  if brItems.Down then
    Border(Editor.Pos, clSkyBlue);
  if brCreatures.Down then
    Border(Editor.Pos, clFuchsia);
  Canvas.Draw(0, Editor.ToolBarHeight, Editor.Engine.Surface);
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  Editor.Free;
end;

procedure TfMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Editor.MouseDown(Button, X, Y);
  FormPaint(Sender);
  UpdateCaption;
end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Editor.KeyDown(Key);
  FormPaint(Sender);
  UpdateCaption;
end;

procedure TfMain.brTerrainClick(Sender: TObject);
var
  I: TTile;
begin
  ListBox.Clear;
  for I := Low(TTile) to High(TTile) do
  begin
    ListBox.Items.Append(Format('[%s] %s', [Editor.Tiles.GetTile(I).Symbol,
      Editor.Tiles.GetTile(I).Name]));
  end;
  ListBox.ItemIndex := 0;
  Editor.Tile := tNone;
  FormPaint(Sender);
end;

procedure TfMain.ListBoxClick(Sender: TObject);
begin
  Editor.Tile := TTile(ListBox.ItemIndex);
end;

procedure TfMain.ToolButton1Click(Sender: TObject);
begin
  if OD.Execute then
  begin
    Editor.CurrentMapFile := OD.FileName;
    Editor.Map.LoadFromFile(Editor.CurrentMapFile);
    Editor.Creatures.LoadFromFile(ChangeFileExt(Editor.CurrentMapFile, '.crt'));
    Editor.Items.LoadFromFile(ChangeFileExt(Editor.CurrentMapFile, '.itm'));
    UpdateCaption;
  end;
end;

procedure TfMain.ToolButton4Click(Sender: TObject);
begin
  if (Editor.CurrentMapFile <> '') then
  begin
    Editor.Map.SaveToFile(Editor.CurrentMapFile);
    Editor.Modified := False;
    UpdateCaption;
  end;
end;

procedure TfMain.UpdateCaption;
var
  S: string;
begin
  if Editor.Modified then
    S := '*'
  else
    S := '';
  if (Editor.CurrentMapFile = '') then
    Caption := Application.Title
  else
    Caption := Format('%s%s - %s', [ExtractFileName(Editor.CurrentMapFile), S,
      Application.Title]);
end;

end.
