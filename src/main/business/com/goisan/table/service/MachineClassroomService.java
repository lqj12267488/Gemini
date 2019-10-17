package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface MachineClassroomService {

    List<BaseBean> getMachineClassroomList(BaseBean baseBean);

    void saveMachineClassroom(BaseBean baseBean);

    BaseBean getMachineClassroomById(String id);

    void updateMachineClassroom(BaseBean baseBean);

    void delMachineClassroom(String id);

}