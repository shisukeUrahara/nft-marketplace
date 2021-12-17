// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
import "./ERC165.sol";
import './interfaces/IERC721.sol';

contract ERC721 is ERC165,IERC721 {
    // state variables
    mapping(uint256=>address) private _tokenOwner;
    mapping(address=>uint256) private _ownedTokensCount;
    // Mapping from token id to approved addresses
    mapping(uint256 => address) private _tokenApprovals; 

    // events 
   
    // constructor 
    // constructor 
constructor(){
  _registerHashFingerPrint(bytes4(keccak256('balanceOf(bytes4)')^(keccak256('ownerOf(bytes4)')^(keccak256('transferFrom(bytes4)')^(keccak256('approve(bytes4)'))))));
}



   // functions     
  function balanceOf(address _owner) public override view returns(uint256) {
       require(_owner!=address(0),'ERC721: _owner cannot be zero address');
       return _ownedTokensCount[_owner];
   }

      function _exists(uint256 tokenId) internal view returns(bool){
        // setting the address of nft owner to check the mapping
        // of the address from tokenOwner at the tokenId 
         address owner = _tokenOwner[tokenId];
         // return truthiness tha address is not zero
         return owner != address(0);
    }


   function ownerOf(uint256 _tokenId) public override view returns(address) {
       require(_tokenOwner[_tokenId]!=address(0),'ERC721: Token doesnot exists');
       return _tokenOwner[_tokenId];
   }

   function _mint(address _to,uint256 _tokenId) internal  virtual{
       require(!_exists(_tokenId),'ERC721: Invalid mint address');
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

    function transferFrom(address _from, address _to, uint256 _tokenId)  public  override {
        require(isApprovedOrOwner(msg.sender, _tokenId));
        _transferFrom(_from, _to, _tokenId);
    }


        // 1. require that the person approving is the owner
    // 2. we are approving an address to a token (tokenId)
    // 3. require that we cant approve sending tokens of the owner to the owner (current caller)
    // 4. update the map of the approval addresses

    function approve(address _to, uint256 tokenId) public  override {
        address owner = ownerOf(tokenId);
        require(_to != owner, 'Error - approval to current owner');
        require(msg.sender == owner, 'Current caller is not the owner of the token');
        _tokenApprovals[tokenId] = _to;
        emit Approval(owner, _to, tokenId);
    } 

    function isApprovedOrOwner(address spender, uint256 tokenId) internal view returns(bool) {
        require(_exists(tokenId), 'token does not exist');
        address owner = ownerOf(tokenId);
        return(spender == owner); 
    }

 
}