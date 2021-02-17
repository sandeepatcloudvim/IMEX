codeunit 50400 ExtendEvents
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, database::"Production BOM Line", 'OnValidateNoOnAfterAssignItemFields', '', true, true)]
    local procedure InsertProdBOMLine(VAR ProductionBOMLine: Record "Production BOM Line"; Item: Record Item; VAR xProductionBOMLine: Record "Production BOM Line"; CallingFieldNo: Integer)
    begin
        ProductionBOMLine."Unit Cost" := Item."Unit Cost";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Capacity Task List" then
            NewReportId := Report::"Capacity Task List CBR";
    end;

}