defmodule MonobolyDealWeb.Presence do
  use Phoenix.Presence,
    otp_app: :monoboly_deal,
    pubsub_server: MonobolyDeal.PubSub
end
