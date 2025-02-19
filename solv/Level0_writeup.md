# Ethernaut Foundry로 풀기

## 00.Hello Ethernaut

[참조](https://medium.com/@JohnnyTime/ethernaut-foundry-solutions-2023-how-to-start-challenge-0-solution-3dbe243168c4)해서 시작

forge script script/Level0Solution.s.sol --broadcast
를 했는데 안되어서 확인해보니 컨트랙트 이름을 Instance -> Level0으로 수정해야했었고

[solution github](https://github.com/RealJohnnyTime/ethernaut-foundry-solutions-johnnytime) 에 있는 foundry.toml 과 .gitmodules를 가져와야한다.

순서는

1. ethernaut에서 문제를 생성하고 주소를 가져와서
2. foundry를 통해서 트랜잭션을 실행시킨 후
3. 가서 확인 트랜잭션을 날리면된다.
