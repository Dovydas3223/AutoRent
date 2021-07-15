table 50105 "Auto Damage"
{
    Caption = 'Auto Damage Table';
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
        field(10; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(20; "Description"; Text[255])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(30; Status; Enum "Auto Damage Status")
        {
            Caption = 'Status';
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

    procedure ChangeStatusColor(Rec: Record "Auto Damage"): Text[20]
    begin
        case Rec.Status of
            Rec.Status::Status:
                exit('ambiguous');
            Rec.Status::Relevant:
                exit('unfavorable');
            Rec.Status::Resolved:
                exit('favorable');
        end;
    end;

}