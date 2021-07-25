page 50117 "Finished Auto Rend Header Card"
{
    Caption = 'Finished Auto Rent Header';
    PageType = Document;
    UsageCategory = None;
    SourceTable = "Finished Auto Rent Header";
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
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
                    ToolTip = 'Auto rent price.';
                }

            }


            part(FinishedAutoRentListPart; "Finished Auto Rent ListPart")
            {
                Caption = 'Auto Rent Lines';
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
        area(FactBoxes)
        {
            part(DriverLicense; "Driver License")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
                Editable = Rec."Auto No." <> '';
                Enabled = Rec."Auto No." <> '';
                UpdatePropagation = Both;

            }
        }
    }
}