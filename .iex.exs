global_settings = "~/.iex.exs"
if File.exists?(global_settings), do: Code.require_file(global_settings)

import Ecto.{Changeset, Query}

alias MonobolyDeal.Repo
alias MonobolyDealWeb.Router.Helpers, as: Routes
