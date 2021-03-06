table 50100 "Auto Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
            NotBlank = true;
        }
        field(10; "Car Nos."; Code[20])
        {
            Caption = 'Car Nos.';
            DataClassification = CustomerContent;
        }
        field(20; "Rent Card Nos."; Code[20])
        {
            Caption = 'Rent Card Nos.';
            DataClassification = CustomerContent;
        }
        field(30; "Item Reclass. Nos."; Code[20])
        {
            Caption = 'Rent Card Nos.';
            DataClassification = CustomerContent;
        }
        field(40; "Attachment"; Code[20])
        {
            Caption = 'Attachment';
            DataClassification = CustomerContent;
            TableRelation = "Location";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        SetDefaultValues();
    end;

    procedure InsertIfNotExist()
    begin
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;

    procedure SetDefaultValues()
    var
        AutoRentSetupManagement: Codeunit "Auto Rent Setup Management";
        CarNosLbl: Label 'CAR';
        CarNosDescriptionLbl: Label 'Car Nos.';
        CarNosFirstNoLbl: Label 'CAR00001';
        RentCardNosLbl: Label 'RENT CARD';
        RentCardNosDescriptionLbl: Label 'Rent Card Nos.';
        RentCardNosFirstNoLbl: Label 'REC00001';
        ItemReclassNoLbl: Label 'AUTO ITEM';
        ItemReclassNosDescriptionLbl: Label 'Auto Item Reclassification Nos.';
        ItemReclassNosFirstNoLbl: Label 'IRE00001';
    begin
        if "Car Nos." = '' then
            "Car Nos." := AutoRentSetupManagement.NewNoSeries(CarNosLbl, CarNosDescriptionLbl, CarNosFirstNoLbl);
        if "Rent Card Nos." = '' then
            "Rent Card Nos." := AutoRentSetupManagement.NewNoSeries(RentCardNosLbl, RentCardNosDescriptionLbl, RentCardNosFirstNoLbl);
        if "Item Reclass. Nos." = '' then
            "Item Reclass. Nos." := AutoRentSetupManagement.NewNoSeries(ItemReclassNoLbl, ItemReclassNosDescriptionLbl, ItemReclassNosFirstNoLbl);
    end;
}