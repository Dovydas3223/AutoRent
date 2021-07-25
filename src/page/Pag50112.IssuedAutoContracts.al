page 50112 "Issued Auto Contracts"
{
    Caption = 'Issued Auto Contracts';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Header";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto rent document No.';
                }
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto rent document client No.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date of document filing.';
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Renting auto No.';
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valid reservation start.';
                }
                field("Reserved To"; Rec."Reserved To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valid reservation end.';
                }
                field("Price"; Rec."Price")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto rent document status.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Status, Rec.Status::Issued);
    end;
}