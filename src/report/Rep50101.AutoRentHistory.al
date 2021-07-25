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


            dataitem(AutoRentHeader; "Auto Rent Header")
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
                    if Customer.Get(AutoRentHeader."Client No.") then
                        ClientName := Customer.Name;
                    LineAmount := CalculateHeaderAmount(AutoRentHeader);



                end;

                trigger OnPreDataItem()
                begin

                    AutoRentHeader.SetFilter("Reserved From", '>=%1', StartDate);
                    AutoRentHeader.SetFilter("Reserved To", '<=%1', EndDateReq);
                    AutoRentHeader.SetCurrentKey("Reserved From");
                    AutoRentHeader.SetAscending("Reserved From", true);
                    TotalAutoRentAmount := CalculateTotalRentAmount(AutoRentHeader);
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
        TotalAutoRentAmountLbl = 'Total Amount';
    }
    var
        ClientName: Text[100];
        LineAmount: Decimal;
        TotalAutoRentAmount: Decimal;
        AmountTemp: Decimal;
        StartDate: DateTime;
        EndDateReq: DateTime;

    procedure CalculateHeaderAmount(var RentHeader: Record "Auto Rent Header"): Decimal
    var
        RentLine: Record "Auto Rent Line";
        Amount: Decimal;
    begin
        RentLine.SetRange("No.", RentHeader."No.");
        if RentLine.FindSet() then
            repeat begin
                Amount += RentLine."Final price";
            end until RentLine.Next() = 0;
        exit(Amount);
    end;

    procedure CalculateTotalRentAmount(var RentHeaders: Record "Auto Rent Header"): Decimal
    var
        Amount: Decimal;
    begin
        repeat begin
            Amount += CalculateHeaderAmount(RentHeaders);
        end until RentHeaders.Next() = 0;
        exit(Amount);
    end;
}