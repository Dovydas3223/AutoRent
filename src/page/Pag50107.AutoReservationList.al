page 50107 "Auto Reservation List"
{
    Caption = 'Auto Reservation List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservation";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'What car will be reserved.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Who is renting the car.';
                }
                field("Reservation Start"; Rec."Reservation Start")
                {
                    ApplicationArea = All;
                    ToolTip = 'Start of reservation.';
                }
                field("Reservation End"; Rec."Reservation End")
                {
                    ApplicationArea = All;
                    ToolTip = 'End of reservation.';
                }
            }
        }
    }
}