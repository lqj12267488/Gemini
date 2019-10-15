package com.goisan.staff.service.impl;

import com.goisan.staff.bean.Staff;
import com.goisan.staff.dao.StaffDao;
import com.goisan.staff.service.StaffService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

@Service
public class StaffServiceImpl implements StaffService {

    @Resource
    private StaffDao staffDao;

    @Override
    public List<Staff> getStaffList(BaseBean baseBean) {
        return staffDao.getStaffList(baseBean);
    }

    @Override
    public void saveStaff(Staff staff) {
        staff.setCreateDept(CommonUtil.getDefaultDept());
        staff.setCreator(CommonUtil.getPersonId());
        staff.setId(UUID.randomUUID().toString());

            staffDao.saveStaff(staff);



    }

    @Override
    public Staff getStaffById(String id) {
        return staffDao.getStaffById(id);
    }

    @Override
    public void updateStaff(Staff staff) {
        staff.setChangeDept(CommonUtil.getDefaultDept());
        staff.setChanger(CommonUtil.getPersonId());
        staffDao.updateStaff(staff);
    }

    @Override
    public void delStaff(String id) {
        staffDao.delStaff(id);
    }

    @Override
    public AutoComplete getPersonDept(String personid) {
        return staffDao.getPersonDept(personid);
    }
}
