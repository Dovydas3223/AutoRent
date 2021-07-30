report 50100 "Auto Rental Card"
{

    Caption = 'Auto Rental Card';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/reportlayouts/R50100.rdl';

    dataset
    {

        dataitem(AutoRentHeader; "Auto Rent Header")
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {
                IncludeCaption = true;
            }
            column(AutoNo_AutoRentHeader; "Auto No.")
            {
                IncludeCaption = true;
            }
            column(ClientNo_AutoRentHeader; "Client No.")
            {
                IncludeCaption = true;
            }
            column(Price_AutoRentHeader; Price)
            {
                IncludeCaption = true;
            }
            column(ReservedFrom_AutoRentHeader; "Reserved From")
            {
                IncludeCaption = true;
            }
            column(ReservedTo_AutoRentHeader; "Reserved To")
            {
                IncludeCaption = true;
            }

            column(TotalRentAndServiceAmount; TotalRentAndServiceAmount)
            {
            }
            column(TotalServiceAmount; TotalServiceAmount)
            {
            }
            column(RentAmount; RentAmount)
            {
            }
            dataitem(Auto; Auto)
            {
                DataItemLink = "No." = field("Auto No.");
                column(Mark_Auto; Mark)
                {
                    IncludeCaption = true;
                }
                column(Model_Auto; Model)
                {
                    IncludeCaption = true;
                }
            }

            dataitem(AutoRentLine; "Auto Rent Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("Line No.");

                column("Type"; "Type")
                {
                    IncludeCaption = true;
                }
                column(Type_No_; "Type No.")
                {
                    IncludeCaption = true;
                }
                column(Type_Description; "Type Description")
                {
                    IncludeCaption = true;
                }
                column(Unit; Unit)
                {
                    IncludeCaption = true;
                }
                column(Quantity; Quantity)
                {
                    IncludeCaption = true;
                }
                column(Unit_price; "Unit price")
                {
                    IncludeCaption = true;
                }
                column(Final_price; "Final price")
                {
                    IncludeCaption = true;
                }
            }

            trigger OnAfterGetRecord()
            begin
                CalculateAmounts(AutoRentHeader);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    Caption = 'Options';

                }
            }
        }
    }


    Labels
    {
        ReportOfAutoRentCardLbl = 'Auto Rent Card Report';
        Total_Service_Caption = 'Total Service Amount';
        Rent_Amount_Caption = 'Auto Rent Amount';
        Rent_Service_Amount_Caption = 'Rent And Service Amount';
    }

    var
        TotalServiceAmount: Decimal;
        RentAmount: Decimal;
        TotalRentAndServiceAmount: Decimal;


    procedure CalculateAmounts(var RentHeader: Record "Auto Rent Header")
    var
        RentLines: Record "Auto Rent Line";
    begin
        RentLines.SetRange("No.", RentHeader."No.");
        if RentLines.FindSet() then
            repeat begin
                if RentLines."Is First" then begin
                    RentAmount := RentLines.Quantity * RentLines."Unit price";
                end;
                if (RentLines.Type = RentLines.Type::Resource) and (not RentLines."Is First") then
                    TotalServiceAmount += RentLines.Quantity * RentLines."Unit price";
            end until RentLines.Next() = 0;
        TotalRentAndServiceAmount := RentAmount + TotalServiceAmount;

    end;

}