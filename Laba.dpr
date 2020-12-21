program Laba;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  UnitAddTerm in '..\UnitAddTerm.pas' {frmAddTerm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAddTerm, frmAddTerm);
  Application.Run;
end.
