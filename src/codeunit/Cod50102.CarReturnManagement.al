codeunit 50102 "Car Return Management"
{
    procedure ReturnCar(var AutoContract: Record "Auto Rent Header")
    var
        NewVersionCreatedLbl: Label 'Contract %1 was removed';
    begin
        CreateFinishedContract(AutoContract);
        TransferAutoDamage(AutoContract);
        RemoveAutoRentContract(AutoContract);
        Message(NewVersionCreatedLbl, AutoContract."No.");
    end;

    procedure CreateFinishedContract(var AutoContract: Record "Auto Rent Header")
    var
        FinishedHeader: Record "Finished Auto Rent Header";
        FinishedLines: Record "Finished Auto Rent Line";
        AutoRentLine: Record "Auto Rent Line";
    begin
        FinishedHeader.SetRange("No.", AutoContract."No.");
        if not FinishedHeader.FindLast() then
            FinishedHeader.Init();

        FinishedHeader.TransferFields(AutoContract);
        FinishedHeader.Insert();

        AutoRentLine.SetRange("No.", AutoContract."No.");
        if not AutoRentLine.FindSet() then
            exit;

        FinishedLines.SetRange("No.", AutoContract."No.");

        if not FinishedLines.FindLast() then
            FinishedLines.Init();

        repeat begin
            FinishedLines.TransferFields(AutoRentLine);
            FinishedLines.Insert();
        end until AutoRentLine.Next() = 0;



    end;

    procedure TransferAutoDamage(var AutoContract: Record "Auto Rent Header")
    var
        AutoDamage: Record "Auto Damage";
        AutoRentDamage: Record "Auto Rent Damage";
    begin
        AutoRentDamage.SetRange("No.", AutoContract."No.");
        if not AutoRentDamage.FindSet() then
            exit;

        AutoDamage.SetRange("Auto No.", AutoContract."Auto No.");
        if not AutoDamage.FindLast() then
            AutoDamage.Init();


        repeat begin
            AutoDamage.TransferFields(AutoRentDamage);
            AutoDamage."Auto No." := AutoContract."Auto No.";
            AutoDamage."Line No." := AutoDamage.Count() + 1;
            AutoDamage.Status := AutoDamage.Status::Relevant;
            AutoDamage.Insert();
        end until AutoRentDamage.Next() = 0;
    end;

    procedure RemoveAutoRentContract(var AutoContract: Record "Auto Rent Header")
    var
        AutoRentLine: Record "Auto Rent Line";
    begin
        AutoRentLine.SetRange("No.", AutoContract."No.");
        if AutoRentLine.FindSet() then
            AutoRentLine.DeleteAll();

        AutoContract.Delete();
    end;

}