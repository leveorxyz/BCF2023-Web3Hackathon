
//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CourseWave is Ownable{

    struct Student{
        uint256 id;
        address studentEthAddress;
        string name;
    }

    struct Instuctor{
        uint128 id;
        address instructorEthAddress;
        string name;
    }

    struct Course{
        uint128 id;
        string name;
        uint128 instructorId;
        string description;
        uint256 duration;
        uint256 stakingAmount;
    }

    address erc20Address;
    address nftAddress;

    uint128 latestCourseId;
    // instructor address => Course[]
    mapping(address => Course[]) courses;

    // courseID => student IDs => enrollment time
    mapping(uint256 => mapping (uint256 => uint256)) courseEnrollment;

    // student ID => course ID => marks
    mapping (uint256 => mapping (uint256=>uint256)) marks;

    uint256 latestStudentId;
    mapping (address=>Student) students;

    uint128 latestInstructorId;
    Instuctor[] instructors;

    event CreateCourse(
        uint256 courseId,
        uint256 createdAt
    );

    function getInstructorId(address addrs) internal view returns(uint128){
        uint128 instructorId = 999999999999;
        for (uint i = 0; i < instructors.length; i++) {
            if(instructors[i].instructorEthAddress == addrs){
                instructorId = instructors[i].id;
                break;
            }
        }
        return instructorId;
    }

    modifier isNotInstructor(address addressToCheck) {
        require(getInstructorId(addressToCheck) == 999999999999, "Already an instructor");
        _;
    }

    modifier isNotStudent(address addressToCheck) {
        require(students[addressToCheck].studentEthAddress != address(0), "Already a student");
        _;
    }

    modifier isInstructor(address addressToCheck) {
        require(getInstructorId(addressToCheck) != 999999999999, "Not an instructor");
        _;
    }

    modifier isStudent(address addressToCheck) {
        require(students[addressToCheck].studentEthAddress == address(0), "Is not a student");
        _;
    }

    constructor(Instuctor[] memory _instructors, address _erc20Address, address _nftAddress) {
        instructors = _instructors;
        erc20Address = _erc20Address;
        _nftAddress = _nftAddress;
    }

    function onBoardStudent(
        string calldata name
    ) external isNotStudent(msg.sender) { 
        students[msg.sender] = Student(
            latestStudentId,
            msg.sender,
            name
        );
        latestStudentId++;
    }

    function addInstrutor(
        string calldata name,
        address instructorAddress
    ) external onlyOwner isNotInstructor(instructorAddress)  {
        instructors[latestInstructorId] = Instuctor(
            latestInstructorId,
            instructorAddress,
            name
        );
        latestInstructorId++;
    }

    function createCourse(
        string calldata name,
        string calldata description,
        uint256 duration,
        uint256 stakingAmount
    ) external {
        uint128 instructorID = getInstructorId(msg.sender);
        require(instructorID != 999999999999, "Instructor do not exist");
        courses[msg.sender].push(Course(
            latestCourseId,
            name,
            instructorID,
            description,
            duration,
            stakingAmount
        ));
        latestCourseId++;
    }

    function stake() internal {
        
    }

    function enrollCourse(

    ) external {
        
    }

    function assignMarks() external {
        
    }

    function issueCertificate() external {
        
    }

    function distributeStakes() external {
        
    }

    function distributeStake() external {
        
    }

    function getCourses() external view returns(Course[] memory){
        
    }

    function getEnrolledStudents() external view returns(Student[] memory){
        
    }

    function getEnrolledCourses() external view returns(Course[] memory){
        
    }

    function getCertificates() external view returns(Course[] memory){
        
    }
 

}