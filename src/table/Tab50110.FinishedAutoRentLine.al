table 50110 "Finished Auto Rent Line"
{
    Caption = 'Auto Rent Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(10; "Type"; Enum "Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(11; "Type No."; Code[20])
        {
            Caption = 'Type No.';
            DataClassification = CustomerContent;
            TableRelation = if ("Type" = const(Item)) Item else
            if ("Type" = const(Resource)) Resource;
        }
        field(12; "Type Description"; Text[100])
        {
            Caption = 'Type Description';
            DataClassification = CustomerContent;
        }
        field(20; "Unit"; Code[10])
        {
            Caption = 'Unit of Measurment';
            DataClassification = CustomerContent;
        }

        field(30; "Quantity"; Integer)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(40; "Unit price"; Decimal)
        {
            Caption = 'Unit price';
            DataClassification = CustomerContent;
        }
        field(50; "Final price"; Decimal)
        {
            Caption = 'Final price';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }
}