package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.service.SchoolCarTypeService;
import com.goisan.system.bean.UserDic;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.*;

/**学校车辆类型管理
 * Created by wq on 2017/7/12.
 */
@Controller
public class SchoolCarTypeController {
    @Resource
    private SchoolCarTypeService schoolCarTypeService;
    /*跳转到学校车辆类型管理JSP*/
    @RequestMapping("/schoolCar/schoolCarType")
    public ModelAndView schoolCarTypeList(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("business/synergy/workflow/schoolCar/schoolCarType/schoolCarType");
        return mv;
    }
    /*列表显示和查询*/
    @ResponseBody
    @RequestMapping("/schoolCarType/schoolCarTypeAction")
    public Map<String,List<UserDic>> schoolCarTypeAction() {
        Map<String, List<UserDic>> schoolCarType = new HashMap<String, List<UserDic>>();
        schoolCarType.put("data",schoolCarTypeService.schoolCarTypeAction(new UserDic()));
        return schoolCarType;
    }
    /*新增界面跳转*/
    @RequestMapping("/schoolCarType/addSchoolCarType")
    public ModelAndView addSchoolCarType() {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/schoolCar/schoolCarType/addSchoolCarType");
        mv.addObject("head", "耗材新增");
        return mv;
    }
    /*修改界面跳转*/
    @ResponseBody
    @RequestMapping("/schoolCarType/editSchoolCarType")
    public ModelAndView getSchoolCarTypeById(String id) {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/schoolCar/schoolCarType/addSchoolCarType");
        UserDic userDic = schoolCarTypeService.getSchoolCarTypeById(id);
        mv.addObject("head", "耗材修改");
        mv.addObject("schoolCarType", userDic);
        return mv;
    }
    /*新增和修改保存*/
    @ResponseBody
    @RequestMapping("/schoolCarType/saveSchoolCarType")
    public Message saveSchoolCarType(UserDic userDic){
        Date date = new Date(new Date().getTime());
        userDic.setCreateTime(CommonUtil.getDate());
        if(userDic.getId()==null || userDic.getId().equals("")){
            userDic.setCreator(CommonUtil.getLoginUser().getUserAccount());
            userDic.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            userDic.setId(CommonUtil.getUUID());
            schoolCarTypeService.insertSchoolCarType(userDic);
            return new Message(1, "新增成功！", null);
        }else{
            userDic.setChanger(CommonUtil.getLoginUser().getUserAccount());
            userDic.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            schoolCarTypeService.updateSchoolCarType(userDic);
            return new Message(1, "修改成功！", null);
        }
    }
    /*删除行*/
    @ResponseBody
    @RequestMapping("/schoolCarType/deleteSchoolCarTypeById")
    public Message deleteDeptById(String id) {
        schoolCarTypeService.deleteSchoolCarTypeById(id);
        return new Message(1, "删除成功！", null);
    }
    /*查询行*/
    @ResponseBody
    @RequestMapping("/schoolCarType/getSchoolCarTypeById")
    public ModelAndView getAssetsById(String id) {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/schoolCar/schoolCarType/addSchoolCarType");
        UserDic userDic = schoolCarTypeService.getSchoolCarTypeById(id);
        mv.addObject("head", "申请修改");
        mv.addObject("schoolCarType", userDic);
        return mv;
    }
    /*查询列表*/
    @ResponseBody
    @RequestMapping("/schoolCarType/getSchoolCarTypeList")
    public Map<String, List<UserDic>> getSchoolCarTypeList(UserDic userDic) {
        Map<String, List<UserDic>> softMap = new HashMap<String, List<UserDic>>();
        userDic.setCreator(CommonUtil.getPersonId());
        softMap.put("data", schoolCarTypeService.getSchoolCarTypeList(userDic));
        return softMap;
    }
    /*字段查重*/
//车辆类型查重
    @ResponseBody
    @RequestMapping("/schoolCarType/checkName")
    public Message checkName(UserDic userDic){
        List size = schoolCarTypeService.checkName(userDic);
        if(size.size()>0){
            return new Message(1, "耗材名称重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
//车辆类型编号查重
    @ResponseBody
    @RequestMapping("/schoolCarType/checkCode")
    public Message checkCode(UserDic userDic) {
        List size = schoolCarTypeService.checkCode(userDic);
        if (size.size() > 0) {
            return new Message(2, "耗材编号重复，请重新填写！", null);
        } else {
            return new Message(0, "", null);
        }
    }
//类型序号查重
    @ResponseBody
    @RequestMapping("/schoolCarType/checkOrder")
    public Message checkOrder(UserDic userDic){
        List size = schoolCarTypeService.checkOrder(userDic);
        if(size.size()>0){
            return new Message(3, "耗材排序重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    //取出未使用的序号
    @ResponseBody
    @RequestMapping("/schoolCarType/getSchoolCarTypeNoOrder")
    public List<String> getSchoolCarTypeList() {
        List<String> list = schoolCarTypeService.getSchoolCarTypeNoOrder();
        List<String> ulist=new ArrayList<String>();
        boolean flag=true;
        for (int i = 1; i <100; i++) {
            for (String s:list) {
                if (i==Integer.parseInt(s)){
                    flag=false;
                    break;
                }
            }
            if(flag){
                ulist.add(""+i);
            }
        }
        return ulist;
    }
}
