page 50108 "Valid reservation"
{
    Caption = 'Valid reservations list';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservation";
    Editable = false;

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
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                }
                field("Reservation Start"; Rec."Reservation Start")
                {
                    ApplicationArea = All;
                }
                field("Reservation End"; Rec."Reservation End")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        AutoReservation: Record "Auto Reservation";
    begin
        if not Rec.IsEmpty() then
            Rec.SetFilter("Reservation Start", '>%1', CurrentDateTime());
    end;
}