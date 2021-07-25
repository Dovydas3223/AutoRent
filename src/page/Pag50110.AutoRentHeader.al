page 50110 "Auto Rent Header"
{
    Caption = 'Auto Rent Header List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Auto Rent Header Card";
    SourceTable = "Auto Rent Header";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
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
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto rent document status.';
                }


            }
        }
    }
}