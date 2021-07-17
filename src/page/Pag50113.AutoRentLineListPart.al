page 50113 "Auto Rent Line ListPart"
{
    PageType = ListPart;
    SourceTable = "Auto Rent Line";
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
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