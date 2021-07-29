codeunit 50104 "Field Color Management"
{
    procedure ChangeStatusColor(Status: Text): Text[20]
    begin
        case Status of
            'Relevant':
                exit('unfavorable');
            'Resolved':
                exit('favorable');
            'Open':
                exit('unfavorable');
            'Issued':
                exit('favorable');
        end;
    end;
}