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
            NotBlank = true;
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
                    Rec.checkDateOrder();
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

    //Checking if reservation time is overlaping with other dates.
    procedure IsDatetimeOverlaping(ReservationTime: DateTime)
    var
        AutoRes: Record "Auto Reservation";
        DateErr: Label 'Reservation Time %1 is overlaping with reservation time %2 - %3.';
    begin
        if AutoRes.IsEmpty() then begin
            exit;
        end;
        AutoRes.SetRange("Auto No.", Rec."Auto No.");
        AutoRes.FindSet();
        repeat begin
            if ((ReservationTime >= AutoRes."Reservation Start") and (ReservationTime <= AutoRes."Reservation End")) then
                Error(DateErr, ReservationTime, AutoRes."Reservation Start", AutoRes."Reservation End");
            if (Rec."Reservation Start" <> 0DT) and (Rec."Reservation End" <> 0DT) then begin
                if (Rec."Reservation Start" < AutoRes."Reservation Start") and (Rec."Reservation End" > AutoRes."Reservation End") then
                    Error(DateErr, ReservationTime, AutoRes."Reservation Start", AutoRes."Reservation End");
            end;
        end until AutoRes.Next() = 0;
    end;

    //Cheking if Reservation Start is not after Reservation End.
    procedure checkDateOrder()
    var
        ReservationTimeErr: Label 'Reservation end %1 can not be before reservation start %2.';
    begin
        if "Reservation End" < "Reservation Start" then
            Error(ReservationTimeErr, "Reservation End", "Reservation Start");
    end;
}