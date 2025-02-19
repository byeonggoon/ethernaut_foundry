# Ethernaut Foundry로 풀기

## 02.Fallout

똑같이 실행하려했는데 Fallout은 솔리디티버전이 0.6.0.
수정이 필요하다.

Fallout이 컨트랙트 이름이고
construct는 Fal1out으로 다르다. 그렇기때문에 오너설정이 아직 안되어있음
그것만해주면 해결된다.

\*\* 에러처리
openzeppelin에서 solidity 0.6버전을 지원하는것을 받으면
lib폴더에 생기는데 그거 이름을 openzeppelin-contracts-06 으로 바꿔야한다.

//forge script script/Level2Solution.s.sol --broadcast
