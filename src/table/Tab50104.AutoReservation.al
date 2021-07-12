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
        }

        field(21; "Reservation End"; DateTime)
        {
            Caption = 'Reservation End';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Auto No.", "Line No.")
        {
            Clustered = true;
        }
    }
}