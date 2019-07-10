defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  use GenServer
  @opaque account :: pid
  @account_closed {:error, :account_closed}

  @doc """
  Open the bank. Makes the account available.
  """
  def init(_) do
    {:ok, 0}
  end

  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = GenServer.start(BankAccount, 0)
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    GenServer.call(account, :getbalance)
  catch
    :exit, _reason -> @account_closed
  end

  def handle_call(:getbalance, _from, balance) do
    {:reply, balance, balance}
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    balance = balance(account)

    if balance == @account_closed do
      @account_closed
    else
      GenServer.cast(account, {:putbalance, balance + amount})
    end
  end

  def handle_cast({:putbalance, new_balance}, _balance) do
    {:noreply, new_balance}
  end
end
