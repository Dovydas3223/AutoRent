table 50107 "Auto Rent Line"
{
    Caption = 'Auto Rent Line';
    DataClassification = CustomerContent;
    DrillDownPageID = "Auto Rent Line ListPart";
    LookupPageID = "Auto Rent Line ListPart";


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(10; "Type"; Enum "Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if Rec."Type" <> xRec."Type" then
                    ShowMainAutoServiceError();
            end;
        }
        field(11; "Type No."; Code[20])
        {
            Caption = 'Type No.';
            DataClassification = CustomerContent;
            TableRelation = if ("Type" = const(Item)) Item else
            if ("Type" = const(Resource)) Resource;

            trigger OnValidate()
            begin
                if Rec."Type No." <> xRec."Type No." then begin
                    CheckItemQuantityInWarehouse();
                    ShowMainAutoServiceError();
                    GetUnitPriceDescriptionQuant()
                end;

            end;
        }
        field(12; "Type Description"; Text[100])
        {
            Caption = 'Type Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Unit"; Code[10])
        {
            Caption = 'Unit of Measurment';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(30; "Quantity"; Integer)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if (Rec.Quantity <> xRec.Quantity) and (Rec."Unit price" <> 0) then begin
                    CheckItemQuantityInWarehouse();
                    CalculateFinalPrice();
                end;
            end;
        }
        field(40; "Unit price"; Decimal)
        {
            Caption = 'Unit price';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                if (Rec."Unit price" <> xRec."Unit price") and (Rec.Quantity <> 0) then
                    CalculateFinalPrice()
            end;
        }
        field(50; "Final price"; Decimal)
        {
            Caption = 'Final price';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60; "Is First"; Boolean)
        {
            Caption = 'Is First';
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

    trigger OnDelete()
    begin
        ShowMainAutoServiceError()
    end;

    procedure CheckItemQuantityInWarehouse()
    var
        Item: Record Item;
        NoItemsInInventoryErr: Label 'Item %1 is not in stock. Available: %2.';
        NotEnoughItemsErr: Label 'Item %1 is out of stock.';
    begin
        if (not Item.IsEmpty()) and (Rec.Type = Rec.Type::Item) then begin
            Item.Get(Rec."Type No.");
            Item.CalcFields(Inventory);
            if Item.Inventory <= 0 then
                Error(NotEnoughItemsErr, Rec."Type No.");
            if (Quantity <> 0) and (Item.Inventory < Quantity) then
                Error(NoItemsInInventoryErr, Rec."Type No.", Item.Inventory);
        end;

    end;

    procedure ShowMainAutoServiceError()
    var
        MainServiceDeletionErrLbl: Label 'Resource %1 is this car main rent service';
    begin
        if Rec."Is First" then
            Error(MainServiceDeletionErrLbl, Rec."Type No.");
    end;

    procedure InsertFirst(RentHeader: Record "Auto Rent Header")
    var
        Auto: Record Auto;
        Resource: Record Resource;
    begin
        Auto.SetRange("No.", RentHeader."Auto No.");
        Auto.FindFirst();
        Rec.SetRange("No.", RentHeader."No.");
        Rec.DeleteAll();
        if Rec.IsEmpty() then begin
            Rec.Init();
            Rec."No." := RentHeader."No.";
            Rec."Line No." := 10000;
            Rec."Type" := Rec."Type"::Resource;
            Rec."Type No." := Auto."Rent Service";
            GetUnitPriceDescriptionQuant();
            Rec."Is First" := true;
            Rec.Insert();
        end;
    end;

    procedure CalculateFinalPrice()
    var
        autoheader: Record "Auto Rent Header";
        autoheaderPage: Page "Auto Rent Header Card";
    begin
        Rec."Final price" := rec.Quantity * Rec."Unit price";
    end;

    //Gets Resource or Item unit of measure, unit price, description and default quantity.
    procedure GetUnitPriceDescriptionQuant()
    var
        Item: Record Item;
        Resource: Record Resource;
    begin
        case "Type" of
            Type::Item:
                begin
                    Item.Get("Type No.");
                    Rec."Unit Price" := Item."Unit Cost";
                    Rec."Unit" := Item."Base Unit of Measure";
                    Rec."Type Description" := Item.Description;
                end;
            Type::Resource:
                begin
                    Resource.Get("Type No.");
                    Rec."Unit Price" := Resource."Unit Price";
                    Rec."Unit" := Resource."Base Unit of Measure";
                    Rec."Type Description" := 'DAY';
                    Rec.Quantity := GetMainServiceQuantity();
                end;
        end;
    end;

    procedure GetMainServiceQuantity(): Integer
    var
        AutoRentLine: Record "Auto Rent Line";
    begin
        AutoRentLine.SetRange("No.", Rec."No.");
        AutoRentLine.Ascending(true);
        if AutoRentLine.FindFirst() then
            exit(AutoRentLine.Quantity);
    end;
}