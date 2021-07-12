table 50102 "Auto Model"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Auto Mark Code"; Code[20])
        {
            Caption = 'Auto Mark Code';
            DataClassification = CustomerContent;
            TableRelation = "Auto Mark";
        }
        field(10; "Code"; Code[20])
        {
            Caption = 'Model Code';
            DataClassification = CustomerContent;
        }
        field(20; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Auto Mark Code", "Code")
        {
            Clustered = true;
        }
    }

}