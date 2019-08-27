package ${packageName}.bean;

import com.goisan.system.bean.BaseBean;

public class ${beanName} extends BaseBean {
<#list cols as col>
    private String ${col?uncap_first};
</#list>

<#list cols as col>
    public String get${col?cap_first}() {
        return ${col?uncap_first};
    }

    public void set${col?cap_first}(String ${col?uncap_first}) {
        this.${col?uncap_first} = ${col?uncap_first};
    }
</#list>
}
