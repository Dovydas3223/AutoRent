report 50101 "Auto Rent History"
{
    Caption = 'Auto Rent History';
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './Source/reportlayouts/R50101.rdl';

    dataset
    {

        dataitem(Auto; Auto)
        {

            column(No_; "No.")
            {
                IncludeCaption = true;
            }
            column(Mark; Mark)
            {
                IncludeCaption = true;
            }
            column(Model; Model)
            {
                IncludeCaption = true;
            }
            column(TotalAutoRentAmount; TotalAutoRentAmount)
            {
            }


            dataitem(FinishedAutoRentHeader; "Finished Auto Rent Header")
            {
                DataItemLink = "Auto No." = field("No.");

                column(Reserved_From;
                "Reserved From")
                {
                    IncludeCaption = true;
                }
                column(Reserved_To; "Reserved To")
                {
                    IncludeCaption = true;
                }
                column(ClientName; ClientName)
                {
                }
                column(Amount; LineAmount)
                {
                }


                trigger OnAfterGetRecord()
                var
                    Customer: Record Customer;
                begin
                    if Customer.Get(FinishedAutoRentHeader."Client No.") then
                        ClientName := Customer.Name;
                    LineAmount := CalculateHeaderAmount(FinishedAutoRentHeader);
                end;

                trigger OnPreDataItem()
                begin
                    FinishedAutoRentHeader.SetFilter("Reserved From", '>=%1', StartDate);
                    FinishedAutoRentHeader.SetFilter("Reserved To", '<=%1', EndDateReq);
                    FinishedAutoRentHeader.SetCurrentKey("Reserved From");
                    FinishedAutoRentHeader.SetAscending("Reserved From", true);
                    TotalAutoRentAmount := CalculateTotalRentAmount(FinishedAutoRentHeader);
                end;

            }

        }


    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Statement Period")
                {
                    Caption = 'Statement Period';
                    field(StartingDate; StartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the start date for the time interval for VAT statement lines in the report.';
                    }
                    field(EndingDate; EndDateReq)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies the end date for the time interval for VAT statement lines in the report.';
                    }

                }

            }

        }


    }



    labels
    {
        ReportOfAutoHistoryLbl = 'Auto History';
        TotalAutoRentAmountLbl = 'Total Amount';
    }

    trigger OnPreReport()
    begin

        if EndDateReq = 0DT then
            EndDateReq := CreateDateTime(30001230D, 0T)
    end;

    var
        ClientName: Text[100];
        LineAmount: Decimal;
        TotalAutoRentAmount: Decimal;
        AmountTemp: Decimal;
        StartDate: DateTime;
        EndDateReq: DateTime;

    procedure CalculateHeaderAmount(var RentHeader: Record "Finished Auto Rent Header"): Decimal
    var
        FinRentLine: Record "Finished Auto Rent Line";
        Amount: Decimal;
    begin
        FinRentLine.SetRange("No.", RentHeader."No.");
        if FinRentLine.FindSet() then
            repeat
                Amount += FinRentLine.Quantity * FinRentLine."Unit price";
            until FinRentLine.Next() = 0;
        exit(Amount);
    end;

    procedure CalculateTotalRentAmount(var RentHeaders: Record "Finished Auto Rent Header"): Decimal
    var
        Amount: Decimal;
    begin
        repeat
            Amount += CalculateHeaderAmount(RentHeaders);
        until RentHeaders.Next() = 0;
        exit(Amount);
    end;
}