package com.goisan.system.tools;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.*;
import java.sql.*;
import java.util.*;

public class Generate {
    private static String driverClassName = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@192.168.2.251:1521:orcl";
    private static String username = "goisan_xjxd";
    private static String password = "goisan_xjxd";

    private static String path = System.getProperty("user.dir");

//    public static void main(String[] args) {
//        Map<String, Object> data = new HashMap<String, Object>();
//        data.put("tableName", "T_XG_STU_ARCHIVESADDR");
//        data.put("beanName", "TeachingplanNew");
//        data.put("packageName", "com.goisan.educational.teachingplan");
//        data.put("jspPath", "/teachingplanNew");
//        data.put("primary", "id");
//        data.put("moduleName", "business");
//        data.put("url", "/teachingplanNew");
//        createFile(data);
//    }

    public static void main(String[] args) {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("tableName", "T_XG_STU_ARCHIVESADDR");
        data.put("beanName", "TeachingplanNew");
        data.put("packageName", "com.goisan.studentwork.graduatearchivesaddress");
        data.put("jspPath", "/studentwork/graduatearchivesaddress");
        data.put("primary", "id");
        data.put("moduleName", "business");
        data.put("url", "/StuArcad");
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

    private void createBean(Map<String, Object> data) {
        String beanFtl = "/src/main/webapp/WEB-INF/template/bean.ftl";
        Map<String, Object> map = new HashMap<String, Object>();
        map.putAll(data);
        List<String> cols = new ArrayList<String>();
        for (String col : (List<String>) data.get("cols")) {
            if (!check(col) && !"id".equals(col)) {
                cols.add(colFormat(col));
            }
        }
        cols.remove("demo");
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
        List<String> cols = (List<String>) data.get("cols");
        map.put("update", generateCode.getUpdateSql(cols, (String) map.get("tableName"), (String)
                map.get("primary")));
        map.put("insert", generateCode.getInsertSql(cols, (String)
                map.get("tableName")));
        map.put("select", generateCode.getSelectSql(cols, (String)
                map.get("tableName")));
        String filePath = path + "/src/main/resources/mapper/" + map.get("moduleName") + "/";
        createFile(mapperFtl, map, filePath + map.get("beanName") + "Dao.xml");
    }

    private void createList(Map<String, Object> data, Generate generateCode) {
        String listFtl = "/src/main/webapp/WEB-INF/template/list.ftl";
        Map<String, Object> map = new HashMap<String, Object>();
        map.putAll(data);
        List<String> cols = (List<String>) data.get("cols");
        map.put("tableJson", generateCode.getTableJson(cols));
        map.put("primary", colFormat((String) data.get("primary")));
        String filePath = path + "/src/main/webapp/WEB-INF/" + map.get("moduleName") + "/" + map.get("jspPath");
        File file = new File(filePath);
        file.mkdirs();
        createFile(listFtl, map, filePath + "/" + colFormat((String) map.get("beanName")) + "List" + ".jsp");
    }

    private void createEdit(Map<String, Object> data, Generate generateCode) {
        String editFtl = "/src/main/webapp/WEB-INF/template/edit.ftl";
        Map<String, Object> map = new HashMap<String, Object>();
        map.putAll(data);
        List<String> cols = (List<String>) data.get("cols");
        map.put("save", generateCode.save(cols));
        map.put("ajax", generateCode.ajaxJson(cols));
        map.put("form", generateCode.form(cols, (String) data.get("primary")));
        map.put("primary", colFormat((String) data.get("primary")));
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
     *
     * @param tableName 表名
     * @return 当前表字段名称List
     */

    public List<String> getCols(String tableName) {


        try {
            Class.forName(driverClassName);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<String> cols = new ArrayList<String>();
        try {
            conn = DriverManager.getConnection(url, username, password);
            stmt = conn.createStatement();
            String sql = "select column_name from user_tab_columns where table_name = '" +
                    tableName.toUpperCase() + "' order by column_id";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                cols.add(rs.getString("column_name").toLowerCase());
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

    public String getSelectSql(List<String> cols, String tableName) {
        String selectSql = "select ";
        for (String col : cols) {
            if (check(col) && !"id".equals(col)) {
                continue;
            } else {
                selectSql += col + ",";
            }
        }
        selectSql = selectSql.substring(0, selectSql.length() - 1) + " from " + tableName;
        return selectSql;
    }

    /**
     * 生成Insert语句
     *
     * @param cols      字段List
     * @param tableName 表名
     * @return Insert语句
     */
    public String getInsertSql(List<String> cols, String tableName) {
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
                sql += "#{" + colFormat(col) + "},";
            }
        }
        sql = sql.substring(0, sql.length() - 1) + ")";
        return sql;
    }

    /**
     * 生成Update语句
     *
     * @param cols      字段List
     * @param tableName 表名
     * @return Update语句
     */

    public String getUpdateSql(List<String> cols, String tableName, String primary) {
        String sql = "update " + tableName.toLowerCase() + " set ";
        for (String col : cols) {
            if (!("creator,create_time,create_dept,valid_flag".indexOf(col) != -1 || col
                    .toUpperCase().equals(primary.toUpperCase()))) {
                sql += col + "=#{" + colFormat(col) + "},";
            }
        }
        sql = sql.substring(0, sql.length() - 1);
        return sql;
    }

    /**
     * 生成datatable json串
     *
     * @param cols 字段List
     * @return datatable json串
     */

    public String getTableJson(List<String> cols) {
        String tableJson = "";
        for (String col : cols) {
            if (!(check(col) && !"id".equals(col))) {
                tableJson += "{\"data\":\"" + colFormat(col) + "\",\"title\":\"\"},\n";
            }
        }
        return tableJson;
    }

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
    public String save(List<String> cols) {
        String save = "";
        for (String col : cols) {
            if (!(check(col) && !"id".equals(col))) {
                save += "var " + colFormat(col) + " = $(\"#" + colFormat(col) + "\").val();\n";
            }
        }
        for (String col : cols) {
            if (!(check(col) && !"id".equals(col))) {
                save += "if (" + colFormat(col) + " == \"\" || " + colFormat(col) + " == " +
                        "undefined || " + colFormat(col) + " == null) {\n" +
                        "\tswal({\n" +
                        "                \ttitle: \"请选择网站类型！\",\n" +
                        "                \ttype: \"info\"\n" +
                        "            \t});\n\treturn;\n}\n";
            }
        }
        return save;

    }

    /**
     * 生成form,都是input需要做部分修改
     *
     * @param cols 字段List
     * @return from表单
     */
    public String form(List<String> cols, String primary) {

        String form = "";
        for (String col : cols) {
            if (!(check(col) || col.toUpperCase().equals(primary.toUpperCase()))) {
                form += "<div class=\"form-row\">\n";
                form += "<div class=\"col-md-3 tar\">\n";
                form += "name\n";
                form += "</div>\n";
                form += "<div class=\"col-md-9\">\n";
                form += "<input id=\"" + colFormat(col) + "\" value=\"${data." + colFormat(col) +
                        "}\"/>\n";
                form += "</div>\n";
                form += "</div>";
            }
        }
        return form;
    }

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

}
