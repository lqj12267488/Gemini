package ${packageName}.bean;

import com.goisan.system.bean.BaseBean;

public class ${beanName} extends BaseBean {
<#list cols as col>

    /**${col.comments}*/
    private String ${col.column_name?uncap_first};
    <#if col.dic??>

   private String ${col.column_name?uncap_first}Show;
    </#if>
</#list>

<#list cols as col>
    public String get${col.column_name?cap_first}() {
        return ${col.column_name?uncap_first};
    }

    public void set${col.column_name?cap_first}(String ${col.column_name?uncap_first}) {
        this.${col.column_name?uncap_first} = ${col.column_name?uncap_first};
    }

    <#if col.dic??>
    public String get${col.column_name?cap_first}Show() {
        return ${col.column_name?uncap_first}Show;
    }

    public void set${col.column_name?cap_first}Show(String ${col.column_name?uncap_first}Show) {
        this.${col.column_name?uncap_first}Show = ${col.column_name?uncap_first}Show;
    }

    </#if>
</#list>
}
