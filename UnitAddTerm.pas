unit UnitAddTerm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Main;

type
  TfrmAddTerm = class(TForm)
    Label1: TLabel;
    edInputTerm: TEdit;
    Label2: TLabel;
    edShowPages: TEdit;
    edInputPage: TEdit;
    btAddPage: TButton;
    btDelete: TButton;
    Label3: TLabel;
    mmOutputSubterms: TMemo;
    edInputSubterm: TEdit;
    btAddSubterm: TButton;
    btDeleteSubterm: TButton;
    Label4: TLabel;
    edViewSubterm: TEdit;
    btViewSubterm: TButton;
    btAddTerm: TButton;
    Label5: TLabel;
    procedure btAddTermClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btAddPageClick(Sender: TObject);
    procedure btAddSubtermClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btDeleteSubtermClick(Sender: TObject);
    procedure btViewSubtermClick(Sender: TObject);
    procedure edInputPageKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
      procedure AddPage(Value: Integer);
      procedure AddSubterm(PTerm: PNodePointer);
      procedure DeletePage(Value: Integer);
      procedure DeleteSubterm(Value: string);
      procedure ShowPages();
      procedure ShowSubterms();
      function Search(Value: string; var Dest: PNodePointer): Boolean;
    { Public declarations }
  end;

var
  frmAddTerm: TfrmAddTerm;
  PPage: PPagePointer;
  PSubterm: PNodePointer;

implementation

{$R *.dfm}

function  TfrmAddTerm.Search(Value: string; var Dest: PNodePointer): Boolean;
var
   PRunner: PNodePointer;
   isFound: Boolean;
begin
   PRunner := PSubterm;
   isFound := False;
   if (PRunner <> nil) then
   begin
      while (PRunner <> nil) and (pRunner^.Term <> Value) do
         PRunner := PRunner^.PNext;
      if (PRunner <> nil) then
      begin
         isFound := True;
         Dest := PRunner;
      end;
   end;
   Result := isFound;
end;

procedure TfrmAddterm.DeleteSubterm(Value: string);
var
   PRunner, Temp: PNodePointer;
   isFound: Boolean;
begin
   PRunner := PSubterm;
   isFound := False;
   if (PRunner <> nil) then
      if (PRunner^.Term <> Value) then
      begin
         while (PRunner^.PNext <> nil) and not isFound do
         begin
            if (PRunner^.PNext^.Term = Value) then
               isFound := True
            else
               PRunner := PRunner^.PNext;
         end;
         if not isFound then
            MessageDlg('“акого подтермина дл€ данного термина не существует',
               mtInformation, [mbOk], 0)
         else
         begin
            Temp := PRunner^.PNext;
            PRunner^.PNext := PRunner^.PNext^.PNext;
            Dispose(Temp);
         end;
      end
      else
      begin
         Temp := PRunner;
         PSubterm := Temp^.PNext;
         Dispose(Temp);
      end
   else
      MessageDlg('—писок подтерминов пуст', mtInformation, [mbOK], 0);
end;

procedure TfrmAddTerm.DeletePage(Value: Integer);
var
   PRunner, Temp: PPagePointer;
   isFound: Boolean;
begin
   PRunner := PPage;
   isFound := False;
   if (PRunner <> nil) then
      if (PRunner^.Number <> Value) then
      begin
         while (PRunner^.PNext <> nil) and not isFound do
         begin
            if (PRunner^.PNext^.Number = Value) then
               isFound := True
            else
               PRunner := PRunner^.PNext;
         end;
         if not isFound then
            MessageDlg('—траницы с таким номером дл€ данного термина не существует',
               mtInformation, [mbOk], 0)
         else
         begin
            Temp := PRunner^.PNext;
            PRunner^.PNext := PRunner^.PNext^.PNext;
            Dispose(Temp);
       end;
      end
      else
      begin
         PPage := PRunner^.PNext;
         Dispose(PRunner);
      end
   else
      MessageDlg('—писок страниц пуст', mtInformation, [mbOk], 0);
end;

procedure TfrmAddTerm.AddPage(Value: Integer);
var
   PRunner, PPrev: PPagePointer;
begin
   PRunner := PPage;
   if (PRunner <> nil) then
   begin
      while (PRunner <> nil) do
      begin
         PPrev := PRunner;
         PRunner := PRunner.PNext;
      end;
      New(PRunner);
      PRunner^.Number := Value;
      PRunner^.PNext := nil;
      PPrev^.PNext := PRunner;
   end
   else
   begin
      New(PRunner);
      PRunner^.PNext := nil;
      PRunner^.Number := Value;
      PPage := PRunner;
   end;
end;

procedure TfrmAddTerm.ShowPages;
var
   PRunner: PPagePointer;
   Temp: string;
begin
   Temp := '';
   PRunner := PPage;
   while (PRunner <> nil) do
   begin
      Temp := Temp + IntToStr(PRunner^.Number)+' ';
      PRunner := PRunner^.PNext;
   end;
   edShowPages.Text := Temp;
end;

procedure TfrmAddTerm.ShowSubterms;
var
   PRunner: PNodePointer;
   Temp: string;
begin
   Temp := '';
   PRunner := PSubterm;
   mmOutputSubterms.Clear;
   while (PRunner <> nil) do
   begin
      Temp := PRunner^.Term;
      mmOutputSubterms.Lines.Add(Temp);
      PRunner := PRunner^.PNext;
   end;
end;

procedure TfrmAddTerm.AddSubterm(PTerm: PNodePointer);
var
   PRunner, PPrev: PNodePointer;
begin
   PRunner := PSubterm;
   if (PRunner <> nil) then
   begin
      while (PRunner <> nil) do
      begin
         PPrev := PRunner;
         PRunner := PRunner^.PNext;
      end;
      PRunner := PTerm;
      PPrev^.PNext := PRunner;
   end
   else
   begin
      PRunner := PTerm;
      PRunner^.PNext := nil;
      PSubterm := PRunner;
   end;
end;

procedure TfrmAddTerm.btAddTermClick(Sender: TObject);
var
   PTempHash, PPrevHash: PHashNodePointer;
begin
   TempTerm^.Term := edInputTerm.Text;
   TempTerm^.PPage := PPage;
   TempTerm^.PSubterm := PSubterm;
    if not frmMain.SearchHashTable(Tempterm^.Term, PTempHash, PPrevHash) then
   begin
      New(PTempHash);
      PTempHash^.Value := TempTerm;
      PTempHash^.Key := Copy(PtempHash^.Value^.Term, 1,
         Length(PTempHash^.Value^.Term));
      PTempHash^.PNext := nil;
      frmMain.AddHashTable(PTempHash);
//      Form1.AddListElement(Main.PHeadTermList, TempTerm);
   end;
   Self.Close;
end;

procedure TfrmAddTerm.FormActivate(Sender: TObject);
begin
   New(PPage);
   PPage := TempTerm^.PPage;
   New(PSubterm);
   PSubterm := TempTerm^.PSubterm;
   ShowPages;
   ShowSubterms;
   edInputTerm.Text := TempTerm^.Term;
   edInputPage.Text := '';
   edInputSubterm.Text := '';
end;


procedure TfrmAddTerm.btAddPageClick(Sender: TObject);
var
   Num: Integer;
begin
   Num := StrToInt(edInputPage.Text);
   edInputPage.Text := '';
   AddPage(Num);
   ShowPages;
end;

procedure TfrmAddTerm.btAddSubtermClick(Sender: TObject);
var
   Temp: PNodePointer;
   PHashNode, PPrev: PHashNodePointer;
   Value: string;
begin
   Value := edInputSubterm.Text;
   if not  frmMain.SearchHashTable(Value, PHashNode, PPrev) then
   begin
      New(Temp);
      Temp^.Term := edInputSubterm.Text;
      Temp^.PNext := nil;
      Temp^.PPage := nil;
      Temp^.PSubterm := nil;
   end
   else
      Temp := PHashNode^.Value;
   edInputSubterm.Text := '';
   AddSubterm(Temp);
   ShowSubterms;
end;

procedure TfrmAddTerm.btDeleteClick(Sender: TObject);
var
   Num: Integer;
begin
   Num := STrToInt(edInputPage.Text);
   DeletePage(Num);
   ShowPages;
end;

procedure TfrmAddTerm.btDeleteSubtermClick(Sender: TObject);
var
   Value: string;
begin
   Value := edInputSubterm.Text;
   DeleteSubterm(Value);
   ShowSubterms;
end;

procedure TfrmAddTerm.btViewSubtermClick(Sender: TObject);
var
   Temp, SaveTempTerm, SaveSubterm: PNodePointer;
   SavePage: PPagePointer;
   Value: string;
   frmAddTerm1: TfrmAddTerm;
begin
   Value := edViewSubterm.Text;
   New(Temp);
   if (Search(Value, Temp)) then
   begin
      SavePage := PPage;
      SaveSubterm := PSubterm;
      SaveTempTerm := TempTerm;
      TempTerm := Temp;
      with TfrmAddterm.Create(self) do
         ShowModal;
      PPage := SavePage;
      PSubterm := SaveSubterm;
      TempTerm := SaveTempTerm;
   end;
end;

procedure TfrmAddTerm.edInputPageKeyPress(Sender: TObject; var Key: Char);
const
   Digits = ['0'..'9', #8];
begin
   if not (Key in Digits) then
      Key := #0;
end;

end.
