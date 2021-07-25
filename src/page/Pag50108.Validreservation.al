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
                    ToolTip = 'Reserved Time Auto No.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Reserved time client No.';
                }
                field("Reservation Start"; Rec."Reservation Start")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto reservation start.';
                }
                field("Reservation End"; Rec."Reservation End")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto reservation start.';
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