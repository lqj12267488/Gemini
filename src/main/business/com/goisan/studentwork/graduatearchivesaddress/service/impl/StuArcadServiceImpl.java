package com.goisan.studentwork.graduatearchivesaddress.service.impl;

import com.goisan.studentwork.graduatearchivesaddress.bean.Arcad;
import com.goisan.studentwork.graduatearchivesaddress.bean.StuArcad;
import com.goisan.studentwork.graduatearchivesaddress.dao.ArcadDao;
import com.goisan.studentwork.graduatearchivesaddress.dao.StuArcadDao;
import com.goisan.studentwork.graduatearchivesaddress.service.StuArcadService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created  By hanjie ON 2019/8/30
 */
@Service
public class StuArcadServiceImpl implements StuArcadService {

    @Autowired
    private StuArcadDao stuArcadDao;

    @Autowired
    private ArcadDao arcadDao;

    @Override
    public List<StuArcad> getStuArcadList(StuArcad stuArcad) {
        return stuArcadDao.getStuArcadList(stuArcad);
    }

    @Override
    @Transactional
    public Message insertStuArcad(StuArcad stuArcad) {

        String studentIds = stuArcad.getStudentIds();
        String[] stuArray = studentIds.split(",");

//        获取档案地址id
        Arcad query = new Arcad();
        query.setArcadProvince(stuArcad.getArcadProvince());
        query.setArcadCity(stuArcad.getArcadCity());
        query.setArcadCounty(stuArcad.getArcadCounty());
        query.setArcadDetail(stuArcad.getArcadDetail());
        Arcad arcad = arcadDao.checkArcad(query);


        if (null==arcad){
            return new Message(1,"新增失败，档案地址错误",null);
        }
       for (String studentId: stuArray) {
//            检查该学生是否已存在
            stuArcad.setStudentId(studentId);
            List<StuArcad> stuArcads = stuArcadDao.checkStudent(stuArcad);
            if (stuArcads.size()>0){
                StringBuffer sb = new StringBuffer();
                for (StuArcad sa:stuArcads) {
                    sb.append(sa.getStudentName());
                    sb.append(" ");
                }
                return new Message(1,"新增失败,"+sb.toString()+"学生已存在",null);
            }
        }
        stuArcadDao.delStuArcadByArcadId1(arcad.getArcadId());
        for (String studentId: stuArray){
            stuArcad.setStudentId(studentId);
//            stuArcadDao.delStuArcadByArcadId(stuArcad);
            stuArcad.setArcadId(arcad.getArcadId());
            stuArcad.setCreator(CommonUtil.getPersonId());
            stuArcad.setCreateDept(CommonUtil.getDefaultDept());
            stuArcadDao.insertStuArcad(stuArcad);
        }
        return new Message(0,"保存成功",null);
    }

    @Override
    public List<StuArcad> getStuByArcadId(String arcadId) {
        return stuArcadDao.getStuByArcadId(arcadId);
    }

    @Override
    @Transactional
    public Message updStuArcad(StuArcad stuArcad) {

        stuArcad.setChanger(CommonUtil.getPersonId());
        stuArcad.setChangeDept(CommonUtil.getDefaultDept());

        return this.insertStuArcad(stuArcad);
    }

    @Override
    public List<StuArcad> getStuArcadByClass(StuArcad stuArcad) {
        return stuArcadDao.getStuArcadByClass(stuArcad);
    }

    @Override
    public StuArcad getStuArcadById(StuArcad stuArcad) {
        return stuArcadDao.getStuArcadById(stuArcad);
    }

    @Override
    public void updQueryStuArcad(StuArcad stuArcad) {
        Arcad arcad = new Arcad();
        arcad.setArcadProvince(stuArcad.getArcadProvince());
        arcad.setArcadCity(stuArcad.getArcadCity());
        arcad.setArcadCounty(stuArcad.getArcadCounty());
        arcad.setArcadDetail(stuArcad.getArcadDetail());
        Arcad checkArcad = arcadDao.checkArcad(arcad);
        stuArcad.setArcadId(checkArcad.getArcadId());
        stuArcad.setChangeDept(CommonUtil.getDefaultDept());
        stuArcad.setChanger(CommonUtil.getPersonId());
        stuArcadDao.updStuArcadById(stuArcad);
    }
}
