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
            TableRelation = Auto;
        }
        field(40; "Reserved From"; DateTime)
        {
            Caption = 'Reserved From';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IsReservationStartValid();
            end;
        }
        field(41; "Reserved To"; DateTime)
        {
            Caption = 'Reserved To';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IsReservationEndValid();
            end;
        }
        field(50; "Price"; Decimal)
        {
            Caption = 'Price';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60; Status; Enum "Auto Rent Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
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

    procedure IsReservationStartValid()
    var
        AutoReservation: Record "Auto Reservation";
        NoValidReservationErr: Label 'There is no valid reservation for this Auto %1 and Client %2';
    begin
        AutoReservation.SetRange("Reservation Start", Rec."Reserved From");
        if AutoReservation.FindFirst() then
            if (AutoReservation."Auto No." <> Rec."Auto No.") OR (AutoReservation."Client No." <> Rec."Client No.") then
                Error(NoValidReservationErr, Rec."Auto No.", Rec."Client No.");
    end;

    procedure IsReservationEndValid()
    var
        AutoReservation: Record "Auto Reservation";
        NoValidReservationErr: Label 'There is no valid reservation for this Auto %1 and Client %2';
    begin
        AutoReservation.SetRange("Reservation End", Rec."Reserved To");
        if AutoReservation.FindFirst() then
            if (AutoReservation."Auto No." <> Rec."Auto No.") OR (AutoReservation."Client No." <> Rec."Client No.") then
                Error(NoValidReservationErr, Rec."Auto No.", Rec."Client No.");
    end;

    procedure TestStatusOpen(): Boolean
    begin
        if Status <> Status::Open then
            exit(false);
        exit(true);
    end;


}