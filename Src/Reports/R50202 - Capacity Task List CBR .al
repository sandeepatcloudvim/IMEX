report 50202 "Capacity Task List CBR"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CapacityTaskList.rdl';
    ApplicationArea = Manufacturing;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Prod. Order Routing Line"; "Prod. Order Routing Line")
        {
            DataItemTableView = SORTING(Type, "No.");
            RequestFilterFields = Type, "No.", Status, "Starting Date";
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(PORtngLineTableCaptFilter; TableCaption + ':' + ProdOrderRtngLineFilter)
            {
            }
            column(ProdOrderRtngLineFilter; ProdOrderRtngLineFilter)
            {
            }
            column(Type_ProdOrderRtngLine; Type)
            {
            }
            column(No_ProdOrderRtngLine; "No.")
            {
            }
            column(PONo_ProdOrderRtngLine; "Prod. Order No.")
            {
                IncludeCaption = true;
            }
            column(RtngNo_ProdOrderRtngLine; "Routing No.")
            {
                IncludeCaption = true;
            }
            column(OPNo_ProdOrderRtngLine; "Operation No.")
            {
                IncludeCaption = true;
            }
            column(Desc_ProdOrderRtngLine; Description)
            {
                IncludeCaption = true;
            }
            column(InptQty_ProdOrderRtngLine; "Input Quantity")
            {
                IncludeCaption = true;
            }
            column(StrtTm_ProdOrderRtngLine; "Starting Time")
            {
                IncludeCaption = true;
            }
            column(StrtDt_ProdOrderRtngLine; Format("Starting Date"))
            {
            }
            column(EndTime_ProdOrderRtngLine; "Ending Time")
            {
                IncludeCaption = true;
            }
            column(EndDate_ProdOrderRtngLine; Format("Ending Date"))
            {
            }
            column(CapacityTaskListCapt; CapacityTaskListCaptLbl)
            {
            }
            column(CurrReportPageNoCapt; CurrReportPageNoCaptLbl)
            {
            }
            column(ProdOrderRtngLnStrtDtCapt; ProdOrderRtngLnStrtDtCaptLbl)
            {
            }
            column(ProdOrderRtngLnEndDtCapt; ProdOrderRtngLnEndDtCaptLbl)
            {
            }
            column(FinishedQuantity; FinishedQuantity)
            {

            }
            column(RemainingQuantity; RemainingQuantity)
            {

            }
            column(SourceNo; ProductionOrder."Source No.")
            {

            }
            column(Description; ProductionOrder.Description)
            {

            }

            trigger OnAfterGetRecord()
            begin
                if (Status = Status::Finished) or ("Routing Status" = "Routing Status"::Finished) then
                    CurrReport.Skip();


                ProdOrderLine.Reset();
                ProdOrderLine.SetRange(Status, ProdOrderLine.Status::Released);
                ProdOrderLine.SetRange("Prod. Order No.", "Prod. Order No.");
                if ProdOrderLine.FindFirst() then begin
                    FinishedQuantity := ProdOrderLine."Finished Quantity";
                    RemainingQuantity := ProdOrderLine."Remaining Quantity";
                end;

                ProductionOrder.reset();
                ProductionOrder.SetRange("No.", "Prod. Order No.");
                if ProductionOrder.FindFirst() then;
            end;

            trigger OnPreDataItem()
            begin
                ProdOrderRtngLineFilter := GetFilters;
                FinishedQuantity := 0;
                RemainingQuantity := 0;

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ProdOrderRtngLineFilter: Text;
        ProductionOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        FinishedQuantity: Decimal;
        RemainingQuantity: Decimal;
        CapacityTaskListCaptLbl: Label 'Capacity Task List';
        CurrReportPageNoCaptLbl: Label 'Page';
        ProdOrderRtngLnStrtDtCaptLbl: Label 'Starting Date';
        ProdOrderRtngLnEndDtCaptLbl: Label 'Ending Date';
}

