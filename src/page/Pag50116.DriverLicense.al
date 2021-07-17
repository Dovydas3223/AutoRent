page 50116 "Driver License"
{
    Caption = 'Driver License';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Auto Rent Header";

    layout
    {
        area(Content)
        {
            field("Driver License"; Rec."Driver License")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the picture of the Clients driver license.';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    Rec.TestField("No.");
                    if Rec."Client No." = '' then
                        Error(MustSpecifyNameErr);

                    if Rec."Driver License".HasValue then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(Rec."Driver License");
                    Rec."Driver License".ImportFile(FileName, ClientFileName);
                    if not Rec.Modify(true) then
                        Rec.Insert(true);
                    if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    Rec.TestField("Client No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec."Driver License");
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteEnabled := Rec."Driver License".HasValue;
    end;

    var
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteEnabled: Boolean;
        MustSpecifyNameErr: Label 'You must specify a client name before you can import a picture.';
}