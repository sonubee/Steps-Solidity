pragma solidity ^0.4.11;
//0xa77c989bd04e4e0f1f27c9abc74290183c783079
contract Steps{

    struct Stepper{
        mapping(string => uint) steps;
    }

    mapping(address => Stepper) steppers;
    mapping(string => uint) totalSteps;
    mapping(string => uint) totalPeople;
    mapping(bytes32 => address) addressBook;

    function Steps(){
    }

    function saveMySteps (uint numSteps, string date){

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

    function recallMySteps(string date) constant returns (uint numSteps){
        numSteps = steppers[msg.sender].steps[date];
    }

    function everyoneStepsDate(string date) constant returns (uint allSteps){
        allSteps = totalSteps[date];
    }

    function countAllPeopleDate(string date) constant returns (uint allPeople){
        allPeople = totalPeople[date];
    }

    function setAddress(string a, address b){
        addressBook[sha3(a)] = b;
    }

    function getAddress(string a) constant returns(address){
        return addressBook[sha3(a)];
    }

}
