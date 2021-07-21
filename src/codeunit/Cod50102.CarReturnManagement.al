codeunit 50102 "Car Return Management"
{


    procedure ReturnCar(var AutoContract: Record "Auto Rent Header")
    begin
        CreateNewContractVersion(AutoContract);
        TransferAutoDamage(AutoContract);
    end;

    procedure CreateNewContractVersion(var AutoContract: Record "Auto Rent Header")
    var
        FinishedHeader: Record "Finished Auto Rent Header";
        NewVersionCreatedLbl: Label 'Contract %1 New Version Created %2';
    begin
        FinishedHeader.SetRange("No.", AutoContract."No.");
        if not FinishedHeader.FindLast() then
            FinishedHeader.Init();

        FinishedHeader.TransferFields(AutoContract);
        FinishedHeader.Insert();
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


}