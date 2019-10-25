package com.goisan.table.service.impl;

import com.goisan.table.bean.MachineClassroom;
import com.goisan.table.dao.MachineClassroomDao;
import com.goisan.table.service.MachineClassroomService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MachineClassroomServiceImpl implements MachineClassroomService {

    @Resource
    private MachineClassroomDao machineClassroomDao;

    @Override
    public List<BaseBean> getMachineClassroomList(BaseBean baseBean) {
        return machineClassroomDao.getMachineClassroomList(baseBean);
    }

    @Override
    public void saveMachineClassroom(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        machineClassroomDao.saveMachineClassroom(baseBean);
    }

    @Override
    public BaseBean getMachineClassroomById(String id) {
        return machineClassroomDao.getMachineClassroomById(id);
    }

    @Override
    public void updateMachineClassroom(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        machineClassroomDao.updateMachineClassroom(baseBean);
    }

    @Override
    public void delMachineClassroom(String id) {
        machineClassroomDao.delMachineClassroom(id);
    }

    @Override
    public List<MachineClassroom> checkYear(MachineClassroom machineClassroom) {
        return machineClassroomDao.checkYear(machineClassroom);
    }
}
