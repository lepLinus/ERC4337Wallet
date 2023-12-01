# BatchedWallet

## Overview

The BatchedWallet is a simple implementation of the erc4337 standart.
It allows to batch transactions, and includes requiered functions to use "Entrypoints".

Entrypoints are contracts that are deployed on each chain onces, and should be used by all erc4337 wallets.
Read more at: ["https://www.erc4337.io/docs/understanding-ERC-4337/entry-point-contract"]

## Functions

### State Chaning functions

`execute(dest,value,func)` executes call on dest with provided value and data.

`executeBatch(dest[],value[],func[])` executes multiple calls from this account. Caller needs to be entryPoint or owner.

`initialize()` Initializes this contract.

`addDeposit()` deposits msg.value to entrypoint.

`withdrawDepositTo(withdrawAddress,amount)` withdraws amount to withdrawAddress from entrypoint. Caller needs to be owner.


### View Functions

`entryPoint()` returns the EntryPoint of this wallet.

`_onlyOwner()` returns true if msg.sender is owner or the wallet itself (self call).

`_requireFromEntryPointOrOwner()` returns true if msg.sender is owner or the entryPoint.

`getDeposit()` returns amount deposited to entryPoint.

## Modifer

`onlyOwner()` modifer allows for accses controll, only the owner of this contract can call functions using this modifer.

## State

`address public owner;` the address of the contract owner.

`IEntryPoint private immutable _entryPoint;` the address of the entrypoint, this can not be changed after set!