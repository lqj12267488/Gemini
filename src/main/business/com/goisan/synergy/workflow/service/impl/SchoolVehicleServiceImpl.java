package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.SchoolVehicle;
import com.goisan.synergy.workflow.dao.SchoolVehicleDao;
import com.goisan.synergy.workflow.service.SchoolVehicleService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**校内车辆管理
 * Created by wq on 2017/10/10.
 */
@Service
public class SchoolVehicleServiceImpl implements SchoolVehicleService{
    @Resource
    private SchoolVehicleDao schoolVehicleDao;

    public List<SchoolVehicle> getSchoolVehicleList(SchoolVehicle schoolVehicle) {
        return schoolVehicleDao.getSchoolVehicleList(schoolVehicle);
    }

    public void insertSchoolVehicle(SchoolVehicle schoolVehicle) {
        schoolVehicleDao.insertSchoolVehicle(schoolVehicle);
    }

    public void deleteSchoolVehicle(String id) {
        schoolVehicleDao.deleteSchoolVehicle(id);
    }

    public void updateSchoolVehicle(SchoolVehicle schoolVehicle) {
        schoolVehicleDao.updateSchoolVehicle(schoolVehicle);
    }

    public SchoolVehicle getSchoolVehicleById(String id) {
        return schoolVehicleDao.getSchoolVehicleById(id);
    }

    public List<SchoolVehicle> getSchoolVehicleProcessList(SchoolVehicle schoolVehicle) {
        return schoolVehicleDao.getSchoolVehicleProcessList(schoolVehicle);
    }

    public List<SchoolVehicle> getSchoolVehicleCompleteList(SchoolVehicle schoolVehicle) {
        return schoolVehicleDao.getSchoolVehicleCompleteList(schoolVehicle);
    }

    public List<AutoComplete> selectPerson() {
        return schoolVehicleDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return schoolVehicleDao.selectDept();
    }

    public String getPersonNameById(String personId) {
        return schoolVehicleDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return schoolVehicleDao.getDeptNameById(deptId);
    }
}
