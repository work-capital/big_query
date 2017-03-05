defmodule BigQueryTest do
  use ExUnit.Case
  doctest BigQuery

  test "big query" do
    project_id   = Application.get_env(:big_query, :project_id)
    view         = Application.get_env(:big_query, :view)
    uuid         = Application.get_env(:big_query, :uuid)
    query_string = "SELECT * FROM [" <> project_id <> ":" <> view <> "] WHERE uuid = '" <> uuid <> "'"
    query =  %BigQuery.Types.Query{query: query_string, timeoutMs: 1000*120}
    {:ok, %BigQuery.Types.QueryResultsResponse{rows: [res | _]}} = BigQuery.Job.query(project_id, query)
    %BigQuery.Types.QueryResultRow{f: [_, %BigQuery.Types.QueryResultCell{v: uuid_res} | _]} = res

    assert uuid_res == uuid
  end
end
