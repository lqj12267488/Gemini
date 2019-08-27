package com.goisan.logistics.repair.controller;

import com.goisan.logistics.repair.bean.RepairSupplies;
import com.goisan.logistics.repair.service.RepairSuppliesService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hanyu on 2017/5/24.
 */
@Controller
public class RepairSuppliesController {
    @Resource
    private RepairSuppliesService repairSuppliesService;
    @Resource
    private EmpService empService;

    //跳转页面
    @RequestMapping("/repairSupplies/repairSuppliesList")
    public ModelAndView ITDeviceList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/logistics/repair/repairSuppliesList");//跳转到这个路径下的jsp
        return mv;
    }

    //获取表中所有数据
    @ResponseBody
    @RequestMapping("/repairSupplies/getRepairSuppliesList")
    public Map<String, List<RepairSupplies>> RepairSuppliesAction(RepairSupplies repairSupplies) {
        Map<String, List<RepairSupplies>> repairSuppliesMap = new HashMap<String, List<RepairSupplies>>();//创建一个map集合
        repairSupplies.setCreator(CommonUtil.getPersonId());
        repairSupplies.setCreateDept(CommonUtil.getDefaultDept());
        repairSupplies.setLevel(CommonUtil.getLoginUser().getLevel());
        repairSuppliesMap.put("data", repairSuppliesService.RepairSuppliesAction(repairSupplies));
        //通过.xml中的RepairSuppliesAction方法查询数据库中的数据
        return repairSuppliesMap;//返回一个map集合
    }

    //删除一个数据
    @ResponseBody
    @RequestMapping("/repairSupplies/deleteRepairSuppliesById")
    public Message deleteDeptById(String id) {
        repairSuppliesService.deleteRepairSuppliesById(id);//.xml中的deleteRepairSuppliesById方法,通过id删除数据库中的一条数据
        return new Message(1, "删除成功！", null);
    }

    //查询符合条件的数据
    @ResponseBody
    @RequestMapping("/repairSupplies/search")
    public Map<String, List<RepairSupplies>> search(RepairSupplies repairSupplies) {
        Map<String, List<RepairSupplies>> repairSuppliesMap = new HashMap<String, List<RepairSupplies>>();
        repairSupplies.setCreator(CommonUtil.getPersonId());
        repairSupplies.setCreateDept(CommonUtil.getDefaultDept());
        repairSupplies.setLevel(CommonUtil.getLoginUser().getLevel());
        List<RepairSupplies> r = repairSuppliesService.RepairSuppliesComplete(repairSupplies);
        //通过.xml中的RepairSuppliesComplete方法查询数据库中符合条件的数据
        repairSuppliesMap.put("data", r);
        return repairSuppliesMap;
    }

    //跳转修改页面
    @ResponseBody
    @RequestMapping("/repairSupplies/getRepairSuppliesById")
    public ModelAndView getRepairSuppliesById(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/editRepairSupplies");
        RepairSupplies repairSupplies = repairSuppliesService.getRepairSuppliesById(id);
        //.xml中的getRepairSuppliesById方法,通过id查询数据库中的一条数据
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        mv.addObject("head", "修改"); //修改页面头部 显示的文字
        mv.addObject("RepairSupplies", repairSupplies);//通过RepairSupplies.字段名查询字段
        mv.addObject("personName", personName);
        mv.addObject("deptName", deptName);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/repairSupplies/searchRepairSupplies")
    public Map<String, List<RepairSupplies>> searchRepairSupplies(RepairSupplies repairSupplies) {
        Map<String, List<RepairSupplies>> repairSuppliesMap = new HashMap<String, List<RepairSupplies>>();
        repairSupplies.setCreator(CommonUtil.getPersonId());
        repairSupplies.setCreateDept(CommonUtil.getDefaultDept());
        repairSuppliesMap.put("data", repairSuppliesService.getRepairSuppliesList(repairSupplies));
        return repairSuppliesMap;
    }

    @ResponseBody
    @RequestMapping("/repairSupplies/getDept")
    public List<AutoComplete> getDept() {
        return repairSuppliesService.selectDept();
    }

    @ResponseBody
    @RequestMapping("/repairSupplies/getPerson")
    public List<AutoComplete> getPerson() {
        return repairSuppliesService.selectPerson();
    }

    //跳转新增页面
    @ResponseBody
    @RequestMapping("/repairSupplies/saveRepairSupplies")
    public Message saveRepairSupplies(RepairSupplies repairSupplies) {
        if (repairSupplies.getId() == null || repairSupplies.getId().equals("")) {
            repairSupplies.setCreator(CommonUtil.getPersonId());
            repairSupplies.setCreateDept(CommonUtil.getDefaultDept());
            repairSupplies.setId(CommonUtil.getUUID());
            CommonUtil.save(repairSupplies);
            repairSuppliesService.insertRepairSupplies(repairSupplies);
            //通过.xml中的insertRepairSupplies方法存储数据到数据库中
            return new Message(1, "新增成功！", null);
        } else {
            repairSupplies.setChanger(CommonUtil.getPersonId());
            repairSupplies.setChangeDept(CommonUtil.getDefaultDept());
            repairSuppliesService.updateRepairSuppliesById(repairSupplies);
            //通过.xml中的updateRepairSuppliesById方法修改数据库中的数据
            return new Message(1, "修改成功！", null);
        }
    }
    //把数据存到数据库中

    @RequestMapping("/repairSupplies/editSupplies")
    public ModelAndView editSupplies(RepairSupplies repairSupplies) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/logistics/repair/editSupplies");
        mv.addObject("head", "耗材添加");
        mv.addObject("RepairSupplies", repairSupplies);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/repairSupplies/addRepairSupplies")
    public ModelAndView addRepairSupplies() {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/addRepairSupplies");//跳转到这个路径下的jsp
        RepairSupplies repairSupplies = new RepairSupplies();
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new java.util.Date());
        String time = formatTime.format(new java.util.Date());
        String datetime = date + "T" + time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        repairSupplies.setIntime(datetime);//设置存入数据库的时间
        mv.addObject("head", "新增耗材库存");//新增页面头部 显示的文字
        mv.addObject("RepairSupplies", repairSupplies);//通过RepairSupplies.字段名查询字段
        mv.addObject("personName", personName);
        mv.addObject("deptName", deptName);
        return mv;
    }

    /*查询库存数量*/
    @ResponseBody
    @RequestMapping("/repairSupplies/getSuppliesInnum")
    public String getDormOverPlusNumber(String id) {
        String suppliesInnum = repairSuppliesService.getSuppliesInnum(id);
        return suppliesInnum;
    }

    /*查耗材名称*/
    @ResponseBody
    @RequestMapping("/repairSupplies/getName")
    public Message getName(String id) {
        String sname = repairSuppliesService.getName(id);
        return new Message(0, sname, null);
    }

    /*添加耗材—新增保存方法*/
    @ResponseBody
    @RequestMapping("/repairSupplies/saveAddSupplies")
    public Message saveAddSupplies(RepairSupplies repairSupplies) {
        repairSupplies.setCreator(CommonUtil.getPersonId());
        repairSupplies.setCreateDept(CommonUtil.getDefaultDept());
        repairSupplies.setId(CommonUtil.getUUID());
        repairSuppliesService.saveAddSupplies(repairSupplies);
        repairSupplies.setStatus("1");
        repairSuppliesService.updateSuppliesFlag(repairSupplies);
        repairSuppliesService.updateSuppliesnum(repairSupplies);
        return new Message(1, "新增成功！", null);
    }

    /*删除添加的耗材/repairSupplies/deleteSupplies*/
    @ResponseBody
    @RequestMapping("/repairSupplies/deleteSupplies")
    public Message deleteSupplies(String id, String repairId,String suppliesInnum,String suppliesid) {
        repairSuppliesService.deleteSupplies(id);//.xml中的deleteRepairSuppliesById方法,通过id删除数据库中的一条数据
        if (repairSuppliesService.countByReapairId(repairId) == 0) {
            RepairSupplies repairSupplies = new RepairSupplies();
            repairSupplies.setRepairID(repairId);
            repairSupplies.setStatus("0");
            repairSuppliesService.updateSuppliesFlag(repairSupplies);
            RepairSupplies repairSupplies1 = new RepairSupplies();
            repairSupplies1.setSuppliesid(suppliesid);
            repairSupplies1.setSuppliesInnum(suppliesInnum);
            repairSuppliesService.updateSuppliesInNum(repairSupplies1);
        }
        return new Message(1, "删除成功！", null);
    }
}
