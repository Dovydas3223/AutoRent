page 50118 "Finished Auto Rent ListPart"
{
    Caption = 'Auto Rent Lines';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Finished Auto Rent Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                }
                field("Type No."; Rec."Type No.")
                {
                    ApplicationArea = All;
                }
                field("Type Description"; Rec."Type Description")
                {
                    ApplicationArea = All;
                }
                field("Unit"; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field("Quantity"; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit price")
                {
                    ApplicationArea = All;
                }
                field("Final Price"; Rec."Final price")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}