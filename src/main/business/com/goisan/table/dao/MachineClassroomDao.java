package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface MachineClassroomDao {

    List<BaseBean> getMachineClassroomList(BaseBean baseBean);

    void saveMachineClassroom(BaseBean baseBean);

    BaseBean getMachineClassroomById(String id);

    void updateMachineClassroom(BaseBean baseBean);

    void delMachineClassroom(String id);

}
