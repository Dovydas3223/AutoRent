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
                    ToolTip = 'Line type.';
                }
                field("Type No."; Rec."Type No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Item or Resource No.';
                }
                field("Type Description"; Rec."Type Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Item or Resource Description.';
                }
                field("Unit"; Rec.Unit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Service unit of measure.';
                }
                field("Quantity"; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Time or item quantity.';
                }
                field("Unit Price"; Rec."Unit price")
                {
                    ApplicationArea = All;
                    Tooltip = 'Not editable unit price';
                }
                field("Final Price"; Rec."Final price")
                {
                    ApplicationArea = All;
                    Tooltip = 'Final price calculated by multiplying quantity and unit price.';
                }
            }
        }
    }
}