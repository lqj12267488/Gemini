package com.goisan.logistics.repair.controller;

import com.goisan.logistics.repair.bean.Repair;
import com.goisan.logistics.repair.bean.RepairSupplies;
import com.goisan.logistics.repair.service.RepairService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Tree;
import com.goisan.system.bean.UserDic;
import com.goisan.system.service.EmpService;
import com.goisan.system.service.UserDicService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class RepairController {
    @Resource
    private RepairService repairService;
    @Resource
    private EmpService empService;
    @Resource
    private UserDicService userDicService;

    /*跳到主页*/
    @RequestMapping("/repair/repairList")
    public ModelAndView RepairList(Repair repair) {
        repair.setCreator(CommonUtil.getPersonId());
        ModelAndView mv = new ModelAndView("/business/logistics/repair/repair");
        mv.addObject("repair", repair);
        return mv;
    }

    /*维修任务申请*/
    @ResponseBody
    @RequestMapping("/repair/search")
    public Map<String, List<Repair>> RepairAction(Repair repair) {
        Map<String, List<Repair>> repairMap = new HashMap<String, List<Repair>>();
        repair.setCreator(CommonUtil.getPersonId());
        repair.setCreateDept(CommonUtil.getDefaultDept());
        List<Repair> ll = repairService.RepairAction(repair);
        String name = "";
        List<Repair> dd = new ArrayList<>();
        for (Repair repair1 : ll) {
            String[] name_id = repair1.getItemName().split(",");
            String newname = "";
            for (int j = 0; j < name_id.length; j++) {
                String a = name_id[j];
                name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            if(!"".equals(newname)) newname = newname.substring(0,newname.length()-1);
            repair1.setItemNameShow(newname);
            if (repair.getItemName() != null && !"".equals(repair.getItemName())) {
                if (newname.contains(repair.getItemName())) {
                    dd.add(repair1);
                }
            }
        }
        if (repair.getItemName() != null && !"".equals(repair.getItemName())) {
            repairMap.put("data", dd);
        } else {
            repairMap.put("data", ll);
        }
        return repairMap;
    }

    /*跳到新增页*/
    @RequestMapping("/repair/addRepair")
    public ModelAndView addRepair() {
        String pdept = empService.getDeptNameById(CommonUtil.getDefaultDept());
        ModelAndView mv = new ModelAndView("/business/logistics/repair/editRepair");
        mv.addObject("head", "新增");
        mv.addObject("pdept", pdept);
        return mv;
    }

    /*跳到修改页*/
    @ResponseBody
    @RequestMapping("/repair/editRepairById")
    public ModelAndView editRepairById(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/editRepair");
        Repair repair = repairService.getRepairById(id);
        String[] name_id = repair.getItemName().split(",");
        StringBuilder newname = new StringBuilder();
        for (String a : name_id) {
            String name = userDicService.getDicName(a);
            if (name != null) {
                newname.append(name).append(",");
            }
        }
        if(newname.length()>0){
            repair.setItemNameShow(newname.substring(0, newname.length() - 1));
        }else {
            repair.setItemNameShow("");
        }
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        mv.addObject("head", "修改");
        mv.addObject("repair", repair);
        mv.addObject("personName", personName);
        mv.addObject("deptName", deptName);
        return mv;
    }

    /*新增修改保存方法*/
    @ResponseBody
    @RequestMapping("/repair/saveRepair")
    public Message saveRepair(Repair repair) {
        if (repair.getRepairID() == null || repair.getRepairID().equals("")) {
            repair.setCreator(CommonUtil.getPersonId());
            repair.setCreateDept(CommonUtil.getDefaultDept());
            repair.setRepairID(CommonUtil.getUUID());
            repairService.insertRepair(repair);
            return new Message(1, "新增成功！", null);
        } else {
            repair.setChanger(CommonUtil.getPersonId());
            repair.setChangeDept(CommonUtil.getDefaultDept());
            repairService.updateRepair(repair);
            return new Message(1, "修改成功！", null);
        }
    }

    /*删除一个数据*/
    @ResponseBody
    @RequestMapping("/repair/deleteRepairById")
    public Message deleteRepairById(String id) {
        repairService.deleteRepairById(id);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 删除维修员校验
     */
    @ResponseBody
    @RequestMapping("/repair/getRepairByRepairMan")
    public boolean getRepairByRepairMan(String id) {
        List<Repair> list = repairService.getRepairByRepairMan(id);
        if (list.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    /*提交*/
    @ResponseBody
    @RequestMapping("/repair/submitRepair")
    public Message submitRepair(Repair repair) {
        repairService.submitRepair(repair);
        return new Message(1, "提交成功！", null);
    }

    /*维修任务分配菜单主页*/
    @RequestMapping("/repair/distribution")
    public ModelAndView RepairDistribution() {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/repairDistribution");
        return mv;
    }

    /*维修任务分配页*/
    @ResponseBody
    @RequestMapping("/repair/distributionInfo")
    public Map<String, List<Repair>> distributionInfo(Repair repair) {
        Map<String, List<Repair>> repairMap = new HashMap<String, List<Repair>>();
        repair.setCreator(CommonUtil.getPersonId());
        repair.setCreateDept(CommonUtil.getDefaultDept());
        repair.setLevel(CommonUtil.getLoginUser().getLevel());
        List<Repair> ll = repairService.distributionInfo(repair);
        for (Repair repair1 : ll) {
            String name =  repairService.selectName(repair1.getCreator());
            repair1.setCreatorName(name);
        }
        String name = "";
        List<Repair> dd = new ArrayList<>();
        for (Repair repair1 : ll) {
            String[] name_id = repair1.getItemName().split(",");
            String newname = "";
            for (int j = 0; j < name_id.length; j++) {
                String a = name_id[j];
                name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            repair1.setItemNameShow(newname);
            if (repair.getItemName() != null && !"".equals(repair.getItemName())) {
                if (newname.contains(repair.getItemName())) {
                    dd.add(repair1);
                }
            }
        }
        if (repair.getItemName() != null && !"".equals(repair.getItemName())) {
            repairMap.put("data", dd);
        } else {
            repairMap.put("data", ll);
        }
        return repairMap;
    }

    /*任务分配页*/
    @ResponseBody
    @RequestMapping("/repair/getDistribution")
    public ModelAndView getDistribution(Repair repair) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/getDistribution");
        mv.addObject("head", "维修任务分配");
        mv.addObject("repair", repair);
        return mv;
    }

    /*分配维修员查询*/
    @ResponseBody
    @RequestMapping("/repair/searchgetDistribution")
    public Map<String, List<Repair>> searchgetDistribution(Repair repair) {
        Map<String, List<Repair>> repairMap = new HashMap<String, List<Repair>>();
        repair.setLevel(CommonUtil.getLoginUser().getLevel());
        repair.setCreator(CommonUtil.getPersonId());
        repair.setCreateDept(CommonUtil.getDefaultDept());
        List<Repair> r = repairService.searchgetDistribution(repair);
        List<Repair> ids = repairService.getPeopleId(repair.getRepairID());
        if (ids.size() != 0) {
            for (int i = 0; i < r.size(); i++) {
                for (int j = 0; j < ids.size(); j++) {
                    String a = r.get(i).getPersonId();
                    String b = ids.get(j).getPersonId();
                    if (r.get(i).getPersonId().equals(ids.get(j).getPersonId())) {
                        r.get(i).setPeopleFlag("是");
                        break;
                    } else {
                        r.get(i).setPeopleFlag("否");
                    }
                }
            }
        } else {
            for (int a = 0; a < r.size(); a++) {
                r.get(a).setPeopleFlag("否");
            }
        }
        repairMap.put("data", r);
        return repairMap;
    }

    /*分配任务*/
    @ResponseBody
    @RequestMapping("/repair/FenPei")
    public Message repairFenPei(String ids) {
        Repair repair = new Repair();
        repair.setCreator(CommonUtil.getPersonId());
        repair.setCreateDept(CommonUtil.getDefaultDept());
        String[] arr_id = ids.split("','");
        String pname = "";
        for (int i = 0; i < arr_id.length; i++) {
            String[] arr_values = arr_id[i].split(",");
            repair.setDeptName(arr_values[0].replace("'", ""));
            repair.setPersonName(arr_values[1]);
            repair.setRepairID(arr_values[2]);
            pname = pname + arr_values[1] + ",";
            repairService.insertRepairExecute(repair);
        }
        repairService.repairFenPei(repair);
        return new Message(1, "分配成功！", null);
    }

    @ResponseBody
    @RequestMapping("/repair/deleteRepairTypeById")
    public Message deleteRepairTypeById(String repairType, String id) {
        Repair repair = new Repair();
        repair.setRepairType(repairType);
        List<Repair> repairList = repairService.checkRepairList(repair);
        if (repairList.size() > 0) {
            return new Message(1, "此保修类型已关联报修，删除失败！", null);
        } else {
            userDicService.deleteUserDicById(id);
            return new Message(0, "删除成功！", null);
        }
    }


    /*维修详情*/
    @RequestMapping("/repair/searchFenPei")
    public ModelAndView searchFenPei(String repairID) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/searchFenPei");
        Repair repair = repairService.searchFenPei(repairID);
        mv.addObject("repair", repair);
        return mv;
    }

    /*维修员设置*/
    @RequestMapping("/repair/repairman")
    public ModelAndView Repairman() {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/repairMan");
        return mv;
    }

    /*查看维修员*/
    @ResponseBody
    @RequestMapping("/repair/searchMan")
    public Map<String, List<Repair>> RepairManAction(Repair repair) {
        Map<String, List<Repair>> repairMap = new HashMap<String, List<Repair>>();
        repair.setCreateDept(CommonUtil.getDefaultDept());
        repair.setLevel(CommonUtil.getLoginUser().getLevel());
        repairMap.put("data", repairService.RepairManAction(repair));
        return repairMap;
    }

    /**
     * 获取人员自动完成框
     */
    @ResponseBody
    @RequestMapping("/repair/getPerson")
    public List<AutoComplete> getPerson() {
        return repairService.selectPerson();
    }

    /*跳到新增维修员界面*/
    @RequestMapping("/repair/addRepairMan")
    public ModelAndView addRepairman() {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/addRepairMan");
        return mv;
    }

    /**
     * 字段查重
     */
    @ResponseBody
    @RequestMapping("/repair/checkPersonID")
    public Message checkPersonID(Repair repair) {
        List size = repairService.checkPersonID(repair);
        if (size.size() > 0) {
            return new Message(1, "维修员已存在或不是后勤处人员，请重新填写！", null);
        } else {
            return new Message(0, "", null);
        }
    }


    /*维修员修改查询*/
    @ResponseBody
    @RequestMapping("/repair/editRepairMan")
    public ModelAndView editRepairManById(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/addRepairMan");
        Repair repair = repairService.getRepairManById(id);
        String pName = empService.getPersonNameById(CommonUtil.getPersonId());
        String dName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        mv.addObject("head", "修改");
        mv.addObject("repair", repair);
        mv.addObject("pName", pName);
        mv.addObject("dName", dName);
        return mv;
    }

    /*保存维修员信息*/
    @ResponseBody
    @RequestMapping("/repair/saveRepairMan")
    public Message addRepairMan(Repair repair) {
        if (repair.getId() == null || repair.getId().equals("")) {
            repair.setCreator(CommonUtil.getPersonId());
            repair.setCreateDept(CommonUtil.getDefaultDept());
            repairService.insertRepairMan(repair);
            return new Message(1, "新增成功！", null);
        } else {
            repair.setChanger(CommonUtil.getPersonId());
            repair.setChangeDept(CommonUtil.getDefaultDept());
            repairService.updateRepairMan(repair);
            return new Message(1, "修改成功！", null);
        }
    }

    /*删除维修员*/
    @ResponseBody
    @RequestMapping("/repair/delRepairMan")
    public Message delRepairMan(String id) {
        repairService.delRepairMan(id);
        return new Message(1, "删除成功！", null);
    }

    /*维修信息查询页面*/
    @RequestMapping("/repair/repairInfo")
    public ModelAndView RepairInfo() {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/repairInfo");
        return mv;
    }

    /*维修信息数据查询*/
    @ResponseBody
    @RequestMapping("/repair/Info")
    public Map<String, List<Repair>> repairInfo(Repair repair) {
        Map<String, List<Repair>> repairMap = new HashMap<String, List<Repair>>();
        repair.setCreator(CommonUtil.getPersonId());
        repair.setCreateDept(CommonUtil.getDefaultDept());
        repair.setLevel(CommonUtil.getLoginUser().getLevel());
        List<Repair> ll = repairService.repairInfo(repair);
        String name = "";
        for (int i = 0; i < ll.size(); i++) {
            String[] arr_id = ll.get(i).getItemName().split(",");
            String newname = "";
            for (int j = 0; j < arr_id.length; j++) {
                String a = arr_id[j];
                name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            ll.get(i).setItemNameShow(newname);
        }
        repairMap.put("data", ll);
        //repairMap.put("data", repairService.repairInfo(repair));
        return repairMap;
    }

    /**
     * 维修任务详情页
     */
    @RequestMapping("/repair/repairListInfo")
    public ModelAndView repairListInfo(String repairID) {
        Repair repair = repairService.getRepairListInfo(repairID);
        String name = "";
        for (int i = 0; i < repair.getItemName().length(); i++) {
            String[] arr_id = repair.getItemName().split(",");
            String newname = "";
            for (int j = 0; j < arr_id.length; j++) {
                String a = arr_id[j];
                name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            repair.setItemNameShow(newname);
        }
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "维修信息详情");
        mv.addObject("repair", repair);
        mv.setViewName("/business/logistics/repair/repairListInfo");
        //mv.setViewName("/business/studentwork/studentgrants/studentGrantsDetail");
        return mv;
    }


    /*后勤维修页面*/
    @RequestMapping("/repair/logisticsRepair")
    public ModelAndView logisticsRepair() {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/logisticsRepair");
        return mv;
    }

    /*后勤维修查询*/
    @ResponseBody
    @RequestMapping("/repair/repairDefine")
    public Map<String, List<Repair>> repairDefine(Repair repair) {
        Map<String, List<Repair>> repairMap = new HashMap<String, List<Repair>>();
        repair.setCreator(CommonUtil.getPersonId());
        repair.setCreateDept(CommonUtil.getDefaultDept());
        List<Repair> ll = repairService.repairDefine(repair);
        for (Repair repair1 : ll) {
           String name =  repairService.selectName(repair1.getCreator());
            repair1.setCreatorName(name);
        }
        String name = "";
        List<Repair> dd = new ArrayList<>();
        for (Repair repair1 : ll) {
            String[] name_id = repair1.getItemName().split(",");
            String newname = "";
            for (int j = 0; j < name_id.length; j++) {
                String a = name_id[j];
                name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            repair1.setItemNameShow(newname);
            if (repair.getItemName() != null && !"".equals(repair.getItemName())) {
                if (newname.contains(repair.getItemName())) {
                    dd.add(repair1);
                }
            }
        }
        if (repair.getItemName() != null && !"".equals(repair.getItemName())) {
            repairMap.put("data", dd);
        } else {
            repairMap.put("data", ll);
        }
        return repairMap;
    }

    /*字典编码重复性校验*/
    @ResponseBody
    @RequestMapping("/repair/checkRequestFlag")
    public Message checkRequestFlag(Repair repair) {
        repair.setCreator(CommonUtil.getPersonId());
        List size = repairService.checkRequestFlag(repair);
        if (size.size() > 0) {
            return new Message(1, "", null);
        } else {
            return new Message(0, "", null);
        }
    }

    /*确认维修*/
    @RequestMapping("/repair/repairContent")
    public ModelAndView repairContent(Repair repair) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/repairContent");
        repair = repairService.getRepairListInfo(repair.getRepairID());
        String name = "";
        for (int i = 0; i < repair.getItemName().length(); i++) {
            String[] arr_id = repair.getItemName().split(",");
            String newname = "";
            for (int j = 0; j < arr_id.length; j++) {
                String a = arr_id[j];
                name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            repair.setItemNameShow(newname);
        }
        mv.addObject("head", "确认维修");
        mv.addObject("repair", repair);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/repair/saveContent")
    public Message saveContent(Repair repair) {
        List<Repair> re = repairService.getRepairExecute(repair.getRepairID());
        repair.setCreator(CommonUtil.getPersonId());
        if (re.size() == 1) {//如果是最后一个人确认维修。
            repairService.YesRepair(repair, "1");//任务状态置为已完成，表示所有人都完成
            repairService.YesRepair(repair, "2");//此维修员单独的任务状态置为已完成
            repairService.insertContent(repair);
        } else {
            repairService.YesRepair(repair, "2");
            repairService.insertContent(repair);
        }
        return new Message(1, "确认成功！", null);
    }

    /*回捡任务分配页*/
    @RequestMapping("/repair/check")
    public ModelAndView repairCheck() {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/repairCheck");
        return mv;
    }

    /*回捡数据查询*/
    @ResponseBody
    @RequestMapping("/repair/checkInfo")
    public Map<String, List<Repair>> checkInfo(Repair repair) {
        Map<String, List<Repair>> repairMap = new HashMap<String, List<Repair>>();
        repair.setCreateDept(CommonUtil.getDefaultDept());
        repair.setLevel(CommonUtil.getLoginUser().getLevel());
        List<Repair> ll = repairService.checkInfo(repair);
        String name = "";
        List<Repair> dd = new ArrayList<>();
        for (Repair repair1 : ll) {
            String[] name_id = repair1.getItemName().split(",");
            String newname = "";
            for (int j = 0; j < name_id.length; j++) {
                String a = name_id[j];
                name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            repair1.setItemNameShow(newname);
            if (repair.getItemName() != null && !"".equals(repair.getItemName())) {
                if (newname.contains(repair.getItemName())) {
                    dd.add(repair1);
                }
            }
        }
        if (repair.getItemName() != null && !"".equals(repair.getItemName())) {
            repairMap.put("data", dd);
        } else {
            repairMap.put("data", ll);
        }
        return repairMap;
    }

    /*查看回捡员*/
    @ResponseBody
    @RequestMapping("/repair/searchCheckPerson")
    public Map<String, List<Repair>> searchCheckPerson(Repair repair) {
        Map<String, List<Repair>> repairMap = new HashMap<String, List<Repair>>();
        repairMap.put("data", repairService.searchCheckPerson(repair));
        return repairMap;
    }

    /*跳到新增回检员界面*/
    @RequestMapping("/repair/addCheckMan")
    public ModelAndView addCheckMan(Repair repair) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/addCheckMan");
        mv.addObject("repair", repair);
        return mv;
    }

    /*保存回检员*/
    @ResponseBody
    @RequestMapping("/repair/saveCheckerMan")
    public Message saveCheckerMan(Repair repair) {
        repairService.updateCheckerMan(repair);
        return new Message(1, "分配成功！", null);
    }

    /*跳到后勤回捡界面*/
    @RequestMapping("/repair/logisticsCheck")
    public ModelAndView logisticsCheck(Repair repair) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/logisticsCheck");
        mv.addObject("repair", repair);
        return mv;
    }

    /*查询后勤回捡数据*/
    @ResponseBody
    @RequestMapping("/repair/checkDefine")
    public Map<String, List<Repair>> checkDefine(Repair repair) {
        Map<String, List<Repair>> repairMap = new HashMap<String, List<Repair>>();
        repair.setCreator(CommonUtil.getPersonId());
        repair.setCreateDept(CommonUtil.getDefaultDept());
        List<Repair> ll = repairService.checkDefine(repair);
        String name = "";
        List<Repair> dd = new ArrayList<>();
        for (Repair repair1 : ll) {
            String[] name_id = repair1.getItemName().split(",");
            String newname = "";
            for (int j = 0; j < name_id.length; j++) {
                String a = name_id[j];
                name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            repair1.setItemNameShow(newname);
            if (repair.getItemName() != null && !"".equals(repair.getItemName())) {
                if (newname.contains(repair.getItemName())) {
                    dd.add(repair1);
                }
            }
        }
        if (repair.getItemName() != null && !"".equals(repair.getItemName())) {
            repairMap.put("data", dd);
        } else {
            repairMap.put("data", ll);
        }

        return repairMap;
    }

    /*回捡信息查询界面*/
    @RequestMapping("/repair/logisticsCheckInfo")
    public ModelAndView logisticsCheckInfo(Repair repair) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/logisticsCheckInfo");
        mv.addObject("repair", repair);
        return mv;
    }

    /*回捡信息查询*/
    @ResponseBody
    @RequestMapping("/repair/selectCheck")
    public Map<String, List<Repair>> selectCheck(Repair repair) {
        Map<String, List<Repair>> repairMap = new HashMap<String, List<Repair>>();
        repair.setCreator(CommonUtil.getPersonId());
        repair.setLevel(CommonUtil.getLoginUser().getLevel());
        repair.setCreateDept(CommonUtil.getDefaultDept());
        List<Repair> ll = repairService.selectCheck(repair);
        String name = "";
        List<Repair> dd = new ArrayList<>();
        for (Repair repair1 : ll) {
            String[] name_id = repair1.getItemName().split(",");
            String newname = "";
            for (int j = 0; j < name_id.length; j++) {
                String a = name_id[j];
                name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            repair1.setItemNameShow(newname);
            if (repair.getItemName() != null && !"".equals(repair.getItemName())) {
                if (newname.contains(repair.getItemName())) {
                    dd.add(repair1);
                }
            }
        }
        if (repair.getItemName() != null && !"".equals(repair.getItemName())) {
            repairMap.put("data", dd);
        } else {
            repairMap.put("data", ll);
        }
        return repairMap;
    }

    /*确认回捡*/
    @ResponseBody
    @RequestMapping("/repair/YesCheck")
    public Message YesCheck(Repair repair) {
        repairService.YesCheck(repair);
        return new Message(1, "确认成功！", null);
    }

    /*申请人反馈界面*/
    @RequestMapping("/repair/feedBack")
    public ModelAndView feedBack(Repair repair) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/feedBackRepair");
        mv.addObject("repair", repair);
        return mv;
    }

    /*保存反馈信息*/
    @ResponseBody
    @RequestMapping("/repair/saveFeedBack")
    public Message saveFeedBack(Repair repair) {
        repairService.saveFeedBack(repair);
        return new Message(1, "保存成功！", null);
    }


    /*后勤维修添加耗材*/
    @RequestMapping("/repair/addSupplies")
    public ModelAndView addSupplies(Repair repair) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/addSupplies");
        mv.addObject("repair", repair);
        return mv;
    }

    /*后勤维修耗材查询*/
    @ResponseBody
    @RequestMapping("/repair/getRepairItemList")
    public Map<String, List<RepairSupplies>> getRepairItemList(RepairSupplies repairSupplies) {
        Map<String, List<RepairSupplies>> repairMap = new HashMap<String, List<RepairSupplies>>();
        repairSupplies.setCreator(CommonUtil.getPersonId());
        repairSupplies.setCreateDept(CommonUtil.getDefaultDept());
        repairMap.put("data", repairService.getRepairItemList(repairSupplies));
        return repairMap;
    }


    @ResponseBody
    @RequestMapping("/repair/checkDelFile")
    public Message checkDelFile(String repairID) {
        Repair repair = new Repair();
        repair.setRepairID(repairID);
        List<Repair> list = repairService.checkRepairList(repair);
        String flag = list.get(0).getRequestFlag();
        //1维修分配中、2维修中、3维修完成
        if ("1".equals(flag)) {
            return new Message(0, "当前报修申请正在维修分配中，不可删除！", null);
        }
        if ("2".equals(flag)) {
            return new Message(0, "当前报修申请正在维修中，不可删除！", null);
        }
        if ("3".equals(flag)) {
            return new Message(0, "当前报修申请已维修完成，不可删除！", null);
        } else {
            return new Message(1, null, null);
        }

    }

    /**
     * 报修负责人
     */
    @RequestMapping("/repair/repairAdmin")
    public ModelAndView repairAdmin() {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/repairAdmin");
        return mv;
    }

    /**
     * 查看报修负责人
     */
    @ResponseBody
    @RequestMapping("/repair/repairAdminList")
    public Map<String, List<Repair>> repairAdminList(Repair repair) {
        Map<String, List<Repair>> repairMap = new HashMap<String, List<Repair>>();
        repair.setCreateDept(CommonUtil.getDefaultDept());
        repair.setLevel(CommonUtil.getLoginUser().getLevel());
        repairMap.put("data", repairService.repairAdminList(repair));
        return repairMap;
    }

    /**
     * 新增报修负责人界面
     */
    @RequestMapping("/repair/addRepairAdmin")
    public ModelAndView addRepairAdmin() {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/editRepairAdmin");
        return mv;
    }

    /**
     * 修改报修负责人界面
     */
    @ResponseBody
    @RequestMapping("/repair/editRepairAdmin")
    public ModelAndView editRepairAdmin(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/editRepairAdmin");
        Repair repair = repairService.getRepairAdminById(id);
        String personId = repair.getRepairmanPersonID() + "---" + repair.getRepairmanDeptID();
        repair.setPersonName(personId);
        mv.addObject("head", "修改");
        mv.addObject("repair", repair);
        return mv;
    }

    /**
     * 报修负责人查重
     */
    @ResponseBody
    @RequestMapping("/repair/checkAdminID")
    public Message checkAdminID(Repair repair) {
        List size = repairService.checkAdminID(repair);
        if (size.size() > 0) {
            return new Message(1, "维修员已存在或不是后勤处人员，请重新填写！", null);
        } else {
            return new Message(0, "", null);
        }
    }

    /**
     * 保存报修负责人
     */
    @ResponseBody
    @RequestMapping("/repair/saveRepairAdmin")
    public Message saveRepairAdmin(Repair repair) {
        if (repair.getId() == null || repair.getId().equals("")) {
            repair.setCreator(CommonUtil.getPersonId());
            repair.setCreateDept(CommonUtil.getDefaultDept());
            repairService.insertRepairAdmin(repair);
            return new Message(1, "新增成功！", null);
        } else {
            repair.setChanger(CommonUtil.getPersonId());
            repair.setChangeDept(CommonUtil.getDefaultDept());
            repairService.updateRepairAdmin(repair);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除报修负责人
     */
    @ResponseBody
    @RequestMapping("/repair/delRepairAdmin")
    public Message delRepairAdmin(String id) {
        repairService.delRepairAdmin(id);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 首页报修详情
     */
    @ResponseBody
    @RequestMapping("/repair/repairIndexInfo")
    public ModelAndView repairIndexInfo(String businessId, String flag) {
        ModelAndView mv = new ModelAndView("/business/logistics/repair/repairIndexInfo");
        Repair repair = repairService.getRepairListInfo(businessId);
        String name = "";
        for (int i = 0; i < repair.getItemName().length(); i++) {
            String[] name_id = repair.getItemName().split(",");
            String newname = "";
            for (int j = 0; j < name_id.length; j++) {
                String a = name_id[j];
                name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            repair.setItemNameShow(newname);
        }
        mv.addObject("repair", repair);
        mv.addObject("flag", flag);
        return mv;
    }

    /**
     * 已读方法
     */
    @ResponseBody
    @RequestMapping("/repair/insertRepairLog")
    public Message insertRepairLog(Repair repair, String flag) {
        repair.setCreator(CommonUtil.getPersonId());
        if (flag.equals("5")) {
            repair.setRequestFlag("3");
        } else {
            repair.setRequestFlag("1");
        }
        repairService.insertRepairLog(repair);
        return new Message(1, "新增成功！", null);
    }

    /**
     * 报修物品信息维护根节点
     */
    @ResponseBody
    @RequestMapping("/getRepairDicTree")
    public List<Tree> getRepairDicTree() {
        String dicType = "BXWPXX";
        List<Tree> trees = userDicService.getDicTree(dicType);
        Tree root = new Tree();
        root.setId("0");
        root.setName("报修物品信息");
        root.setpId("root");
        root.setOpen(true);
        trees.add(root);
        return trees;
    }

    /**
     * 报修物品信息维护
     */
    @ResponseBody
    @RequestMapping("/repair/repairGoods")
    public ModelAndView repairGoods() {
        ModelAndView mv = new ModelAndView("/business/logistics/repairgoods/repairGoods");
        String dicType = "BXWPXX";
        mv.addObject("dicType", dicType);
        return mv;
    }

    /**
     * 报修物品信息新增
     */
    @ResponseBody
    @RequestMapping("/repair/addRepairGoods")
    public ModelAndView addRepairGoods(String pId, String name, String dicType) {
        ModelAndView mv = new ModelAndView();
        //UserDic userDic = userDicService.getUserDicById(pId,"WPLX");
        mv.addObject("pId", pId);
        mv.addObject("name", name);
        mv.addObject("dicType", dicType);
        mv.setViewName("/business/logistics/repairgoods/addRepairGoods");
        return mv;
    }

    /**
     * 报修物品信息修改
     */
    @ResponseBody
    @RequestMapping("/repair/editRepairGoods")
    public ModelAndView editRepairGoods(String id, String name, String dicType) {
        ModelAndView mv = new ModelAndView();
        UserDic userDic = userDicService.getUserDicById(id, dicType);
        mv.addObject("userDic", userDic);
        mv.addObject("name", name);
        mv.addObject("dicType", dicType);
        mv.setViewName("/business/logistics/repairgoods/editRepairGoods");
        return mv;
    }

    /**
     * 字典类别名称查重
     */
    @ResponseBody
    @RequestMapping("/repair/checkName")
    public Message archivesTypeCheckName(UserDic userDic) {
        List size = userDicService.checkName(userDic);
        if (size.size() > 0) {
            return new Message(1, "名称重复，请重新填写！", null);
        } else {
            return new Message(0, "", null);
        }
    }

    /**
     * 报修物品信息新增保存
     */
    @ResponseBody
    @RequestMapping("/repair/saveRepairGoods")
    public Message saveRepairGoods(UserDic userDic) {
        userDic.setCreator(CommonUtil.getPersonId());
        userDic.setCreateTime(CommonUtil.getDate());
        String dicorder = userDicService.getMaxDicOrder(userDic.getDictype());
        String diccode = userDicService.getMaxDicCode(userDic.getDictype());
        if (dicorder != null && dicorder != "") {
            userDic.setDicorder(dicorder);
        } else {
            userDic.setDicorder("1");
        }
        if (diccode != null && diccode != "") {
            userDic.setDiccode(diccode);
        } else {
            userDic.setDiccode("1");
        }
        userDicService.saveRepairGoods(userDic);
        return new Message(1, "添加成功！", null);
    }

    /**
     * 报修物品信息修改保存
     */
    @ResponseBody
    @RequestMapping("/repair/updateRepairGoods")
    public Message updateDept(UserDic userDic) {
        userDic.setChanger(CommonUtil.getPersonId());
        userDic.setCreateTime(CommonUtil.getDate());
        userDicService.updateRepairGoods(userDic);
        return new Message(1, "修改成功！", null);
    }

    /**
     * 报修物品信息删除
     */
    @ResponseBody
    @RequestMapping("/repair/delRepairGoods")
    public Message delRepairGoods(String id) {
        userDicService.delRepairGoods(id);
        return new Message(1, "删除成功", null);
    }

    /**
     * 维修耗材信息维护根节点
     */
    @ResponseBody
    @RequestMapping("/getRepairSuppliesDicTree")
    public List<Tree> getRepairSuppliesDicTree() {
        String dicType = "WXHCXX";
        List<Tree> trees = userDicService.getDicTree(dicType);
        Tree root = new Tree();
        root.setId("0");
        root.setName("维修耗材信息");
        root.setpId("root");
        root.setOpen(true);
        trees.add(root);
        return trees;
    }

    /**
     * 维修耗材信息维护
     */
    @ResponseBody
    @RequestMapping("/repairSupplies/repairSuppliesGoods")
    public ModelAndView repairSuppliesGoods() {
        ModelAndView mv = new ModelAndView("/business/logistics/repairgoods/repairSuppliesGoods");
        String dictype = "WXHCXX";
        mv.addObject("dictype", dictype);
        return mv;
    }

    /**
     * 撤销分配
     */
    @ResponseBody
    @RequestMapping("/repair/deletePeople")
    public Message deletePeople(Repair repair) {
        repairService.deletePeople(repair);
        List<Repair> list = repairService.getRepairExecuteByRepairId(repair.getRepairID());
        if(list.size()<1){
            repairService.repairChenXiaoFenPei(repair);
        }
        return new Message(1, "撤销成功！", null);
    }

    /**
     * 导出数据
     *
     * @param response
     */
    @ResponseBody
    @RequestMapping("/repair/expRepair")
    public void expRepair(String itemNameShow, HttpServletResponse response) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Repair repair = new Repair();
        repair.setItemNameShow(itemNameShow);
        List<Repair> ll = repairService.selectCheck(repair);
        String name = "";
        for (int i = 0; i < ll.size(); i++) {
            String[] name_id = ll.get(i).getItemName().split(",");
            String newname = "";
            for (int j = 0; j < name_id.length; j++) {
                String a = name_id[j];
                name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            ll.get(i).setItemNameShow(newname);
        }
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("电子档案基本信息");

        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row1 = sheet.createRow(tmp);
        row1.createCell(0).setCellValue("报修种类");
        row1.createCell(1).setCellValue("所在部门");
        row1.createCell(2).setCellValue("报修物品名称");
        row1.createCell(3).setCellValue("维修地址");
        row1.createCell(4).setCellValue("故障描述");
        row1.createCell(5).setCellValue("联系人电话");
        row1.createCell(6).setCellValue("回检状态");
        row1.createCell(7).setCellValue("回检完成时间");
        row1.createCell(8).setCellValue("反馈状态");
        tmp++;
        int i = 1;
        for (Repair salaryObj : ll) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(salaryObj.getRepairTypeShow());
            row.createCell(1).setCellValue(salaryObj.getDept());
            row.createCell(2).setCellValue(salaryObj.getItemNameShow());
            row.createCell(3).setCellValue(salaryObj.getRepairAddress());
            row.createCell(4).setCellValue(salaryObj.getFaultDescription());
            row.createCell(5).setCellValue(salaryObj.getContactNumber());
            row.createCell(6).setCellValue(salaryObj.getCheckFlag());
            row.createCell(7).setCellValue(salaryObj.getCheckTime());
            row.createCell(8).setCellValue(salaryObj.getFeedbackFlag());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("回捡信息.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @ResponseBody
    @RequestMapping("/repair/closeWork")
    public Message deleteITDeviceById(String repairId) {
        repairService.closeRepair(repairId);
        return new Message(1, "流程已关闭！", null);
    }

    /**
     * 报修物品自动提示框
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/repair/getItemName")
    public List<AutoComplete> getItemName() {
        return repairService.getItemName();
    }

    @ResponseBody
    @RequestMapping("/repair/searchDetils")
    public ModelAndView searchDetils(String repairID) {
        ModelAndView mv = new ModelAndView();
        //UserDic userDic = userDicService.getUserDicById(id, dicType);
        Repair repair = repairService.selectDistributionInfo(repairID);
        String name = "";
        String[] name_id = repair.getItemName().split(",");
        String newname = "";
        for (int j = 0; j < name_id.length; j++) {
            String a = name_id[j];
            name = userDicService.getDicName(a);
            if (name != null) {
                newname = newname + name + ",";
            }
        }
        repair.setItemNameShow(newname);

        repair.setSysName(CommonUtil.getPersonName());
        mv.setViewName("/business/repair/searchDetils");
        mv.addObject("repair", repair);
        return mv;
    }

    //打印
    @ResponseBody
    @RequestMapping("/repair/printDistribution")
    public ModelAndView printDistribution(String repairID) {
        Repair repair = repairService.selectDistributionInfo(repairID);
        String name = "";
        String[] name_id = repair.getItemName().split(",");
        String newname = "";
        for (int j = 0; j < name_id.length; j++) {
            String a = name_id[j];
            name = userDicService.getDicName(a);
            if (name != null) {
                newname = newname + name + ",";
            }
        }
        repair.setItemNameShow(newname);
        repair.setSysName(CommonUtil.getPersonName());
        ModelAndView mv = new ModelAndView("/business/repair/printDistribution");
        mv.addObject("repair", repair);
        return mv;
    }
}
