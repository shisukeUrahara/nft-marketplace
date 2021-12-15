// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract ERC721 {
    // state variables
    mapping(uint256=>address) private _tokenOwner;
    mapping(address=>uint256) private _ownedTokensCount;

    // events 
    event Transfer(address from,address to,uint256 tokenId);


    // constructor 


   // functions     
  function balanceOf(address _owner) public view returns(uint256) {
       require(_owner!=address(0),'ERC721: _owner cannot be zero address');
       return _ownedTokensCount[_owner];
   }

   function ownerOf(uint256 _tokenId) public view returns(address) {
       require(_tokenOwner[_tokenId]!=address(0),'ERC721: Token doesnot exists');
       return _tokenOwner[_tokenId];
   }

   function _mint(address _to,uint256 _tokenId) internal  virtual{
       require(_to!=address(0),'ERC721: Invalid mint address');
       require(_tokenOwner[_tokenId]==address(0),'ERC721: Token Already minted');
       _tokenOwner[_tokenId] = _to;
       _ownedTokensCount[_to]++;
       emit Transfer(address(0), _to, _tokenId);
   }

       /// @notice Transfer ownership of an NFT 
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer

    // this is not safe! 
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        require(_to != address(0), 'Error - ERC721 Transfer to the zero address');
        require(ownerOf(_tokenId) == _from, 'Trying to transfer a token the address does not own!');

        _ownedTokensCount[_from]--;
        _ownedTokensCount[_to]++;

        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId)  public {
        // require(isApprovedOrOwner(msg.sender, _tokenId));
        _transferFrom(_from, _to, _tokenId);

    }

 
}