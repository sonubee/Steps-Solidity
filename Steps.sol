pragma solidity ^0.4.11;
//Version 1
contract Steps{

    struct Stepper{
        mapping(string => uint) steps;
    }

    mapping(address => Stepper) steppers;
    mapping(string => uint) totalSteps;
    mapping(string => uint) totalPeople;
    mapping(bytes32 => address) addressBook;

    function Steps() public {
    }

    function saveMySteps (uint numSteps, string date) public {

        //save steps if higher than saved before
        if (steppers[msg.sender].steps[date] < numSteps && numSteps > 0){
            //add people count only if new entry
            totalPeople[date] += 1;

              //only add additional steps to total count
        uint currentSteps = steppers[msg.sender].steps[date];
        uint difference = numSteps - currentSteps;
        totalSteps[date] += difference;

        //set daily steps
        steppers[msg.sender].steps[date] = numSteps;
        }
    }

    function recallMySteps(string date) public constant returns (uint numSteps){
        numSteps = steppers[msg.sender].steps[date];
    }

    function everyoneStepsDate(string date) public constant returns (uint allSteps){
        allSteps = totalSteps[date];
    }

    function countAllPeopleDate(string date) public constant returns (uint allPeople){
        allPeople = totalPeople[date];
    }

    //a=uuid and b=address
    function setAddress(string a, address b) public{
        addressBook[keccak256(a)] = b;
    }

    //a=uuid
    function getAddress(string a) public constant returns(address){
        return addressBook[keccak256(a)];
    }

}
