pragma solidity ^0.8.19;

contract ExamContract {
    struct Exam {
        uint256 id;
        string ipfsHash;
        address creator;
        bool isPublished;
    }

    struct Submission {
        uint256 examId;
        string ipfsHash;
        address student;
        bool isSubmitted;
    }

    mapping(uint256 => Exam) public exams;
    mapping(address => mapping(uint256 => Submission)) public submissions;
    uint256 public examCount;

    event ExamCreated(uint256 examId, string ipfsHash, address creator);
    event ExamSubmitted(uint256 examId, string ipfsHash, address student);

    function createExam(string memory _ipfsHash) public {
        examCount++;
        exams[examCount] = Exam(examCount, _ipfsHash, msg.sender, false);
        emit ExamCreated(examCount, _ipfsHash, msg.sender);
    }

    function submitExam(uint256 _examId, string memory _ipfsHash) public {
        require(exams[_examId].id != 0, "Exam does not exist");
        submissions[msg.sender][_examId] = Submission(_examId, _ipfsHash, msg.sender, true);
        emit ExamSubmitted(_examId, _ipfsHash, msg.sender);
    }

    function getExam(uint256 _examId) public view returns (string memory) {
        return exams[_examId].ipfsHash;
    }

    function getSubmission(uint256 _examId) public view returns (string memory) {
        return submissions[msg.sender][_examId].ipfsHash;
    }
}
