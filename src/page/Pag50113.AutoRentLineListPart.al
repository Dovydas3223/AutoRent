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
                }
                field("Type No."; Rec."Type No.")
                {
                    ApplicationArea = All;
                    Editable = Editable;
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

    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Is First" then begin
            Editable := false;
        end else begin
            Editable := true;
        end;
    end;

    var
        Editable: Boolean;

}