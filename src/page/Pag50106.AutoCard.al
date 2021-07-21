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
                }
                field(Mark; Rec.Mark)
                {
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field("Year of manufacture"; Rec."Year of manufacture")
                {
                    ApplicationArea = All;
                }
                field("Insurance validity"; Rec."Insurance validity")
                {
                    ApplicationArea = All;
                }
                field("TI End"; Rec."TI End")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Rent Service"; Rec."Rent Service")
                {
                    ApplicationArea = All;
                }
                field("Rent Price"; Rec."Rent Price")
                {
                    ApplicationArea = All;
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

            action("Open Auto Damage List")
            {
                Caption = 'Open Auto Damage List';
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
        }

    }
}