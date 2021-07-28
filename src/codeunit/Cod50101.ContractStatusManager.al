codeunit 50101 "Contract Status Manager"
{
    procedure PerformManualRelease(var AutoRentHeader: Record "Auto Rent Header")
    begin
        if AutoRentHeader."Status" = AutoRentHeader."Status"::Issued then
            exit;
        CheckMainAutoService(AutoRentHeader);
        AutoRentHeader.TestField("No.");
        AutoRentHeader.TestField("Client No.");
        AutoRentHeader.TestField("Auto No.");
        AutoRentHeader.TestField("Reserved From");
        AutoRentHeader.TestField("Reserved To");

        AutoRentHeader."Status" := AutoRentHeader."Status"::Issued;
        AutoRentHeader.Modify(true);
    end;


    procedure PerformManualOpen(var AutoRentHeader: Record "Auto Rent Header")
    begin
        if AutoRentHeader."Status" = AutoRentHeader."Status"::Open then
            exit;
        AutoRentHeader."Status" := AutoRentHeader."Status"::Open;
        AutoRentHeader.Modify(true);
    end;

    procedure CheckMainAutoService(var AutoRentHeader: Record "Auto Rent Header")
    var
        RentLine: Record "Auto Rent Line";
        QuantityErr: Label 'Main auto service quantity can not be 0 or nagative.';
    begin
        RentLine.SetRange("No.", AutoRentHeader."No.");
        if RentLine.FindFirst() then
            if RentLine.Quantity <= 0 then
                Error(QuantityErr);
    end;
}