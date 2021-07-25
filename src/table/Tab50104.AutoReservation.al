table 50104 "Auto Reservation"
{
    Caption = 'Auto Reservation';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Auto No."; Code[20])
        {
            Caption = 'Auto No.';
            DataClassification = CustomerContent;
            TableRelation = Auto;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(10; "Client No."; Code[20])
        {
            Caption = 'Client No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(20; "Reservation Start"; DateTime)
        {
            Caption = 'Reservation Start';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."Reservation Start" <> xRec."Reservation Start" then begin
                    Rec.IsDatetimeOverlaping(Rec."Reservation Start");
                end;
            end;
        }

        field(21; "Reservation End"; DateTime)
        {
            Caption = 'Reservation End';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if Rec."Reservation End" <> xRec."Reservation End" then begin
                    Rec.IsDatetimeOverlaping(Rec."Reservation End");
                    Rec.checkDate();
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Auto No.", "Line No.")
        {
            Clustered = true;
        }
    }

    //It works but needs more work
    procedure IsDatetimeOverlaping(ReservationTime: DateTime)
    var
        AutoRes: Record "Auto Reservation";
        StartDateErrorLbl: Label 'Reservation Time %1 is underlaping with reservation time %2 - %3.';
        DateErrorLbl: Label 'Reservation Time %1 is overlaping with reservation time %2 - %3.';
    begin
        // if AutoRes.IsEmpty() then begin
        //     exit;
        // end;
        AutoRes.SetRange("Auto No.", Rec."Auto No.");
        AutoRes.FindSet();
        AutoRes.SetCurrentKey("Reservation Start");
        if AutoRes.Get(ReservationTime) then
            Error(StartDateErrorLbl, ReservationTime, AutoRes."Reservation Start", AutoRes."Reservation End");
        repeat begin
            // if ((ReservationTime >= AutoRes."Reservation Start") and (ReservationTime <= AutoRes."Reservation End")) then
            //     Error(StartDateErrorLbl, ReservationTime, AutoRes."Reservation Start", AutoRes."Reservation End");
            if (Rec."Reservation Start" <> 0DT) and (Rec."Reservation End" <> 0DT) then begin
                if (Rec."Reservation Start" < AutoRes."Reservation Start") and (Rec."Reservation End" > AutoRes."Reservation End") then
                    Error(DateErrorLbl, ReservationTime, AutoRes."Reservation Start", AutoRes."Reservation End");
            end;
        end until AutoRes.Next() = 0;
    end;

    procedure checkDate()
    var
        ReservationTimeErrorLbl: Label 'Reservation end %1 can not be before reservation start %2.';
    begin
        if "Reservation End" < "Reservation Start" then
            Error(ReservationTimeErrorLbl, "Reservation End", "Reservation Start");

        Message(Format(("Reservation End" - "Reservation Start") > 010000));

    end;
}