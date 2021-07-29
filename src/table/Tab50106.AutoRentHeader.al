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
            NotBlank = true;
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
                    Rec."Reserved From" := 0DT;
                    Rec."Reserved To" := 0DT;
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
            ExtendedDatatype = None;
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

            trigger OnValidate()
            begin
                if Rec."Auto No." <> xRec."Auto No." then begin
                    Rec."Reserved From" := 0DT;
                    Rec."Reserved To" := 0DT;
                end;
            end;
        }
        field(40; "Reserved From"; DateTime)
        {
            Caption = 'Reserved From';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Reserved To" <> 0DT then begin
                    IsReservationDateValid();
                    CalculateQuantity();
                end;
            end;
        }
        field(41; "Reserved To"; DateTime)
        {
            Caption = 'Reserved To';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Reserved To" <> 0DT then begin
                    IsReservationDateValid();
                    CalculateQuantity();
                end;
            end;
        }
        field(50; "Price"; Decimal)
        {
            Caption = 'Price';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Auto Rent Line"."Final price" where("No." = field("No.")));
            trigger OnValidate()
            begin
                CalculatePrice();
            end;
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
        if "Date" = 0D then
            "Date" := WorkDate();
    end;

    procedure CalculateQuantity()
    var
        Line: Record "Auto Rent Line";
        Dur: Duration;
    begin
        Line.SetRange("No.", Rec."No.");
        if Line.FindFirst() then begin
            Dur := (Rec."Reserved To" - Rec."Reserved From");
            Line.Quantity := ROUND((Dur / 86400000), 1, '>');
            Line.CalculateFinalPrice();
            Line.Modify(true);
            Rec.CalculatePrice();
        end;
    end;

    procedure OpenReservationlist()
    var
        AutoReservation: record "Auto Reservation";
        NoReservationLbl: Label 'There is no reservation for auto %1 and client %2.';
    begin
        AutoReservation.SetRange("Auto No.", Rec."Auto No.");
        AutoReservation.SetRange("Client No.", Rec."Client No.");
        AutoReservation.Ascending(true);

        if not AutoReservation.IsEmpty() then begin
            if Page.RunModal(Page::"Auto Reservation List", AutoReservation) = Action::LookupOK then begin
                "Reserved From" := AutoReservation."Reservation Start";
                "Reserved To" := AutoReservation."Reservation End";
            end;
        end else begin
            Message(NoReservationLbl, "Auto No.", "Client No.");
        end;
    end;

    procedure CalculatePrice()
    var
        AutoRentLine: Record "Auto Rent Line";
        "Sum": Decimal;
    begin
        AutoRentLine.SetRange("No.", Rec."No.");
        if AutoRentLine.FindSet() then
            repeat begin
                "Sum" += AutoRentLine."Final price";
            end until AutoRentLine.Next() = 0;
        Rec.Price := "Sum";
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

    procedure IsReservationDateValid()
    var
        AutoReserv: Record "Auto Reservation";
        NoValidReservErr: Label 'There is no valid reservation for this Auto %1 and Client %2';
    begin
        AutoReserv.SetRange("Reservation Start", Rec."Reserved From");
        AutoReserv.SetRange("Reservation End", Rec."Reserved To");
        AutoReserv.SetRange("Auto No.", Rec."Auto No.");
        AutoReserv.SetRange("Client No.", Rec."Client No.");
        if not AutoReserv.FindFirst() then
            Error(NoValidReservErr, Rec."Auto No.", Rec."Client No.");
    end;

    procedure TestStatusOpen(): Boolean
    begin
        if Status <> Status::Open then
            exit(false);
        exit(true);
    end;


}