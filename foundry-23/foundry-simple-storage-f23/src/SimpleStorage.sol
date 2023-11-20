// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; // versi 0.8.18 atau lebih

contract SimpleStorage {
    uint public MyfavoritNumber; // 0 

    struct Person{
        uint favoritNumber;
        string name;
    }

    Person[] public listofPeople;   //dynamic array
    mapping(string => uint256) public NametoFavoriteNumber;

    function store(uint _favoriteNumber) public virtual {
        MyfavoritNumber = _favoriteNumber;
    }
    
    function retrieve() public view returns(uint){
        return MyfavoritNumber;
    }

    function addPerson(string memory _name, uint _favoriteNumber ) public {
        listofPeople.push(Person(_favoriteNumber, _name));
        NametoFavoriteNumber[_name] = _favoriteNumber;  // for searching someone's favorite number
    }

}



