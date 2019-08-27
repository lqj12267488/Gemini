package com.goisan.educational.place.building.dao;


import com.goisan.educational.place.building.bean.Building;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;

import java.util.List;

/**
 * Created by hanyu on 2017/7/13.
 */

public interface BuildingDao {
    List<Building> getBuildingList(String id);
    void insertBuilding(Building building);
    List<Building> buildingAction(Building building);
    Building getBuildingById(String id);
    void updateBuildingById(Building building);
    void deleteBuildingById(String id);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
    String getPersonNameById(String id);
    String getDeptNameById(String id);
    List<Building> selectAll1(String id);
    List<Building> selectAll2(String id);
    List<Building> selectAll3(String id);
    List<Building> checkName(Building building);
    List<Select2> getFloorByBuildingId(String id);
}
