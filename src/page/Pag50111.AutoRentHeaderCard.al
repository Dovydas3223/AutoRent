page 50111 "Auto Rent Header Card"
{
    Caption = 'Auto Rent Header Card';
    PageType = Document;
    UsageCategory = None;
    SourceTable = "Auto Rent Header";
    PromotedActionCategories = 'New,Process,Report,Manage,Contract Status';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec."No." = '' then
                            Rec."No." := Rec.GetAutoNoFromNoSeries();
                    end;
                }
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;

                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                }
                field("Reserved To"; Rec."Reserved To")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                }
                field("Price"; Rec."Price")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(DriverLicense; "Driver License")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }
    actions
    {

        area(Processing)
        {
            action("Issue Contract")
            {
                Caption = 'Issue Contract';
                ApplicationArea = All;
                Enabled = rec."Status" <> rec."Status"::Issued;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Category5;


                trigger OnAction()
                var
                    ContractStatusManager: Codeunit "Contract Status Manager";
                begin
                    ContractStatusManager.PerformManualRelease(Rec);
                    IsEditable := Rec.TestStatusOpen();
                end;
            }
            action("Open Contract")
            {
                Caption = 'Open Contract';
                ApplicationArea = All;
                Enabled = rec."Status" <> rec."Status"::Open;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ContractStatusManager: Codeunit "Contract Status Manager";
                begin
                    ContractStatusManager.PerformManualOpen(Rec);
                    IsEditable := Rec.TestStatusOpen();
                end;
            }


        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Open then
            IsEditable := true;
    end;

    var
        IsEditable: Boolean;
}