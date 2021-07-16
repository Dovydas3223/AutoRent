page 50111 "Auto Rent Header Card"
{
    Caption = 'Auto Rent Header Card';
    PageType = Document;
    UsageCategory = None;
    SourceTable = "Auto Rent Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec."No." = '' then
                            Rec."No." := Rec.GetAutoNoFromNoSeries();
                    end;
                }
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;

                }
                field("Driver License"; Rec."Driver License")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ApplicationArea = All;
                }
                field("Reserved To"; Rec."Reserved To")
                {
                    ApplicationArea = All;
                }
                field("Price"; Rec."Price")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}