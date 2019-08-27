package com.goisan.studentwork.internships.service.impl;

import com.goisan.studentwork.internships.bean.InternshipManage;
import com.goisan.studentwork.internships.dao.InternshipManageDao;
import com.goisan.studentwork.internships.service.InternshipManageService;
import com.goisan.system.bean.Student;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/8/1.
 */
@Service
public class InternshipManageServiceImpl implements InternshipManageService{
    @Resource
    private InternshipManageDao internshipManageDao;
    public List<InternshipManage> getInternshipManageList(String internshipId){
        return internshipManageDao.getInternshipManageList(internshipId);
    }
    public void insertInternshipManage(InternshipManage internshipManage){
        internshipManageDao.insertInternshipManage(internshipManage);
    }
    public List<InternshipManage> InternshipManageAction(InternshipManage internshipManage){
       return internshipManageDao.InternshipManageAction(internshipManage);
    }
    public InternshipManage getInternshipManageById(String internshipId){
       return internshipManageDao.getInternshipManageById(internshipId);
    }
    public void updateInternshipManageById(InternshipManage internshipManage){
        internshipManageDao.updateInternshipManageById(internshipManage);
    }
    public void deleteInternshipManageById(String internshipId){
        internshipManageDao.deleteInternshipManageById(internshipId);
    }
    public String selectNewInternshipUnitId(String internshipId){return internshipManageDao.selectNewInternshipUnitId(internshipId);}
    public InternshipManage select(String internshipId){return internshipManageDao.select(internshipId);}
    public InternshipManage selectId(String internshipId){
        return internshipManageDao.selectId(internshipId);
    }
    public InternshipManage selectNewId(String internshipId){return internshipManageDao.selectNewId(internshipId);}
    public void updateInternshipManage(InternshipManage internshipManage){ internshipManageDao.updateInternshipManage(internshipManage);}
    public InternshipManage getInternshipManage(String internshipId){return internshipManageDao.getInternshipManage(internshipId);}
    public List<InternshipManage> selectInternshipManage(String internshipId){return internshipManageDao.selectInternshipManage(internshipId);}
    public Student selectStudent(String studentNumber){
        return internshipManageDao.selectStudent(studentNumber);
    }
    public String selectArea(String internshipId){
        return internshipManageDao.selectArea(internshipId);
    }
    public String selectInternshipType(String internshipId){
        return internshipManageDao.selectInternshipType(internshipId);
    }
}
