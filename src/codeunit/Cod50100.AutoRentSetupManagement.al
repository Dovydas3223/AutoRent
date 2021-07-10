codeunit 50100 "Auto Rent Setup Management"
{
    procedure NewNoSeries(NoSeriesCode: Code[20]; NoSeriesDescription: Text; NoSeriesFirstNo: Code[20]): Code[20]
    var
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
    begin
        if NoSeries.Get(NoSeriesCode) then
            exit(NoSeriesCode);
        NoSeries.Init();
        NoSeries.Code := NoSeriesCode;
        NoSeries.Description := CopyStr(NoSeriesDescription, 1, MaxStrLen(NoSeries.Description));
        NoSeries."Default Nos." := true;
        NoSeries.Insert();

        NoSeriesLine.Init();
        NoSeriesLine."Series Code" := NoSeriesCode;
        NoSeriesLine."Line No." := 10000;
        NoSeriesLine.Validate("Starting No.", NoSeriesFirstNo);
        NoSeriesLine.Insert();
        exit(NoSeriesCode);
    end;
}