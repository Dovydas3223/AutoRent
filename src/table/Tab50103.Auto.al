table 50103 "Auto"
{
    Caption = 'Auto';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            Editable = false;
        }
        field(10; "Name"; Text[50])
        {
            Caption = 'Auto Name';
            DataClassification = CustomerContent;
        }
        field(20; "Mark"; Code[20])
        {
            Caption = 'Auto Mark';
            DataClassification = CustomerContent;
            TableRelation = "Auto Mark";
        }
        field(21; "Model"; Code[20])
        {
            Caption = 'Auto Mark';
            DataClassification = CustomerContent;
            TableRelation = "Auto Model"."Code" where("Auto Mark Code" = field(Mark));
        }
        field(30; "Year of manufacture"; Date)
        {
            Caption = 'Year of manufacture';
            DataClassification = CustomerContent;
        }
        field(31; "Insurance validity"; Date)
        {
            Caption = 'Insurance valid until';
            DataClassification = CustomerContent;
        }
        field(32; "TI End"; Date)
        {
            Caption = 'TI End';
            DataClassification = CustomerContent;
        }
        field(40; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(50; "Rent Service"; Code[20])
        {
            Caption = 'Rent Service';
            DataClassification = CustomerContent;
            TableRelation = Resource."No.";
        }
        field(60; "Rent Price"; Decimal)
        {
            Caption = 'Rent Price';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Unit Price" where("No." = field("Rent Service")));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then
            "No." := GetAutoNoFromNoSeries();
    end;

    procedure GetAutoNoFromNoSeries(): Code[20]
    var
        AutoSetup: Record "Auto Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        AutoSetup.Get();
        AutoSetup.TestField("Car Nos.");

        exit(NoSeriesManagement.GetNextNo(AutoSetup."Car Nos.", WorkDate(), true));
    end;

}