// SPDX-License-Identifier: MIT
// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
import './ERC721Connector.sol';

contract KryptoBird is ERC721Connector{

    // state variables
    string[] public kryptoBirdz;
    mapping(string=>bool) private _kryptoBirdzExists;

    // events   




    // constructor 
    constructor() ERC721Connector("KryptoBirdz","KBIRDZ"){
    }


    // functions    
    function mint(string memory kryptoBird) public {
        require(!_kryptoBirdzExists[kryptoBird],'KryptoBird Already exists.');
        uint256 id= kryptoBirdz.length;
        kryptoBirdz.push(kryptoBird);
        _mint(msg.sender,id);
        _kryptoBirdzExists[kryptoBird]=true;
    }


}

