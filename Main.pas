unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;


const
   AverageLength = 8;

type

   TStringArr = array of string;

   PPagePointer = ^TPage;
   TPage = record
      Number: Integer;
      PNext: PPagePointer;
   end;


   PNodePointer = ^TNode;

   TNode = record
      Term: string;
      PSubterm: PNodePointer;
      PPage: PPagePointer;
      PNext: PNodePointer;
   end;


   PHashNodePointer = ^THashPointer;

   THashPointer = record
      Key: string;
      Value: PNodePointer;
      PNext: PHashNodePointer;
   end;

   TCompFunc = function(PNodeI, PNodeJ: PNodePointer): Boolean;

   THashTable = array[0..AverageLength - 1] of PHashNodePointer;

   TfrmMain = class(TForm)
    mmOutput: TMemo;
    btAddTerm: TButton;
    btViewTerm: TButton;
    edViewTerm: TEdit;
    btDelete: TButton;
    btSortAlphabet: TButton;
    btSortPages: TButton;
    edSearchTerm: TEdit;
    btSearchTerm: TButton;
    Label1: TLabel;
    edSearchSubterm: TEdit;
    btSearchSubterm: TButton;
    Label2: TLabel;
    btShowTable: TButton;
    Label3: TLabel;
    procedure btAddTermClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btViewTermClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btSortAlphabetClick(Sender: TObject);
    procedure btSortPagesClick(Sender: TObject);
    procedure btSearchTermClick(Sender: TObject);
    procedure btShowTableClick(Sender: TObject);
    procedure btSearchSubtermClick(Sender: TObject);
   private
       { Private declarations }
   public
      function SearchHashTable(Key: string; var PNode, PPrev: PHashNodePointer):Boolean;
      function Hash(Key: string): Integer;
      procedure InitHashTable();
      procedure AddHashTable(Value: PHashNodePointer);
      procedure DeleteHashTable(Key: string);

      procedure AddListElement(PHead, Term: PNodePointer);
      procedure DeleteList(Key: string);
      function SearchList(Key: string; var Dest: PNodePointer): Boolean; overload;
      function SearchList(Key: string; var Dest, PrevDest: PNodePointer): Boolean; overload;
      procedure SortList(PHead: PNodePointer; CompFunc: TCompFunc);

      procedure ShowTermList();
      procedure ShowTable();
      procedure ShowPages(Source: PNodePointer; var Dest: string);
      procedure ShowSubterms(Source: PNodePointer; var Dest: string);
      procedure SearchTermList(Value: string; var Dest: TStringArr); { Public declarations }
      procedure SearchSubterms(Value: string; var Dest: TStringArr; var Depth: Integer);
   end;

var
   frmMain: TfrmMain;
   HashTable: THashTable;
   PHeadTermList: PNodePointer;
   TempTerm: PNodePointer;


implementation

uses UnitAddTerm;

{$R *.dfm}

procedure TfrmMain.DeleteHashTable(Key: string);
var
   PTemp, PPrev: PHashNodePointer;
begin
   if (SearchHashTable(Key, Ptemp, PPrev)) then
   begin
      PPrev^.PNext := PTemp^.PNext;
      Dispose(PTemp);
   end;
end;

procedure TfrmMain.AddHashTable(Value: PHashNodePointer);
var
   PRunner: PHashNodePointer;
   j: Integer;
begin
   j := Hash(Value^.Key);
   PRunner := HashTable[j];
   while (PRunner^.PNext <> nil) do
   begin
      PRunner := PRunner^.PNext;
   end;
   Value^.PNext := nil;
   PRunner^.PNext := Value;
end;

procedure tfrmMain.SearchSubterms(Value: string; var Dest: TStringArr;
  var Depth: Integer);
var
   PRunner: PHashNodePointer;
   PTemp: PNodePointer;
   j, i: Integer;
   isFound: Boolean;
begin
   j := Hash(Value);
   PRunner := HashTable[j];
   isFound := False;
   Inc(Depth);
   while (PRunner^.PNext <> nil) and not isFound do
   begin
      if (AnsiCompareStr(PRunner^.PNext^.Key, Value) = 0) then
      begin
         PTemp := PRunner^.PNext^.Value^.PSubterm;
         while (PTemp <> nil) do
         begin
            SetLength(Dest, Length(Dest) + 1);
            Dest[High(Dest)] := PTemp^.Term + #10#13;
            for i := 0 to Depth - 1 do
               Dest[High(Dest)] := '-' + Dest[High(Dest)];
            SearchSubterms(PTemp^.Term, Dest, Depth);
            Dec(Depth);
            PTemp := Ptemp^.PNext;
         end;
         isFound := True;
      end;
      PRunner := PRunner^.PNext;
   end;
end;

function TfrmMain.SearchList(Key: string; var Dest, PrevDest: PNodePointer): Boolean;
var
   PRunner: PNodePointer;
   isFound: Boolean;
begin
   isFound := False;
   PrevDest := PHeadTermList;
   PRunner := PHeadTermList^.PNext;
   while (not isFound) and (PRunner <> nil) do
   begin
      if (PRunner^.Term = Key) then
      begin
         isFound := True;
         Dest := PRunner;
      end
      else
         PrevDest := PrevDest^.PNext;
      PRunner := PRunner^.PNext;
   end;
   Result := isFound;
end;

function TfrmMain.SearchList(Key: string; var Dest: PNodePointer): Boolean;
var
   PRunner: PNodePointer;
   isFound: Boolean;
begin
   isFound := False;
   PRunner := PHeadTermList^.PNext;
   while (not isFound) and (PRunner <> nil) do
   begin
      if (PRunner^.Term = Key) then
      begin
         isFound := True;
         Dest := PRunner;
      end;
      PRunner := PRunner^.PNext;
   end;
   Result := isFound;
end;

procedure TfrmMain.SearchTermList(Value: string; var Dest: TStringArr);
var
   PRunnerTerm, PRunnerSubterm: PNodePointer;
begin
   SetLength(Dest, 0);
   PRunnerTerm := PHeadTermList^.PNext;
   while PRunnerTerm <> nil do
   begin
      PRunnerSubterm := PRunnerTerm^.PSubterm;
      while (PRunnerSubterm <> nil) do
      begin
         if (AnsiCompareStr(PRunnerSubterm^.Term, Value) = 0) then
         begin
            SetLength(Dest, Length(Dest) + 1);
            Dest[High(Dest)] := PRunnerTerm^.Term;
         end;
         PRunnerSubterm := PRunnerSubterm^.PNext;
      end;
      PRunnerTerm := PRunnerTerm^.PNext;
   end;
end;

function CompAlphabet(PNodeI, PNodeJ: PNodePointer): Boolean;
begin
   CompAlphabet := (PNodeI^.Term > PNodeJ^.Term);
end;

function CompPages(PNodeI, PNodeJ: PNodePointer): Boolean;
begin
   if (PNodeI^.PPage <> nil) and (PNodeJ^.PPage <> nil) then
      CompPages := (PNodeI^.PPage^.Number > PNodeJ^.PPage^.Number);
end;

procedure TfrmMain.SortList(PHead: PNodePointer; CompFunc: TCompFunc);
var
   PRunnerI, PRunnerJ: PNodePointer;
   TempSubterm: PNodePointer;
   TempPages: PPagePointer;
   TempTerm: string;
begin
   PRunnerI := PHead^.PNext;
   while (PRunnerI <> nil) do
   begin
      PRunnerJ := PRunnerI;
      while (PRunnerJ <> nil) do
      begin
         if (CompFunc(PRunnerI, PRunnerJ)) then
         begin
            TempSubterm := PRunnerI^.PSubterm;
            TempPages := PRunnerI^.PPage;
            TempTerm := PRunnerI^.Term;
            PRunnerI^.Term := PRunnerJ^.Term;
            PRunnerI^.PSubterm := PRunnerJ^.PSubterm;
            PRunnerI^.PPage := PRunnerJ^.PPage;
            PRunnerJ^.Term := TempTerm;
            PRunnerJ^.PSubterm := tempSubterm;
            PRunnerJ^.PPage := TempPages;
         end;
         PRunnerJ := PRunnerJ^.PNext;
      end;
      PRunnerI := PRunnerI^.PNext;
   end;
end;

procedure TfrmMain.ShowTermList();
var
   PRunner: PNodePointer;
   Pages, Subterms: string;
begin
   PRunner := PHeadTermList;
   mmOutput.Clear;
   while (PRunner^.PNext <> nil) do
   begin
      mmOutput.Lines.Add(PRunner^.PNext^.Term + #10#13);
      ShowPages(PRunner^.PNext, Pages);
      ShowSubterms(PRunner^.PNext, Subterms);
      mmOutput.Lines.Add('---------------------');
      mmOutput.Lines.Add('Страницы: ');//#10#13);
      mmOutput.Lines.Add(Pages + #10#13);
      mmOutput.Lines.Add('---------------------');
      mmOutput.Lines.Add('Подтермины: ');
      mmOutput.Lines.Add(Subterms);
      PRunner := PRunner^.PNext;
   end;
end;

procedure TfrmMain.ShowPages(Source: PNodePointer; var Dest: string);
var
   PRunner: PPagePointer;
begin
   Dest := '';
   PRunner := Source^.PPage;
   while (PRunner <> nil) do
   begin
      Dest := Dest + IntToStr(PRunner^.Number) + ' ';
      PRunner := PRunner^.PNext;
   end;
end;

procedure TfrmMain.ShowSubterms(Source: PNodePointer; var Dest: string);
var
   PRunner: PNodePointer;
begin
   Dest := '';
   PRunner := Source^.PSubterm;
   while (PRunner <> nil) do
   begin
      Dest := Dest + PRunner^.Term + ' | ' + #10#13;
      PRunner := PRunner^.PNext;
   end;
end;

function TfrmMain.Hash(Key: string): Integer;
var
   Sum, i: Integer;
begin
   Sum := 0;
   for i := 1 to Length(Key) do
      Sum := Sum + Ord(Key[i]);
   Result := Sum mod AverageLength;
end;


//works only with one node in the list
procedure TfrmMain.ShowTable();
var
   TempTerm, TempSubterms, TempPages: string;
   i: Integer;
   PRunner: PHashNodePointer;
begin
   mmOutput.Clear;
   for i := 0 to High(HashTable) do
   begin
      PRunner := HashTable[i];
      tempterm := '';
      while (PRunner^.PNext <> nil) do
      begin
         TempTerm := PRunner^.PNext^.Key;
         ShowPages(PRunner^.PNext^.Value, tempPages);
         ShowSubterms(PRunner^.PNext^.Value, TempSubterms);
         mmOutput.Lines.Add(tempTerm);
         mmOutput.Lines.Add('---------------------');
         mmOutput.Lines.Add('Страницы: ' +  TempPages);
         mmOutput.Lines.Add('---------------------');
         mmOutput.Lines.Add('Подтермины: ' + #10#13 + TempSubterms);
         PRunner := PRunner^.PNext;
      end;
   end;
end;

procedure TfrmMain.AddListElement(PHead, Term: PNodePointer);
begin
   while (PHead.PNext <> nil) do
      PHead := PHead^.PNext;
   Term^.PNext := nil;
   PHead^.PNext := Term;
end;

function TfrmMain.SearchHashTable(Key: string; var PNode, PPrev: PHashNodePointer):
   Boolean;
var
   i: Integer;
   Temp: PHashNodePointer;
   isFound: Boolean;
begin
   i := Hash(Key);
   isFound := false;
   Temp := HashTable[i];
   while (Temp^.PNext <> nil) and not isFound do
   begin
      if (AnsiCompareStr(Temp^.PNext^.Key, Key) = 0) then
      begin
         isFound := true;
         PPrev := Temp;
         PNode := Temp^.PNext;
      end;
      Temp := Temp^.PNext;
   end;
   Result := isFound;
end;

procedure TfrmMain.DeleteList(Key: string);
var
   PNode, PTemp, PPrev: PNodePointer;
begin
   if SearchList(Key, PNode, PPrev) then
   begin
         PTemp := PNode;
         PPrev^.PNext := PNode^.PNext;
         Dispose(PTemp);
   end
   else
      MessageDlg('Данный термин не найден', mtInformation, [mbOk], 0);
end;

procedure TfrmMain.InitHashTable();
var
   i: Integer;
begin
   for i := 0 to High(HashTable) do
   begin
      New(HashTable[i]);
      HashTable[i]^.PNext := nil;
   end;
end;

procedure TfrmMain.btAddTermClick(Sender: TObject);
var
   i, j: Integer;
   PTemp: PNodePointer;
   PTempHash: PHashNodePointer;
begin
   New(TempTerm);
   TempTerm^.Term := '';
   TempTerm^.PPage := nil;
   TempTerm^.PSubterm := nil;
   frmAddTerm.ShowModal();
   AddListElement(PHeadTermList, TempTerm);
   ShowTermList;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
   InitHashTable();
   New(TempTerm);
   TempTerm^.PNext := nil;
   TempTerm^.PPage := nil;
   TempTerm^.PSubterm := nil;
   New(PHeadTermList);
   PHeadTermList^.PNext := nil;
end;

procedure TfrmMain.btViewTermClick(Sender: TObject);
var
   PRunner: PNodePointer;
   Value: string;
begin
   Value := edViewTerm.Text;
   if SearchList(Value, PRunner) then
   begin
      TempTerm := PRunner;
      frmAddTerm.ShowModal;
      ShowTermList;
   end
   else
      MessageDlg('Данный термин не найден', mtInformation, [mbOk], 0);
end;

procedure TfrmMain.btDeleteClick(Sender: TObject);
var
   Value: string;
begin
   Value := edSearchSubterm.Text;

   DeleteList(Value);
   DeleteHashTable(Value);
   ShowTermList;
end;

procedure TfrmMain.btSortAlphabetClick(Sender: TObject);
begin
   SortList(PHeadtermList, CompAlphabet);
   ShowTermList;
end;

procedure TfrmMain.btSortPagesClick(Sender: TObject);
begin
   SortList(PHeadTermList, CompPages);
   ShowTermList;
end;

procedure TfrmMain.btSearchTermClick(Sender: TObject);
var
   Terms: TStringArr;
   Value: string;
   i: Integer;
begin
   Value := edSearchTerm.Text;
   SearchTermList(Value, Terms);
   mmOutput.Clear;
   mmOutput.Lines.Add('Термины по этому подтермину: ');
   for i := 0 to High(Terms) do
      mmOutput.Lines.Add(Terms[i]);
end;

procedure TfrmMain.btShowTableClick(Sender: TObject);
begin
   ShowTable;
end;

procedure TfrmMain.btSearchSubtermClick(Sender: TObject);
var
   Dest: TStringArr;
   Value: string;
   i, Depth: Integer;
begin
   Value := edSearchSubterm.Text;
   Depth := 0;
   SearchSubterms(Value, Dest, Depth);
   mmOutput.Clear;
   mmOutput.Lines.Add('Подтермины: ');
   mmOutput.Lines.Add('--------------');
   for i := 0 to High(Dest) do
      mmOutput.Lines.Add(Dest[i]);
end;

end.
