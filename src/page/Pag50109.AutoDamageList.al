page 50109 "Auto Damage List"
{
    Caption = 'Auto Damage List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Damage";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ToolTip = 'For recording a description of the violation';
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    begin
                        StyleExprTxt := Rec.ChangeStatusColor(Rec);
                    end;
                }

            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        StyleExprTxt := Rec.ChangeStatusColor(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        StyleExprTxt := 'ambiguous';
    end;

    var
        StyleExprTxt: Text[20];
}