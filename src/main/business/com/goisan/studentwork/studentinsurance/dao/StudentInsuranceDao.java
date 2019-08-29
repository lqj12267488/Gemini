package com.goisan.studentwork.studentinsurance.dao;

import com.goisan.studentwork.studentinsurance.bean.StudentInsurance;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created  By hanjie ON 2019/8/28
 */
@Repository
public interface StudentInsuranceDao {

    List<StudentInsurance> getStudentInsuranceList(StudentInsurance studentInsurance);
    void insertStudentInsurance(StudentInsurance studentInsurance);
    void delStudentInsurance(StudentInsurance studentInsurance);
    void updStudentInsurance(StudentInsurance studentInsurance);
    StudentInsurance getStudentInsuranceByStudentId (StudentInsurance studentInsurance);
    StudentInsurance getStudentInsuranceById (String id);
}
