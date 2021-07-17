table 50106 "Auto Rent Header"
{
    Caption = 'Auto Rent Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Client No."; Code[20])
        {
            Caption = 'Client No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;

            trigger OnValidate()
            var
                ClientInDebtErrorLbl: Label 'Client No. %1 has debt';
                ClientIsBlockedErrorLbl: Label 'Client No. %1 is blocked';
            begin
                if Rec."Client No." <> xRec."Client No." then begin
                    if IsClientInDebt() then
                        Error(ClientInDebtErrorLbl, Rec."Client No.");
                    if IsClientBlocked() then
                        Error(ClientIsBlockedErrorLbl, Rec."Client No.");
                end;

            end;
        }
        field(11; "Driver License"; Media)
        {
            Caption = 'Driver License';
            ExtendedDatatype = Person;
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(60; Status; Enum "Auto Rent Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
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
        AutoSetup.TestField("Rent Card Nos.");
        exit(NoSeriesManagement.GetNextNo(AutoSetup."Rent Card Nos.", WorkDate(), true));
    end;

    procedure IsClientInDebt(): Boolean
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        "sum": Decimal;
    begin
        CustLedgerEntry.SetRange("Customer No.", Rec."Client No.");
        if CustLedgerEntry.FindSet() then begin
            repeat begin
                "sum" += CustLedgerEntry."Amount (LCY)";
            end until CustLedgerEntry.Next() = 0;
            if sum < 0 then
                exit(true);
        end;
        exit(false);
    end;

    procedure IsClientBlocked(): Boolean
    var
        Customer: Record Customer;
    begin
        if Customer.Get(Rec."Client No.") then
            exit(Customer.IsBlocked());
    end;

}