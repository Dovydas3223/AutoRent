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
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    Editable = Editable;
                    ToolTip = 'Line type.';
                }
                field("Type No."; Rec."Type No.")
                {
                    ApplicationArea = All;
                    Editable = Editable;
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



    trigger OnAfterGetRecord()
    begin
        if Rec."Is First" then begin
            Editable := false;
        end else begin
            Editable := true;
        end;
    end;

    trigger OnOpenPage()
    begin
        Editable := true;
    end;

    var
        CurrAutoRentHeader: Record "Auto Rent Header";
        Editable: Boolean;

}