table 50102 "Auto Model"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Auto Mark No."; Code[20])
        {
            Caption = 'Auto Mark No.';
            DataClassification = CustomerContent;
            TableRelation = "Auto Mark";
        }
        field(10; "No."; Integer)
        {
            Caption = 'Model No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(20; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Auto Mark No.", "No.")
        {
            Clustered = true;
        }
    }

}