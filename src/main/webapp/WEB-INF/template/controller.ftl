package ${packageName}.controller;

import ${packageName}.bean.${beanName?cap_first};
import ${packageName}.service.${beanName?cap_first}Service;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.BaseBean;

import javax.annotation.Resource;
import java.util.*;

@Controller
public class ${beanName?cap_first}Controller {

    @Resource
    private ${beanName?cap_first}Service ${beanName?uncap_first}Service;

    @RequestMapping("${url}/to${beanName?cap_first}List")
    public String to${beanName?cap_first}List() {
        return "/${moduleName}${jspPath}/${beanName?uncap_first}List";
    }

    @ResponseBody
    @RequestMapping("${url}/get${beanName?cap_first}List")
    public Map<String,Object> get${beanName?cap_first}List(${beanName?cap_first} ${beanName?uncap_first},int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  ${beanName?uncap_first}Service.get${beanName?cap_first}List(${beanName?uncap_first});
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("${url}/to${beanName?cap_first}Add")
    public String toAdd${beanName?cap_first}(Model model) {
        model.addAttribute("head", "新增");
        return "/${moduleName}${jspPath}/${beanName?uncap_first}Edit";
    }

    @ResponseBody
    @RequestMapping("${url}/save${beanName?cap_first}")
    public Message save${beanName?cap_first}(${beanName?cap_first} ${beanName?uncap_first}) {
        if (null != ${beanName?uncap_first}.get${primary?cap_first}() && !"".equals(${beanName?uncap_first}.get${primary?cap_first}())) {
           CommonUtil.update(${beanName?uncap_first});
            ${beanName?uncap_first}Service.update${beanName?cap_first}(${beanName?uncap_first});
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(${beanName?uncap_first});
            ${beanName?uncap_first}Service.save${beanName?cap_first}(${beanName?uncap_first});
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("${url}/to${beanName?cap_first}Edit")
    public String toEdit${beanName?cap_first}(String id, Model model) {
        model.addAttribute("data", ${beanName?uncap_first}Service.get${beanName?cap_first}ById(id));
        model.addAttribute("head", "修改");
        return "/${moduleName}${jspPath}/${beanName?uncap_first}Edit";
    }

    @ResponseBody
    @RequestMapping("${url}/del${beanName?cap_first}")
    public Message del${beanName?cap_first}(String id) {
        ${beanName?uncap_first}Service.del${beanName?cap_first}(id);
        return new Message(0, "删除成功！", null);
    }

}
