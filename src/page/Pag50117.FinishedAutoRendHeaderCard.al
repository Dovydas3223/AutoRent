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
                }
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ApplicationArea = All;
                }
                field("Reserved To"; Rec."Reserved To")
                {
                    ApplicationArea = All;
                }
                field("Price"; Rec."Price")
                {
                    ApplicationArea = All;
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