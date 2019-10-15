package com.goisan.staff.service;

import com.goisan.staff.bean.Staff;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface StaffService {

    List<Staff> getStaffList(BaseBean baseBean);

    void saveStaff(Staff staff);

    Staff getStaffById(String id);

    void updateStaff(Staff staff);

    void delStaff(String id);

    AutoComplete getPersonDept(String personid);
}