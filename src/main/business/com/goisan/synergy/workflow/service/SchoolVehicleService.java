package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.SchoolVehicle;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**协同办公-校内车辆管理
 * Created by wq on 2017/10/10.
 */
public interface SchoolVehicleService {
    List<SchoolVehicle> getSchoolVehicleList(SchoolVehicle schoolVehicle);

    void insertSchoolVehicle(SchoolVehicle schoolVehicle);

    void deleteSchoolVehicle(String id);

    void updateSchoolVehicle(SchoolVehicle schoolVehicle);

    SchoolVehicle getSchoolVehicleById(String id);

    List<SchoolVehicle> getSchoolVehicleProcessList(SchoolVehicle schoolVehicle);

    List<SchoolVehicle> getSchoolVehicleCompleteList(SchoolVehicle schoolVehicle);

    List<AutoComplete> selectPerson();

    List<AutoComplete> selectDept();

    String getPersonNameById(String personId);

    String getDeptNameById(String deptId);
}
