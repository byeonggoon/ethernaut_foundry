# Ethernaut Foundry로 풀기

## 08.Vault

private타입으로 되어있는거 불러오면 되는 것.
ethers,web3에도 있는데 foundry에도

```
bytes32 password = vm.load(address(vaultInstance), bytes32(uint256(1)));
```

같은게 있어서 편하다.
