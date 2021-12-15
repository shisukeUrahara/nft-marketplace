// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract ERC721Metadata{
    // state variables
    string private _name;
    string private _symbol;

    // constructor
    constructor(string memory initName,string memory initSymbol) {
        _name=initName;
        _symbol=initSymbol;
    }

    // functions 
    function name() external view returns(string memory){
        return _name;
    }

      function symbol() external view returns(string memory){
        return _symbol;
    }
}