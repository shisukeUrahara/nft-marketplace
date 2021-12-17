// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './interfaces/IERC165.sol';

contract ERC165 is IERC165 {
// hash table to keep track of contract fingerprint data
mapping(bytes4=>bool) private _supportInterfaces;

// constructor 
constructor(){
    _registerHashFingerPrint(0x01ffc9a7);
}

// functions 
function supportsInterface(bytes4 interfaceId) external override view returns(bool){
    return _supportInterfaces[interfaceId];
}

// function to register hash fingerprint for the contract 
function _registerHashFingerPrint(bytes4 interfaceId) internal  {
    require(interfaceId!=0xffffffff,'ERC165: Invalid interface');
    _supportInterfaces[interfaceId]=true;
}

}