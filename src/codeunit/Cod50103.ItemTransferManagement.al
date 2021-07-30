codeunit 50103 "ItemTransferManagement"
{
    procedure TransferItemsToAutoWarehouse(var RentHeader: Record "Auto Rent Header")
    var
        ItemJournalLine: Record "Item Journal Line";
        AutoSetup: Record "Auto Setup";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        Auto: Record Auto;
        Item: Record Item;
        RentLine: Record "Auto Rent Line";
        JournalLineDocNos: Text[20];

        NoWarehouseLocationErr: Label 'No warehouse location selected.';
        NoAutoErr: Label 'No car selected.';
        NoItemInWarehouseErr: Label 'Item %1 is not found or is not enough in your selected warehouse %2.';
    begin
        AutoSetup.Get();
        if AutoSetup.Attachment = '' then
            Error(NoWarehouseLocationErr);

        if not Auto.Get(RentHeader."Auto No.") then
            Error(NoAutoErr);

        RentLine.SetRange("No.", RentHeader."No.");
        RentLine.SetRange("Type", RentLine."Type"::Item);
        ItemJournalLine.DeleteAll();
        JournalLineDocNos := GetDocumentNoFromNoSeries();
        if RentLine.FindSet() then
            repeat begin
                Item.Get(RentLine."Type No.");
                if not IsWarehouseHasEnoughOfItem(Item, AutoSetup.Attachment, RentLine.Quantity) then
                    Error(NoItemInWarehouseErr, Item."No.", AutoSetup.Attachment);
                ItemJournalLine.Init();
                ItemJournalLine."Document No." := JournalLineDocNos;
                ItemJournalLine."Line No." += 1;
                ItemJournalLine."Posting Date" := WorkDate();
                ItemJournalLine."Document Date" := WorkDate();
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Transfer;
                ItemJournalLine."Item No." := RentLine."Type No.";
                ItemJournalLine."Location Code" := AutoSetup.Attachment;
                ItemJournalLine."New Location Code" := Auto."Location Code";
                ItemJournalLine."Quantity (Base)" := RentLine.Quantity;
                ItemJournalLine."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                ItemJnlPostLine.RunWithCheck(ItemJournalLine);

            end until RentLine.Next() = 0;
    end;

    procedure ReturnItemsFromAutoWarehouse(var
                                               RentHeader: Record "Auto Rent Header")
    var
        ItemJournalLine: Record "Item Journal Line";
        AutoSetup: Record "Auto Setup";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        Auto: Record Auto;
        Item: Record Item;
        RentLine: Record "Auto Rent Line";
        JournalLineDocNos: Text[20];

        NoWarehouseLocationErr: Label 'No warehouse location selected.';
        NoAutoErr: Label 'No car selected.';
        Text001: Label 'The journal lines were successfully posted.';
    begin
        AutoSetup.Get();
        if AutoSetup.Attachment = '' then
            Error(NoWarehouseLocationErr);

        if not Auto.Get(RentHeader."Auto No.") then
            Error(NoAutoErr);

        RentLine.SetRange("No.", RentHeader."No.");
        RentLine.SetRange("Type", RentLine."Type"::Item);
        ItemJournalLine.DeleteAll();
        JournalLineDocNos := GetDocumentNoFromNoSeries();
        if RentLine.FindSet() then
            repeat begin
                Item.Get(RentLine."Type No.");
                ItemJournalLine.Init();
                ItemJournalLine."Document No." := JournalLineDocNos;
                ItemJournalLine."Line No." += 1;
                ItemJournalLine."Posting Date" := WorkDate();
                ItemJournalLine."Document Date" := WorkDate();
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Transfer;
                ItemJournalLine."Item No." := RentLine."Type No.";
                ItemJournalLine."Location Code" := Auto."Location Code";
                ItemJournalLine."New Location Code" := AutoSetup.Attachment;
                ItemJournalLine."Quantity (Base)" := RentLine.Quantity;
                ItemJournalLine."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                ItemJnlPostLine.RunWithCheck(ItemJournalLine);
            end until RentLine.Next() = 0;
    end;

    //Checks if selected item is enough in specific warehouse
    //by calculating sums from item ledger entry
    procedure IsWarehouseHasEnoughOfItem(Item: Record Item; LocationCode: Code[10]; Quantity: Integer): Boolean
    var
        ledger: Record "Item Ledger Entry";
        Amount: Integer;
    begin
        ledger.SetRange("Item No.", Item."No.");
        ledger.SetRange("Location Code", LocationCode);
        if ledger.FindSet() then
            repeat begin
                Amount += ledger.Quantity;
            end until ledger.Next() = 0;
        exit(Amount >= Quantity);
    end;

    local procedure GetDocumentNoFromNoSeries(): Code[20]
    var
        AutoSetup: Record "Auto Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        AutoSetup.Get();
        AutoSetup.TestField("Item Reclass. Nos.");

        exit(NoSeriesManagement.GetNextNo(AutoSetup."Item Reclass. Nos.", WorkDate(), true));
    end;
}