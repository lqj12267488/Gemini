package com.goisan.staff.dao;

import com.goisan.staff.bean.Staff;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface StaffDao {

    List<Staff> getStaffList(BaseBean baseBean);

    void saveStaff(BaseBean baseBean);

    Staff getStaffById(String id);

    void updateStaff(BaseBean baseBean);

    void delStaff(String id);

    AutoComplete getPersonDept(String personid);
}
