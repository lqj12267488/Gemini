package com.goisan.studentwork.studentinsurance.service;

import com.goisan.studentwork.studentinsurance.bean.StudentInsurance;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created  By hanjie ON 2019/8/28
 */
public interface StudentInsuranceService {
    List<StudentInsurance> getStudentInsuranceList(StudentInsurance studentInsurance);
    void insertStudentInsurance(StudentInsurance studentInsurance);
    void delStudentInsurance(StudentInsurance studentInsurance);
    StudentInsurance getStudentInsuranceById (String id);
    void updStudentInsurance(StudentInsurance studentInsurance);

    void saveStudentInsurance (StudentInsurance studentInsurance);

}
