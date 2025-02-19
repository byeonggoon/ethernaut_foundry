# Ethernaut Foundry로 풀기

## 13.Gatekeeper One ***

조건이 3개가 있어서 그걸 모두 통과해야한다.

1. gateOne -> 컨트랙트로 실행

2. gateTwo -> gasleft() % 8191 == 0
   => 이거는 call을 통해서 트랜잭션날릴때 가스비 설정할수있어서 그걸로 해결

3. gateThree -> 내주소를 형변환한것과 인자로 들어오는것이 같아야하는데
   조건이 세가지라서 하나씩 뜯어봐야함

```
 modifier gateThree(bytes8 _gateKey) {
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
        _;
    }
```

여기서 require이 세가지니까 하니씩 뜯어보면
`uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)`
gateKey 가 0xA1A2A3A4A5A6A7A8 이라고 가정하면

`console.log(toHexString(uint32(uint64(0xA1A2A3A4A5A6A7A8))));
console.log(toHexString(uint16(uint64(0xA1A2A3A4A5A6A7A8))));`
이렇게 했을때

```
  0x00000000000000000000000000000000000000000000000000000000a5a6a7a8
  0x000000000000000000000000000000000000000000000000000000000000a7a8
```

가 나오는데 두개가 같아야하니까 a5a6자리는 0000이 와야한다.

gateKey 가 0xA1A2A3A40000A7A8 우선 이렇게.

그리고

```
uint32(uint64(_gateKey)) != uint64(_gateKey)
```

에서

```
  0x000000000000000000000000000000000000000000000000000000000000a7a8
  0x000000000000000000000000000000000000000000000000a1a2a3a40000a7a8
```

이렇게 나오니까 a1a2a3a4자리는 0이 아니고 아무거나 들어오면 된다.

gateKey 가 0xA1A2A3A40000a7a8 우선 이렇게.

마지막

```
uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)
=>
 0x000000000000000000000000000000000000000000000000000000000000a7a8
 0x0000000000000000000000000000000000000000000000000000000000001f38
```

저게 같아야하니까 마지막은 이 들어가서

gateKey 가 0xCCCCCCCC00001f38 이런식이된다.

이게 자꾸 안되길래 왜그런가 했는데..

```
(bool success, ) = address(gatekeeperOne).call{gas: i + (8191 * 3)}(
  abi.encodeWithSignature("enter(bytes8)", bytes8(0xCCCCCCCC00001f38))
);
```

값을 넣어줄때 `0xCCCCCCCC00001f38` 이렇게만 넣어주니까 에러가 뜨고 `bytes8(0xCCCCCCCC00001f38))` 이렇게 감싸서 넣어줘야한다.
