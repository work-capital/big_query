defmodule BigQueryTest do
  use ExUnit.Case
  doctest BigQuery

  test "big query" do
    project_id = "work-capital-data-analysis"
    query_string = "SELECT * FROM [work-capital-data-analysis:ProductionViews.OMIE_DECISION] WHERE uuid = 'a9382faffc2c0b24b028c47f4c3b17b5'"
    query =  %BigQuery.Types.Query{query: query_string, timeoutMs: 1000*120}
    {:ok, %BigQuery.Types.QueryResultsResponse{rows: [res | _]}} = BigQuery.Job.query(project_id, query)
    %BigQuery.Types.QueryResultRow{f: [_, %BigQuery.Types.QueryResultCell{v: uuid} | _]} = res

    assert uuid == "a9382faffc2c0b24b028c47f4c3b17b5"
  end
end
