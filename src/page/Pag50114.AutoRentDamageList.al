page 50114 "Auto Rent Damage List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Damage";
    AutoSplitKey = true;
    DelayedInsert = true;

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
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }

                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date of when damage was filed.';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description of damage done.';
                }
            }
        }
    }
}