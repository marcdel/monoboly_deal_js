defmodule MonobolyDealWeb.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use MonobolyDealWeb.ConnCase
      use PhoenixIntegration
    end
  end
end
