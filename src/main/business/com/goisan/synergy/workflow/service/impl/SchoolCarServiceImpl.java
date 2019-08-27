package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.SchoolCar;
import com.goisan.synergy.workflow.dao.SchoolCarDao;
import com.goisan.synergy.workflow.service.SchoolCarService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**协同办公--学校车辆外出使用管理
 * Created and modify by Administrator on 2017/6/27 0027.
 */
@Service
public class SchoolCarServiceImpl implements SchoolCarService {
    @Resource
    private SchoolCarDao schoolCarDao;

    public List<SchoolCar> getSchoolCarList(SchoolCar schoolCar) {
        return schoolCarDao.getSchoolCarList(schoolCar);
    }

    public void insertSchoolCar(SchoolCar schoolCar) {
        schoolCarDao.insertSchoolCar(schoolCar);
    }

    public void deleteSchoolCarById(String id) {
        schoolCarDao.deleteSchoolCarById(id);
    }

    public void updateSchoolCarById(SchoolCar schoolCar) {
        schoolCarDao.updateSchoolCarById(schoolCar);
    }

    public SchoolCar getSchoolCarById(String id) {
        return schoolCarDao.getSchoolCarById(id);
    }

    public List<SchoolCar> getSchoolCarListProcess(SchoolCar schoolCar) {
        return schoolCarDao.getSchoolCarListProcess(schoolCar);
    }

    public List<SchoolCar> getSchoolCarListComplete(SchoolCar schoolCar) {
        return schoolCarDao.getSchoolCarListComplete(schoolCar);
    }

    public String getPersonNameById(String personId) {
        return  schoolCarDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return schoolCarDao.getDeptNameById(deptId);
    }

    public List<AutoComplete> selectPerson() {
        return schoolCarDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return schoolCarDao.selectDept();
    }

    public List<SchoolCar> getSchoolCarRegisterList(SchoolCar schoolCar) {
        return schoolCarDao.getSchoolCarRegisterList(schoolCar);
    }

    public List<SchoolCar> getSchoolCarConfirmList(SchoolCar schoolCar) {
        return schoolCarDao.getSchoolCarConfirmList(schoolCar);
    }

    public void updateSchoolCarRegister(SchoolCar schoolCar) {
        schoolCarDao.updateSchoolCarRegister(schoolCar);
    }

    public void updateSchoolCarConfirm(SchoolCar schoolCar) {
        schoolCarDao.updateSchoolCarConfirm(schoolCar);
    }
}
