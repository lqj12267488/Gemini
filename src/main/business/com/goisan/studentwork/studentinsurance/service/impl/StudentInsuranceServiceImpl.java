package com.goisan.studentwork.studentinsurance.service.impl;

import com.goisan.educational.place.dorm.dao.DormDao;
import com.goisan.studentwork.studentinsurance.bean.StudentInsurance;
import com.goisan.studentwork.studentinsurance.dao.StudentInsuranceDao;
import com.goisan.studentwork.studentinsurance.service.StudentInsuranceService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created  By hanjie ON 2019/8/28
 */
@Service
public class StudentInsuranceServiceImpl implements StudentInsuranceService {

    @Autowired
    private StudentInsuranceDao studentInsuranceDao;

    @Autowired
    private DormDao dormDao;

    @Override
    public List<StudentInsurance> getStudentInsuranceList(StudentInsurance studentInsurance) {
        return studentInsuranceDao.getStudentInsuranceList(studentInsurance);
    }

    @Override
    public void insertStudentInsurance(StudentInsurance studentInsurance) {
        studentInsurance.setCreator(CommonUtil.getPersonId());
        studentInsurance.setCreateDept(CommonUtil.getDefaultDept());
        studentInsuranceDao.insertStudentInsurance(studentInsurance);
    }

    @Override
    public void delStudentInsurance(StudentInsurance studentInsurance) {
        studentInsurance.setChanger(CommonUtil.getPersonId());
        studentInsurance.setChanger(CommonUtil.getDefaultDept());
        studentInsuranceDao.delStudentInsurance(studentInsurance);
    }

    @Override
    public StudentInsurance getStudentInsuranceById(String id) {
        return studentInsuranceDao.getStudentInsuranceById(id);
    }

    @Override
    public void updStudentInsurance(StudentInsurance studentInsurance) {
        studentInsurance.setChanger(CommonUtil.getPersonId());
        studentInsurance.setChanger(CommonUtil.getDefaultDept());
        studentInsuranceDao.updStudentInsurance(studentInsurance);
    }

    @Override
    public void saveStudentInsurance(StudentInsurance studentInsurance) {
        StudentInsurance stuInsurance = studentInsuranceDao.getStudentInsuranceByStudentId(studentInsurance);
        String dormId = dormDao.getDormByName(studentInsurance.getDormName());
        if (null == stuInsurance){
            studentInsurance.setCreator(CommonUtil.getPersonId());
            studentInsurance.setCreateDept(CommonUtil.getDefaultDept());
            if (null!=dormId){
                studentInsurance.setDormId(dormId);
            }
            studentInsuranceDao.insertStudentInsurance(studentInsurance);
        }else {
            studentInsurance.setChanger(CommonUtil.getPersonId());
            studentInsurance.setChangeDept(CommonUtil.getDefaultDept());
            studentInsurance.setId(stuInsurance.getId());
            if (null!=dormId){
                studentInsurance.setDormId(dormId);
            }
            studentInsuranceDao.updStudentInsurance(studentInsurance);
        }
    }


}
