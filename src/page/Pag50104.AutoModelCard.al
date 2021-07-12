page 50104 "Auto Model Card"
{
    Caption = 'Auto Model Card';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Auto Model";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Auto Mark Code";Rec."Auto Mark Code")
                {
                    ApplicationArea = All;
                }
                field("Code";Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}