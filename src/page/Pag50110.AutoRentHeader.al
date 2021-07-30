page 50110 "Auto Rent Header"
{
    Caption = 'Auto Rent Header List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Auto Rent Header Card";
    SourceTable = "Auto Rent Header";
    PromotedActionCategories = 'New,Process,Report,Manage,Contract Status';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto rent document No.';
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
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valid reservation start.';
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
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    ToolTip = 'Auto rent document status.';
                }


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
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = rec."Status" <> rec."Status"::Issued;

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
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = rec."Status" <> rec."Status"::Open;

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
                    AutoDamageConfirmLbl: Label 'Is auto rent damage filled in?';
                begin
                    if Confirm(AutoDamageConfirmLbl) then begin
                        ItemTransferMngmt.ReturnItemsFromAutoWarehouse(Rec);
                        CarReturnMgmt.ReturnCar(Rec);
                    end;

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
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    Report.RunModal(50100, true, true, Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        StyleExprTxt := FieldColorMngmt.ChangeStatusColor(Format(Rec.Status));
    end;

    var
        FieldColorMngmt: Codeunit "Field Color Management";
        StyleExprTxt: Text[20];
}