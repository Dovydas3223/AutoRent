page 50100 "Auto Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Auto Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Car Nos."; Rec."Car Nos.")
                {
                    ApplicationArea = All;
                }
                field("Rent Card Nos."; Rec."Rent Card Nos.")
                {
                    ApplicationArea = All;
                }
                field("Item Reclass. Nos."; Rec."Item Reclass. Nos.")
                {
                    ApplicationArea = All;
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExist();
    end;
}