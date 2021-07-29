page 50109 "Auto Damage List"
{
    Caption = 'Auto Damage List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Damage";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Damaged auto No.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date of time when auto was damaged.';
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'For recording a description of the violation';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    ToolTip = 'Status of auto damage.';

                    trigger OnValidate()
                    begin
                        StyleExprTxt := FieldColorMngmt.ChangeStatusColor(Format(Rec.Status));
                    end;
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        StyleExprTxt := FieldColorMngmt.ChangeStatusColor(Format(Rec.Status));
    end;

    var
        FieldColorMngmt: Codeunit "Field Color Management";
        StyleExprTxt: Text[20];
}