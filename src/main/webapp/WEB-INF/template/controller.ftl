package ${packageName}.controller;

import ${packageName}.bean.${beanName?cap_first};
import ${packageName}.service.${beanName?cap_first}Service;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
// @RequestMapping("")
public class ${beanName?cap_first}Controller {

    @Resource
    private ${beanName?cap_first}Service ${beanName?uncap_first}Service;

    @RequestMapping("${url}/to${beanName?cap_first}List")
    public String toList() {
        return "/${moduleName}${jspPath}/${beanName?uncap_first}List";
    }

    @ResponseBody
    @RequestMapping("${url}/get${beanName?cap_first}List")
    public Map getList(${beanName?cap_first} ${beanName?uncap_first}) {
        return CommonUtil.tableMap(${beanName?uncap_first}Service.get${beanName?cap_first}List(${beanName?uncap_first}));
    }

    @RequestMapping("${url}/to${beanName?cap_first}Add")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/${moduleName}${jspPath}/${beanName?uncap_first}Edit";
    }

    @ResponseBody
    @RequestMapping("${url}/save${beanName?cap_first}")
    public Message save(${beanName?cap_first} ${beanName?uncap_first}) {
        if ("".equals(${beanName?uncap_first}.get${primary?cap_first}())) {
            ${beanName?uncap_first}.set${primary?cap_first}(CommonUtil.getUUID());
            CommonUtil.save(${beanName?uncap_first});
            ${beanName?uncap_first}Service.save${beanName?cap_first}(${beanName?uncap_first});
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(${beanName?uncap_first});
            ${beanName?uncap_first}Service.update${beanName?cap_first}(${beanName?uncap_first});
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("${url}/to${beanName?cap_first}Edit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", ${beanName?uncap_first}Service.get${beanName?cap_first}ById(id));
        model.addAttribute("head", "修改");
        return "/${moduleName}${jspPath}/${beanName?uncap_first}Edit";
    }

    @ResponseBody
    @RequestMapping("${url}/del${beanName?cap_first}")
    public Message del(String id) {
        ${beanName?uncap_first}Service.del${beanName?cap_first}(id);
        return new Message(0, "删除成功！", null);
    }

}
