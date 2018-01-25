defmodule OAuth2.Provider.ChatWork do
  @moduledoc """
  OAuth2 ChatWork Provider

  Based on:

      chatwork.com/scrogson/oauth2

  Add `client_id` and `client_secret` to your configuration:

      config :oauth2_chatwork, OAuth2.Provider.ChatWork,
        client_id: System.get_env("CHATWORK_CLIENT_ID"),
        client_secret: System.get_env("CHATWORK_CLIENT_SECRET")
  """
  use OAuth2.Strategy

  @client_defaults [
    strategy: __MODULE__,
    site: "http://developer.chatwork.com/ja/oauth.html",
    authorize_url: "https://www.chatwork.com/packages/oauth2/login.php",
    token_url: "https://oauth.chatwork.com/token"
  ]

  @doc """
  Construct a client for requests to ChatWork.
  This will be setup automatically for you in `Ueberauth.Strategy.ChatWork`.
  These options are only useful for usage outside the normal callback phase
  of Ueberauth.
  """
  def client(opts \\ []) do
    opts =
      @client_defaults
      |> Keyword.merge(config())
      |> Keyword.merge(opts)

    OAuth2.Client.new(opts)
  end

  @doc """
  Provides the authorize url for the request phase.
  """
  def authorize_url!(params \\ [], opts \\ []) do
    opts
    |> client
    |> OAuth2.Client.authorize_url!(params)
  end

  @doc """
  Returns an OAuth2.Client with token.
  """
  def get_token!(params \\ [], opts \\ []) do
    headers = Keyword.get(opts, :headers, [])
    options = Keyword.get(opts, :options, [])

    opts
    |> client
    |> OAuth2.Client.get_token!(params, headers, options)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_param(:client_secret, client.client_secret)
    |> put_header("Accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end

  # Helpers

  defp config do
    Application.fetch_env!(:oauth2_chatwork, OAuth2.Provider.ChatWork)
    |> check_config_key_exists(:client_id)
    |> check_config_key_exists(:client_secret)
  end

  defp check_config_key_exists(config, key) when is_list(config) do
    unless Keyword.has_key?(config, key) do
      raise "#{inspect(key)} missing from config :oauth2_chatwork, OAuth2.Provider.ChatWork"
    end

    config
  end

  defp check_config_key_exists(_, _) do
    raise "Config :oauth2_chatwork, OAuth2.Provider.ChatWork is not a keyword list, as expected"
  end
end
