pragma solidity ^0.4.11;

contract Steps{

    struct Stepper{
        mapping(string => uint) steps;
    }

    mapping(address => Stepper) steppers;
    mapping(string => uint) totalSteps;
    mapping(string => uint) totalPeople;
    mapping(bytes32 => address) addressBook;

    function Steps() public{
    }

    function saveMySteps (uint numSteps, string date) private{

        if (steppers[msg.sender].steps[date] == 0 && numSteps > 0){
            //add people count only if new entry
            totalPeople[date] += 1;
        }

        //only add additional steps to total count
        uint currentSteps = steppers[msg.sender].steps[date];
        uint difference = numSteps - currentSteps;
        totalSteps[date] += difference;

        //set daily steps
        steppers[msg.sender].steps[date] = numSteps;
    }

    function recallMySteps(string date) private constant returns (uint numSteps){
        numSteps = steppers[msg.sender].steps[date];
    }

    function everyoneStepsDate(string date) private constant returns (uint allSteps){
        allSteps = totalSteps[date];
    }

    function countAllPeopleDate(string date) private constant returns (uint allPeople){
        allPeople = totalPeople[date];
    }

    //a=uuid and b=address
    function setAddress(string a, address b) private{
        addressBook[keccak256(a)] = b;
    }

    //a=uuid
    function getAddress(string a) private constant returns(address){
        return addressBook[keccak256(a)];
    }

}
