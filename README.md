# ERC4337Wallet

## Overview

To read more about the different ideas why and why not to use erc4337 visit:
[Design](Docs/Design.md)  

To read the technical documentation of BatchedWallet visit:
[Docs](Docs/BatchedWallet.md)

To read about the different test cases visit:
[Tests](Docs/Test.md)

This project uses foundry, to read about setup and tests go to [Setup](/ERC4337Wallet/README.md). 

## Important!!!

These contracts are not audited and are not intended to be deployed on any network.
These contracts are part of erc4337. This implemenation is only a demo of a simple wallet.

If you still want to use these contracts make sure to call init in the same transaction as deployment to set owner.
Otherwise there is risk of being frontrun. The damage in any case will be minimal (just redeploy) but keep this in mind.
