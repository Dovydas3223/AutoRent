page 50103 "Auto Mark Card"
{
    Caption = 'Auto Mark Card';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Auto Mark";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."Code")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                    ToolTip = 'Car mark no.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Car mark description.';
                }
            }
        }
    }
}