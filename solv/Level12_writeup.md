# Ethernaut Foundry로 풀기

## 12. Privacy

storage에 어떻게 들어가있나 체크하면 되는 문제

`bytes32 value1 = vm.load(address(privacy), bytes32(uint256(0)));`
foundry에서 제공하는 vm.load이용해서 해당 스토리지에 있는 key를 찾아서 넣으면 해결
