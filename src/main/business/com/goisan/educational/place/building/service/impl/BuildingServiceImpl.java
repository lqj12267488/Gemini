package com.goisan.educational.place.building.service.impl;


import com.goisan.educational.place.building.bean.Building;
import com.goisan.educational.place.building.dao.BuildingDao;
import com.goisan.educational.place.building.service.BuildingService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/7/13.
 */

@Service
public class BuildingServiceImpl implements BuildingService {
    @Resource
    private BuildingDao buildingDao;
    public List<Building> getBuildingList(String id){ return buildingDao.getBuildingList(id);}
    public void insertBuilding(Building building){ buildingDao.insertBuilding(building); }
    public List<Building> buildingAction (Building building){ return buildingDao.buildingAction(building);}
    public Building getBuildingById(String id){ return buildingDao.getBuildingById(id);}
    public void updateBuildingById(Building building){ buildingDao.updateBuildingById(building);}
    public void deleteBuildingById(String id){ buildingDao.deleteBuildingById(id);}
    public List<AutoComplete> selectDept(){ return buildingDao.selectDept();}
    public List<AutoComplete> selectPerson(){return buildingDao.selectPerson();}
    public String getPersonNameById(String id){ return buildingDao.getPersonNameById(id);}
    public String getDeptNameById(String id){ return buildingDao.getDeptNameById(id);}
    public List<Building> selectAll1(String id){ return buildingDao.selectAll1(id);}
    public List<Building> selectAll2(String id){ return buildingDao.selectAll2(id);}
    public List<Building> selectAll3(String id){ return buildingDao.selectAll3(id);}
    public List<Building> checkName(Building building) {
        return buildingDao.checkName(building);
    }
    public List<Select2> getFloorByBuildingId(String id){
        return buildingDao.getFloorByBuildingId(id);
    }

}
