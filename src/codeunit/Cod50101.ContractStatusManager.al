codeunit 50101 "Contract Status Manager"
{
    procedure PerformManualRelease(var AutoRentHeader: Record "Auto Rent Header")
    begin
        if AutoRentHeader."Status" = AutoRentHeader."Status"::Issued then
            exit;

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
}