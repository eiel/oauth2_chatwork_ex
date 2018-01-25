# OAuth2 ChatWork

> A ChatWork OAuth2 Provider for Elixir

[![Build Status](https://travis-ci.org/eiel/oauth2_chatwork.svg?branch=master)](https://travis-ci.org/eiel/oauth2_chatwork)

OAuth2 ChatWork is convenience library built on top of [`oauth2`](https://hex.pm/packages/oauth2). It adds ChatWork specific functions to interact with ChatWork endpoints using OAuth2.

## Installation

```elixir
# mix.exs

def application do
  # Add the application to your list of applications.
  # This will ensure that it will be included in a release.
  [applications: [:logger, :oauth2_chatwork]]
end

defp deps do
  # Add the dependency
  [{:oauth2_chatwork, "~> 0.1"}]
end
```
