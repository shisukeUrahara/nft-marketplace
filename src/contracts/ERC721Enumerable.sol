// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is ERC721,IERC721Enumerable {
    // array to store all tokens 
    uint256[] private _allTokens;

    // mapping to map tokenId to index in _allTokens 
    mapping(uint256=>uint256) private _allTokensIndex;

    // mapping of owner to list all owner tokens 
    mapping(address=>uint256[]) private _ownedTokens;

    // mapping from tokenId to index of owner's token list
    mapping(uint256=>uint256) private _ownedTokensIndex;


    // CONSTRUCTOR 
    constructor(){
  _registerHashFingerPrint(bytes4(keccak256('totalSupply(bytes4)')^(keccak256('tokenByIndex(bytes4)')^(keccak256('tokenOfOwnerByIndex(bytes4)')))));
}


    // function tokenByIndex(uint256 _index) external view returns (uint256);

  
    // function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256);

    // MINT FUNCTION 
   function _mint(address _to,uint256 _tokenId) internal override(ERC721){
       super._mint(_to,_tokenId);
       _addTokensToAllTokenEnumeration(_tokenId);
       _addTokensToOwnerEnumeration(_to,_tokenId);
   } 

// add new token to _allTokens array and save up its index position too
   function _addTokensToAllTokenEnumeration(uint256 _tokenId) private {
       _allTokensIndex[_tokenId]= _allTokens.length;
        _allTokens.push(_tokenId);
   }

   // add new token to owner details 
   function _addTokensToOwnerEnumeration(address _to,uint256 _tokenId) private {
       _ownedTokensIndex[_tokenId] = _ownedTokens[_to].length;
       _ownedTokens[_to].push(_tokenId);

   }

   function totalSupply() public view override returns(uint256) {
       return _allTokens.length;
   }

   function tokenByIndex(uint256 index) public view override returns(uint256){
       require(index<totalSupply(),'Global index out of bounds.');
       return _allTokens[index];
   }

   function tokenOfOwnerByIndex(address to,uint256 index) public view override returns(uint256){
       require(index<balanceOf(to),'Owner index out of bounds.');
       return _ownedTokens[to][index];
   }

}