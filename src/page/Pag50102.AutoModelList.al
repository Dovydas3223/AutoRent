page 50102 "Auto Model List"
{
    Caption = 'Auto Model List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Model";
    CardPageId = "Auto Model Card";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto Mark Code"; Rec."Auto Mark Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto mark No.';
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto model No.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto model description.';
                }
            }
        }
    }
}