# Ethernaut Foundry로 풀기

## 11.Elevator

`top`에 도달하면 된다.

여기서 중요한것은 Elevator컨트랙트에 있는 `goTo()`에서
`Building(msg.sender)`이 부분이 중요하다.

`goTo()`를 실행하는 msg.sender가 컨트랙트가 되면 그 컨트랙트의 isLastFloor를 사용하기 때문이다.
