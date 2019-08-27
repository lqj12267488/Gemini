package com.goisan.studentwork.internships.service.impl;

import com.goisan.studentwork.internships.bean.InternshipManage;
import com.goisan.studentwork.internships.bean.Internships;
import com.goisan.studentwork.internships.dao.InternshipsDao;
import com.goisan.studentwork.internships.service.InternshipsService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/7/31.
 */

@Service
public class InternshipsServiceImpl implements InternshipsService {
    @Resource
    private InternshipsDao internshipsDao;
    public List<Internships> getInternshipsList(String internshipUnitId){return internshipsDao.getInternshipsList(internshipUnitId);}
    public void insertInternships(Internships internships){ internshipsDao.insertInternships(internships);}
    public List<Internships> InternshipsAction(Internships internships){return internshipsDao.InternshipsAction(internships);}
    public List<Internships> InternshipsActionList(Internships internships){return internshipsDao.InternshipsActionList(internships);}
    public Internships getInternshipsById(String internshipUnitId){return internshipsDao.getInternshipsById(internshipUnitId);}
    public void updateInternshipsById(Internships internships){internshipsDao.updateInternshipsById(internships);}
    public void deleteInternshipsById(String internshipUnitId){ internshipsDao.deleteInternshipsById(internshipUnitId);}
    public List<AutoComplete> selectDept(){return internshipsDao.selectDept();}
    public List<AutoComplete> selectPerson(){return internshipsDao.selectPerson();}
    public String getPersonNameById(String id){ return internshipsDao.getPersonNameById(id);}
    public String getDeptNameById(String id){ return internshipsDao.getDeptNameById(id);}
    public Internships selectId(String internshipUnitId){return internshipsDao.selectId(internshipUnitId);}
    public Internships selectAll(String id){return internshipsDao.selectAll(id);}
    public Internships selectOne(String internshipUnitId){return internshipsDao.selectOne(internshipUnitId);}
    public List<InternshipManage> getInternshipsByInternshipUnitName(String internshipUnitName){return internshipsDao.getInternshipsByInternshipUnitName(internshipUnitName);}
}
