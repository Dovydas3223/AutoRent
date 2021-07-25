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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec."No." = '' then
                            Rec."No." := Rec.GetAutoNoFromNoSeries();
                    end;
                }
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;

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
                    Editable = IsEditable;
                }
                field("Reserved To"; Rec."Reserved To")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                }
                field("Price"; Rec."Price")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }

            }
            part(AutoRentLineListPart; "Auto Rent Line ListPart")
            {
                Caption = 'Auto Rent Lines';
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
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
                UpdatePropagation = Both;

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
                begin
                    ContractStatusManager.PerformManualRelease(Rec);
                    IsEditable := Rec.TestStatusOpen();
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
                    IsEditable := Rec.TestStatusOpen();
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
                begin
                    CarReturnMgmt.ReturnCar(Rec);
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

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Issued then
            CurrPage.Editable(false)
        else
            IsEditable := true;
    end;

    var
        IsEditable: Boolean;
        cust: Record Customer;
}