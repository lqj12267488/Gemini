package com.goisan.educational.place.building.controller;


import com.goisan.educational.place.building.bean.Building;
import com.goisan.educational.place.building.service.BuildingService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class BuildingController {
    @Resource
    private BuildingService buildingService;
    @Resource
    private EmpService empService;
     /**
     * 楼宇场地维护跳转
     * request by hanyue
     * modify by hanyue
     * @return
     */

    @RequestMapping("/building/request")
    public ModelAndView buildingServiceList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/place/building/building");
        return mv;
    }
     /**
     * 楼宇场地维护URL
     *  url by hanyue
     *  modify by hanyue
     * @param building
     * @return
     */

    @ResponseBody
    @RequestMapping("/building/getBuildingList")
    public Map<String, List<Building>> buildingAction(Building building ) {
        Map<String, List<Building>> buildingMap = new HashMap<String, List<Building>>();
        building.setCreator(CommonUtil.getPersonId());
        building.setCreateDept(CommonUtil.getDefaultDept());
        buildingMap.put("data", buildingService.buildingAction(building));
        return buildingMap;
    }


     /**
     * 筛选
     * search by hanyue
     * modify by hanyue
     * @param building
     * @return
     */

    @ResponseBody
    @RequestMapping("/building/search")
    public Map<String, List<Building>> search(Building building){
        Map<String, List<Building>>  buildingMap = new HashMap<String, List<Building>>();
        building.setCreator(CommonUtil.getPersonId());
        building.setCreateDept(CommonUtil.getDefaultDept());
        List<Building> r = buildingService.buildingAction(building);
        buildingMap.put("data", r);
        return buildingMap;
    }

    @ResponseBody
    @RequestMapping("/building/selectAll")
    public boolean selectAll(String id){
        List<Building> list1=buildingService.selectAll1(id);
        List<Building> list2=buildingService.selectAll2(id);
        List<Building> list3=buildingService.selectAll3(id);
        if( list1.size()==0 && list2.size()==0 && list3.size()==0 ){
            return true;
        }else{
            return false;
        }

    }
     /**
     * 楼宇场地维护修改
     * update by hanyue
     * modify by hanyue
     * @param id
     * @return
     */

    @ResponseBody
    @RequestMapping("/building/getBuildingById")
    public ModelAndView getBuildingById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/place/building/addBuilding");
        Building building = buildingService.getBuildingById(id);
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        mv.addObject("head", "修改");
        mv.addObject("building", building);
        return mv;
    }
     /**
     * 楼宇场地维护新增
     * add by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/building/addBuilding")
    public ModelAndView addBuilding() {
        ModelAndView mv = new ModelAndView("/business/educational/place/building/editBuilding");
        Building building=new Building();
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        mv.addObject("head", "新增申请");
        mv.addObject("building",building);
        mv.addObject("personName",personName);
        mv.addObject("deptName", deptName);
        return mv;
    }
     /**
     * 删除楼宇场地
     * delete by hanyue
     * modify by hanyue
     * @param id
     * @return
     */

    @ResponseBody
    @RequestMapping("/building/deleteBuildingById")
    public Message deleteBuildingById(String id) {
        buildingService.deleteBuildingById(id);
        return new Message(1, "删除成功！", null);
    }
     /**
     * 保存楼宇场地
     * save by hanyue
     * modify by hanyue
     * @param building
     * @return
     */

    @ResponseBody
    @RequestMapping("/building/saveBuilding")
    public Message saveBuilding(Building building){
        if(building.getId()==null || building.getId().equals("")){
            building.setCreator(CommonUtil.getPersonId());
            building.setCreateDept(CommonUtil.getDefaultDept());
            building.setId(CommonUtil.getUUID());
            buildingService.insertBuilding(building);
            return new Message(1, "新增成功！", null);
        }else{
            building.setChanger(CommonUtil.getPersonId());
            building.setChangeDept(CommonUtil.getDefaultDept());
            buildingService.updateBuildingById(building);
            return new Message(1, "修改成功！", null);
        }
    }
     /**
     * 部门自动提示框
     * dept by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/building/getDept")
    public List<AutoComplete> getDept() {
        return buildingService.selectDept();
    }

     /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/building/getPerson")
    public List<AutoComplete> getPerson() {
        return buildingService.selectPerson();
    }


    /*名称查重*/
    @ResponseBody
    @RequestMapping("/building/checkName")
    public Message checkName(Building building) {
        List size = buildingService.checkName(building);
        if (size.size() > 0) {
            return new Message(1, "楼宇名称重复，请重新填写！", null);
        } else {
            return new Message(0, "", null);
        }
    }
    /*通过楼宇Id查询楼层create by wq 17/10/30*/
    @ResponseBody
    @RequestMapping("/building/getFloorByBuildingId")
    public List<Select2> getFloorByBuildingId(String id) {
        return buildingService.getFloorByBuildingId(id);
    }
}
