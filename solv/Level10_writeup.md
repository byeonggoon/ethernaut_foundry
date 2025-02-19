# Ethernaut Foundry로 풀기

## 10.Reentrancy

![Level10설명](../img/Level10.png)

코드를 보면 `withdraw`함수에 `call`을 통해서 ether를 보내는 곳이 있는데
받는 주소가 컨트랙트이고 그 컨트랙트에 receive함수를 통해서 다른 동작을 실행할 수 있게한다면
재진입이 가능하다.

컨트랙트 안에는 0.001ETH가 있다. 그걸 빼고 받으면 끝
