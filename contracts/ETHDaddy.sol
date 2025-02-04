// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ETHDaddy is ERC721 {
    uint256 public maxSupply;
    uint256 public totalSupply;
    address public owner;

    struct Domain {
        string name;
        uint256 cost;
        bool isOwned;
    }

    mapping(uint256 => Domain) domains;

    modifier onlyOwner() {
        require(msg.sender==owner);
        _;
    }

    //TODO
    //1. List Domains
    //2. Buy Domains
    //3. Get Paid

    constructor(string memory _name, string memory _symbol) 
        ERC721(_name, _symbol) 
    {
        owner= msg.sender;    
    }

    function list(string memory _name, uint256 _cost) public onlyOwner {
        maxSupply++;
        domains[maxSupply] = Domain(_name, _cost, false);

        //Model a domain  [X]
        //Save the domain  [X]
        //Update total domain count
    }

    function getDomain(uint256 _id) public view returns(Domain memory){
        return domains[_id];
    }

    function mint(uint256 _id) public payable {
        require(_id != 0);
        require(_id <= maxSupply);
        require(_id <= maxSupply);
        require(domains[_id].isOwned == false);
        require(msg.value >= domains[_id].cost);


        domains[_id].isOwned=true;
        totalSupply++;
        _safeMint(msg.sender, _id);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdraw() public onlyOwner{
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success);
    }

}
