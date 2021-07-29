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
            column(RentAmount; RentAmount)
            {
            }
            column(TotalServiceAmount; TotalServiceAmount)
            {
            }

            column(TotalRentAndServiceAmount; TotalRentAndServiceAmount)
            {
            }
            dataitem(AutoRentLine; "Auto Rent Line")
            {
                DataItemTableView = sorting("Line No.");
                DataItemLink = "No." = field("No.");

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

                trigger OnPreDataItem()
                begin
                    if AutoRentLine.FindSet() then
                        repeat begin
                            TotalServiceAmount += AutoRentLine."Final price";
                        end until AutoRentLine.Next() = 0;
                end;
            }
            dataitem(Auto; Auto)
            {
                DataItemLink = "No." = field("Auto No.");
                column(Mark; Mark)
                {
                    IncludeCaption = true;
                }
                column(Model; Model)
                {
                    IncludeCaption = true;
                }


            }


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
        Total_Service_Caption = 'Service Amount';

        Rent_Amount_Caption = 'Auto Rent Amount';
        Rent_Service_Amount_Caption = 'Rent And Service Amount';
    }

    var
        TotalServiceAmount: Decimal;
        RentAmount: Decimal;
        TotalRentAndServiceAmount: Decimal;


}