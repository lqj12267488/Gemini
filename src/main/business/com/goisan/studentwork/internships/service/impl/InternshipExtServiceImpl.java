package com.goisan.studentwork.internships.service.impl;

import com.goisan.studentwork.internships.bean.InternshipExt;
import com.goisan.studentwork.internships.bean.Internships;
import com.goisan.studentwork.internships.dao.InternshipExtDao;
import com.goisan.studentwork.internships.service.InternshipExtService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/8/1.
 */
@Service
public class InternshipExtServiceImpl implements InternshipExtService{
    @Resource
    private InternshipExtDao internshipExtDao;
    public List<InternshipExt> getInternshipExtList(String id){return internshipExtDao.getInternshipExtList(id);}
    public void insertInternshipExt(InternshipExt internshipExt){internshipExtDao.insertInternshipExt(internshipExt);}
    public List<InternshipExt> InternshipExtAction(InternshipExt internshipExt){return internshipExtDao.InternshipExtAction(internshipExt);}
    public List<InternshipExt> internshipExtActionById(InternshipExt internshipExt){return internshipExtDao.internshipExtActionById(internshipExt);}
    public InternshipExt getInternshipExtById(String id){return internshipExtDao.getInternshipExtById(id);}
    public InternshipExt getInternshipExtId(String id){return internshipExtDao.getInternshipExtId(id);}
    public void updateInternshipExtById(InternshipExt internshipExt){internshipExtDao.updateInternshipExtById(internshipExt);}
    public void deleteInternshipExtById(String id){internshipExtDao.deleteInternshipExtById(id);}
    public InternshipExt selectId(String internshipUnitId){return internshipExtDao.selectId(internshipUnitId);}
    public Internships selectString(String internshipUnitId){return selectString(internshipUnitId);}
}
