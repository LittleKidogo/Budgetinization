defmodule SpenderWeb.ApiCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection working
  on the API endpoints

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common datastructures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import SpenderWeb.Router.Helpers
      alias Spender.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Spender.ModelCase
      import Spender.Factories

    

      # The default endpoint for testing
      @endpoint SpenderWeb.Endpoint
    end
  end


  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Spender.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Spender.Repo, {:shared, self()})
    end
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

end