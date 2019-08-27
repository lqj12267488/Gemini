package ${packageName}.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ${beanName?cap_first}Service {

    List<BaseBean> get${beanName?cap_first}List(BaseBean baseBean);

    void save${beanName?cap_first}(BaseBean baseBean);

    BaseBean get${beanName?cap_first}ById(String id);

    void update${beanName?cap_first}(BaseBean baseBean);

    void del${beanName?cap_first}(String id);

}