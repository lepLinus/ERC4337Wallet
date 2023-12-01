# Foundery Tests

## BatchedWallet unit tests

### test_BatchETHTransfer

This is a simple test to show how batch transfer works.
It transfers 3 wei of ETH to the batchWallet, and sends these in 2 transactions back to the test.

### test_ETHTransfer

This is a simple test to show how ETH transfer works.
It transfers 1 wei of ETH to the batchWallet, and sends it back to the test.

### test_tokenTransfer

This is a simple test to show how Token transfer works.
It transfers 10 wei of MockERC20 to the batchWallet, and sends it back to the test.

## BatchedWallet invarient tests

### test_revertOnDifferentArraySizeTest

This test show that when batch transfer is called with different array size the transactio reverts.