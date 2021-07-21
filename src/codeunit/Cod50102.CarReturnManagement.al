codeunit 50102 "Car Return Management"
{


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


}