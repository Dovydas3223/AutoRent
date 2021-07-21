table 50109 "Finished Auto Rent Header"
{
    Caption = 'Auto Rent Header';
    DataClassification = CustomerContent;
    LookupPageId = "Finished Auto Rent Header List";
    DrillDownPageId = "Finished Auto Rent Header List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(10; "Client No."; Code[20])
        {
            Caption = 'Client No.';
            DataClassification = CustomerContent;
        }
        field(11; "Driver License"; Media)
        {
            Caption = 'Driver License';
            DataClassification = CustomerContent;
            ExtendedDatatype = Person;
        }
        field(20; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(30; "Auto No."; Code[20])
        {
            Caption = 'Auto No.';
            DataClassification = CustomerContent;
        }
        field(40; "Reserved From"; DateTime)
        {
            Caption = 'Reserved From';
            DataClassification = CustomerContent;
        }
        field(41; "Reserved To"; DateTime)
        {
            Caption = 'Reserved To';
            DataClassification = CustomerContent;
        }
        field(50; "Price"; Decimal)
        {
            Caption = 'Price';
            FieldClass = FlowField;
            CalcFormula = sum("Finished Auto Rent Line"."Final price" where("No." = field("No.")));
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
}