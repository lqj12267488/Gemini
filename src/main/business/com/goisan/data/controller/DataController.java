package com.goisan.data.controller;

import com.goisan.data.bean.Data;
import com.goisan.data.bean.DataLocation;
import com.goisan.data.bean.DataType;
import com.goisan.data.service.DataService;
import com.goisan.system.bean.Tree;
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
public class DataController {
    @Resource
    private DataService dataService;

    /**
     * @function 获得资料类型树
     * @author FanNing
     * @date 2018/09/26
     */
    @ResponseBody
    @RequestMapping("/dataType/getDataTypeTree")
    public List<Tree> getDataTypeTree() {
        List<Tree> trees = dataService.getDataTypeTree();
        Tree root = new Tree();
        root.setId("0");
        root.setName("资料类别");
        root.setpId("root");
        root.setOpen(true);
        trees.add(root);
        return trees;
    }

    /**
     * @function 资料类别页面
     * @author FanNing
     * @date 2018/09/26
     */
    @ResponseBody
    @RequestMapping("/dataType/dataTypeList")
    public ModelAndView dataTypeList() {
        ModelAndView modelAndView = new ModelAndView("/business/data/dataTypeList");
        return modelAndView;
    }

    /**
     * @function 资料类别新增
     * @author FanNing
     * @date 2018/09/26
     */
    @ResponseBody
    @RequestMapping("/dataType/addDataType")
    public ModelAndView addDataType(String pId, String typeName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("id", dataService.getNewTypeId(pId));
        mv.addObject("pId", pId);
        mv.addObject("name", typeName);
        mv.setViewName("/business/data/addDataType");
        return mv;
    }

    /**
     * @function 字典类别名称查重
     * @author FanNing
     * @date 2018/09/26
     */
    @ResponseBody
    @RequestMapping("/dataType/checkName")
    public Message DataTypeCheckName(DataType DataType) {
        List size = dataService.checkName(DataType);
        if (size.size() > 0) {
            return new Message(1, "名称重复，请重新填写！", null);
        } else {
            return new Message(0, "", null);
        }
    }

    /**
     * @function 资料新增保存
     * @author FanNing
     * @date 2018/09/26
     */
    @ResponseBody
    @RequestMapping("/dataType/saveDataType")
    public Message saveDataType(DataType dataType) {
        dataType.setCreator(CommonUtil.getPersonId());
        dataType.setCreateTime(CommonUtil.getDate());
        dataType.setCreateDept(CommonUtil.getDefaultDept());
        dataService.saveDataType(dataType);
        return new Message(1, "添加成功！", null);
    }

    /**
     * @function 资料类别修改
     * @author FanNing
     * @date 2018/09/26
     */
    @ResponseBody
    @RequestMapping("/dataType/editDataType")
    public ModelAndView editDataType(String id, String name) {
        ModelAndView mv = new ModelAndView();
        DataType dataType = dataService.getDataTypeById(id);
        mv.addObject("dataType", dataType);
        mv.addObject("name", name);
        mv.addObject("id", id);
        mv.setViewName("/business/data/editDataType");
        return mv;
    }

    /**
     * @function 资料类别修改保存
     * @author FanNing
     * @date 2018/09/26
     */
    @ResponseBody
    @RequestMapping("/dataType/updateDataType")
    public Message updateDataType(DataType dataType) {
        dataType.setChanger(CommonUtil.getPersonId());
        dataType.setChangeTime(CommonUtil.getDate());
        dataType.setChangeDept(CommonUtil.getDefaultDept());
        dataService.updateDataType(dataType);
        return new Message(1, "修改成功！", null);
    }

    /**
     * @function 资料类别删除
     * @author FanNing
     * @date 2018/09/26
     */
    @ResponseBody
    @RequestMapping("/dataType/deleteDataType")
    public Message deleteDataType(String id) {
        Message message = new Message(1, "删除成功！", "success");
        dataService.deleteDataType(id);
        return message;
    }

    /**
     * @function 获得资料存放位置树
     * @author FanNing
     * @date 2018/09/27
     */
    @ResponseBody
    @RequestMapping("/dataLocation/getDataLocationTree")
    public List<Tree> getDataLocationTree() {
        List<Tree> trees = dataService.getDataLocationTree();
        Tree root = new Tree();
        root.setId("0");
        root.setName("资料存放位置");
        root.setpId("root");
        root.setOpen(true);
        trees.add(root);
        return trees;
    }

    /**
     * @function 资料存放位置页面
     * @author FanNing
     * @date 2018/09/27
     */
    @ResponseBody
    @RequestMapping("/dataLocation/dataLocationList")
    public ModelAndView dataLocationList() {
        ModelAndView modelAndView = new ModelAndView("/business/data/dataLocationList");
        return modelAndView;
    }

    /**
     * @function 资料类别新增
     * @author FanNing
     * @date 2018/09/26
     */
    @ResponseBody
    @RequestMapping("/dataLocation/addDataLocation")
    public ModelAndView addDataLocation(String pId, String locationName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("id", dataService.getNewLocationId(pId));
        mv.addObject("pId", pId);
        mv.addObject("name", locationName);
        mv.setViewName("/business/data/addDataLocation");
        return mv;
    }

    /**
     * @function 字典位置名称查重
     * @author FanNing
     * @date 2018/09/27
     */
    @ResponseBody
    @RequestMapping("/dataLocation/checkLocationName")
    public Message checkLocationName(DataLocation dataLocation) {
        List size = dataService.checkLocationName(dataLocation);
        if (size.size() > 0) {
            return new Message(1, "名称重复，请重新填写！", null);
        } else {
            return new Message(0, "", null);
        }
    }

    /**
     * @function 资料存放位置新增保存
     * @author FanNing
     * @date 2018/09/27
     */
    @ResponseBody
    @RequestMapping("/dataLocation/saveDataLocation")
    public Message saveDataLocation(DataLocation dataLocation) {
        dataLocation.setCreator(CommonUtil.getPersonId());
        dataLocation.setCreateTime(CommonUtil.getDate());
        dataLocation.setCreateDept(CommonUtil.getDefaultDept());
        dataService.saveDataLocation(dataLocation);
        return new Message(1, "添加成功！", null);
    }

    /**
     * @function 资料存放位置修改
     * @author FanNing
     * @date 2018/09/26
     */
    @ResponseBody
    @RequestMapping("/dataLocation/editDataLocation")
    public ModelAndView editDataLocation(String id, String name) {
        ModelAndView mv = new ModelAndView();
        DataLocation dataLocation = dataService.getDataLocationById(id);
        mv.addObject("dataLocation", dataLocation);
        mv.addObject("name", name);
        mv.addObject("id", id);
        mv.setViewName("/business/data/editDataLocation");
        return mv;
    }

    /**
     * @function 资料存放位置修改保存
     * @author FanNing
     * @date 2018/09/27
     */
    @ResponseBody
    @RequestMapping("/dataLocation/updateDataLocation")
    public Message updateDataLocation(DataLocation dataLocation) {
        dataLocation.setChanger(CommonUtil.getPersonId());
        dataLocation.setChangeTime(CommonUtil.getDate());
        dataLocation.setChangeDept(CommonUtil.getDefaultDept());
        dataService.updateDataLocation(dataLocation);
        return new Message(1, "修改成功！", null);
    }

    /**
     * @function 资料管理首页
     * @author FanNing
     * @date 2018/10/08
     */
    @RequestMapping("/data/dataList")
    public ModelAndView dataList() {
        ModelAndView mv = new ModelAndView("/business/data/dataList");
        return mv;
    }

    /**
     * @function 获得资料结果集
     * @author FanNing
     * @date 2018/10/08
     */
    @ResponseBody
    @RequestMapping("/data/getDataList")
    public Map<String, List<Data>> getdataList(Data data) {
        Map<String, List<Data>> dataMap = new HashMap<String, List<Data>>();
        data.setCreator(CommonUtil.getPersonId());
        data.setCreateDept(CommonUtil.getDefaultDept());
        dataMap.put("data", dataService.getDataList(data));
        return dataMap;
    }

    /**
     * @function 资料信息新增
     * @author FanNing
     * @date 2018/10/08
     */
    @ResponseBody
    @RequestMapping("/data/addData")
    public ModelAndView addData() {
        ModelAndView mv = new ModelAndView("/business/data/editData");
        Data data = new Data();
        mv.addObject("data", data);
        mv.addObject("head", "新增资料信息");
        return mv;
    }

    /**
     * @function 资料信息修改
     * @author FanNing
     * @date 2018/10/08
     */
    @ResponseBody
    @RequestMapping("/data/editData")
    public ModelAndView editData(String dataId) {
        ModelAndView mv = new ModelAndView("/business/data/editData");
        Data data = dataService.getDataById(dataId);
        mv.addObject("head", "资料信息修改");
        mv.addObject("data", data);
        return mv;
    }

    /**
     * @function 资料信息新增修改保存方法
     * @author FanNing
     * @date 2018/10/08
     */
    @ResponseBody
    @RequestMapping("/data/saveData")
    public Message saveData(Data data) {
        if (data.getDataId() == null || data.getDataId().equals("") || data.getDataId() == "") {
            data.setCreator(CommonUtil.getPersonId());
            data.setCreateDept(CommonUtil.getDefaultDept());
            data.setDataId(CommonUtil.getUUID());
            dataService.insertData(data);
            return new Message(1, "新增成功！", "success");
        } else {
            data.setChanger(CommonUtil.getPersonId());
            data.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            dataService.updateData(data);
            return new Message(1, "修改成功！", "success");
        }
    }

    /**
     * @function 资料信息删除
     * @author FanNing
     * @date 2018/10/10
     */
    @ResponseBody
    @RequestMapping("/data/deleteDataById")
    public Message deleteData(String dataId) {
        Message message = new Message(1, "删除成功！", "success");
        dataService.deleteData(dataId);
        return message;
    }

}
