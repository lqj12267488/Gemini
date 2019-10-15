package com.goisan.system.tools;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.*;
import java.sql.*;
import java.util.*;

public class Generate {
    private static String path = System.getProperty("user.dir");
    private static String driverClassName = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@192.168.2.251:1521:orcl";
    private static String username = "goisan_xjxd";
    private static String password = "goisan_xjxd";

//   配置
    /**
     * 1.数据库表, 字段备注必填
     * 2. 如果使用字典,备注使用{CodeValue}标识,如${ZJ}
     * 3. 如果找不到oracle驱动, 项目设置（Libraries- '+' - 添加ojdbc包）
     *
     */
    /**实体名*/
    private static String BASE_NAME = "ClubReward";
    /**数据库表名*/
    private static String TABLE_NAME = "t_tab_club_reward";
    /**1. 模块名,不填默认business （core,business）*/
    private static String MODULE_NAME = "";
    /** packageName 包所在位置;实际包生成所在位置=MODULE_NAME+PACKAGE_NAME*/
    private static String PACKAGE_NAME = "com.goisan.table";
    /** jsp 文件所在路径; jsp文件生成所在位置 = MODULE_NAME + JSP_PATH*/
    private static String JSP_PATH = "/table/clubreward";
    /** 表主键*/
    private static String PRIMARY = "id";

    public static void main(String[] args) {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("tableName",TABLE_NAME);
        data.put("beanName", BASE_NAME);
        if ("".equals(MODULE_NAME)){
            data.put("moduleName", "business");
        }else {
            data.put("moduleName", MODULE_NAME);
        }
        data.put("packageName", PACKAGE_NAME);

        if ("".equals(JSP_PATH)){
            data.put("jspPath", "/business/" + BASE_NAME);
        }else {
            data.put("jspPath",JSP_PATH);
        }
        data.put("primary", PRIMARY);
        data.put("url", "/"+BASE_NAME.toLowerCase());
        createFile(data);
    }


    private static void createFile(Map<String, Object> data) {
        Generate generateCode = new Generate();
        List cols = generateCode.getCols((String) data.get("tableName"));
        data.put("cols", cols);
        generateCode.createBean(data);
        generateCode.createController(data);
        generateCode.createService(data);
        generateCode.createServiceImpl(data);
        generateCode.createDao(data);
        generateCode.createList(data, generateCode);
        generateCode.createEdit(data, generateCode);
        generateCode.createMapper(data, generateCode);
    }

//    生成bean
    private void createBean(Map<String, Object> data) {
        String beanFtl = "/src/main/webapp/WEB-INF/template/bean.ftl";
        Map<String, Object> map = new HashMap<String, Object>();
        map.putAll(data);
        List<Map<String,String>> cols  = new ArrayList<>();
        for (Map<String,String> colMap: (List<Map<String,String>>) data.get("cols")){
            if (!check(colMap.get("column_name")) || "id".equals(colMap.get("column_name"))) {
                HashMap<String, String> hashMap = new HashMap<>();
                String comments = colMap.get("comments");
                hashMap.put("column_name",colFormat(colMap.get("column_name")));
                hashMap.put("comments",comments);
                if (null!= comments){
                    if (comments.indexOf('{')!= -1 && comments.indexOf('}')!=-1 ) {
                        String dic = comments.substring(comments.indexOf('{')+1, comments.indexOf('}'));
                        if (dic != null && !"".equals(dic)) {
                            colMap.put("dic", dic.toUpperCase());
                            hashMap.put("dic", dic.toUpperCase());
                        }
                    }
                }
                cols.add(hashMap);
            }
        }
        map.put("cols", cols);
        String filePath = path + "/src/main/" + map.get("moduleName") + "/" + ((String)
                map.get("packageName")).replace(".", "/") + "/bean/";
        File file = new File(filePath);
        file.mkdirs();
        createFile(beanFtl, map, filePath + map.get("beanName") + ".java");
    }

    public void createController(Map<String, Object> data) {
        String controllerFtl = "/src/main/webapp/WEB-INF/template/controller.ftl";
        Map<String, Object> map = new HashMap<String, Object>();
        map.putAll(data);
        map.put("primary", colFormat((String) data.get("primary")));
        String filePath = path + "/src/main/" + map.get("moduleName") + "/" + ((String) map.get("packageName")).replace
                ("" + ".", "/") + "/controller/";
        File file = new File(filePath);
        file.mkdirs();
        createFile(controllerFtl, map, filePath + map.get("beanName") + "Controller.java");
    }

    public void createService(Map<String, Object> data) {
        String serviceFtl = "/src/main/webapp/WEB-INF/template/service.ftl";
        Map<String, Object> map = new HashMap<String, Object>();
        map.putAll(data);
        String filePath = path + "/src/main/" + map.get("moduleName") + "/" + ((String) map.get("packageName"))
                .replace(".", "/") + "/service/";
        File file = new File(filePath);
        file.mkdirs();
        createFile(serviceFtl, map, filePath + map.get("beanName") + "Service.java");
    }

    public void createServiceImpl(Map<String, Object> data) {
        String serviceImplFtl = "/src/main/webapp/WEB-INF/template/serviceImpl.ftl";
        Map<String, Object> map = new HashMap<String, Object>();
        map.putAll(data);
        String filePath = path + "/src/main/" + map.get("moduleName") + "/" + ((String)
                map.get("packageName")).replace(".", "/") + "/service/impl/";
        File file = new File(filePath);
        file.mkdirs();
        createFile(serviceImplFtl, map, filePath + map.get("beanName") + "ServiceImpl.java");
    }

    public void createDao(Map<String, Object> data) {
        String daoFtl = "/src/main/webapp/WEB-INF/template/dao.ftl";
        Map<String, Object> map = new HashMap<String, Object>();
        map.putAll(data);
        String filePath = path + "/src/main/" + map.get("moduleName") + "/" + ((String)
                map.get("packageName")).replace(".", "/") + "/dao/";
        File file = new File(filePath);
        file.mkdirs();
        createFile(daoFtl, map, filePath + map.get("beanName") + "Dao.java");
    }

    public void createMapper(Map<String, Object> data, Generate generateCode) {
        String mapperFtl = "/src/main/webapp/WEB-INF/template/mapper.ftl";
        Map<String, Object> map = new HashMap<String, Object>();
        map.putAll(data);
        List<String> cols = listMapToList(data.get("cols"));
        List<Map<String,String>> colAll = (List<Map<String, String>>) data.get("cols");
        map.put("update", generateCode.getUpdateSql(cols, (String) map.get("tableName"), (String)
                map.get("primary")));
        map.put("insert", generateCode.getInsertSql(cols, (String)
                map.get("tableName"), (String) map.get("primary")));
        map.put("select", generateCode.getSelectSql(colAll, (String)
                map.get("tableName"),(String) map.get("primary")));
        String filePath = path + "/src/main/resources/mapper/" + map.get("moduleName") + "/";
        createFile(mapperFtl, map, filePath + map.get("beanName") + "Dao.xml");
    }

    private void createList(Map<String, Object> data, Generate generateCode) {
        String listFtl = "/src/main/webapp/WEB-INF/template/list.ftl";
        Map<String, Object> map = new HashMap<>();
        map.putAll(data);
        String primary = colFormat((String) data.get("primary"));
        List<Map<String,String>> colMap = (List<Map<String, String>>) data.get("cols");
        map.put("primary", primary);
        map.put("queryMapList",getQueryCol(colMap,primary));
        String filePath = path + "/src/main/webapp/WEB-INF/" + map.get("moduleName") + "/" + map.get("jspPath");
        File file = new File(filePath);
        file.mkdirs();
        createFile(listFtl, map, filePath + "/" + colFormat((String) map.get("beanName")) + "List" + ".jsp");
    }

    private void createEdit(Map<String, Object> data, Generate generateCode) {
        String editFtl = "/src/main/webapp/WEB-INF/template/edit.ftl";
        Map<String, Object> map = new HashMap<String, Object>();
        map.putAll(data);
        List<String> cols = listMapToList(data.get("cols"));
//        map.put("save", generateCode.save(cols));
        map.put("ajax", generateCode.ajaxJson(cols));
//        map.put("form", generateCode.form(cols, (String) data.get("primary")));
        map.put("primary", colFormat((String) data.get("primary")));
        map.put("queryMapList",getQueryCol((List<Map<String, String>>) data.get("cols"),colFormat((String) data.get("primary"))));
        String filePath = path + "/src/main/webapp/WEB-INF/" + map.get("moduleName") + "/" +
                map.get("jspPath");
        File file = new File(filePath);
        file.mkdirs();
        createFile(editFtl, map, filePath + "/" + colFormat((String) map.get("beanName")) + "Edit" +
                ".jsp");
    }

    public static boolean createFile(String ftl, Map<String, Object> data, String targetFile) {
        try {
            // 创建Template对象
            Configuration cfg = new Configuration(Configuration.VERSION_2_3_0);
            cfg.setDefaultEncoding("UTF-8");
            Template template = cfg.getTemplate(ftl);
            Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream
                    (targetFile), "UTF-8"));
            template.process(data, out);
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        } catch (TemplateException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public static boolean check(String str) {
        String cols = "creator,create_time,create_dept,changer,change_time,change_dept,valid_flag";
        return cols.indexOf(str) != -1;
    }

    /**
     * 连接数据库通过表名获取当前表字段
     * @param tableName 表名
     * @return 当前表字段名称List
     */

    public List<Map<String,String>> getCols(String tableName) {
        try {
            Class.forName(driverClassName);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<Map<String,String>> cols = new ArrayList<>();
        try {
            conn = DriverManager.getConnection(url, username, password);
            stmt = conn.createStatement();
            String sql = "select column_name,comments from user_col_comments where table_name ='" +
                    tableName.toUpperCase()+"'";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                HashMap<String, String> column = new HashMap<>();
                column.put("column_name",rs.getString("column_name").toLowerCase());
                column.put("comments",rs.getString("comments")==null ? "":rs.getString("comments").toLowerCase());
                cols.add(column);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (cols.size() == 0) {
            throw new RuntimeException("表名输入有误！");
        }
        return cols;
    }


    public String getSelectSql( List<Map<String,String>> cols, String tableName ,String primary) {
        StringBuilder selectSql = new StringBuilder();
        selectSql.append( "select ");
        for (Map<String,String> colMap : cols) {
            String col = colMap.get("column_name");
            String dic = colMap.get("dic");
                selectSql.append(col);
                selectSql.append(",");
                if (null!=dic && !"".equals(dic)){
                    selectSql.append("func_get_dicvalue(");
                    selectSql.append(col);
                    selectSql.append(",'"+dic+"') "+colFormat(col)+"Show,");
                }
        }
        selectSql.deleteCharAt(selectSql.length()-1);
        selectSql.append(" from "+tableName+" where 1=1 \n");
        for (Map<String,String> colMap : cols) {
            String col = colMap.get("column_name");
            if (!(check(col) && !"id".equals(col)) && !primary.equals(col) ) {
                HashMap<String, String> hashMap = new HashMap<>();
                if (colMap.get("dic")!=null) {
                    selectSql.append("<if test='" + colFormat(col) + " != \"\" and " + colFormat(col) + " != null'>");
                    selectSql.append(" AND " + col + " = #{" + colFormat(col) + "} </if> \n");
                }else {
                    selectSql.append("<if test='" + colFormat(col) + " != \"\" and " + colFormat(col) + " != null'>");
                    selectSql.append(" AND " + col + " like '%'||#{" + colFormat(col) + "}||'%' </if> \n");
                }
            }
        }
        return selectSql.toString();
    }
    /**
     * 生成Insert语句
     *
     * @param cols      字段List
     * @param tableName 表名
     * @return Insert语句
     */
    public String getInsertSql(List<String> cols, String tableName,String primary) {
        String sql = "insert into " + tableName.toLowerCase() + " (";
        for (String col : cols) {
            if ("changer,change_time,change_dept,valid_flag".indexOf(col) != -1 && !"id".equals
                    (col)) {
                continue;
            } else {
                sql += col + ",";
            }

        }
        sql = sql.substring(0, sql.length() - 1) + ") values (";
        for (String col : cols) {
            if ("changer,change_time,change_dept,valid_flag".indexOf(col) != -1 && !"id".equals
                    (col)) {
                continue;
            } else {
                if (primary.equals(col)){
//                    第一个为id
                    sql += "func_get_uuid ,";
                }
                else if ("create_time".equals(col)){
                    sql += "sysdate ,";
                }
                else {
                    sql += "#{" + colFormat(col) + "},";
                }
            }
        }
        sql = sql.substring(0, sql.length() - 1) + ")";
        return sql;
    }

    /**
     * 生成Update语句
     * @param cols      字段List
     * @param tableName 表名
     * @return Update语句
     */

    public String getUpdateSql(List<String> cols, String tableName, String primary) {
        String sql = "update " + tableName.toLowerCase() + " set ";
        for (String col : cols) {
            if (!("creator,create_time,create_dept,valid_flag".indexOf(col) != -1 || col
                    .toUpperCase().equals(primary.toUpperCase()))) {
                if ("change_time".equals(col)){
                    sql += col + "= sysdate,";
                }else {
                    sql += col + "=#{" + colFormat(col) + "},";
                }
            }
        }
        sql = sql.substring(0, sql.length() - 1);
        return sql;
    }

//    /**
//     * 生成datatable json串
//     *
//     * @param cols 字段List
//     * @return datatable json串
//     */
//
//    public String getTableJson( List<Map<String,String>> colMap,String primary) {
//        StringBuilder tableJson = new StringBuilder();
//        for (Map<String,String> map : colMap) {
//            String col = map.get("column_name");
//            String comments = map.get("comments");
//            if (!(check(col) && !"id".equals(col))) {
//                tableJson.append("{\"data\":\"" );
//                tableJson.append(colFormat(col) );
//                tableJson.append("\",\"title\":\"");
//                tableJson.append(comments+"\"");
//                if (primary.equals(col)) {
//                    tableJson.append(", \"visible\": false");
//                }
//                tableJson.append("},\n");
//            }
//        }
//        return tableJson.toString();
//    }

     /** 生成需要查询或者需要编辑的字段的字段*/
    public List<Map<String,String>> getQueryCol(List<Map<String,String>> colMap,String primary){
        ArrayList<Map<String,String>> queryMapList = new ArrayList<>();
        for (Map<String,String> map : colMap) {
            String col = map.get("column_name");
            if (!(check(col) && !"id".equals(col)) && !primary.equals(col) ) {
                HashMap<String, String> hashMap = new HashMap<>();
                if (map.get("dic")!=null){
                    hashMap.put("dic",map.get("dic"));
                }
                hashMap.put("queryCol",colFormat(col));
                hashMap.put("comments",map.get("comments"));
                hashMap.put("edit",("${data."+colFormat(col)+"}"));
                queryMapList.add(hashMap);
            }
        }
        return queryMapList;
    };


    /**
     * 生成ajax json串
     *
     * @param cols 字段List
     * @return ajax json串
     */
    public String ajaxJson(List<String> cols) {
        String ajaxJson = "";
        for (String col : cols) {
            if (!(check(col) && !"id".equals(col))) {
                ajaxJson += colFormat(col) + ":" + colFormat(col) + ",\n";
            }
        }
        return ajaxJson;
    }

    /**
     * 生成save方法获取表单值和校验串
     *
     * @param cols 字段List
     * @return save方法获取表单值和校验串
     */
//    public String save(List<String> cols) {
//        String save = "";
//        for (String col : cols) {
//            if (!(check(col) && !"id".equals(col))) {
//                save += "var " + colFormat(col) + " = $(\"#" + colFormat(col) + "\").val();\n";
//            }
//        }
//        for (String col : cols) {
//            if (!(check(col) && !"id".equals(col))) {
//                save += "if (" + colFormat(col) + " == \"\" || " + colFormat(col) + " == " +
//                        "undefined || " + colFormat(col) + " == null) {\n" +
//                        "\tswal({\n" +
//                        "                \ttitle: \"请选择网站类型！\",\n" +
//                        "                \ttype: \"info\"\n" +
//                        "            \t});\n\treturn;\n}\n";
//            }
//        }
//        return save;
//    }

//    /**
//     * 生成form,都是input需要做部分修改
//     *
//     * @param cols 字段List
//     * @return from表单
//     */
//    public String form(List<String> cols, String primary) {
//
//        String form = "";
//        for (String col : cols) {
//            if (!(check(col) || col.toUpperCase().equals(primary.toUpperCase()))) {
//                form += "<div class=\"form-row\">\n";
//                form += "<div class=\"col-md-3 tar\">\n";
//                form += "name\n";
//                form += "</div>\n";
//                form += "<div class=\"col-md-9\">\n";
//                form += "<input id=\"" + colFormat(col) + "\" value=\"${data." + colFormat(col) +
//                        "}\"/>\n";
//                form += "</div>\n";
//                form += "</div>";
//            }
//        }
//        return form;
//    }

    /**
     * 格式化字段
     *
     * @param col 字段
     * @return 驼峰格式字段
     */
    public String colFormat(String col) {
        if (col.indexOf("_") != -1) {
            String[] tmps = col.split("_");
            for (int i = 0; i < tmps.length; i++) {
                if (i > 0) {
                    col += tmps[i].substring(0, 1).toUpperCase() + tmps[i].substring(1,
                            tmps[i].length());
                } else {
                    col = tmps[i].substring(0, 1).toLowerCase() + tmps[i].substring(1,
                            tmps[i].length());
                }
            }
        }
        return col.substring(0, 1).toLowerCase() + col.substring(1, col.length());
    }

    public List<String> listMapToList(Object list) {
        List<Map<String,String>> clist = (List<Map<String, String>>) list;
        List<String> cols = new ArrayList<>();
            for (Map<String,String> colMap:clist){
            cols.add(colMap.get("column_name"));
        }
        return  cols;
    }
}
