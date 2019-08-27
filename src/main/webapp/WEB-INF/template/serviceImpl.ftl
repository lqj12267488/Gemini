package ${packageName}.service.impl;

import ${packageName}.dao.${beanName?cap_first}Dao;
import ${packageName}.service.${beanName?cap_first}Service;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ${beanName?cap_first}ServiceImpl implements ${beanName?cap_first}Service {
@Resource
private ${beanName?cap_first}Dao ${beanName?uncap_first}Dao;

    public List<BaseBean> get${beanName?cap_first}List(BaseBean baseBean) {
        return ${beanName?uncap_first}Dao.get${beanName?cap_first}List(baseBean);
    }

    public void save${beanName?cap_first}(BaseBean baseBean) {
        ${beanName?uncap_first}Dao.save${beanName?cap_first}(baseBean);
    }

    public BaseBean get${beanName?cap_first}ById(String id) {
        return ${beanName?uncap_first}Dao.get${beanName?cap_first}ById(id);
    }

    public void update${beanName?cap_first}(BaseBean baseBean) {
        ${beanName?uncap_first}Dao.update${beanName?cap_first}(baseBean);
    }

    public void del${beanName?cap_first}(String id) {
        ${beanName?uncap_first}Dao.del${beanName?cap_first}(id);
    }
}
