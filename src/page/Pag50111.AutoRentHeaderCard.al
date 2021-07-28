page 50111 "Auto Rent Header Card"
{
    Caption = 'Auto Rent Header Card';
    PageType = Document;
    UsageCategory = None;
    SourceTable = "Auto Rent Header";
    PromotedActionCategories = 'New,Process,Report,Manage,Contract Status,Return Car';


    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = Rec.Status = Rec.Status::Open;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto rent document No.';

                    trigger OnAssistEdit()
                    begin
                        if Rec."No." = '' then
                            Rec."No." := Rec.GetAutoNoFromNoSeries();
                    end;
                }
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;

                    ToolTip = 'Auto rent document client No.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;

                    ToolTip = 'Date of document filing.';
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;

                    ToolTip = 'Renting auto No.';

                    trigger OnValidate()
                    var
                        AutoRentLine: Record "Auto Rent Line";
                    begin
                        if Rec."Auto No." <> xRec."Auto No." then
                            AutoRentLine.InsertFirst(Rec);
                    end;

                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ApplicationArea = All;

                    ToolTip = 'Valid reservation start.';

                    trigger OnAssistEdit()
                    begin
                        Rec.OpenReservationlist();

                    end;

                    trigger OnValidate()
                    begin

                    end;
                }
                field("Reserved To"; Rec."Reserved To")
                {
                    ApplicationArea = All;

                    ToolTip = 'Valid reservation end.';
                }
                field("Price"; Rec."Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto rent price.';
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto rent document status.';
                }

            }
            part(AutoRentLineListPart; "Auto Rent Line ListPart")
            {
                Caption = 'Auto Rent Lines';
                Editable = Rec.Status = Rec.Status::Open;
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
                UpdatePropagation = Both;
            }
        }
        area(FactBoxes)
        {
            part(DriverLicense; "Driver License")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
                Editable = Rec."Auto No." <> '';
                Enabled = Rec."Auto No." <> '';
            }
        }
    }
    actions
    {

        area(Processing)
        {
            action("Issue Contract")
            {
                Caption = 'Issue Contract';
                ApplicationArea = All;
                Enabled = rec."Status" <> rec."Status"::Issued;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ContractStatusManager: Codeunit "Contract Status Manager";
                    ItemTransferMngmt: Codeunit ItemTransferManagement;
                begin
                    ContractStatusManager.PerformManualRelease(Rec);
                    CurrPage.Update(true);
                    ItemTransferMngmt.TransferItemsToAutoWarehouse(Rec);
                end;
            }
            action("Open Contract")
            {
                Caption = 'Open Contract';
                ApplicationArea = All;
                Enabled = rec."Status" <> rec."Status"::Open;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ContractStatusManager: Codeunit "Contract Status Manager";
                begin
                    ContractStatusManager.PerformManualOpen(Rec);
                    CurrPage.Update(true);
                end;
            }

            action("Return Car")
            {
                Caption = 'Return Car';
                ApplicationArea = All;
                Image = Return;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    CarReturnMgmt: Codeunit "Car Return Management";
                    ItemTransferMngmt: Codeunit ItemTransferManagement;
                begin
                    ItemTransferMngmt.ReturnItemsFromAutoWarehouse(Rec);
                    // CarReturnMgmt.ReturnCar(Rec);
                end;
            }
            action("Auto Damage")
            {
                Caption = 'Auto Damage';
                ApplicationArea = All;
                Image = Edit;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    AutoRentDamage: Record "Auto Rent Damage";
                begin
                    AutoRentDamage.SetRange("No.", Rec."No.");
                    Page.RunModal(0, AutoRentDamage);
                end;

            }

            action("Print Card")
            {
                Caption = 'Print Card';
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    Report.RunModal(50100, true, true, Rec);
                end;
            }


        }
    }


}