page 50106 "Auto Card"
{
    Caption = 'Auto Card';
    PageType = Card;
    UsageCategory = None;
    SourceTable = Auto;

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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto Name.';
                }
                field(Mark; Rec.Mark)
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto mark dropdown.';
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto model dropdown.';
                }
                field("Year of manufacture"; Rec."Year of manufacture")
                {
                    ApplicationArea = All;
                    ToolTip = 'Year of manufacture.';
                }
                field("Insurance validity"; Rec."Insurance validity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date of insurance expiration.';
                }
                field("TI End"; Rec."TI End")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date of TI expiration.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto location';
                }
                field("Rent Service"; Rec."Rent Service")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto provided service.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Rent Price"; Rec."Rent Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Provided service price.';
                }
            }
        }


    }
    actions
    {
        area(Processing)
        {
            action("Reserve Auto")
            {
                RunObject = page "Auto Reservation List";
                RunPageLink = "Auto No." = field("No.");
                Image = LinesFromJob;
                Promoted = true;
            }

            action("Valid Reservations")
            {
                RunObject = page "Valid reservation";
                RunPageLink = "Auto No." = field("No.");
                Image = CompleteLine;
                Promoted = true;
            }

            action("Auto Damage List")
            {
                Caption = 'Auto Damage List';
                ApplicationArea = All;
                Image = List;

                trigger OnAction()
                var
                    AutoDamage: Record "Auto Damage";
                begin
                    AutoDamage.SetRange("Auto No.", Rec."No.");
                    Page.RunModal(0, AutoDamage);
                end;
            }

            action("Print History")
            {
                Caption = 'Print History';
                ApplicationArea = All;
                Image = Print;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    Report.RunModal(50101, true, true, Rec);
                end;
            }
        }

    }
}