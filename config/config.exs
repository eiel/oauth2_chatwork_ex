use Mix.Config

config :logger, level: :info

config :oauth2_chatwork, OAuth2.Provider.ChatWork,
  client_id: System.get_env("CHATWORK_CLIENT_ID"),
  client_secret: System.get_env("CHATWORK_CLIENT_SECRET")
